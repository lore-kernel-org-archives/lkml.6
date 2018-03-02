Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932238AbeCBTtv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:49:51 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50992 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbeCBTtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:49:49 -0500
X-Google-Smtp-Source: AG47ELvpDuRxoM25LiFSFb+OrS/Q5PXCTIJmTXu2FkO+6hF040R+XeKeX/2LUwbnRrv8c6MbmqNtbg==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/21] powerpc: Remove warning on array size when empty
Date: Fri,  2 Mar 2018 20:49:18 +0100
Message-Id: <20180302194918.4358-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-2-malat@debian.org>
References: <20180225172236.29650-2-malat@debian.org>
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

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/prom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4dffef947b8a..330c65f04820 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -291,11 +291,11 @@ static inline void identical_pvr_fixup(unsigned long node)
 
 static void __init check_cpu_feature_properties(unsigned long node)
 {
-	unsigned long i;
+	int i;
 	struct feature_property *fp = feature_properties;
 	const __be32 *prop;
 
-	for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
+	for (i = 0; i < (int)ARRAY_SIZE(feature_properties); ++i, ++fp) {
 		prop = of_get_flat_dt_prop(node, fp->name, NULL);
 		if (prop && be32_to_cpup(prop) >= fp->min_value) {
 			cur_cpu_spec->cpu_features |= fp->cpu_feature;
-- 
2.11.0
