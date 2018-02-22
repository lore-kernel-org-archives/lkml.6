Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbeBVMQy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:16:54 -0500
Received: from mout.gmx.net ([212.227.15.18]:35749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932460AbeBVMQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:16:50 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/5] powerpc/mm/32: Use page_is_ram to check for RAM
Date: Thu, 22 Feb 2018 13:15:14 +0100
Message-Id: <20180222121516.23415-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222121516.23415-1-j.neuschaefer@gmx.net>
References: <20180222121516.23415-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:imzWv0HW6u7PjnmbdAxp05TEoNUnpIt/I4cUMp1shRDDFUKnmLk
 GqpaQvOj0oRsYS34xXsDltPGiHKPON2TEdw26tx/au/iKyF2wBbrgVxi2HCqWjB3C601xJp
 EWHfggM1x33/VdpK2xkJMoGneHlizQOp1okh6G1YTBC0Lbbi42USXpg+Zhpl+B32nkRZ26s
 gWztmcTrX8EWaNYZW/9/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TV2Axsgxqmk=:06pW4J3RwVfKAe4su4CZD5
 c2NQRBWVtJ1CJPuiM42/ZRfotz8hOHBYJWCi5drQIwPBF+MW73dyWfRkMbOmQQrMwxclPXvN/
 fRFPkwny9K3YZjmFvVy6RDZi//fV6Ct3Il6JAroX86QC2GG6eAC3A6qaiL5bzPII3jV+5e+Rn
 ju6cFDieZrYShwuemf0wwLgxY/lApVHEwqhHVQlRug667I0FP8bIHVa9EPLCHTWq3PC7RaXio
 7GUwx8AP97AlZ6fw+fDsges7qrTS+XbRbP3BS4LgwCmqai2jJxtwmlfQDMDGSWxdvjHiMLewS
 Ou7oO9tq/fRXixipq2XLwK4XJu4ZAYUudxOOBonDRmZ/Gn8YnC7jJ7/uKGOJ8BaKN9HGW8+a0
 ZAUON1B1rUfmlvGs6ateBiNTBoWGOyV9Z8yI2ZcxeTlORB75k1yT0wxZGTlgH4kUrr6B+QL3f
 B96ODeP/0EKsij4uY9vmgqrppJrYs+76kX0IzdC8kv9/WFXBHphd1ywG3LCXeU2RMqXL18HhL
 Th2gnWaqe2R8+l6SQx5IHShMUz3X5zSEZTbDYH/ys3rMwLdYhWIwg8v8AL4OrPB+gEjKs7JU3
 46uphkb4uJPPQgtCobWLhxmX+4TKcGUAhDyttrOlWpJja2gYDA6sne1LRTr5KdxjIVfj4OhB+
 uCxStuyzth3+CN/2wGXDP8ayyPKuV0Yrx0rY06mqP5Mtb4SjndnfNfCna1DekM6clWC6rNcp2
 C3QPITKqsJBajkqa4/uvFRo3ZJZoIv/OXNrngU2mBX54QbtK3Q+1WaCe6S+/adDaiZBK/wf7x
 Z4i1aLH29MqwD9AlWgV1zjutlqM+DeGmkgA3bMZ0f3lplsC+KQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/mm/pgtable_32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index d35d9ad3c1cd..d54e1a9c1c99 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -145,9 +145,8 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 #ifndef CONFIG_CRASH_DUMP
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using.
-	 * mem_init() sets high_memory so only do the check after that.
 	 */
-	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
+	if (page_is_ram(__phys_to_pfn(p)) &&
 	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size))) {
 		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
 		       (unsigned long long)p, __builtin_return_address(0));
-- 
2.16.1
