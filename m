Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225VQuiqxPnSehrTe80z3OZrCCSeDBsC6jCEeuNkTeRlaTbGOCUR4YnYTVNYTYepk5GRHV0D
ARC-Seal: i=1; a=rsa-sha256; t=1517591030; cv=none;
        d=google.com; s=arc-20160816;
        b=hBzljvDhh8d8ajhVxIJSIV2AUzUQcwXQf9f7Zm+EdjEj7VNNzZhUFvFmJEa/7e+EGr
         l+yWIAoMCcKLAGoeGczRd6q/j3sdsTQxtmy8m6owzLTyGKOeaF37fN4KaPjvpFEskcRq
         Vkujqmd6y6enaA6sTMcGzcgAH6L5XXQCUYshsVq5P2s7basI3bNCnz0IGK14ZzIPK0nz
         sDzmrbxH5cH+W1vuyn7hrMU7VMCjvaOSNID1xwd32khlL6TFyL8+7jpiomFeKEwfgtPp
         AYZJAovmLcuuU4kMs0mdLexvB6q+eC0WI3PmmFpfcw+3rnqhzomBMnDMtT+E6nerCt/z
         VmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QpTiy4RLpLMsRJrs6Ze/I8o1Gaiy35ZS9NIMi1/AJCw=;
        b=HrjewLXBB711Mc9VNHDyPiT97m6HQX/tOm8Nnh+J3PJJX9tKkr1PYoMIzHMGOHQYrb
         iOL0BiUHJLSAN6dHQRDIbw3RaEyZsQ3qet8J9WlIa/aNYcIKgqGSLzlO1Bpryx4e7vET
         Sxu4L8ndrLH9wI0O1H4qyg1xCeGAPHPtwRcSV0+3zUnfFWR0aUjYex7IZn+7Q/qFVUYt
         t1or7k2u0o0xFlZLP/AMJtPlnOtaLzL68NxPjLpU37etLuuIUTcpbd+PgImQtLH8uvpI
         QMDJUNPSQIpN6qVU2D9TgiVsa2rP0zNwH8njUq73B5H6oci/pOdhTAcQOr6XCtiXckL2
         wk1g==
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
Subject: [PATCH 4.9 28/86] bcache: check return value of register_shrinker
Date: Fri,  2 Feb 2018 17:57:48 +0100
Message-Id: <20180202140825.175201232@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309428712517955?=
X-GMAIL-MSGID: =?utf-8?q?1591309532055006647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -803,7 +803,10 @@ int bch_btree_cache_alloc(struct cache_s
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
