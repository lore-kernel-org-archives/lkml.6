Return-Path: <kernel-hardening-return-12236-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvFAQQmzICkVhhQ0CfK8Y3v7Ifm5R9t4wwI38rEOswMEHMVvyfhbRpjEBP7ai9juq0mPJKU
ARC-Seal: i=1; a=rsa-sha256; t=1520516064; cv=none;
        d=google.com; s=arc-20160816;
        b=RifMTiZmG+H7qDcJp/3V+OlZUcwaIyxi7fNwxxisAkc7Gzers5IYdG5zRc16pjt8Ps
         +jL8vjXTb2WNr5PWAEO2WgB4Q2ySxLXm1g4wdGTPow+qGq9R9SVk67AmlUtu6gSaM+X8
         bqaEYG+3svyn2G9qPoDIQUL1+Wiz47hajheY7bdFbYKBsO2v89A1xmLF3tZZ59qgKEOr
         83mGKQYAwm835nDit3LD9FgZEgqpRCSXz3RDsVrN3uG9DkraymRsInA8Cee8JhVqJqxM
         vcw9JPTmjOfSyCbULzAjDMEj/EKboF0KkDuf0WKTP9nskevqLTwrv42v34AMulBY7Ds0
         jbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Dw9gYVgTOviSqcZV16h8h4vdCrgk8Fcg2RHGL/kwwrE=;
        b=XZQ9daIxQLuRJKlByTU5l2CSTNCMhxj+H+mAnrHZK3FQsfV3SRV3IsvsZubzjhEtCv
         h0k6UMtbDyBvKLvNrExrEo3TaYbly22Bas9ujXBRVBzK3R6bvY3RjGAU3t22orcM4PiH
         mrInD0CeX91bz0w6doEy3vZG6k9zT+eRnLtn7UO2s2SdCOXtryTz2/z1TBinZgiWciwP
         bRUz23Vtgza2khoOylTpsMRVD7Qdos/QTooK6+esn/+CAATwfZ7l1TaUPc3vCiLu4K2d
         +3EspSUMdMSO2qE24lyKRpgQ9kR+FW9PbOBRieSlvV9h1cNoGSaDXR3VErQFuMsZiW2r
         IKBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12236-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12236-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12236-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12236-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Stephen Kitt <steve@sk2.org>
To: hare@suse.com
Cc: linux-scsi@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org,
	Stephen Kitt <steve@sk2.org>
Subject: [PATCH] aic7xxx/aic79xx: remove VLAs
Date: Thu,  8 Mar 2018 14:22:25 +0100
Message-Id: <20180308132225.13229-1-steve@sk2.org>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594376653072055099?=
X-GMAIL-MSGID: =?utf-8?q?1594376653072055099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wvla, remove VLAs and replace them with
fixed-length arrays instead.

The arrays fixed here, using the number of constant sections, aren't
really VLAs, but they appear so to the compiler. Since we know at
build-time how many critical sections there are, we might as well use
a pre-processor-level constant instead.

This was prompted by https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/scsi/aic7xxx/aic79xx_core.c        | 8 ++++----
 drivers/scsi/aic7xxx/aic79xx_seq.h_shipped | 3 +--
 drivers/scsi/aic7xxx/aic7xxx_core.c        | 8 ++++----
 drivers/scsi/aic7xxx/aic7xxx_seq.h_shipped | 3 +--
 drivers/scsi/aic7xxx/aicasm/aicasm.c       | 6 ++++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index b560f396ee99..034f4eebb160 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -9338,9 +9338,9 @@ ahd_dumpseq(struct ahd_softc* ahd)
 static void
 ahd_loadseq(struct ahd_softc *ahd)
 {
-	struct	cs cs_table[num_critical_sections];
-	u_int	begin_set[num_critical_sections];
-	u_int	end_set[num_critical_sections];
+	struct	cs cs_table[NUM_CRITICAL_SECTIONS];
+	u_int	begin_set[NUM_CRITICAL_SECTIONS];
+	u_int	end_set[NUM_CRITICAL_SECTIONS];
 	const struct patch *cur_patch;
 	u_int	cs_count;
 	u_int	cur_cs;
@@ -9456,7 +9456,7 @@ ahd_loadseq(struct ahd_softc *ahd)
 		 * Move through the CS table until we find a CS
 		 * that might apply to this instruction.
 		 */
-		for (; cur_cs < num_critical_sections; cur_cs++) {
+		for (; cur_cs < NUM_CRITICAL_SECTIONS; cur_cs++) {
 			if (critical_sections[cur_cs].end <= i) {
 				if (begin_set[cs_count] == TRUE
 				 && end_set[cs_count] == FALSE) {
diff --git a/drivers/scsi/aic7xxx/aic79xx_seq.h_shipped b/drivers/scsi/aic7xxx/aic79xx_seq.h_shipped
index 4b51e232392f..20fb9ca9e271 100644
--- a/drivers/scsi/aic7xxx/aic79xx_seq.h_shipped
+++ b/drivers/scsi/aic7xxx/aic79xx_seq.h_shipped
@@ -1186,5 +1186,4 @@ static const struct cs {
 	{ 759, 763 }
 };
 
-static const int num_critical_sections = sizeof(critical_sections)
-				       / sizeof(*critical_sections);
+#define NUM_CRITICAL_SECTIONS 14
diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index 6612ff3b2e83..e97eceacf522 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -6848,9 +6848,9 @@ ahc_dumpseq(struct ahc_softc* ahc)
 static int
 ahc_loadseq(struct ahc_softc *ahc)
 {
-	struct	cs cs_table[num_critical_sections];
-	u_int	begin_set[num_critical_sections];
-	u_int	end_set[num_critical_sections];
+	struct	cs cs_table[NUM_CRITICAL_SECTIONS];
+	u_int	begin_set[NUM_CRITICAL_SECTIONS];
+	u_int	end_set[NUM_CRITICAL_SECTIONS];
 	const struct patch *cur_patch;
 	u_int	cs_count;
 	u_int	cur_cs;
@@ -6915,7 +6915,7 @@ ahc_loadseq(struct ahc_softc *ahc)
 		 * Move through the CS table until we find a CS
 		 * that might apply to this instruction.
 		 */
-		for (; cur_cs < num_critical_sections; cur_cs++) {
+		for (; cur_cs < NUM_CRITICAL_SECTIONS; cur_cs++) {
 			if (critical_sections[cur_cs].end <= i) {
 				if (begin_set[cs_count] == TRUE
 				 && end_set[cs_count] == FALSE) {
diff --git a/drivers/scsi/aic7xxx/aic7xxx_seq.h_shipped b/drivers/scsi/aic7xxx/aic7xxx_seq.h_shipped
index 07e93fbae706..d814f1d6b820 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_seq.h_shipped
+++ b/drivers/scsi/aic7xxx/aic7xxx_seq.h_shipped
@@ -1304,5 +1304,4 @@ static const struct cs {
 	{ 875, 877 }
 };
 
-static const int num_critical_sections = sizeof(critical_sections)
-				       / sizeof(*critical_sections);
+#define NUM_CRITICAL_SECTIONS 7
diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm.c b/drivers/scsi/aic7xxx/aicasm/aicasm.c
index 21ac265280bf..bdffe84221ce 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm.c
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm.c
@@ -353,6 +353,7 @@ output_code()
 	critical_section_t *cs;
 	symbol_node_t *cur_node;
 	int instrcount;
+	int num_critical_sections;
 
 	instrcount = 0;
 	fprintf(ofile,
@@ -440,19 +441,20 @@ output_code()
 "	uint16_t	end;\n"
 "} critical_sections[] = {\n");
 
+	num_critical_sections = 0;
 	for (cs = TAILQ_FIRST(&cs_tailq);
 	     cs != NULL;
 	     cs = TAILQ_NEXT(cs, links)) {
 		fprintf(ofile, "%s\t{ %d, %d }",
 			cs == TAILQ_FIRST(&cs_tailq) ? "" : ",\n",
 			cs->begin_addr, cs->end_addr);
+		num_critical_sections++;
 	}
 
 	fprintf(ofile, "\n};\n\n");
 
 	fprintf(ofile,
-"static const int num_critical_sections = sizeof(critical_sections)\n"
-"				       / sizeof(*critical_sections);\n");
+		"#define NUM_CRITICAL_SECTIONS %d\n", num_critical_sections);
 
 	fprintf(stderr, "%s: %d instructions used\n", appname, instrcount);
 }
-- 
2.11.0
