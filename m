Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2303DC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C40222B4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="frjt+H+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfBKN7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:59:16 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:34752 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfBKN7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:59:16 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6B86525BDAB;
        Tue, 12 Feb 2019 00:59:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1549893553; bh=ljerEY1JRU9rufbM7bw4+EIZZ2tWcZFjMXlD25nC7uI=;
        h=From:To:Cc:Subject:Date:From;
        b=frjt+H+LR+WY25J7sPe+hZyHRZ4f0eSOvkmEptIGcrC1Q3V20k9Kp7mKGvm1fm1OF
         XZQmQV5VHNjcN7WnOO/+xTte/r929NRK1OwYhjRWBF+Oj7VyNRlB2pKS/veWhV41yu
         AHKiH6pXopgjcNv0jeBIQT0MdiLCTbW1u/4pv/SA=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 76C6E940362; Mon, 11 Feb 2019 14:59:11 +0100 (CET)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v5 0/6] clk: renesas: r8a77990, r8a774c0: Add Z2 clock
Date:   Mon, 11 Feb 2019 14:58:52 +0100
Message-Id: <20190211135858.23635-1-horms+renesas@verge.net.au>
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

Changes since v4
* Separate patch to add DIV64_U64_ROUND_CLOSEST helper
* Accumulate review tags

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

v4 of this patchset was tested on Ebisu-4D/E3 with top of
renesas-devel-20190207-v5.0-rc5. This allowed CPUFreq to be successfully
exercised.

v4 of the patchset was also tested for regressions Salvator-X/M3-W ES1.0.

There is no overall code-change between v4 and v5 of this patchset.

This v3 of this patchset was been independently tested RZ/G2E.
It is not expected that v5 will have any behavioural differences
on that (or any other 64bit) platform.


Patches List by Author
----------------------

Simon Horman (4):
  clk: renesas: rcar-gen3: Parameterise Z and Z2 clock offset
  math64: New DIV64_U64_ROUND_CLOSEST helper
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

-- 
2.11.0
