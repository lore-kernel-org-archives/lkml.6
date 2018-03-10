Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsKPPMThuXLXH6WOJiMjNyLTwUFViwNloiUa/v8iMLZELrRw6fwdyy/Hu6Yj4EYej+PNKX/
ARC-Seal: i=1; a=rsa-sha256; t=1520641171; cv=none;
        d=google.com; s=arc-20160816;
        b=TM4FUKSdnCTeM3iZGRly0SSOHX8dV+htJDd87q+GcJckBm6xAbQaK2vdujbpAISrTn
         cBEwqODqMqzYDk1UY3UKvscRULdumvq2CHj8GOJrbkN3d3cnkrKtwkUKFmOmvpsksk08
         UKHVbgz9rN2J3CLpXZCbJeBWFWq2K9sRLKhZ7UpWupgL75skc7Kqvxai6rTUHYk7e8f9
         /464Q0E9qysXpKrMaIkwP85rmSIv6jaodlPQi3WuIArZmLnv6Ib5rmy7SHeA+w4a9UTB
         Fk3jM+I89Qls74l0efF6v6tQmZVPXg/KFRjCkV+K/HtuCG61UuyH59OJYYGxWj4KAkp8
         rppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2ZDCwdYaKku6iYwcMuOpfn9oMgCq1IsRRjN0i6VssEo=;
        b=BrsZSX032e2erNHFmQ9jXhwbOPW/buGQtGV8q/kjU5nxG0tX+31yrUsRZKRP098PG1
         /46TiQMoUdKloK9TMhwPaqocMdvls0tLeRuLm8N6tHb9RKE18556F7fCweTDjBaNMHVo
         2wkY62cDAopbxjCagLdrB6zS2UsxqstST41IeLwZrMRUy6UVXVcPFYoXl0eY3MaOBzuH
         iEGXzFUKM2ZAXjWKxEE0WrAHTdZm91zTTRfM3r7ZYoC0nlz2GGvCbxo34ck/CZl34jkf
         u7QIHEXMgynk3vZ/enNjClSvUuKCSjhpN6rYbEfInEF1cqKJ+NIpFaJbL0LcZUJQhtlE
         4Dhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhang Yi <yizhan@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 3.18 21/21] dm io: fix duplicate bio completion due to missing ref count
Date: Fri,  9 Mar 2018 16:18:43 -0800
Message-Id: <20180310001802.413510669@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507837427893471?=
X-GMAIL-MSGID: =?utf-8?q?1594507837427893471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit feb7695fe9fb83084aa29de0094774f4c9d4c9fc upstream.

If only a subset of the devices associated with multiple regions support
a given special operation (eg. DISCARD) then the dec_count() that is
used to set error for the region must increment the io->count.

Otherwise, when the dec_count() is called it can cause the dm-io
caller's bio to be completed multiple times.  As was reported against
the dm-mirror target that had mirror legs with a mix of discard
capabilities.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=196077
Reported-by: Zhang Yi <yizhan@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-io.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -299,6 +299,7 @@ static void do_region(int rw, unsigned r
 	else if (rw & REQ_WRITE_SAME)
 		special_cmd_max_sectors = q->limits.max_write_same_sectors;
 	if ((rw & (REQ_DISCARD | REQ_WRITE_SAME)) && special_cmd_max_sectors == 0) {
+		atomic_inc(&io->count);
 		dec_count(io, region, -EOPNOTSUPP);
 		return;
 	}
