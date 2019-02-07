Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20529C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A16206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="cPlTDEwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfBGNgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:36:16 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:55601 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfBGNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:36:15 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 2541725B7E2;
        Fri,  8 Feb 2019 00:36:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1549546570; bh=UmnSDGx9AZJkqmAobrpuFFnf/+wQbmMB7rXMTWi0QUM=;
        h=From:To:Cc:Subject:Date:From;
        b=cPlTDEwC6UzdWMh/lFgGZPNmNaeasUHODkAIdm4W2LfnBglZDtVTobYpZS/27gG2P
         xMtzIxeZC1i0iVpAOXtfK5EQbwfz8x4TLxu8/I03M0LNFUORak7YshNjtTKYUK4Sn9
         4MU+nHTN7kBZFQ3Ue7h4lxq2zq99J5KjcWmsQ7Yw=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 512999401DB; Thu,  7 Feb 2019 14:36:07 +0100 (CET)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v4 0/5] clk: renesas: r8a77990, r8a774c0: Add Z2 clock
Date:   Thu,  7 Feb 2019 14:35:45 +0100
Message-Id: <20190207133550.13967-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series adds the Z2 clock as a clock with both a fixed and variable
divisor with a parent of PLL0 to the CPG-MSSR drivers for the R-Car E3
(r8a77990) and RZ/G2E (r8a774c0) SoCs.

In order to do so this series:

1. Parameterise Z and Z2 clock fixed divisor in shared Gen-3 CPG
   driver code to allow fixed divisors other than 2 - the E3 Z2
   clock has a fixed divisor of 4

2. Parameterise offset of Z and Z2 clock control bits -
   the offsets on E3 differ to other R-Car Gen 3 SoCs

3. Support Z and Z2 clocks with high frequency parents.
   The parent of the E3 Z2 clock, PLL0, is 4.8GHz and thus
   when expressed in HZ must be treated as a 64bit value.

4. Actually add the Z2 clocks

Changes since v3
----------------
* Add and use DIV64_U64_ROUND_CLOSEST in the patch to allow
  high frequency parents. This corrects the patch for 32bit platforms.
* Accumulate review and testing tags.

Changes since v2
----------------
* Parameterise control bit offset rather than using a quirk
* Revised RZ/G2E patch - I was confused and updating the file for
  the wrong part number


Testing Overview
----------------

This patchset has been tested on Ebisu-4D/E3 with
top of renesas-devel-20190207-v5.0-rc5. This allowed CPUFreq
to be successfully exercised, showing scaling of the Z2 clock as per the
results below.

This patchset was also tested for regressions Salvator-X/M3-W ES1.0.
As per the results below CPUFreq was used to show that with these
patches applied Z and Z2 clocks still scale as expected.

This v3 of this patchset has been independently tested RZ/G2E.
It is not expected that v4 will have any behavioural differences
on that (or any other 64bit) platform.


Patches List by Author
----------------------

Simon Horman (3):
  clk: renesas: rcar-gen3: Parameterise Z and Z2 clock offset
  clk: renesas: rcar-gen3: Support Z and Z2 clocks with high frequency
    parents
  clk: renesas: r8a774c0: Add Z2 clock

Takeshi Kihara (2):
  clk: renesas: rcar-gen3: Parameterise Z and Z2 clock fixed divisor
  clk: renesas: r8a77990: Add Z2 clock

 drivers/clk/renesas/r8a774a1-cpg-mssr.c |  4 ++--
 drivers/clk/renesas/r8a774c0-cpg-mssr.c |  1 +
 drivers/clk/renesas/r8a7795-cpg-mssr.c  |  5 +++--
 drivers/clk/renesas/r8a7796-cpg-mssr.c  |  5 +++--
 drivers/clk/renesas/r8a77965-cpg-mssr.c |  2 +-
 drivers/clk/renesas/r8a77990-cpg-mssr.c |  1 +
 drivers/clk/renesas/rcar-gen3-cpg.c     | 27 +++++++++++++--------------
 drivers/clk/renesas/rcar-gen3-cpg.h     |  4 ++++
 include/linux/math64.h                  | 13 +++++++++++++
 9 files changed, 41 insertions(+), 21 deletions(-)

Ebisu-4D/E3 Test Results
------------------------

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
performance
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
800000 1000000 1200000 
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1200000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1200000
/sys/kernel/debug/clk/z2/clk_rate:1200000000
# echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:975000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:975000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1000000
/sys/kernel/debug/clk/z2/clk_rate:975000000
# echo 800000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:787500
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:787500
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:800000
/sys/kernel/debug/clk/z2/clk_rate:787500000
# echo 1200000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1200000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:1200000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1200000
/sys/kernel/debug/clk/z2/clk_rate:1200000000


Salvator-X/M3-W ES1 Test Results
--------------------------------

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
performance
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
500000 1000000 1500000 
# cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_available_frequencies
800000 1000000 1200000 
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z/clk_rate /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1499999
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1500000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:1499999
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1500000
/sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq:1199999
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:1200000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq:1199999
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:1200000
/sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_cur_freq:1199999
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:1200000
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_cur_freq:1199999
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:1200000
/sys/kernel/debug/clk/z/clk_rate:1499999940
/sys/kernel/debug/clk/z2/clk_rate:1199999952
# echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z/clk_rate /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:984374
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:984374
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq:1199999
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:1200000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq:1199999
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:1200000
/sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_cur_freq:1199999
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:1200000
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_cur_freq:1199999
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:1200000
/sys/kernel/debug/clk/z/clk_rate:984374961
/sys/kernel/debug/clk/z2/clk_rate:1199999952
# echo 1000000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z/clk_rate /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:984374
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:984374
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq:974999
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq:974999
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_cur_freq:974999
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:1000000
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_cur_freq:974999
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:1000000
/sys/kernel/debug/clk/z/clk_rate:984374961
/sys/kernel/debug/clk/z2/clk_rate:974999961
# echo 500000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
# echo 800000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z/clk_rate /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:468749
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:500000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:468749
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:500000
/sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq:787499
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq:787499
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_cur_freq:787499
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:800000
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_cur_freq:787499
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:800000
/sys/kernel/debug/clk/z/clk_rate:468749981
/sys/kernel/debug/clk/z2/clk_rate:787499969
# echo 1500000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
# echo 1200000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
# grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z/clk_rate /sys/kernel/debug/clk/z2/clk_rate
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1499999
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1500000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:1499999
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1500000
/sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq:1199999
/sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:1200000
/sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq:1199999
/sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:1200000
/sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_cur_freq:1199999
/sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:1200000
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_cur_freq:1199999
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:1200000
/sys/kernel/debug/clk/z/clk_rate:1499999940
/sys/kernel/debug/clk/z2/clk_rate:1199999952

-- 
2.11.0
