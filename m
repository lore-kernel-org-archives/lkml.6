Return-Path: <kernel-hardening-return-13084-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49WYffrdUPQck1fCmnctT0DRCidBPDygwWTxpwMdRhTm6w3cq4r/1PMPm4LeeaIqWm/y1PI
ARC-Seal: i=1; a=rsa-sha256; t=1524414797; cv=none;
        d=google.com; s=arc-20160816;
        b=LfduvACo2pUwGQer6iVxn6dwRpZTZnTNW6+M3iVRPbexvYGRN8Y46gtaQKcriCTsC5
         v8cQTNBG2/FsOKsPMDjQ1PyuUAZVWgDn/izMTo8mZtZyWdxGTtQj2JLUhYGHZQVpLwrj
         DZEAAuWquUduJfLTNkX4Q/BRa3qMQ6kAsIVB7LmXu7fMJVxgiwVj1Y63Tkpefn3iMCrz
         uHawjXceWjZ8jPUD5f674hspNMykf7QhJ/A1NMSDW+zDUWnB8059XpzGjNGFNwRLc2zS
         +rm8xhWzrwhFoyyssozBgBIL3P8voSaLoKHQ9WThU0vEGmXp0MeU+b5NP+pGpNB5mRpn
         4eXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=tdmD3Dr99ns/zjQi4fbmXsMZMEmBPK/bZnnaR/3GPkw=;
        b=eNJlCyisstQtHmJCFFpMUfGAQVRNnvotU96mM7QwDF4d+I4NjoEuVCtQSVUh+dPi9p
         mbmP1SwyLby6XBZ5RQKoZWsX3MBWCRpYVceK8B03JG8XzEH8qiP9gV6UPGp/N2Wz+SQY
         FMehxMc4J8Ty4WqRG1eUA8OZkmODMAbpCECfYl5t+6jR07OH2exQmVUn+sWWxo4KkLWG
         CDopHwMANhGKAkTDcEfeouK4BQOKDR2zPcaH+z3sUlOpHW3WwM6EIjFrsTPdSsY6OKGU
         jZclP/Y8yScRmf8QdgvcKqLKHO7YuUQu4wW6lewfV7W8/YsV+/rQvaqmPvpleBhxHI2y
         WEdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13084-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13084-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13084-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13084-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180422162513.093459051@linutronix.de>
User-Agent: quilt/0.63-1
Date: Sun, 22 Apr 2018 18:23:54 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Andrew Morton <akpm@linuxfoundation.org>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [patch V3 09/10] mtd: rawnand: diskonchip: Allocate rs control per
 instance
References: <20180422162345.004292133@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=mtd-diskonchip--Allocate_rs_control_per_instance.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598464770902033323?=
X-GMAIL-MSGID: =?utf-8?q?1598464770902033323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

The reed solomon library is moving the on stack decoder buffers into the rs
control structure. That would break the DoC driver because multiple
instances share the same control structure and can operate in parallel. At
least in theory....

Instantiate a rs control instance per DoC device to avoid that. The per
instance buffer is fine as the operation on a single DoC instance is
serialized by the MTD/NAND core.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Andrew Morton <akpm@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Alasdair Kergon <agk@redhat.com>

---
 drivers/mtd/nand/raw/diskonchip.c |   60 +++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -66,6 +66,7 @@ struct doc_priv {
 	int curchip;
 	int mh0_page;
 	int mh1_page;
+	struct rs_control *rs_decoder;
 	struct mtd_info *nextdoc;
 
 	/* Handle the last stage of initialization (BBT scan, partitioning) */
@@ -123,9 +124,6 @@ MODULE_PARM_DESC(doc_config_location, "P
 /* Number of symbols */
 #define NN 1023
 
-/* the Reed Solomon control structure */
-static struct rs_control *rs_decoder;
-
 /*
  * The HW decoder in the DoC ASIC's provides us a error syndrome,
  * which we must convert to a standard syndrome usable by the generic
@@ -931,7 +929,7 @@ static int doc200x_correct_data(struct m
 				calc_ecc[i] = ReadDOC_(docptr, DoC_ECCSyndrome0 + i);
 		}
 
-		ret = doc_ecc_decode(rs_decoder, dat, calc_ecc);
+		ret = doc_ecc_decode(doc->rs_decoder, dat, calc_ecc);
 		if (ret > 0)
 			pr_err("doc200x_correct_data corrected %d errors\n",
 			       ret);
@@ -1422,10 +1420,10 @@ static inline int __init doc2001plus_ini
 
 static int __init doc_probe(unsigned long physadr)
 {
+	struct nand_chip *nand = NULL;
+	struct doc_priv *doc = NULL;
 	unsigned char ChipID;
 	struct mtd_info *mtd;
-	struct nand_chip *nand;
-	struct doc_priv *doc;
 	void __iomem *virtadr;
 	unsigned char save_control;
 	unsigned char tmp, tmpb, tmpc;
@@ -1562,8 +1560,25 @@ static int __init doc_probe(unsigned lon
 		goto fail;
 	}
 
+
+	/*
+	 * Allocate a RS codec instance
+	 *
+	 * Symbolsize is 10 (bits)
+	 * Primitve polynomial is x^10+x^3+1
+	 * First consecutive root is 510
+	 * Primitve element to generate roots = 1
+	 * Generator polinomial degree = 4
+	 */
+	doc = (struct doc_priv *) (nand + 1);
+	doc->rs_decoder = init_rs(10, 0x409, FCR, 1, NROOTS);
+	if (!doc->rs_decoder) {
+		pr_err("DiskOnChip: Could not create a RS codec\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
+
 	mtd			= nand_to_mtd(nand);
-	doc			= (struct doc_priv *) (nand + 1);
 	nand->bbt_td		= (struct nand_bbt_descr *) (doc + 1);
 	nand->bbt_md		= nand->bbt_td + 1;
 
@@ -1613,7 +1628,6 @@ static int __init doc_probe(unsigned lon
 		   haven't yet added it.  This is handled without incident by
 		   mtd_device_unregister, as far as I can tell. */
 		nand_release(mtd);
-		kfree(nand);
 		goto fail;
 	}
 
@@ -1626,6 +1640,9 @@ static int __init doc_probe(unsigned lon
 	   actually a DiskOnChip.  */
 	WriteDOC(save_control, virtadr, DOCControl);
  fail:
+	if (doc)
+		free_rs(doc->rs_decoder);
+	kfree(nand);
 	iounmap(virtadr);
 
 error_ioremap:
@@ -1648,6 +1665,7 @@ static void release_nanddoc(void)
 		nand_release(mtd);
 		iounmap(doc->virtadr);
 		release_mem_region(doc->physadr, DOC_IOREMAP_LEN);
+		free_rs(doc->rs_decoder);
 		kfree(nand);
 	}
 }
@@ -1656,27 +1674,12 @@ static int __init init_nanddoc(void)
 {
 	int i, ret = 0;
 
-	/* We could create the decoder on demand, if memory is a concern.
-	 * This way we have it handy, if an error happens
-	 *
-	 * Symbolsize is 10 (bits)
-	 * Primitve polynomial is x^10+x^3+1
-	 * first consecutive root is 510
-	 * primitve element to generate roots = 1
-	 * generator polinomial degree = 4
-	 */
-	rs_decoder = init_rs(10, 0x409, FCR, 1, NROOTS);
-	if (!rs_decoder) {
-		pr_err("DiskOnChip: Could not create a RS decoder\n");
-		return -ENOMEM;
-	}
-
 	if (doc_config_location) {
 		pr_info("Using configured DiskOnChip probe address 0x%lx\n",
 			doc_config_location);
 		ret = doc_probe(doc_config_location);
 		if (ret < 0)
-			goto outerr;
+			return ret;
 	} else {
 		for (i = 0; (doc_locations[i] != 0xffffffff); i++) {
 			doc_probe(doc_locations[i]);
@@ -1687,11 +1690,7 @@ static int __init init_nanddoc(void)
 	if (!doclist) {
 		pr_info("No valid DiskOnChip devices found\n");
 		ret = -ENODEV;
-		goto outerr;
 	}
-	return 0;
- outerr:
-	free_rs(rs_decoder);
 	return ret;
 }
 
@@ -1699,11 +1698,6 @@ static void __exit cleanup_nanddoc(void)
 {
 	/* Cleanup the nand/DoC resources */
 	release_nanddoc();
-
-	/* Free the reed solomon resources */
-	if (rs_decoder) {
-		free_rs(rs_decoder);
-	}
 }
 
 module_init(init_nanddoc);
