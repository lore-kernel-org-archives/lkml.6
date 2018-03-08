Return-Path: <kernel-hardening-return-12262-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvGHM244IrEJSLTUv6UhkeVQCQjznze83RAEPzZ49o8tFGi0RGQeNDybb1sGQaHVavKDem0
ARC-Seal: i=1; a=rsa-sha256; t=1520542349; cv=none;
        d=google.com; s=arc-20160816;
        b=v1LLOfQeMtWlo5ySPtJhZlEaZSHJFOb1AlZaWvSY95gCWC7D4UpdgIFkqkvNPSBgg9
         mCkcjQ803eh+GwobQrAMWq76NFuG/Q30fI05zqz5pXlRyEvhsYQNIOOKyQ8pvx41Des4
         Eqjxxlq3Ev+Mk/dSh2+lBFjDxyYs164pz1Gapr2AKHHhJnJfAnxWvGIDy0yv14uKXI/w
         z+yWLLB8i1r5uWgpQZsC1LomrgNhiAWohrYRUbVRhbxw3G7SERDC4YMgwLzE7TwaXjK/
         Yr2+B6gfNQnmTvHu3Awbehwk7ZSFxjaWnmX55R6hmX/ZZhSVP1erzNu572aLe+8djA8e
         wbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=bJnkjs8Al3B4d46sqcdbs9oodbrNXxg9ahl7cSOJFRE=;
        b=AXK11fXtmUBn7XH+ewHp8FuX1w993Ttbp15fmwhsNQFvDZq3DU4SBPEp+Paw94km8G
         2cxBPQhaPiiZ+vLeItoDtgSWvyC+pzQ2pA6L6ovRBBxMZ46kKYA4H2pyigvZ1yQgtVJI
         n7esakuo0eV8UxW36eN+XiBhioINQqB7ks0nGL+9An+COj+gsFXkdnwshPAJsnN+8jiU
         uq3lEgLhPMS2Qgdyc46Mo6DxOgBfa/Kp6gR19EadSXr61oViiPE7KbDrQ0DTc9Zmw39R
         dGxCW54dwqm/KK2ns49vtINanygKmYqTnffhWM0eoz6sTxQZ3/O6Kz/MgwClM/gmFNbk
         CBYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12262-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12262-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12262-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12262-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Stephen Kitt <steve@sk2.org>
To: hare@suse.com,
	keescook@chromium.org
Cc: linux-scsi@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org,
	Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2] aic7xxx/aic79xx: remove VLAs
Date: Thu,  8 Mar 2018 21:51:58 +0100
Message-Id: <20180308205158.5130-1-steve@sk2.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAGXu5jK=JhBFHBGpbWF46DC3-QMruiB0qqz1z+njcK2h7jVU9w@mail.gmail.com>
References: <CAGXu5jK=JhBFHBGpbWF46DC3-QMruiB0qqz1z+njcK2h7jVU9w@mail.gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594376653072055099?=
X-GMAIL-MSGID: =?utf-8?q?1594404214721964115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wvla, remove VLAs and replace them with
fixed-length arrays instead.

The arrays fixed here, using the number of constant sections, aren't
really VLAs, but they appear so to the compiler. Replace the array
sizes with a pre-processor-level constant instead using ARRAY_SIZE.

This was prompted by https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/scsi/aic7xxx/aic79xx_core.c        | 8 ++++----
 drivers/scsi/aic7xxx/aic79xx_seq.h_shipped | 3 +--
 drivers/scsi/aic7xxx/aic7xxx_core.c        | 8 ++++----
 drivers/scsi/aic7xxx/aic7xxx_seq.h_shipped | 3 +--
 drivers/scsi/aic7xxx/aicasm/aicasm.c       | 3 +--
 5 files changed, 11 insertions(+), 14 deletions(-)

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
index 4b51e232392f..fd64a950ee44 100644
--- a/drivers/scsi/aic7xxx/aic79xx_seq.h_shipped
+++ b/drivers/scsi/aic7xxx/aic79xx_seq.h_shipped
@@ -1186,5 +1186,4 @@ static const struct cs {
 	{ 759, 763 }
 };
 
-static const int num_critical_sections = sizeof(critical_sections)
-				       / sizeof(*critical_sections);
+#define NUM_CRITICAL_SECTIONS ARRAY_SIZE(critical_sections)
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
index 07e93fbae706..f37362bc8ece 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_seq.h_shipped
+++ b/drivers/scsi/aic7xxx/aic7xxx_seq.h_shipped
@@ -1304,5 +1304,4 @@ static const struct cs {
 	{ 875, 877 }
 };
 
-static const int num_critical_sections = sizeof(critical_sections)
-				       / sizeof(*critical_sections);
+#define NUM_CRITICAL_SECTIONS ARRAY_SIZE(critical_sections)
diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm.c b/drivers/scsi/aic7xxx/aicasm/aicasm.c
index 21ac265280bf..5f474e490f3e 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm.c
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm.c
@@ -451,8 +451,7 @@ output_code()
 	fprintf(ofile, "\n};\n\n");
 
 	fprintf(ofile,
-"static const int num_critical_sections = sizeof(critical_sections)\n"
-"				       / sizeof(*critical_sections);\n");
+	"#define NUM_CRITICAL_SECTIONS ARRAY_SIZE(critical_sections)\n");
 
 	fprintf(stderr, "%s: %d instructions used\n", appname, instrcount);
 }
-- 
2.11.0
