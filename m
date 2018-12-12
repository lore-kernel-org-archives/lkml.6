Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82335C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A2420873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="T6XQsImF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A2420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeLLCxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:53:08 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:55146 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLCxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:53:07 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from localhost.localdomain ([1.128.224.233])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wBC2qbuW002983
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Wed, 12 Dec 2018 13:52:58 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1544583178; bh=FhsddhCi9/OHvKmc8JUyFk+r/Lpit9Bh5oZd+joP0Ew=;
        h=From:To:Cc:Subject:Date;
        b=T6XQsImFF5zFntTeSI41HBMl0+fkGK9S82AzdhpppWoMe9BwtZ1A+7yKN6MAgPRpp
         k401npNWlzUvSe2IwoDK2TwnN8t96PkChcgHAInl1mx2VXGXLydRjmPDYgAtbPIj91
         ESZyT8u5teqmVu4ab0fOMRAZGLr/+aZ9EeMaEcti+QtbftlXijQRtoEyohXuz9L73Y
         MjpteVDz5hwxLui1D/rSpnrhyXIhQOr1pxym72CjgR7/Pb4mZGGPiTWn5T8oP2NCtK
         /S4bC5VIEo1x2P3K6/69Yv8xsIB502+Bd3TSNp5v/URcU3xou0+ZkHdlRPrql8qsiM
         kPvtLnCmPT3+w==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>
Subject: [PATCH v12 0/3] PPS: pps-gpio PPS ECHO implementation
Date:   Wed, 12 Dec 2018 13:52:11 +1100
Message-Id: <20181212025214.29911-1-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
please find attached the PPS-GPIO PPS ECHO implementation patch. The
driver claims to have echo functionality in the sysfs interface but this
functionality is not present.  This patch provides this functionality.

Part 1 of the patch change the original driver from the number
based GPIO ABI to the descriptor based ABI.

Parts 2 and 3 then add the PPS ECHO functionality.  This is enabled if a
"echo-gpios" entry is found in the devicetree.

Changes in v8:
Changes requested by Rob Herring and Philipp Zabel:
DT explanation and don't change the DT entry for the PPS gpio.

Changes in v9:
Simplify "if" expression by doing echo_active_ms validation earlier.

Changes in v10:
Changes requested by Philipp Zabel:
Mostly cosmetic changes: PATCH 2/4 now reviewed.  Thanks a lot, Philipp!
(Please note that as of v11 PATCH 1 is gone so this has become PATCH 1)

Change in v11:
Change requested by Rob Herring:
All changes in regard to the capture-clear DT entry are gone.

Change in v12:
Change requested by Rob Herring:
Deleted superfluous use of invert-pps-echo

On the linuxpps mailing list it was suggested to use a hrtimer for
resetting the GPIO ECHO active state to the inactive state.
Please also comment on whether a hrtimer is necessary/desirable for the
purpose of resetting the echo pin active state.  I am happy to implement
it if this is useful/desirable.

Please install, test and comment as it is now a quite major change to
the driver.
Suggestions for improvement are welcome.

Tom Burkart

Tom Burkart (3):
  pps: descriptor-based gpio
  dt-bindings: pps: pps-gpio PPS ECHO implementation
  pps: pps-gpio pps-echo implementation

 Documentation/devicetree/bindings/pps/pps-gpio.txt |   7 +
 drivers/pps/clients/pps-gpio.c                     | 159 ++++++++++++++++-----
 include/linux/pps-gpio.h                           |   5 +-
 3 files changed, 131 insertions(+), 40 deletions(-)

-- 
2.12.3

