Return-Path: <kernel-hardening-return-12517-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsl+pdxZeEizHOev/iGR0XcwSxBjI084NORoJD+zo+XXXbPiNKUbwX2J7pIbcdMJ+1NXSfW
ARC-Seal: i=1; a=rsa-sha256; t=1520970719; cv=none;
        d=google.com; s=arc-20160816;
        b=h5x71Ll4q5sCuU46qL/h81Vu9podOOFx7vvvBYT98++3Fo2jBSaYbM7Nx/fFllmdIn
         X+rUHsR4yxR+3D79sl228br8NtWeQuXudzWIT9I1McG34iRXBPyLqaGU6mnmR6NnKcDB
         Z1m0xIfShx6PE4iN1jM878Ih1q4mjFguS7W4DsZnDdpCEW3bRNiPlQIYnxMTl4dGsqx2
         OOYeVfX+3h40ic9nv4Q594GIQx94JS0R1UZZUqjWvHmk1VcnQT/xzuhtMN0W/becbU5B
         anI1nAgsLTEm+6FUzXglb3BT9Z5n1ydo/jzRlUeAPlGkjEyGLe/OOjxFxrq1jQ77D9t9
         qrnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=QUuliaqvvd9yYQ8CUodAdPCoYwxKNVGuRakunjvw/uU=;
        b=h9l3di4y+SKAcs2IwoD8deGax4WHlnW+dGXXGWIaNxEXXJuqlAaRkRsM2U5mTglO8y
         m/3Cb/QfUysLAJNJFTKPd0PTINbc17YB9QK9HanjATAnb4d+djdEQF3y7F+FOJgs9HII
         WOHD0EaGQLo9GSTHAT9TMDVan/zjvLGBvK1yotjoMep1zdMUIYcs3aB073hOOoONqJRe
         vt77Fk9qNqbBBRJdOLVNe1GcsunvLd4asoSBpwDOVs2yv8LKH85QAsC2vfXa1vyx2B1e
         RytSTnxqGYUvVTHS7ePG0MrsJ3zVBZEk/q28X9VNzMS+adLeJpKVNyDodxWpUXRuFoSN
         QN6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uksPBk40;
       spf=pass (google.com: domain of kernel-hardening-return-12517-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12517-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uksPBk40;
       spf=pass (google.com: domain of kernel-hardening-return-12517-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12517-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernel-hardening@lists.openwall.com,
	David Airlie <airlied@linux.ie>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: [PATCH] drm/i915: drop various VLAs in i915_debugfs.c
Date: Tue, 13 Mar 2018 20:51:28 +0100
Message-Id: <1520970688-19683-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853392696206560?=
X-GMAIL-MSGID: =?utf-8?q?1594853392696206560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Avoid 3 VLAs[1] by using real constant expressions instead of variables.
The compiler should be able to optimize the original code and avoid using
any actual VLAs. Anyway this change is useful because it will avoid a false
positives with -Wvla, it might also help the compiler generating better
code.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 drivers/gpu/drm/i915/i915_debugfs.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index e968aea..bf0a8e3 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -4259,19 +4259,20 @@ static ssize_t cur_wm_latency_write(struct file *file, const char __user *ubuf,
 			i915_cache_sharing_get, i915_cache_sharing_set,
 			"%llu\n");
 
+#define CHERRYVIEW_SS_MAX 2
+
 static void cherryview_sseu_device_status(struct drm_i915_private *dev_priv,
 					  struct sseu_dev_info *sseu)
 {
-	int ss_max = 2;
 	int ss;
-	u32 sig1[ss_max], sig2[ss_max];
+	u32 sig1[CHERRYVIEW_SS_MAX], sig2[CHERRYVIEW_SS_MAX];
 
 	sig1[0] = I915_READ(CHV_POWER_SS0_SIG1);
 	sig1[1] = I915_READ(CHV_POWER_SS1_SIG1);
 	sig2[0] = I915_READ(CHV_POWER_SS0_SIG2);
 	sig2[1] = I915_READ(CHV_POWER_SS1_SIG2);
 
-	for (ss = 0; ss < ss_max; ss++) {
+	for (ss = 0; ss < CHERRYVIEW_SS_MAX; ss++) {
 		unsigned int eu_cnt;
 
 		if (sig1[ss] & CHV_SS_PG_ENABLE)
@@ -4290,15 +4291,17 @@ static void cherryview_sseu_device_status(struct drm_i915_private *dev_priv,
 	}
 }
 
+#define GEN10_S_MAX 6
+#define GEN10_SS_MAX 4
+
 static void gen10_sseu_device_status(struct drm_i915_private *dev_priv,
 				     struct sseu_dev_info *sseu)
 {
 	const struct intel_device_info *info = INTEL_INFO(dev_priv);
-	int s_max = 6, ss_max = 4;
 	int s, ss;
-	u32 s_reg[s_max], eu_reg[2 * s_max], eu_mask[2];
+	u32 s_reg[GEN10_S_MAX], eu_reg[2 * GEN10_S_MAX], eu_mask[2];
 
-	for (s = 0; s < s_max; s++) {
+	for (s = 0; s < GEN10_S_MAX; s++) {
 		/*
 		 * FIXME: Valid SS Mask respects the spec and read
 		 * only valid bits for those registers, excluding reserverd
@@ -4320,7 +4323,7 @@ static void gen10_sseu_device_status(struct drm_i915_private *dev_priv,
 		     GEN9_PGCTL_SSB_EU210_ACK |
 		     GEN9_PGCTL_SSB_EU311_ACK;
 
-	for (s = 0; s < s_max; s++) {
+	for (s = 0; s < GEN10_S_MAX; s++) {
 		if ((s_reg[s] & GEN9_PGCTL_SLICE_ACK) == 0)
 			/* skip disabled slice */
 			continue;
@@ -4328,7 +4331,7 @@ static void gen10_sseu_device_status(struct drm_i915_private *dev_priv,
 		sseu->slice_mask |= BIT(s);
 		sseu->subslice_mask = info->sseu.subslice_mask;
 
-		for (ss = 0; ss < ss_max; ss++) {
+		for (ss = 0; ss < GEN10_SS_MAX; ss++) {
 			unsigned int eu_cnt;
 
 			if (!(s_reg[s] & (GEN9_PGCTL_SS_ACK(ss))))
@@ -4345,12 +4348,15 @@ static void gen10_sseu_device_status(struct drm_i915_private *dev_priv,
 	}
 }
 
+#define GEN9_S_MAX 3
+#define GEN9_SS_MAX 4
+
 static void gen9_sseu_device_status(struct drm_i915_private *dev_priv,
 				    struct sseu_dev_info *sseu)
 {
-	int s_max = 3, ss_max = 4;
+	int s_max = GEN9_S_MAX, ss_max = GEN9_SS_MAX;
 	int s, ss;
-	u32 s_reg[s_max], eu_reg[2*s_max], eu_mask[2];
+	u32 s_reg[GEN9_S_MAX], eu_reg[2*GEN9_S_MAX], eu_mask[2];
 
 	/* BXT has a single slice and at most 3 subslices. */
 	if (IS_GEN9_LP(dev_priv)) {
-- 
1.9.1
