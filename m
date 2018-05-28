Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425302AbeE1Pyf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:54:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:44268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425224AbeE1PyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:54:15 -0400
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/64s: Enhance the information in cpu_show_spectre_v1()
Date: Mon, 28 May 2018 15:19:14 +0200
Message-Id: <20180528131914.32231-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180424041559.32410-1-mpe@ellerman.id.au>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


We now have barrier_nospec as mitigation so print it in
cpu_show_spectre_v1 when enabled.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/security.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 0239383c7e4d..a0c32d53980b 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -120,7 +120,10 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, c
 	if (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR))
 		return sprintf(buf, "Not affected\n");
 
-	return sprintf(buf, "Vulnerable\n");
+	if (barrier_nospec_enabled)
+		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+	else
+		return sprintf(buf, "Vulnerable\n");
 }
 
 ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.13.6
