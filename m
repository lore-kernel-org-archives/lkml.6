Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt9XzP7gB7V1Eb91/tTmKhL+c6NiRIdRODIPE3TZgno1xQj3pLclsqO7nTLFarKFqsuQKK6
ARC-Seal: i=1; a=rsa-sha256; t=1521483250; cv=none;
        d=google.com; s=arc-20160816;
        b=iciybY457c2lqqvE+hl1yV3FUIaTHqvagJli7NAANsmvgmYiFetRwDWj9ZGtNYYnmS
         IyxOyFpWP3VR0fye6LYBVvglQ/BpbDwqkdqARDgRvmS5hmSEN5nko9BepJU90oNQ/AFt
         eKvn4mvZ9HGfRKz61cvE4wmbwkR6LLHgL3nNBSK+v4/RbZLSZ45lAyUscOWARt23zZwq
         0c8NKAi9jXnOTJdIg6AhedZhZ0CeTwjuCfp6NfCgSxa4i91YxGkpKVk9D66GY8rrotSo
         uNN4FbppLfmUx3dllIzN3GNpntOlPox+F/eIBdGmhupkJIUGxbxDTy0RNE/XmzQoth+P
         jO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PmAzYEFqfrLkF0kVGPz8ZsxaiqM99BwLrhnhVBJhmZA=;
        b=Ms2kgR515/kcJRPvgeX0p2fIpWhxj6qRwQ2FuqxAt98zrobQoPFeDjCDOxWiBRZVKj
         VYeb4IEESFCHBlfHABGFnn6ulXvfrJVQwca8Buw6I+OdpGsO806g5GzYjzJpcTQIE73y
         TyYUT4d7Wv2EGVwIzRHJwTkweOhCLZRLFUM+Pd0RrJQLL/9dMPIy78Sw4R9fnS/iGRC0
         4t0WVimw1LkF/VADgYPgwKKQOan9LJzQU4XvGvgNvRaIrd/o9ffLV2SMUSyYezxUsh0F
         sX6/p9dJrgs3DV2N+a6cjlDiS62A7uRBVqjnw7aiV6M+x+0ZsnjmqjlMg+seRNj5cnCP
         S5zA==
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
Subject: [PATCH 4.4 037/134] blk-throttle: make sure expire time isnt too big
Date: Mon, 19 Mar 2018 19:05:20 +0100
Message-Id: <20180319171854.688877866@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390531816873601?=
X-GMAIL-MSGID: =?utf-8?q?1595390820111813458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -505,6 +505,17 @@ static void throtl_dequeue_tg(struct thr
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
