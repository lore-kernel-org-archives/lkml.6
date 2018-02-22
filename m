Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbeBVOXU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:23:20 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43057 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932726AbeBVOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:23:17 -0500
X-Google-Smtp-Source: AH8x225xm/makvHDxhgteYbT+lRUt5+og9eCm9LYcu/up0InGWD91jABHrMc/szy1dAWErBjnBYkuw==
From: Rui Miguel Silva <rui.silva@linaro.org>
To: horia.geanta@nxp.com, aymen.sghaier@nxp.com,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryan Harkin <ryan.harkin@linaro.org>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH v4 0/4] Enable CAAM on i.MX7s fix TrustZone issues
Date: Thu, 22 Feb 2018 14:22:46 +0000
Message-Id: <20180222142250.31348-1-rui.silva@linaro.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For v4 I am taking over this patch series as all the left over patches were
implemented by me.

V4:
- removed patch: [PATCH v3 2/5] crypto: caam: Fix endless loop when RNG is
already initialized from the series since Horia presented a better fix for the
 endless loop in case of fail to acquire DECO:
 225ece3e7dad4 crypto: caam - fix endless loop when DECO acquire fails
- add Fabio Estevam reviewed by tag in PATCH 3/3.
- removed CAAM ERA from dts since bootloader will add it - Horia.

V3:
- Added Cc: clk driver maintainers - Fabio Estevam
- Added Cc: i.MX arch maintainers - Fabio Estevam
- Removed bouncing email address for Herbert Xu

V2-resend:
- Patch 0005 lost in the ether - resending

V2:
- Endian detection is ok with TrustZone enabled Horia.
  Endian detection logic tested with TrustZone enabled. The register that
  this relies on though isn't affected by the lock-down in the first page.
  Assuming set of affected registers is actually just the 'deco' registers
  though there is no formal statement of that, that I am aware of.

- Moving of TrustZone work-around into u-boot
  This set actually doesn't need to deal with TrustZone at all now but, for
  the sake of consistency keeping thread title

  https://patchwork.ozlabs.org/patch/866460/
  https://patchwork.ozlabs.org/patch/866462/
  https://patchwork.ozlabs.org/patch/865890/

- Reworded endless loop fix to read a bit better

- Fixes to DTS additions - Rui

- Fixes to number of clocks declared - Rui

V1:
This patch-set enables CAAM on the i.MX7s and fixes a number of issues
identified with the CAAM driver and hardware when TrustZone mode is
enabled.

The first block of patches are simple bug-fixes, followed by a second block
of patches which are simple enabling patches for the i.MX7Solo - note we
aren't enabling for the i.MX7Dual since we don't have hardware to test that
out but it should be a 1:1 mapping for others to enable when appropriate.

Cheers,
    Rui

Rui Miguel Silva (4):
  crypto: caam - Fix null dereference at error path
  crypto: caam - do not use mem and emi_slow clock for imx7x
  clk: imx7d: add CAAM clock
  ARM: dts: imx7s: add CAAM device node

 arch/arm/boot/dts/imx7s.dtsi            | 30 +++++++++++++++++++++++
 drivers/clk/imx/clk-imx7d.c             |  1 +
 drivers/crypto/caam/ctrl.c              | 42 +++++++++++++++++++--------------
 include/dt-bindings/clock/imx7d-clock.h |  3 ++-
 4 files changed, 57 insertions(+), 19 deletions(-)

-- 
2.16.2
