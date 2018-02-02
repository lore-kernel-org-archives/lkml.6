Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224OtxJVqayYQx+Qg2HQfG3CJ3p68PEMjkyAMV6Lc3atA8CFUJGZKEfh9jaenJh6WZr4vhbE
ARC-Seal: i=1; a=rsa-sha256; t=1517591389; cv=none;
        d=google.com; s=arc-20160816;
        b=s1wQOpBlZIy2+feWW0cptZFqhgGkHaadcD7HDAJMhJIbH6lItiYNtsO7WL+ujwYGf/
         w8F8+lLXAOvHIXx2NKCumMFvVoAKolruoMEwtFcV2RVU327obwYbkpUS3j3Wo8UZKDA5
         wGH72WNDhn26Nl+IR/c/hv74tJW7UA47NpPyokOAQn4lXoi6IgQcfHK70W2EBlgIGfjl
         Rm2blvbqf8mWlaL3EBwm9I4uX+yYL5iwgBOkMKTHzDIyQgHi/aWVm0aI7Fu1T+sFi5lt
         YgTmkpPylQOp/oxO3UttQF7AbEiAV2db29BEUGHnojcdXv+WmmryfDO5I5hjolVRm25f
         YcTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IcNeQ7Ke8ZyZ+BMEmB7NRoyNv4but60xLPzLDOTOXuw=;
        b=BX0qknMGE9K98ltgcz7bANW47ZjKZlpTIwcuen//UE9intXhIFdwyJJU76euIdgK0e
         4QErQfq2AEJ5PJy8j8O+LErVsJ+ZPrdu0LmR1H4XpdOvP73gcST6K5lS2WY33nd1YOBP
         dVJVZCmNJYZUHGwtpgF998ctYse+n7DnVHyHg85quurE3nfYpueHJdwVjVbyCMVTZDVB
         o5pIsPOe4y/Z515KOB09t/ZzUzdy2lDbuceN83PnhV8CT56+f5mPQE9pXwjGNtMthgqI
         ZSF4TwZkFxRiays2cVX3Ytqk6/JadSqkJQQ2CoFlu9sGU93XgG6SU/NS5JBGkjHEELUg
         oDow==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 061/156] bcache: check return value of register_shrinker
Date: Fri,  2 Feb 2018 17:57:22 +0100
Message-Id: <20180202140843.061297415@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309428712517955?=
X-GMAIL-MSGID: =?utf-8?q?1591309908954063461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/btree.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -807,7 +807,10 @@ int bch_btree_cache_alloc(struct cache_s
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
