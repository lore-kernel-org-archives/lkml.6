Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp+7w8GWNz67R5jo4FsP6czf0k9hrZESqCVowCfyYTzZ3exMNtnujF9JsxNJLbGAWcsxcWR
ARC-Seal: i=1; a=rsa-sha256; t=1525116237; cv=none;
        d=google.com; s=arc-20160816;
        b=aX2riKpNocirI4W0IHUcYh/CaVLI0Rk18O34pcYCpeSb17T3Zt06RMPjnsW6n396Hh
         ChgtpB5YxNJgeRkO+35qn5i3hm5dK8xjKsWIkoLhu+i+KC2m92uN1gMItcjTyCF95WNq
         fE+084Uys0jyYVEIJcZYuZWEUbMod4XPrz8gogYSLIZpaKF+7VjA7R4yqezWnQv9f7Jb
         1fFBvnRLD3KL2813uNzdZgcSpecg+2fIqOS6ZpWRJkN73XFLJrvzpUGOaAoOMv1fi4l9
         AJqrlh5P/Toh/qCUx1mVQ4LKQnlwIELXff07kUeLJ/eriUH6HbKX3xR+VAbvl2MmFfkr
         MyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ePPbxZgkg1+6mZVIYaLp2j9XmJtfOObyxXwoJlEHxhA=;
        b=kf5SPACDMcluNQD6qkYqFXqUh4l/IZJLXYAIlPoZXeFJvo1UDMZxq8gu8BExIFN/OI
         HwypYvKfEh9QJXU9x69j06le0FAdJ1Kb70LBH3vVNtel6qkv7XRs0FD51+15MLOj5v+E
         DAtz+UP58VCDm9eyYmTV2mUZu5Ey4PmxMbfbWD+/6BBIKCs0a5JrQfukp/+9cQpU7cgC
         NZ7vsDdyvoS+pPr9phqcD9XzWkwPsedeQAlErNHGmty0XswwSPU/N9CaXY7lAt/1gGNK
         Rtz0x3ZNxMLrZFo7kk6mHO1+Qls+4We0f9Z+YkZfKTmbmrURSEkKia04HKZaDswS/dUD
         6IUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCA222DBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Joakim Tjernlund <joakim.tjernlund@infinera.com>,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 3.18 19/25] mtd: cfi: cmdset_0001: Workaround Micron Erase suspend bug.
Date: Mon, 30 Apr 2018 12:23:26 -0700
Message-Id: <20180430183911.601983296@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200283537847620?=
X-GMAIL-MSGID: =?utf-8?q?1599200283537847620?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joakim Tjernlund <joakim.tjernlund@transmode.se>

commit 46a16a2283f9e678a4e26829175e0c37a5191860 upstream.

Some Micron chips does not work well wrt Erase suspend for
boot blocks. This avoids the issue by not allowing Erase suspend
for the boot blocks for the 28F00AP30(1GBit) chip.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/chips/cfi_cmdset_0001.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -45,6 +45,7 @@
 #define I82802AB	0x00ad
 #define I82802AC	0x00ac
 #define PF38F4476	0x881c
+#define M28F00AP30	0x8963
 /* STMicroelectronics chips */
 #define M50LPW080       0x002F
 #define M50FLW080A	0x0080
@@ -375,6 +376,17 @@ static void cfi_fixup_major_minor(struct
 		extp->MinorVersion = '1';
 }
 
+static int cfi_is_micron_28F00AP30(struct cfi_private *cfi, struct flchip *chip)
+{
+	/*
+	 * Micron(was Numonyx) 1Gbit bottom boot are buggy w.r.t
+	 * Erase Supend for their small Erase Blocks(0x8000)
+	 */
+	if (cfi->mfr == CFI_MFR_INTEL && cfi->id == M28F00AP30)
+		return 1;
+	return 0;
+}
+
 static inline struct cfi_pri_intelext *
 read_pri_intelext(struct map_info *map, __u16 adr)
 {
@@ -830,6 +842,11 @@ static int chip_ready (struct map_info *
 		    chip->in_progress_block_addr)
 			goto sleep;
 
+		/* do not suspend small EBs, buggy Micron Chips */
+		if (cfi_is_micron_28F00AP30(cfi, chip) &&
+		    (chip->in_progress_block_mask == ~(0x8000-1)))
+			goto sleep;
+
 		/* Erase suspend */
 		map_write(map, CMD(0xB0), chip->in_progress_block_addr);
 
