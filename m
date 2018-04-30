Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrTwp8jVkHbpWCknIyXqmKPRvNlWD6xo+Heuo1tEcEQ+7IgEgNSJtYZBBbGMgHmxE48xveR
ARC-Seal: i=1; a=rsa-sha256; t=1525116442; cv=none;
        d=google.com; s=arc-20160816;
        b=TFFgRNCytV0AXpr6MKJQjFcOtDjztFCZ2Bl5ZIODwZUeLg/jE96SBVOjfafXxdDZ2k
         kd8pP0iHjvhIkM2y8AelRmn4m7+uGCADC2/k0H2FAQJFdvyo1/aqY6Y4HK3RlfsF92rf
         VEKqmcG+aRevrABmVEt5Cg+v6yRyaUlz8zgR9PGRFs3HKX7v4EdMy3s87KNGSLOfTm5R
         TxpH4Us7BABXt4kG+OEbB7UFunAyU2QzqvxuwOyHnalicIQ49jgnnDnYS0ey3ebB5NGx
         AACh1Auz3vCQU6jekch9JE9l5u7lvSnUzCSP5+Az01BKFGTxvbokQdn44LkwzY5MjlMG
         NIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=FvnpPqrqC3r3KAWvaNa9sDF8owUKAXenE/o40wu3wLM=;
        b=NDr/PTGTfdfVQq1rUiIMk6EZkDDbfNMO/VLRd6e9SY2BeMiDCurVtvjWc8TXD1QPP/
         MwzMIiaykib2tUkg5/iRmdpxBmdn7dmqAOdjovt3wb2YTpqo2AZz28w9MeLHU8C1yFW1
         PtX+sDuHRTAB6rbiEUs7ALighr4EhbZAfZJL3kKaoQeERW/vEhKrcdS+KGXg3zETAUhq
         YjmVJr0qTabuCPtCoxG0EEpARfW1+P1bDeHmZnW9KIsXgt1jZ21yEQdeOHSZhEDite7A
         aKJq0OUUZn6qCYdoyEG8iOb7tsS0M/oqPkZw3PiVWtYbpGn539svr7fgKoCgPlC80krp
         qNKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D84022DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Joakim Tjernlund <joakim.tjernlund@infinera.com>,
	Richard Weinberger <richard@nod.at>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.14 52/91] mtd: cfi: cmdset_0001: Workaround Micron Erase suspend bug.
Date: Mon, 30 Apr 2018 12:24:34 -0700
Message-Id: <20180430184006.893708743@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200283537847620?=
X-GMAIL-MSGID: =?utf-8?q?1599200499120661509?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -836,6 +848,11 @@ static int chip_ready (struct map_info *
 		    chip->in_progress_block_addr)
 			goto sleep;
 
+		/* do not suspend small EBs, buggy Micron Chips */
+		if (cfi_is_micron_28F00AP30(cfi, chip) &&
+		    (chip->in_progress_block_mask == ~(0x8000-1)))
+			goto sleep;
+
 		/* Erase suspend */
 		map_write(map, CMD(0xB0), chip->in_progress_block_addr);
 
