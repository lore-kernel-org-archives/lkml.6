Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs7G1sLwr9t/OegS+4cYngBE3E9JVJEr0ne7Fht9LWMC2WSzTSwmLWe79LWY9YXAzjWYSyP
ARC-Seal: i=1; a=rsa-sha256; t=1521482974; cv=none;
        d=google.com; s=arc-20160816;
        b=gN9QzeKKwORCO4aeTqRHRi0r8v2YiK43Q1SX/nD1/avrFt6YfdyDIrLDtfACEudw5F
         tPGpTtsBfdWdbeGIDowg009HNWmpLJtKzwEnFAz7dWLb10zBwogLF4OkOIqbFI6rzy64
         e0SJNALVIdaBH4q1tfMqL2U6vv4P0jQnbYEJ95/RTYi0HM4wfOoLJCeHH9OIieojF4I0
         NJxaP4GOs8mcs5+v9VKt+tyF4G4Xd/pq/Aa7gsXCXxTInzBd2hlCf3ddccFk47WIck4y
         ahWQv5kRbmWO9UJ/HIBEPJZfhMZw26/PM3w+C+Chk2CkSPpa9EFw91nqxBmUT5Nc+gj1
         jtwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TU0JTO9gw5QyrOs7IWNcKjHP97Yva6e8NBidaR3xei4=;
        b=CxU6fibwnsyNB93qJlYH9Fv36BnOXkVGPOCPq4ZUi+cdCuF6Q7ccxPxGFmAbqFkKtd
         Gt9DqyKu8vMMqOjbN2usYpTcNTzcbofHEtDvfGPocnRuqRW4aIUU0UIDOA+gQDuLSgyF
         YmlniZJmebQmZd34Ny1UtExwxaxsXb4+v6Rm82Oo/5c5nYG4qC2ImWkuMwyzG5d7E7ZC
         vYMdmHt3ps6mg26zH9AC6n/XVRYkideGCFLiw2vVXon9LDgHqNx/befJs0zABw7OQwvd
         t8kXoO+6MuGBnquApHnp+2JkCiAeI4m+j/c2nU+aRd/9c1VIe31riEZ1K6z1xa4eJxZo
         W3TQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shaohua Li <shli@fb.com>,
	Jens Axboe <axboe@fb.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 21/68] blk-throttle: make sure expire time isnt too big
Date: Mon, 19 Mar 2018 19:05:59 +0100
Message-Id: <20180319171830.854453770@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390531816873601?=
X-GMAIL-MSGID: =?utf-8?q?1595390531816873601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shaohua Li <shli@fb.com>


[ Upstream commit 06cceedcca67a93ac7f7aa93bbd9980c7496d14e ]

cgroup could be throttled to a limit but when all cgroups cross high
limit, queue enters a higher state and so the group should be throttled
to a higher limit. It's possible the cgroup is sleeping because of
throttle and other cgroups don't dispatch IO any more. In this case,
nobody can trigger current downgrade/upgrade logic. To fix this issue,
we could either set up a timer to wakeup the cgroup if other cgroups are
idle or make sure this cgroup doesn't sleep too long. Setting up a timer
means we must change the timer very frequently. This patch chooses the
latter. Making cgroup sleep time not too big wouldn't change cgroup
bps/iops, but could make it wakeup more frequently, which isn't a big
issue because throtl_slice * 8 is already quite big.

Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-throttle.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -648,6 +648,17 @@ static void throtl_dequeue_tg(struct thr
 static void throtl_schedule_pending_timer(struct throtl_service_queue *sq,
 					  unsigned long expires)
 {
+	unsigned long max_expire = jiffies + 8 * throtl_slice;
+
+	/*
+	 * Since we are adjusting the throttle limit dynamically, the sleep
+	 * time calculated according to previous limit might be invalid. It's
+	 * possible the cgroup sleep time is very long and no other cgroups
+	 * have IO running so notify the limit changes. Make sure the cgroup
+	 * doesn't sleep too long to avoid the missed notification.
+	 */
+	if (time_after(expires, max_expire))
+		expires = max_expire;
 	mod_timer(&sq->pending_timer, expires);
 	throtl_log(sq, "schedule timer. delay=%lu jiffies=%lu",
 		   expires - jiffies, jiffies);
