Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225wwT2NYz3Q3R/lN0Wvwuhrz+//djEMUNQ1PnOxatsmok3jYpp5/Zq+gt56rBlCmrvu+MPe
ARC-Seal: i=1; a=rsa-sha256; t=1517855174; cv=none;
        d=google.com; s=arc-20160816;
        b=wdWlKnkhSDylewsdxRoe8mN1DpYRxdysQatdQ/VAC5QAVrqOqel42g0JErTpWhiZK8
         XklwF9MVuEEgYzdLELD33ib+7VjfbrS8Wjxglxn0nd+Yz0emrk8cKS8Q3K/SHBavBiX/
         rRe8LJPO1uTV9gbIE7/QyHvEoptTDjtsXNzC0DdJ7FbDQTo8guQ+6+j3UmVcE5EVOh6m
         /Uh9BR6UMxMyiSKkZgSGWIJzVLWAcsfFLAp+oHwZpcyUIMo5LxJTP4NiaYZo8Mn9DZ4r
         nS1ZZU97BEist+lLJetlZ6KLzccleWbLRYvLaGbFm4++uZZ4NimoycM+2J+ssEXtdcLh
         sHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IWB9tiqsxRLgJlrED9n19y1p/z/hgSctqkjzNENr77Q=;
        b=ZVIfqlHUQtpJIpAlyfW2I4A0yN7MLfiNG7Jj8nW+Tc5AZQyB095CmY7LAN+jTcJjRq
         e99KfHv9iVb/ofXXNXaxWni/AsnWTex3L7oOFcbK6mo6wyWJMjAfBGqtuKYdVxvvjCms
         tjMhm9Ra6A1lljlGXmNfp9MHIYx7wxHguvRqaFUUhdweoTUE/+D+BMvb45dw5MfepiYi
         w8Yc/bDyY+cWgs/a6bkYISLLKP9e2lLCKyiO+2PPKyAerxap9g+FMnC++Xs2OVq18M7r
         WSsqF+S2hZnmZZoCsjdlzbR8/i8hNlGFYsTquT54V18zIgm1AJisNwooZKZhPMrP/aBg
         I4dg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Lyle <mlyle@lyle.org>,
	Vojtech Pavlik <vojtech@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 12/36] bcache: check return value of register_shrinker
Date: Mon,  5 Feb 2018 10:23:40 -0800
Message-Id: <20180205182352.277832238@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586507731769283?=
X-GMAIL-MSGID: =?utf-8?q?1591586507731769283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
