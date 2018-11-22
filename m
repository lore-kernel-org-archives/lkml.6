Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A872AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD06620820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="nlntkYuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD06620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393566AbeKVU1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:27:18 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:34182 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389970AbeKVU1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:27:18 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAM9mAdg030201
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 22 Nov 2018 20:48:25 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1542880106; bh=tBL2rel5omeQ6+xhDYvBUUtrcg3gtm6zVrzxky3dlek=;
        h=From:To:Cc:Subject:Date;
        b=nlntkYuWzzg5mPiAdUyGB1gBKIdeLU3NHBZyn/rlgw3yQM+ETEJhY/PBDtUMmQMTU
         zWkKRKoCoGzRoHqfxFOC9n+bWSyzmFqxEgV1z1g4Ui3P+Ciwx2UsztXHcf41XyGwnx
         jsDMGdxcno5E1/8KFIJzFbIJk2sgsvrT7T3TdNFO12XHa2PP3HWbIohUZGg5p3EULh
         cmBek5poA+8bu4TnHWI957SMoFZEtP9GzF26V7wIxiEAh3vMTfETiQ8UHSKRxIFOnU
         Lfy3J0lAd5Ye2HNbE7BGASibKm31S3uPPlUVwj5/TU9k1/W2VMsVPE9R0/KNxvdOml
         pRipbb0GnFYLA==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>
Subject: [PATCH v9 0/4] PPS: pps-gpio PPS ECHO implementation
Date:   Thu, 22 Nov 2018 20:45:58 +1100
Message-Id: <20181122094602.5156-1-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
please find attached the PPS-GPIO PPS ECHO implementation patch. The
driver claims to have echo functionality in the sysfs interface but this
functionality is not present.  This patch provides this functionality.

Parts 1 and 2 of the patch change the original driver from the number
based GPIO ABI to the descriptor based ABI.

Parts 3 and 4 then add the PPS ECHO functionality.  This is enabled if a
"echo-gpios" entry is found in the devicetree.

Changes in v8:
Changes requested by Rob Herring and Philipp Zabel:
DT explanation and don't change the DT entry for the PPS gpio.

Changes in v9:
Simplify "if" expression by doing echo_active_ms validation earlier.

On the linuxpps mailing list it was suggested to use a hrtimer for
resetting the GPIO ECHO active state to the inactive state.
Please also comment on whether a hrtimer is necessary/desirable for the
purpose of resetting the echo pin active state.  I am happy to implement
it if this is useful/desirable.

Please install, test and comment as it is now a quite major change to
the driver.
Suggestions for improvement are welcome.

Tom Burkart

Tom Burkart (4):
  dt-bindings: pps: capture-clear addition
  pps: descriptor-based gpio, capture-clear addition
  dt-bindings: pps: pps-gpio PPS ECHO implementation
  pps: pps-gpio pps-echo implementation

 Documentation/devicetree/bindings/pps/pps-gpio.txt |  11 ++
 drivers/pps/clients/pps-gpio.c                     | 179 ++++++++++++++++-----
 include/linux/pps-gpio.h                           |   6 +-
 3 files changed, 152 insertions(+), 44 deletions(-)

-- 
2.12.3

