Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD19C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C443520868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="Nje3Jdix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C443520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeKXW3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 17:29:02 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:44480 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeKXW3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 17:29:02 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAOBeOq9008096
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Sat, 24 Nov 2018 22:40:39 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1543059640; bh=Wh0eH3B5XYADGZTZS+dALuUB0N3YsH9P+MQ2a7yz7+Q=;
        h=From:To:Cc:Subject:Date;
        b=Nje3JdixlXQ8sZSQDxNFoRQZOzCdJKoruUXicCAhb1fp8qJp8ojesnlo6NijklwoX
         RjvgKwU3h74gfCLe38K0kjisICaEwUXVakR6I/tzkKpdy963bg1/fHeOROxA1P/4+X
         9rnzjJrbWVK84ARDonHPFQHaxplZ74KOCRMpR6nyFA7LzFF0iGyJEyuNYoJwg0/oyS
         4Si2/xYAHxEswyRupSITDE4wF0F6i3M3a+WoDUNZ06/Y53PJIvJek9AS1SiXouX8y2
         PFYMzspSJQ7jZjLIwL15eM9njETS024IWfSiHXz43E2EJVUo5gU+wm/4EdpAe86zv+
         309wu7NoxDq8w==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>
Subject: [PATCH v10 0/4] PPS: pps-gpio PPS ECHO implementation
Date:   Sat, 24 Nov 2018 22:38:08 +1100
Message-Id: <20181124113812.31700-1-tom@aussec.com>
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

Changes in v10:
Changes requested by Philipp Zabel:
Mostly cosmetic changes: PATCH 2/4 now reviewed.  Thanks a lot, Philipp!

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
 drivers/pps/clients/pps-gpio.c                     | 170 ++++++++++++++++-----
 include/linux/pps-gpio.h                           |   6 +-
 3 files changed, 147 insertions(+), 40 deletions(-)

-- 
2.12.3

