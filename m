Return-Path: <j.neuschaefer@gmx.net>
X-Google-Smtp-Source: AH8x226gIKNNyn8btr8Iwien0vdgUonEXTLFum88xZgXhvF2uEVcafQe/lo646gjumr7IdC/EIEA
ARC-Seal: i=1; a=rsa-sha256; t=1519143404; cv=none;
        d=google.com; s=arc-20160816;
        b=AoEWa3y3vWkOIL4qNb1huiOoFeeAkrXo8DsxxNGocxIBcDbV1pVHUAanjiEIEajlHW
         PW2dvxyjkTFT2+27axTJ6YzlYQkd9EUtnR96CtYBYboAXPwiMMQpyFJqDdXOZsjWLMmO
         8/Mk6xoSyRPDECKZ11e+JB3k6O/XAGXHDxdDlvlOIL+nEB2fhJlzWK2FLV6Zps6IgLiJ
         xnt1RNOrEM0/30XUV03nXMVVj0WMB+XokhCzcCbQJcOgdvUjqAoQC7vf89LJk6tUgeyq
         PUcM/45Gn3zoNChRsWvoF7O48F0ZcYz7Sss4QlRMFeWtMnzDP9UpDmGG5j4txUaqrFGV
         ge1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=+0AYLxzJoDiuXmIZCLZzheOH/zaYBdMpJ5hsTrczKO0=;
        b=HGrN9nYjfup+G7mxzz1nwdY6PQ2JBcIFelsLsDgclfqfBAFAnjao1n/KzXMrfDF+TC
         SY0vSEBc2UnErQjVr1dlGuG7jlCEAgDCQuQ3RKG3MlXQXvni7+IuZjcCZpdEdLe9/Woy
         X8lyQ9Mdo1vPy0HGyx8gEt2lkMnVdbbnAsWC65aho+bTJGGilQVtyu80VWpALQbcZvaR
         f54sbQDAMAOi4of43TpJlXeNWLYHqkZ15fsf/eR3JOFGTaJ3TaWDZu33bO6aJhAC4ktG
         j9Lj+XZXk8wVefGNl58oiFNCg7LIEg7/5KYrQRQmJ1vugipCwCXdKLAcxNy7R1HZHTNS
         rPeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.22 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of j.neuschaefer@gmx.net designates 212.227.17.22 as permitted sender) smtp.mailfrom=j.neuschaefer@gmx.net
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-mm@kvack.org,
	Joel Stanley <joel@jms.id.au>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Nathan Fontenot <nfont@linux.vnet.ibm.com>,
	Michael Bringmann <mwb@linux.vnet.ibm.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 5/6] powerpc: Implement DISCONTIGMEM and allow selection on PPC32
Date: Tue, 20 Feb 2018 17:14:23 +0100
Message-Id: <20180220161424.5421-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220161424.5421-1-j.neuschaefer@gmx.net>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Ef61GgKjYRLsV3CHZhmjmyAWWBvqKTYdDtb1IGBtXC5GWbRe9HO
 XXXBzb2sqZygGsQ3+s70/W1wNSDiXM3RUHZjIOWxluJTS5AeblzkLoOCW0mEsMKWPcQwCIx
 o7II6IvWyW5YMru2TriMDc8AVVK8B8pczdm0sCyc55b5Cewj2bWK6SheM7dNdK4SJfdie2L
 lymF5bc6m19OSQ3WCTM3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nUdq7GK29KQ=:1o8l58jovUtY3uMuj95WFS
 sHC1WXKH4DXLo9vZ4l/oAOlg0eSGGX90KBQ/iEF4705V9QAW58gro81C9gvn5ZcqU4pu9DAX1
 h41/KDHFADFXMw+b2jTJwHdJX2ltVhdoTF/cZLCWk2ws5dpzjkYKJm5FD+SlqFaqastsUDPJR
 bsCN8QK9kD8ecUy3Kz/H5gQbPVXpXpaO50cfVUMWUp/OVHoH+IFnL+L+R/6GD7lB6G70DPIVa
 DL+tx2udI33hM74CimK0eGVCqJHJPbbe/OYOeM6RxVM4BuFhfAxfG8rbCiP/nLCVLaD7xmWmH
 SSXQX37HC9KNTNakuBXQorlNOEYp+ds/nAwiG2e6PZcn/MF3EN4y4JjZE3qPkMZ4vsay4MnTs
 hAQjX7t9WqgVA2OdzCSXA274MLaQ0MYHAIDbXIxA8+TGTpx8CbNrwsuryAYP2F/ruKsDjUIgz
 sBpxAslwTHBl6u0ZTF/+i80zBC+bp3VItpTzT3by6h7VPoLk/T+nxHLo9/xNAwiOIOL6x7cZq
 ZoDAtcKjnC/qtU//cIpkOSJrpQ2J7lKrGkvIYGVGb3XBMe6aJWD/LBsF5nVdsEsGXMs8YuGRo
 6Ry1HCukUzRqKSTb3V6OcM4etFtONrqMjWOjpaq4qcwyCPPSGEkr8jdwGoukNeaU2FWDOxuIr
 M9B8UumEj+mm19CloTH/K+OxBwe5suVNvE6UCA2YnqV3gsc1i4pJiJRQqgeQU1zTI/NsEsj/M
 vNV+12D0JwuGpEBBA8ZpijU8o3ULBm4BqPjxufqUyfZLk88nptZzDEH7QDE09dhzUc90KHqGY
 a9HMIvhzqPXr9dDbZrdSUS3U6NjucwudyiToY1WxJqAP4lyzh4=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592937314761110102?=
X-GMAIL-MSGID: =?utf-8?q?1592937314761110102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The implementation of pfn_to_nid and pfn_valid in mmzone.h is based on
arch/metag's implementation.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

NOTE: Checking NODE_DATA(nid) in pfn_to_nid appears to be uncommon.
Running up to MAX_NUMNODES instead of checking NODE_DATA(nid) would
require the node_data array to be filled with valid pointers.
---
 arch/powerpc/Kconfig              |  5 ++++-
 arch/powerpc/include/asm/mmzone.h | 21 +++++++++++++++++++++
 arch/powerpc/mm/numa.c            |  7 +++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd07642..c2633b7b8ed9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -639,7 +639,6 @@ config HAVE_MEMORYLESS_NODES
 
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
-	depends on PPC64
 
 config ARCH_FLATMEM_ENABLE
 	def_bool y
@@ -654,6 +653,10 @@ config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
 	depends on PPC_BOOK3S_64
 
+config ARCH_DISCONTIGMEM_ENABLE
+	def_bool y
+	depends on PPC32
+
 config SYS_SUPPORTS_HUGETLBFS
 	bool
 
diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index 91c69ff53a8a..1684a5c98d23 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -26,6 +26,27 @@ extern struct pglist_data *node_data[];
  */
 #define NODE_DATA(nid)		(node_data[nid])
 
+static inline int pfn_to_nid(unsigned long pfn)
+{
+	int nid;
+
+	for (nid = 0; nid < MAX_NUMNODES && NODE_DATA(nid); nid++)
+		if (pfn >= node_start_pfn(nid) && pfn <= node_end_pfn(nid))
+			return nid;
+
+	return -1;
+}
+
+static inline int pfn_valid(int pfn)
+{
+	int nid = pfn_to_nid(pfn);
+
+	if (nid >= 0)
+		return pfn < node_end_pfn(nid);
+
+	return 0;
+}
+
 /*
  * Following are specific to this numa platform.
  */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index dfe279529463..ec47f1081509 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -744,6 +744,13 @@ static void __init setup_nonnuma(void)
 				  PFN_PHYS(end_pfn - start_pfn),
 				  &memblock.memory, nid);
 		node_set_online(nid);
+
+		/*
+		 * On DISCONTIGMEM systems, place different memory blocks into
+		 * different nodes.
+		 */
+		if (IS_ENABLED(CONFIG_DISCONTIGMEM) && nid < MAX_NUMNODES - 1)
+			nid++;
 	}
 }
 
-- 
2.16.1
