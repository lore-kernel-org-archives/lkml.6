Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6D7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C8D20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Ih9SDbmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfAPVSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:18:44 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:55466 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfAPVSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SlxBPAyHPuHlD9t5cx3Dk+26a1z4YNuD+oxh29qvfHk=; b=Ih9SDbmocMsa1gCUqgK35rJuYB
        LgYaWr9yGWRklJEo1ThEyHUFdb4N6mMFdUyA+8MFddCjPS99oFK6DyVR1lkyUYKOdv1f6xa1PfGou
        jJC/LhmyRBvZtj0nOBzicvaF825ZRoFzIgHwBfzy9DHY8WAGdG6Yf7aj2uYn2dRiULPE=;
Received: from p200300ccfbcc8e007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbcc:8e00:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjsa3-0006IJ-Bs; Wed, 16 Jan 2019 22:18:35 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjsZz-0001eu-Ja; Wed, 16 Jan 2019 22:18:31 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/6] gnss: sirf: add support for w2sg0004 + lna
Date:   Wed, 16 Jan 2019 22:18:06 +0100
Message-Id: <20190116211812.6337-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another chapter of the story to get gta04 gnss power
management into the mainline kernel.
There is a w2sg0004 without wakeup line in there, so power state
can only be determined indirectly by looking at the serial data lines.
Then there as also an lna which needs to be powered for real gps
reception.

Changes in v2:
  - do not change behavior of devices with wakeup line
    - do not keep serdev open if runtime is active and device is not used
  - style cleanup
  - locking of sirf_close() vs. gnss_insert_raw()
  - name reordering

Changes in v3:
  - more style cleanup
  - more locking
  - better regulator error handling
  - timeout logic cleaned up and problems documented
  - initial power off sorted out as a separate patch
  - renamed patch gnss: sirf: power on logic for devices without wakeup signal

Andreas Kemnade (6):
  gnss: sirf: write data to gnss only when the gnss device is open
  gnss: sirf: set power state initially off
  gnss: sirf: add support for configurations without wakeup signal
  dt-bindings: gnss: add w2sg0004 compatible string
  gnss: sirf: add a separate supply for a lna
  dt-bindings: gnss: add lna-supply property

 Documentation/devicetree/bindings/gnss/gnss.txt    |   1 +
 .../devicetree/bindings/gnss/sirfstar.txt          |   1 +
 drivers/gnss/sirf.c                                | 204 +++++++++++++++++----
 3 files changed, 175 insertions(+), 31 deletions(-)

-- 
2.11.0

