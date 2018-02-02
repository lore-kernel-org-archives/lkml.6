Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227YvoGWp8GXyNMXoRwOkUzj8KjZEQw7+0zQrOl/GLfLl2G0829tA1NSepfBW697XvxC5CGF
ARC-Seal: i=1; a=rsa-sha256; t=1517590931; cv=none;
        d=google.com; s=arc-20160816;
        b=YMGOQauU0wVcC546fDOm1G5Wjxj7u4Fbz5cw7gTGQ2u85bXjWjjrhInJLyJi2RwcCq
         0j13XRHFgvRysPtEJFFKlSD0QUG5T1+GK8pvftplyC+2EFCCcfUiDNpY0uxBi7mDQG8a
         rRP3pf6Y+Sx9wZlItgT5U+xI60YKBkbVhQ9gz3kdVjdVzns8qqR0IoxGZgYp/HOyqW3i
         kj+YcATj7Rf34/9gh3JtFQ8W2Tg/dpp45FIRCRv3x2dRqA+GGNoYBHjiyAiyJgCetZF8
         nFdgbr13UTWN3VV6PnP6ThWsHOqnIXKx2yAeCWVAQVp6MK5LVtPAx+TUl0LZWHisuU17
         2sdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P0sc+ReApK0w8sJmDN5lf0YAFiYPJWZeJ9AmubF9s6Q=;
        b=XEGz0qGT0La91ndWAgtOU69i8kZBkjiFT9dlqSUqMk7biQ1h/1dbbUSmUjeckx1Yoa
         FgB92/j9ew1buWULYIFzDi5ITDqQLoTZ1yjeN+rCXRV0L8MKYaogVuSbGApXOgvYdhe4
         Jk5zK93rH6xcdoIZwNnM+SjnG4Lta7HzDSg+I+bv2JGIgay2Ob1sIBlFGGi7Prt8WxXx
         oc0917HYqcS5XPvkpriWHMgPDNcFhdX/gY89KJJTmworWlvmh09erpbUJ30NtAIwZP9H
         c1wUyGGYZvklgxxgt83XXLnsrYV7Tp30sxJei5+mpO2GWA+Du/fz+LLKdopSHy39WJVT
         U9vg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Lyle <mlyle@lyle.org>,
	Vojtech Pavlik <vojtech@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 29/67] bcache: check return value of register_shrinker
Date: Fri,  2 Feb 2018 17:57:58 +0100
Message-Id: <20180202140818.815534462@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309428712517955?=
X-GMAIL-MSGID: =?utf-8?q?1591309428712517955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Lyle <mlyle@lyle.org>


[ Upstream commit 6c4ca1e36cdc1a0a7a84797804b87920ccbebf51 ]

register_shrinker is now __must_check, so check it to kill a warning.
Caller of bch_btree_cache_alloc in super.c appropriately checks return
value so this is fully plumbed through.

This V2 fixes checkpatch warnings and improves the commit description,
as I was too hasty getting the previous version out.

Signed-off-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Vojtech Pavlik <vojtech@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/btree.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -808,7 +808,10 @@ int bch_btree_cache_alloc(struct cache_s
 	c->shrink.scan_objects = bch_mca_scan;
 	c->shrink.seeks = 4;
 	c->shrink.batch = c->btree_pages * 2;
-	register_shrinker(&c->shrink);
+
+	if (register_shrinker(&c->shrink))
+		pr_warn("bcache: %s: could not register shrinker",
+				__func__);
 
 	return 0;
 }
