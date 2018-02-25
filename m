Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeBYRXB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:23:01 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33250 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeBYRWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:22:54 -0500
X-Google-Smtp-Source: AG47ELsPaFZlofA9a8OZZkNr00LrMhoCa7oT1D4/VLfBFAfUN6W0jLyg8KTNn4OtK+3o4FDXURxXZw==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 01/21] powerpc: Remove warning on array size when empty
Date: Sun, 25 Feb 2018 18:22:16 +0100
Message-Id: <20180225172236.29650-2-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When neither CONFIG_ALTIVEC, nor CONFIG_VSX or CONFIG_PPC64 is defined, the
array feature_properties is defined as an empty array, which in turn
triggers the following warning (treated as error on W=1):

  CC      arch/powerpc/kernel/prom.o
arch/powerpc/kernel/prom.c: In function ‘check_cpu_feature_properties’:
arch/powerpc/kernel/prom.c:298:16: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
  for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
                ^
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/prom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4dffef947b8a..6e8e4122820e 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -291,11 +291,10 @@ static inline void identical_pvr_fixup(unsigned long node)
 
 static void __init check_cpu_feature_properties(unsigned long node)
 {
-	unsigned long i;
 	struct feature_property *fp = feature_properties;
 	const __be32 *prop;
 
-	for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
+	for (; fp != feature_properties + ARRAY_SIZE(feature_properties); ++fp) {
 		prop = of_get_flat_dt_prop(node, fp->name, NULL);
 		if (prop && be32_to_cpup(prop) >= fp->min_value) {
 			cur_cpu_spec->cpu_features |= fp->cpu_feature;
-- 
2.11.0
