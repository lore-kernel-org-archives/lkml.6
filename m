Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeBTQRI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:17:08 -0500
Received: from mout.gmx.net ([212.227.15.19]:53127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751827AbeBTQRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:17:06 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4/6] powerpc: numa: Restrict fake NUMA enulation to CONFIG_NUMA systems
Date: Tue, 20 Feb 2018 17:14:22 +0100
Message-Id: <20180220161424.5421-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220161424.5421-1-j.neuschaefer@gmx.net>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:P4F7EC/vWYmHfrQMH2bpMeUU79T//roZJUlnDkw3krhIU02Q5g8
 E9tSsljcEPapxeNuj9ITMxlYAocjanEkSYxkNIGO1trX+zo5kcHvPMG8Ah2VtcK0TO0+JFM
 xNNc7IXmA6Eb37Uvs4X67Xjm3rS7o27z2IZp1lPi3CEBmtWoLT0hJk3JwTc5A9ZdIqxmj9K
 o6e9xj+6QdTgcDQ8ZbDlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EJlT+mRFDzo=:8VMhZ/7oYWO6Mx5DGewjrF
 Psh10dfDexE+WfNfah0MCKiVFcTsFxCIKN94ByWHe4E4gZA6M6SI4Hbc8BFTCErvAHWRBfNLM
 4/Jgu0026s+bbSzML02B3TGx6bLUbhEyg8bLmyepGcdHsoC+e2Ht3fr3dNDvxVdW3VOemlaOb
 t8cHcdyk4vYh3bzxVTAz8mvaABcZfHdDZQQyBTNYp3MokHnVYbF3DzAWPIu2ED4SppULrbGKe
 bAgRz2cDfXqMcZYz1p82rUJCPK4Fke1+u+MCWYfU6vW0IcwWkj3MJvmzESU9CyafM6uSTfdsJ
 RV02upWB+veTL3X9Hca+JIffpRO5BE9tkaS6H7N/SlhWWlS/26WacM6D57Pm3Kenbu6EsBs//
 Fsm7WszvJsZULRL/N4MIbHnPLXIMGzgDfW5bKH1QPGFaTloPoToXxwrZEkKs77xYvPMcq372b
 TbjBA0kgzspUJuyc3ANDI6ywjBXXt4aDdesZ4ea4IZc31Pj9qvGnDPZvisisEROSZoR0uHIH9
 eTTurIL2k/UmVYj6Ii01dqRLzXkOfTJHLC3OAOs1lw90gCfnlm/b7KtCi5wqT3UleNxEbohnU
 uoCMpJTEAeL0IdaSkx68mc+IizAY2zd6iBzkEAtCCu0j+/bdSMETrc6NiFnrbzqv56WGeUr00
 3Kh1aWBn/AfSf0mwYOQgK0IFdDvic2d48B4KXPCFXHaDrI7Mx0dCvkmBXBkpcqyVwry+haoTX
 TMLpejam8UMKDyU8jdBUDDmGEIMO0fagcspNHwPin9x9Pc9gm47Br3exzg1xiN42k0p/89mwE
 /e3ifuglj2qPCjHDUENj8VLIMoLwcwYAWSNUOvBvBo7M/L9SPY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/mm/numa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index df03a65b658f..dfe279529463 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -738,7 +738,8 @@ static void __init setup_nonnuma(void)
 		start_pfn = memblock_region_memory_base_pfn(reg);
 		end_pfn = memblock_region_memory_end_pfn(reg);
 
-		fake_numa_create_new_node(end_pfn, &nid);
+		if (IS_ENABLED(CONFIG_NUMA))
+			fake_numa_create_new_node(end_pfn, &nid);
 		memblock_set_node(PFN_PHYS(start_pfn),
 				  PFN_PHYS(end_pfn - start_pfn),
 				  &memblock.memory, nid);
-- 
2.16.1
