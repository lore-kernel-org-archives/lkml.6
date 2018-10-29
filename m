Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E86C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847E92080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="t5CstN0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847E92080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbeJ2QNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:13:55 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51827 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbeJ2QNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:13:25 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 80DE38364E;
        Mon, 29 Oct 2018 20:25:53 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1540797953;
        bh=KDacA1qLqffnghFCdx82scWoqUVQ1YlKQBJgT2xXNLA=;
        h=From:To:Cc:Subject:Date;
        b=t5CstN0B7qlxNEs09rM9U+vtZK6LCon7I2FHRvyCsvGwmF+n0E5gkXq5vHYv5K2Lu
         bVkpYNsS4oYHAGPF74EEIe1o+Raoj1zH0Ov1CQvEXLlNkskYGKnjc01c5FKbuaNWRH
         vMq/zSGcHnJAcZwr/vEtAikPdWZNLTB1mWn1RmLJwhKINEDlprsY9p4GjmBlXMNjcr
         2FJD9NBbTqyCxKNpLf5eqmLlD9x19jQfLnyLR89pDRfRipuJehMSAuOC6tYzHbyyQ4
         IOlsXPSlTEyfnwkSBr50NR7G3D1WhGMoEtD2v9SoIFFCjwEEKkwwibOLay39RBXCNO
         NUGddi8DIHEuA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bd6b5fc0000>; Mon, 29 Oct 2018 20:25:53 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 1442613EF06;
        Mon, 29 Oct 2018 20:25:53 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 3797E1E21FF; Mon, 29 Oct 2018 20:25:48 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk
Cc:     u.kleine-koenig@pengutronix.de, jlu@pengutronix.de, bp@alien8.de,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 0/8] EDAC drivers for Armada XP L2 and DDR
Date:   Mon, 29 Oct 2018 20:25:27 +1300
Message-Id: <20181029072535.31667-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current plan is for these to go in via the ARM tree once appropriate
Reviews/Acks have been given.

This series adds drivers for the L2 cache and DDR RAM ECC functionality a=
s
found on the MV78230/MV78x60 SoCs. Jan has tested these changes with the
MV78460 (on a custom board with a DDR3 ECC DIMM), Chris has tested these
changes with 88F6820 and 98dx3236 (both a custom boards with fixed DDR3 +=
=20ECC).

Also contained in this series is an additional debugfs wrapper.

Compared to the previous v4 series I've added my s-o-b to some of Jan's
patches and rebased against v4.19.0.

Compared to the previous v3 series, the following changes have been made:=

- Use shorter names for the AURORA ECC and parity registers
- Numerous formatting changes to edac/armada_xp.c (as requested by Boris)=

- Added support for Armada-38x and 98dx3236 SoCs

Compared to the previous v2 series, the following changes have been made:=

- Allocate EDAC structures later during probing and drop devres support
=20 patches (requested by Boris)
- Make drvdata->width usage consistent according to the comment (suggeste=
d by
=20 Chris)

Compared to the previous v1 series, the following changes have been made:=

- Add the aurora-l2 register defines earlier in the series (suggested by
=20 Russell King and Gregory CLEMENT )
- Changed the DT vendor prefix from "arm" to "marvell" for the ecc-enable=
/disable
=20 properties on the aurora-l2 (suggested by Russell King)
- Fix some warnings reported by checkpatch

Compared to the original RFC series, the following changes have been made=
:
- Integrated Chris' patches for parity and ECC configuration via DT
- Merged the DDR RAM and L2 cache drivers (as requested by Boris, analogo=
us
=20 to fsl_ddr_edac.c and mpc85xx_edac.c)
- Added myself to MAINTAINERS (requested by Boris)
- L2 cache: Track the msg size and use snprintf (review comment by Chris)=

- L2 cache: Split error injection from the check function (review comment=
=20by
=20 Chris)
- DDR RAM: Allow 16 bit width in addition to 32 and 64 bit (review commen=
t by
=20 Chris)
- Use of_match_ptr() (review comments by Chris)
- Minor checkpatch cleanups



Chris Packham (3):
=20 ARM: l2x0: support parity-enable/disable on aurora
=20 ARM: l2x0: add marvell,ecc-enable property for aurora
=20 EDAC: armada_xp: Add support for more SoCs

Jan Luebbe (5):
=20 ARM: l2c: move cache-aurora-l2.h to asm/hardware
=20 ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
=20 ARM: aurora-l2: add defines for parity and ECC registers
=20 EDAC: Add missing debugfs_create_x32 wrapper
=20 EDAC: Add driver for the Marvell Armada XP SDRAM and L2 cache ECC

=20.../devicetree/bindings/arm/l2c2x0.txt        |   2 +
=20MAINTAINERS                                   |   6 +
=20.../asm/hardware}/cache-aurora-l2.h           |  50 +-
=20arch/arm/mm/cache-l2x0.c                      |  20 +-
=20drivers/edac/Kconfig                          |   7 +
=20drivers/edac/Makefile                         |   1 +
=20drivers/edac/armada_xp_edac.c                 | 644 ++++++++++++++++++=

=20drivers/edac/debugfs.c                        |  11 +
=20drivers/edac/edac_module.h                    |   5 +
=209 files changed, 742 insertions(+), 4 deletions(-)
=20rename arch/arm/{mm =3D> include/asm/hardware}/cache-aurora-l2.h (50%)=

=20create mode 100644 drivers/edac/armada_xp_edac.c

--=20
2.19.1
