Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932251AbeCDMPl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 07:15:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:9158 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752026AbeCDMPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 07:15:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,422,1515484800";
   d="scan'208";a="34508822"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 2/3] tpm: add new tpm2 commands according to TCG 1.36
Date: Sun,  4 Mar 2018 14:12:04 +0200
Message-Id: <20180304121205.16934-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180304121205.16934-1-tomas.winkler@intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. TPM2_CC_LAST has moved from 182 to 193
2. Convert tpm2_ordinal_duration from an array into a switch statement,
   as there are not so many commands that require special duration
   relative to a number of commands.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm.h      |  41 ++++++----
 drivers/char/tpm/tpm2-cmd.c | 188 +++++++++++++++-----------------------------
 2 files changed, 90 insertions(+), 139 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 192ba68b39c2..b82b924d763c 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -126,22 +126,31 @@ enum tpm2_algorithms {
 };
 
 enum tpm2_command_codes {
-	TPM2_CC_FIRST		= 0x011F,
-	TPM2_CC_CREATE_PRIMARY  = 0x0131,
-	TPM2_CC_SELF_TEST	= 0x0143,
-	TPM2_CC_STARTUP		= 0x0144,
-	TPM2_CC_SHUTDOWN	= 0x0145,
-	TPM2_CC_CREATE		= 0x0153,
-	TPM2_CC_LOAD		= 0x0157,
-	TPM2_CC_UNSEAL		= 0x015E,
-	TPM2_CC_CONTEXT_LOAD	= 0x0161,
-	TPM2_CC_CONTEXT_SAVE	= 0x0162,
-	TPM2_CC_FLUSH_CONTEXT	= 0x0165,
-	TPM2_CC_GET_CAPABILITY	= 0x017A,
-	TPM2_CC_GET_RANDOM	= 0x017B,
-	TPM2_CC_PCR_READ	= 0x017E,
-	TPM2_CC_PCR_EXTEND	= 0x0182,
-	TPM2_CC_LAST		= 0x018F,
+	TPM2_CC_FIRST		        = 0x011F,
+	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
+	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
+	TPM2_CC_CREATE_PRIMARY          = 0x0131,
+	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
+	TPM2_CC_SELF_TEST	        = 0x0143,
+	TPM2_CC_STARTUP		        = 0x0144,
+	TPM2_CC_SHUTDOWN	        = 0x0145,
+	TPM2_CC_NV_READ                 = 0x014E,
+	TPM2_CC_CREATE		        = 0x0153,
+	TPM2_CC_LOAD		        = 0x0157,
+	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
+	TPM2_CC_UNSEAL		        = 0x015E,
+	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
+	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
+	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
+	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
+	TPM2_CC_GET_CAPABILITY	        = 0x017A,
+	TPM2_CC_GET_RANDOM	        = 0x017B,
+	TPM2_CC_PCR_READ	        = 0x017E,
+	TPM2_CC_PCR_EXTEND	        = 0x0182,
+	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
+	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
+	TPM2_CC_CREATE_LOADED           = 0x0191,
+	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
 };
 
 enum tpm2_permanent_handles {
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index c1ddbbba406e..9d2cc8b1daca 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -86,128 +86,73 @@ static struct tpm2_hash tpm2_hash_map[] = {
 };
 
 /*
- * Array with one entry per ordinal defining the maximum amount
+ * tpm2_ordinal_duration returns the maximum amount
  * of time the chip could take to return the result. The values
- * of the SHORT, MEDIUM, and LONG durations are taken from the
- * PC Client Profile (PTP) specification.
+ * of the MEDIUM, and LONG durations are taken from the
+ * PC Client Profile (PTP) specification (750, 2000 msec)
+ *
  * LONG_LONG is for commands that generates keys which empirically
  * takes longer time on some systems.
  */
-static const u8 tpm2_ordinal_duration[TPM2_CC_LAST - TPM2_CC_FIRST + 1] = {
-	TPM_UNDEFINED,		/* 11F */
-	TPM_UNDEFINED,		/* 120 */
-	TPM_LONG,		/* 121 */
-	TPM_UNDEFINED,		/* 122 */
-	TPM_UNDEFINED,		/* 123 */
-	TPM_UNDEFINED,		/* 124 */
-	TPM_UNDEFINED,		/* 125 */
-	TPM_UNDEFINED,		/* 126 */
-	TPM_UNDEFINED,		/* 127 */
-	TPM_UNDEFINED,		/* 128 */
-	TPM_LONG,		/* 129 */
-	TPM_UNDEFINED,		/* 12a */
-	TPM_UNDEFINED,		/* 12b */
-	TPM_UNDEFINED,		/* 12c */
-	TPM_UNDEFINED,		/* 12d */
-	TPM_UNDEFINED,		/* 12e */
-	TPM_UNDEFINED,		/* 12f */
-	TPM_UNDEFINED,		/* 130 */
-	TPM_LONG_LONG,		/* 131 */
-	TPM_UNDEFINED,		/* 132 */
-	TPM_UNDEFINED,		/* 133 */
-	TPM_UNDEFINED,		/* 134 */
-	TPM_UNDEFINED,		/* 135 */
-	TPM_UNDEFINED,		/* 136 */
-	TPM_UNDEFINED,		/* 137 */
-	TPM_UNDEFINED,		/* 138 */
-	TPM_UNDEFINED,		/* 139 */
-	TPM_UNDEFINED,		/* 13a */
-	TPM_UNDEFINED,		/* 13b */
-	TPM_UNDEFINED,		/* 13c */
-	TPM_UNDEFINED,		/* 13d */
-	TPM_MEDIUM,		/* 13e */
-	TPM_UNDEFINED,		/* 13f */
-	TPM_UNDEFINED,		/* 140 */
-	TPM_UNDEFINED,		/* 141 */
-	TPM_UNDEFINED,		/* 142 */
-	TPM_LONG,		/* 143 */
-	TPM_MEDIUM,		/* 144 */
-	TPM_UNDEFINED,		/* 145 */
-	TPM_UNDEFINED,		/* 146 */
-	TPM_UNDEFINED,		/* 147 */
-	TPM_UNDEFINED,		/* 148 */
-	TPM_UNDEFINED,		/* 149 */
-	TPM_UNDEFINED,		/* 14a */
-	TPM_UNDEFINED,		/* 14b */
-	TPM_UNDEFINED,		/* 14c */
-	TPM_UNDEFINED,		/* 14d */
-	TPM_LONG,		/* 14e */
-	TPM_UNDEFINED,		/* 14f */
-	TPM_UNDEFINED,		/* 150 */
-	TPM_UNDEFINED,		/* 151 */
-	TPM_UNDEFINED,		/* 152 */
-	TPM_LONG_LONG,		/* 153 */
-	TPM_UNDEFINED,		/* 154 */
-	TPM_UNDEFINED,		/* 155 */
-	TPM_UNDEFINED,		/* 156 */
-	TPM_UNDEFINED,		/* 157 */
-	TPM_UNDEFINED,		/* 158 */
-	TPM_UNDEFINED,		/* 159 */
-	TPM_UNDEFINED,		/* 15a */
-	TPM_UNDEFINED,		/* 15b */
-	TPM_MEDIUM,		/* 15c */
-	TPM_UNDEFINED,		/* 15d */
-	TPM_UNDEFINED,		/* 15e */
-	TPM_UNDEFINED,		/* 15f */
-	TPM_UNDEFINED,		/* 160 */
-	TPM_UNDEFINED,		/* 161 */
-	TPM_UNDEFINED,		/* 162 */
-	TPM_UNDEFINED,		/* 163 */
-	TPM_UNDEFINED,		/* 164 */
-	TPM_UNDEFINED,		/* 165 */
-	TPM_UNDEFINED,		/* 166 */
-	TPM_UNDEFINED,		/* 167 */
-	TPM_UNDEFINED,		/* 168 */
-	TPM_UNDEFINED,		/* 169 */
-	TPM_UNDEFINED,		/* 16a */
-	TPM_UNDEFINED,		/* 16b */
-	TPM_UNDEFINED,		/* 16c */
-	TPM_UNDEFINED,		/* 16d */
-	TPM_UNDEFINED,		/* 16e */
-	TPM_UNDEFINED,		/* 16f */
-	TPM_UNDEFINED,		/* 170 */
-	TPM_UNDEFINED,		/* 171 */
-	TPM_UNDEFINED,		/* 172 */
-	TPM_UNDEFINED,		/* 173 */
-	TPM_UNDEFINED,		/* 174 */
-	TPM_UNDEFINED,		/* 175 */
-	TPM_UNDEFINED,		/* 176 */
-	TPM_LONG,		/* 177 */
-	TPM_UNDEFINED,		/* 178 */
-	TPM_UNDEFINED,		/* 179 */
-	TPM_MEDIUM,		/* 17a */
-	TPM_LONG,		/* 17b */
-	TPM_UNDEFINED,		/* 17c */
-	TPM_UNDEFINED,		/* 17d */
-	TPM_UNDEFINED,		/* 17e */
-	TPM_UNDEFINED,		/* 17f */
-	TPM_UNDEFINED,		/* 180 */
-	TPM_UNDEFINED,		/* 181 */
-	TPM_MEDIUM,		/* 182 */
-	TPM_UNDEFINED,		/* 183 */
-	TPM_UNDEFINED,		/* 184 */
-	TPM_MEDIUM,		/* 185 */
-	TPM_MEDIUM,		/* 186 */
-	TPM_UNDEFINED,		/* 187 */
-	TPM_UNDEFINED,		/* 188 */
-	TPM_UNDEFINED,		/* 189 */
-	TPM_UNDEFINED,		/* 18a */
-	TPM_UNDEFINED,		/* 18b */
-	TPM_UNDEFINED,		/* 18c */
-	TPM_UNDEFINED,		/* 18d */
-	TPM_UNDEFINED,		/* 18e */
-	TPM_UNDEFINED		/* 18f */
-};
+static u8 tpm2_ordinal_duration(u32 ordinal)
+{
+	switch (ordinal) {
+	/* Startup */
+	case TPM2_CC_STARTUP:                 /* 144 */
+		return TPM_MEDIUM;
+
+	/* Selftest */
+	case TPM2_CC_SELF_TEST:               /* 143 */
+		return TPM_LONG;
+
+	/* Random Number Generator */
+	case TPM2_CC_GET_RANDOM:              /* 17B */
+		return TPM_LONG;
+
+	/* Hash/HMAC/Event Sequences */
+	case TPM2_CC_SEQUENCE_UPDATE:         /* 15C */
+		return TPM_MEDIUM;
+	case TPM2_CC_SEQUENCE_COMPLETE:       /* 13E */
+		return TPM_MEDIUM;
+	case TPM2_CC_EVENT_SEQUENCE_COMPLETE: /* 185 */
+		return TPM_MEDIUM;
+	case TPM2_CC_HASH_SEQUENCE_START:     /* 186 */
+		return TPM_MEDIUM;
+
+	/* Signature Verification */
+	case TPM2_CC_VERIFY_SIGNATURE:        /* 177 */
+		return TPM_LONG;
+
+	/* Integrity Collection (PCR) */
+	case TPM2_CC_PCR_EXTEND:              /* 182 */
+		return TPM_MEDIUM;
+
+	/* Hierarchy Commands */
+	case TPM2_CC_HIERARCHY_CONTROL:       /* 121 */
+		return TPM_LONG;
+	case TPM2_CC_HIERARCHY_CHANGE_AUTH:   /* 129 */
+		return TPM_LONG;
+
+	/* Capability Commands */
+	case TPM2_CC_GET_CAPABILITY:          /* 17A */
+		return TPM_MEDIUM;
+
+	/* Non-volatile Storage */
+	case TPM2_CC_NV_READ:                 /* 14E */
+		return TPM_LONG;
+
+	/* Key generation (not in PTP) */
+	case TPM2_CC_CREATE_PRIMARY:          /* 131 */
+		return TPM_LONG_LONG;
+	case TPM2_CC_CREATE:                  /* 153 */
+		return TPM_LONG_LONG;
+	case TPM2_CC_CREATE_LOADED:           /* 191 */
+		return TPM_LONG_LONG;
+
+	default:
+		return TPM_UNDEFINED;
+	}
+}
 
 struct tpm2_pcr_read_out {
 	__be32	update_cnt;
@@ -816,11 +761,8 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 	int index = TPM_UNDEFINED;
 	int duration = 0;
 
-	if (ordinal >= TPM2_CC_FIRST && ordinal <= TPM2_CC_LAST)
-		index = tpm2_ordinal_duration[ordinal - TPM2_CC_FIRST];
-
-	if (index != TPM_UNDEFINED)
-		duration = chip->duration[index];
+	index = tpm2_ordinal_duration(ordinal);
+	duration = chip->duration[index];
 
 	if (duration <= 0)
 		duration = msecs_to_jiffies(TPM2_DURATION_DEFAULT);
-- 
2.14.3
