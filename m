Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A72CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0908520813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxUcgLts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0908520813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbeJXDdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:33:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40306 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbeJXDdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:33:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id r1-v6so2694249edd.7;
        Tue, 23 Oct 2018 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z0QbeR3VQfZSOiXUbMfJfEO3M/OuYhTCJnLw06ws6+M=;
        b=ZxUcgLtsJu+9asuifclznP5hM1NK3AHqfB2mif0lB5vIfkBTyJr8FTAtGl8JATNjvj
         Zl9fQfkX8dK1rbYehm7ixZ0GKBF+6aN3JD3eLaJWyur3lLpjhK5szQ2EbOcVcCiKwGzd
         4shkdqthdmjEnlAYKzbZ9NeILW619lpYduC4HT8nKPQlDonWv8WDsoQ7U0GPxWmeQ6nf
         6YrP+2F4dFK8VYskVz+Pt1BAlk5vuu5yroUPeW/2b6jX/DjUNel/YFvM12mmpEumdE9b
         ZSAv9V0yUOMq1Tj1+btTSiHEqOBxUcihR++zCzy0brjukRouhipoTH4Wr2IY9BFPKMfl
         khEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z0QbeR3VQfZSOiXUbMfJfEO3M/OuYhTCJnLw06ws6+M=;
        b=I9XfuXwDSG3ijhr8jg1PhvbeobEOIAK8MOicoltePFBG9L+DfIEFQ225yAMOIdfOGW
         wzP2/SHJGg73hpoVzbh1HrzIALi8hAby3OyqX/IZIk+A4+xZ20mK8JHfFYFXeJGCrWid
         7kQiJcItH18UkftfelexUkIp1wm4clAEBit33xsetUmfzzZEBRjEViuxtVA3iPZ6p5cq
         iFH1DckYwTggGfSWWv72o6zTQ9aYBe9Qp1e6XnkRO9eFvwXP9oPjWVFAEcFyxB3lo/VA
         KmCenF0Y9H6oUMyFsRHJ54su0OYPOzYXvST1Mz8pZGE++04zZVS3eZG73rs38PeVKkv9
         JjWQ==
X-Gm-Message-State: AGRZ1gKBcxvIbUFaLVVmBg0p/rMsFPyfPPfx0r3iPjtt1avrt37Py/Fj
        ZJAS9HM61WhOziVrGdyS2sA=
X-Google-Smtp-Source: AJdET5diw70VnYrZdzUVK3bTOBGSu9FrdFEUYq6K5R0PKh3otqRXYqlbErCcheNX0LqTMOIE64PW1w==
X-Received: by 2002:a50:f5ad:: with SMTP id u42-v6mr4935731edm.68.1540321738694;
        Tue, 23 Oct 2018 12:08:58 -0700 (PDT)
Received: from ubuntu.home ([2a02:8071:6a3:700:6d72:e81e:8854:c88e])
        by smtp.gmail.com with ESMTPSA id b26-v6sm722312edw.0.2018.10.23.12.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:08:57 -0700 (PDT)
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Vasut <marex@denx.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Graham Moore <grmoore@opensource.altera.com>,
        Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: [PATCH] arm: dts: socfpga*.dts*: use SPDX-License-Identifier
Date:   Tue, 23 Oct 2018 21:08:53 +0200
Message-Id: <20181023190853.23252-1-simon.k.r.goldschmidt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the recent trend for the license description.

This is also in an effort to fully sync the devicetrees with U-Boot.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
---
 arch/arm/boot/dts/socfpga.dtsi                | 16 +------
 arch/arm/boot/dts/socfpga_arria10.dtsi        | 13 +-----
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi  | 14 +-----
 .../boot/dts/socfpga_arria10_socdk_nand.dts   | 13 +-----
 .../boot/dts/socfpga_arria10_socdk_qspi.dts   | 13 +-----
 .../boot/dts/socfpga_arria10_socdk_sdmmc.dts  | 14 +-----
 arch/arm/boot/dts/socfpga_arria5.dtsi         | 15 +-----
 arch/arm/boot/dts/socfpga_arria5_socdk.dts    | 16 +------
 arch/arm/boot/dts/socfpga_cyclone5.dtsi       | 16 +------
 .../dts/socfpga_cyclone5_de0_nano_soc.dts     | 13 +-----
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi   | 14 +-----
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts | 14 +-----
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts  | 16 +------
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts | 16 +------
 .../boot/dts/socfpga_cyclone5_socrates.dts    | 16 +------
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts  | 16 +------
 .../boot/dts/socfpga_cyclone5_vining_fpga.dts | 46 +------------------
 arch/arm/boot/dts/socfpga_vt.dts              | 16 +------
 18 files changed, 28 insertions(+), 269 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 2d300396f0ed..2458d6707dc5 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (C) 2012 Altera <www.altera.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (C) 2012 Altera <www.altera.com>
  */
 
 #include <dt-bindings/reset/altr,rst-mgr.h>
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 59ef13e37536..0b1ab88b4039 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright Altera Corporation (C) 2014. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index 64cc86a98771..360dae5a5b12 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2015 Altera Corporation <www.altera.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include "socfpga_arria10.dtsi"
 
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
index d14f9ccb6e10..e36e0a0f8aa6 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Altera Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts
index beb2fc6b9eb6..b4c0a76a4d1a 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 Intel. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
index 5822fd2085db..df2bab1624d4 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2014-2015 Altera Corporation <www.altera.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index e59461f5416e..22dbf07afcff 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright (C) 2013 Altera Corporation <www.altera.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (C) 2013 Altera Corporation <www.altera.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
index aac4feea86f3..90e676e7019f 100644
--- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (C) 2013 Altera Corporation <www.altera.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (C) 2013 Altera Corporation <www.altera.com>
  */
 
 #include "socfpga_arria5.dtsi"
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index 68ced67f8bfb..319a71e41ea4 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (C) 2012 Altera Corporation <www.altera.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (C) 2012 Altera Corporation <www.altera.com>
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
index 31b01a998b2e..67076e1b1c7f 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright Altera Corporation (C) 2015. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "socfpga_cyclone5.dtsi"
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
index 3c03da6b8b1d..bd92806ffc12 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2015 Marek Vasut <marex@denx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "socfpga_cyclone5.dtsi"
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
index c2eb88aab8b3..ceaec29770c6 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2015 Marek Vasut <marex@denx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "socfpga_cyclone5_mcv.dtsi"
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index 155829f9eba1..6f138b2b2616 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (C) 2012 Altera Corporation <www.altera.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (C) 2012 Altera Corporation <www.altera.com>
  */
 
 #include "socfpga_cyclone5.dtsi"
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index a4a555c19d94..c155ff02eb6e 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (C) 2013 Steffen Trumtrar <s.trumtrar@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (C) 2013 Steffen Trumtrar <s.trumtrar@pengutronix.de>
  */
 
 #include "socfpga_cyclone5.dtsi"
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
index 031c721441ff..8d5d3996f6f2 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socrates.dts
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (C) 2014 Steffen Trumtrar <s.trumtrar@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (C) 2014 Steffen Trumtrar <s.trumtrar@pengutronix.de>
  */
 
 #include "socfpga_cyclone5.dtsi"
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
index 8860dd2e242c..e54b5f2af74f 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (C) 2016 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (C) 2016 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  */
 
 #include "socfpga_cyclone5.dtsi"
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
index e61efe16e79c..355b3dbf438d 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
@@ -1,48 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
 /*
- *  Copyright (C) 2015 Marek Vasut <marex@denx.de>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of
- *     the License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- *     You should have received a copy of the GNU General Public
- *     License along with this file; if not, write to the Free
- *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
- *     MA 02110-1301 USA
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2015 Marek Vasut <marex@denx.de>
  */
 
 #include "socfpga_cyclone5.dtsi"
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index 547c38632c68..a77846f73b34 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *  Copyright (C) 2013 Altera Corporation <www.altera.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (C) 2013 Altera Corporation <www.altera.com>
  */
 
 /dts-v1/;
-- 
2.17.1

