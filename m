Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ED4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920EB20856
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVBzQZ12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920EB20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbeGQQjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbeGQQjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:39:53 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CC082083B;
        Tue, 17 Jul 2018 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531843591;
        bh=fwQFf4OcuN4MXGSOzd4kTEauRMJPAkEh4neP5Zcr4yk=;
        h=From:To:Cc:Subject:Date:From;
        b=qVBzQZ12Ikpgb/YXLSyxbODjQE3++cWoqtIarjjwxDT0qcQK8l6xHQPaJNwQC6Q/8
         Mwnnv12Z1ZgSnCdbbmqF39kMd/eanmLqWGC+nW07bsKo6gRyqzzGuTlvqFzHTQG3Xz
         dCZBx+yZosBFqerdxur1ppipyU3NQRp1eVXB+FV0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Vitaly Bordug <vbordug@ru.mvista.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devel@driverdev.osuosl.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 0/6] lib/crc32: treewide: Use existing define with polynomial
Date:   Tue, 17 Jul 2018 18:05:35 +0200
Message-Id: <20180717160541.3843-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernel defines same polynomial for CRC-32 in few places.
This is unnecessary duplication of the same value. Also this might
be error-prone for future code - every driver will define the
polynomial again.

This is an attempt to unify definition of polynomial.  Few obvious
hard-coded locations are fixed with define.

All series depend on each 1/6 and 2/6.

This could be merged in two different merge windows (1st lib/crc and then
the rest) or taken through one tree.

It would be nice to get some testing. Only generic lib/crc, bunzip, xz_crc32
and Freescale's Ethernet driver were tested on HW.  Rest got just different
builds.

Best regards,
Krzysztof




Krzysztof Kozlowski (6):
  lib/crc: Move polynomial definition to separate header
  lib/crc: Use consistent naming for CRC-32 polynomials
  crypto: stm32_crc32 - Use existing define with polynomial
  net: ethernet: Use existing define with polynomial
  staging: rtl: Use existing define with polynomial
  lib: Use existing define with polynomial

 drivers/crypto/stm32/stm32_crc32.c               | 11 ++++-------
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c         |  4 ++--
 drivers/net/ethernet/apple/bmac.c                |  8 ++------
 drivers/net/ethernet/broadcom/tg3.c              |  3 ++-
 drivers/net/ethernet/freescale/fec_main.c        |  4 ++--
 drivers/net/ethernet/freescale/fs_enet/fec.h     |  3 ---
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c |  3 ++-
 drivers/net/ethernet/micrel/ks8851_mll.c         |  3 ++-
 drivers/net/ethernet/synopsys/dwc-xlgmac-hw.c    |  4 ++--
 drivers/staging/rtl8712/rtl871x_security.c       |  5 ++---
 drivers/staging/rtl8723bs/core/rtw_security.c    |  5 ++---
 include/linux/crc32poly.h                        | 20 ++++++++++++++++++++
 lib/crc32.c                                      | 11 ++++++-----
 lib/crc32defs.h                                  | 14 --------------
 lib/decompress_bunzip2.c                         |  3 ++-
 lib/gen_crc32table.c                             |  5 +++--
 lib/xz/xz_crc32.c                                |  3 ++-
 17 files changed, 55 insertions(+), 54 deletions(-)
 create mode 100644 include/linux/crc32poly.h

-- 
2.14.1

