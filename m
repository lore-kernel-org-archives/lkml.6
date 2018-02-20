Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752930AbeBTQSt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:18:49 -0500
Received: from mout.gmx.net ([212.227.15.18]:54723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbeBTQSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:18:48 -0500
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
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH 2/6] powerpc: numa: Fix overshift on PPC32
Date: Tue, 20 Feb 2018 17:14:20 +0100
Message-Id: <20180220161424.5421-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220161424.5421-1-j.neuschaefer@gmx.net>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:fjUEsZJ5xb8HrLMSiLDkNOKbFV0dV7YVUL9HfqyU5mPrje+T3oH
 C1LUHJ33vldVbmnSxweqUXzj/GRDvPa+GU4BUPHGzbQ+RpO2D6Ux5/rovYpzqZ/92hiDelX
 rIsae6vsUiAGSLSYs6/e6Mof/2c+mjmsGtE+pvMJZEVStL1RWC3oI0IgOXgm3E8lPmTZ52A
 SnQZb0BhwpV4ctjTxdT4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZSJ04dRNURM=:vUuxJ+sqzdPH6QcDqImz8W
 hrbqcRt59dIynev4HTaywaM3jYMycLubl8JumqRo+54mIep00Fvnk6fCMivBR51uzqkVhmpy5
 Rfx377JKXOuCx9UOttQsDuTt7ijwMmyZX5Ko7NW+1wrRSikij7sZKHEdaEsyYcbWXCPchO75v
 AoWnYmbxXqpgMhYKHZIzgxdmUJZUg3izRDRAxFTdb1HlclSvDsmwPbSoKepjLg4Z6b6luPFca
 P4RkHksNeAiOYerdL1eAARq8KjfzLZb+JdoZak6Bm1h2FRbPOsbF5pIv2//e46zJAeJn3vurX
 /K+SY7aHTn0S9G0JPSoTqdO5WAyLHaBxex7lntly4nx/5c21EU0TDh9XmlXMG0T8Ir+ENkXBF
 4PHfuJlPZQ9T3YKYo66AreGapBBw+RzjjkRO59uddVY4O3mp7JXKtq/Q/vFxUvkA5YkS0LgqV
 /9aTlrP4y1PAfFKiAkFpL763g9yZ+DjD5sdyg3iIJYBjUtVghU7ILgk+sMei7JuIhbRM4CEwI
 8lJ6Ca+uUWUmzxs+KpAc0pi+PfdXCIHncnf3Yx18IyO1cYd7AGO6MeynN0iB+ZRxjLIE9prPo
 JtCyChSdce1NyZFH8qdml2xQ8PHXoKtvitCG7MnSXhH+MyKuNgzyyjTUN0NDTVn+9kE64ipiL
 /j9Vnz2eI3C9LUzlJa4XTi/2dp2Mb7hjEbG5pn1YTDAUxkAyODsN9oAT1RzVDfseQQmipoUOn
 jqK4XYw1fZqiCzgu2BFJ6OZSr4PT0pAIeLSznmPoliv3+Uo1CFSS9AHUnOAYl8nqAI66OSSFj
 YPJVBQ/UJG8jDevD3vf69qaqRahglLPe0tsNpOwQ1xFSeMFRJY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When read_n_cells is compiled for PPC32, "result << 32" causes an
overshift, which GCC doesn't like. Fix this by using u64 instead of
unsigned long.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/mm/numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index edd8d0bc9364..0570bc2a0b13 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -357,9 +357,9 @@ static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
 	of_node_put(memory);
 }
 
-static unsigned long read_n_cells(int n, const __be32 **buf)
+static u64 read_n_cells(int n, const __be32 **buf)
 {
-	unsigned long result = 0;
+	u64 result = 0;
 
 	while (n--) {
 		result = (result << 32) | of_read_number(*buf, 1);
-- 
2.16.1
