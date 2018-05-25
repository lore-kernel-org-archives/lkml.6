Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967171AbeEYQMT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:12:19 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37605 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967068AbeEYQMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:12:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: arm@kernel.org, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: shmobile: only call secure_cntvoff_init on SMP builds
Date: Fri, 25 May 2018 18:10:21 +0200
Message-Id: <20180525161051.187324-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180525161051.187324-1-arnd@arndb.de>
References: <20180525161051.187324-1-arnd@arndb.de>
X-Provags-ID: V03:K1:tFqMGYmqpd1pR9JmWrYP2e90QFG4mMIYNQpNkumNPMw5XvlhsWP
 EGuElLzacMKhddXe7PxXRHrvKyVLPdALORgcU1dKhAaWAWFlsmYEQ5SUJa7dWpEddc60DHf
 eb32kp9J3YxBbeIJfs+HCFiAs3IFqU4EHEiGQBbKgLyu4TiGcaysXf41YrRGWlXP3NEfLfE
 is1wHzSpk2+dVyfHCyaUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AQGS+dQrUAM=:N4MTO+YHVWs5hI9IKEorJ2
 yHqh2BI2MwOOTfpAXBvAoe99dl0OOKlbeYBrYEOswvpvLhF/nPG2twsGkI9nxf14kHk+1jvSR
 TnYo7fUzhTHNpr+AyXTN3Ms5LyPoLu2Z/rF2yq4b2hOc6dK+bhTidlEcHFHkckBnmUo21F3vr
 dc5+jCh3IoHYnw8KD0XG3f5aZ4i/nP7pPZdsst8cXTRQJUJoDNFSlB6vsFzi4P0UPqjcBp1IW
 xJpzD5oQfxhTvslaqMPUD0juzPv4pPiBA6Z/o/Cfx1CstPvnUbEHuNw1ML9t5GwrOudu+Q2lx
 uPEXIdx1ce2NCNmlx2jEHSCE3i8XCMMppjjGPrnUJ70VDtMKrcxr3Ybb80SWdo5QPAqB4Havv
 qMzz1/zVqLgC9LRFkiTtLexQ99EIVuahdmrD9ntE/kjF9bbk5IacmHorn3XNlBiNHYFNnE8gt
 41HtE7NOsaJ/wm4aPBFl8MHZhGGyYGsGqQ+wVgrgdQP1kUxT6/85TOJKK6K6t2U6gatWYPt1w
 E+GwK+0GtYXqonuCFS8g+J/xvfigJ5Zos+R4/tBOwXUWtmvPDmMLgmkxCtZ3Me0BgQLjFm9ju
 kIyoLPaeaTyic/HqOz0EMMj1gVofzYlGraS8+Ld3N0xR+tH/r4L7UL/Ct0O5q+tr3EE69dTo8
 6wq6XOBsICFuNEowWaKr1VjIY1scdaPwDgs+qChNbt0mwDMoIctNySLwgL4BOnVFS84Q=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The secure_cntvoff_init() function is not available without CONFIG_SMP,
leading to a link error on shmobile:

arch/arm/mach-shmobile/setup-rcar-gen2.o: In function `rcar_gen2_timer_init':
setup-rcar-gen2.c:(.init.text+0x18): undefined reference to `secure_cntvoff_init'

>From the description in commit 3fd45a136ff6 ("ARM: shmobile: rcar-gen2:
Make sure CNTVOFF is initialized on CA7/15"), I understand that we
don't need to call it on non-SMP builds because the boot CPU is always
initialized by common code, so we can simply avoid the reference by
checking for CONFIG_SMP.

Fixes: cad160ed0a94 ("ARM: shmobile: Convert file to use cntvoff")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 88fdc1801d90..39085d7a8f37 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -71,7 +71,8 @@ void __init rcar_gen2_timer_init(void)
 	void __iomem *base;
 	u32 freq;
 
-	secure_cntvoff_init();
+	if (IS_ENABLED(CONFIG_SMP))
+		secure_cntvoff_init();
 
 	if (of_machine_is_compatible("renesas,r8a7745") ||
 	    of_machine_is_compatible("renesas,r8a77470") ||
-- 
2.9.0
