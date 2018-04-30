Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoiOkuWeWMhX1Kl6AcGNG1e2V77RD9vD1ODkBCVlG4ThnDu+8x2UGrUDThaVUP3W/tDi6MU
ARC-Seal: i=1; a=rsa-sha256; t=1525116446; cv=none;
        d=google.com; s=arc-20160816;
        b=fNybugyD+Q5op0pzKIxEDBFGsoJh9eDg0J7oDA9iye/tbRhcc0ZgsWbScPC8S5qeVt
         FbamQAxHNI/VVBSWQo5kc931K/hKZcALpE1c6Z0levtsjy+Gzdv4474jvwjzKBEBrQlm
         +wK1Dj5lJfH0m5c/WTyj/7Fdv+VseQ9F2G8Bk+KHG6S9N/9LYc85F4zJC8qRqfpsJ5eF
         1T5tl+akHE9yXh2E4W307s15bVmjc6s+4ZlI7jqYhLsNXg+NRi3ZR8yi4iH856R/3VR7
         D4mUaFHWOB3O8qUlIHUW2UZpJ4QRyQpcMzwTJ0NseaeVd/LsvYxukIB6Xm9lgQ7EeNCu
         X/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=SYWn/NVvNwt8tevKIboiMQYHRhlb63diNwGidwdNw88=;
        b=TcRmXN4Ir2wsVV47NXg1wnpWwMP5MKd2HaeKAL+njFzmR+owM7ZI9/0+o5O9BQ3QC/
         HEZ9NuewdpBD37msYDHjL/4+q5GFKv9ccly8YUq7018OjeF2PcLynS+sczU/SBcrDF33
         47HczVTZSulU03fbspD6FMOe2IkKjR8p411fqI4kRrX9JqfPnJhq1oT0mCTfJ9pf06fq
         Bl2tTxG9CShQ5rk9StQDxNB/8+nzcwGCR0UzLDMQr0L9qv19Q/kLK5CvdK7T53kyW8mA
         1AmEz/LWKQy0lbv3lVoG2B99MgSozpSIICXHzK6OIQXnkZhGQ/kxJMwG47esi7MMBAOr
         GYpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DC822DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Kees Cook <keescook@chromium.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 57/91] bfq-iosched: ensure to clear bic/bfqq pointers when preparing request
Date: Mon, 30 Apr 2018 12:24:39 -0700
Message-Id: <20180430184007.145652337@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200567169556340?=
X-GMAIL-MSGID: =?utf-8?q?1599200502835122945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 72961c4e6082be79825265d9193272b8a1634dec upstream.

Even if we don't have an IO context attached to a request, we still
need to clear the priv[0..1] pointers, as they could be pointing
to previously used bic/bfqq structures. If we don't do so, we'll
either corrupt memory on dispatching a request, or cause an
imbalance in counters.

Inspired by a fix from Kees.

Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reported-by: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Fixes: aee69d78dec0 ("block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bfq-iosched.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4447,8 +4447,16 @@ static void bfq_prepare_request(struct r
 	bool new_queue = false;
 	bool bfqq_already_existing = false, split = false;
 
-	if (!rq->elv.icq)
+	/*
+	 * Even if we don't have an icq attached, we should still clear
+	 * the scheduler pointers, as they might point to previously
+	 * allocated bic/bfqq structs.
+	 */
+	if (!rq->elv.icq) {
+		rq->elv.priv[0] = rq->elv.priv[1] = NULL;
 		return;
+	}
+
 	bic = icq_to_bic(rq->elv.icq);
 
 	spin_lock_irq(&bfqd->lock);
