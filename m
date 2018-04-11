Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+/4px7bXciAyWZ4LPmJnBfNHLoUlqGkRMIHuLonpcX0RmiCaVZJ06suUdrH1Z0SFDcTS/Q
ARC-Seal: i=1; a=rsa-sha256; t=1523473226; cv=none;
        d=google.com; s=arc-20160816;
        b=DRD5l/fVxd3lUhj2Hh5WWhTLCGRHuSPOPsusJyZ5yQ6Sg+ecDKLi2yCIfeyed+1wC6
         OULwh15rrvPGKLkxfcJJaJ6ZVPK8ff3uy4UWo83nsiMgjiyNz3GJ3VUSV0/AwenVezG2
         TAzlyyT8By7V1NbnIA8Q1cpwxVoGVUhD6d4xv80dCkSNfAvK5MZmAKEj1t6DmcpG4g3V
         NT8Hklum3lLQ5HcEuRrUNff//yDymzbpPtCovytWr7OZliQjj0TZyO8+/P1jbf5eLBvN
         3maj6OgcnPhOq0phfjAIqU2FDW38YKeNjpDq06JaoHNpejEV1BUdLVzq8OEWtJpIVIRH
         A2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QMp4atpLVoWIY/Gtno4AcdCJhcV3f7coDNIwyb/NL6c=;
        b=qliiiwaiLJC1qiuIb7NrZOTxWkpz+xZupBQZYhteOqHNmmelalcXsIXqUolNHTuJbQ
         gU6quzsxhWmSU8tMA4RjI7zCcBzoRKheHyRGjW7qIqcfRsHV3CANOZvCKol7oI505klV
         0Pw1CQWev+WhgPSxSEIYkJlWUJP0h2fz9zAG1nTIYv/L69e6w5MUtj8X9DYS6JSmJHhg
         I4a7fgIuERx149evrPCXMJKLhbstjiRKrCPgeJ91oY5U4qdBaht4zczQwQB+oCpJPPFX
         OjvoHLW9EYiXl4oGFt9eSnOvRVZf1yR4xcVItvfQdHHZEJRRs3cjd2fDE7PwZc5ZTRVY
         2ZLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Han Xu <han.xu@nxp.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 169/310] mtd: nand: gpmi: Fix gpmi_nand_init() error path
Date: Wed, 11 Apr 2018 20:35:08 +0200
Message-Id: <20180411183629.881965851@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477461558584954?=
X-GMAIL-MSGID: =?utf-8?q?1597477461558584954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@free-electrons.com>


[ Upstream commit 4d02423e9afe6c46142ce98bbcaf5167316dbfbf ]

The GPMI driver is wrongly assuming that nand_release() can safely be
called on an uninitialized/unregistered NAND device.

Add a new err_nand_cleanup label in the error path and only execute if
nand_scan_tail() succeeded.

Note that we now call nand_cleanup() instead of nand_release()
(nand_release() is actually grouping the mtd_device_unregister() and
nand_cleanup() in one call) because there's no point in trying to
unregister a device that has never been registered.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Acked-by: Han Xu <han.xu@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -2047,18 +2047,20 @@ static int gpmi_nand_init(struct gpmi_na
 
 	ret = nand_boot_init(this);
 	if (ret)
-		goto err_out;
+		goto err_nand_cleanup;
 	ret = chip->scan_bbt(mtd);
 	if (ret)
-		goto err_out;
+		goto err_nand_cleanup;
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
-		goto err_out;
+		goto err_nand_cleanup;
 	return 0;
 
+err_nand_cleanup:
+	nand_cleanup(chip);
 err_out:
-	gpmi_nand_exit(this);
+	gpmi_free_dma_buffer(this);
 	return ret;
 }
 
