Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC1BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD1A223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="ADEZrDQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD1A223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbeKMOBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:01:45 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:40420 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeKMOBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:01:45 -0500
X-Greylist: delayed 1358 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2018 09:01:44 EST
X-Virus-Scanned: amavisd-new at aussec.com
Received: from localhost.localdomain (dhcp-3-227.csm-office.com.au [172.16.3.227])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAD3gTrg014074
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 13 Nov 2018 14:42:49 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1542080569; bh=Rb6NzlLIjAvqAGc57nfnpDpikHSq5TKfk3FQyNUwjns=;
        h=From:To:Cc:Subject:Date;
        b=ADEZrDQyEu1ue0rp3atJzEve5UKMabxGU/mBzvsonrXE6YtyJZtjWZ5j4nfCZ+j3r
         7F9DU4HSMoEp3JTlxaSNfef6WO7eIhujlzmnzJ2Q7A62QfpuvYmknDO1m0hKULM3No
         ZS6xSN+mTopry1ib0U8ilb1noubWRQ8Ow3lWUR+/LKftfsZhonF8eShWEvCjP6dlT/
         AE9wjtvIv5w2E7ohpp0xJk55yfwt+Rl8vrQvZflu5E7t/MCtMAZVXjGskhedhJTJtX
         fwdhCEuPUuutsQw8m8rdX04WC5vNcGua/RkoOpsnsU4XVHa1k6xy7v58/8gydRFCos
         cB3EL+CazgAwA==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>
Subject: [PATCH v6 0/4] PPS: pps-gpio PPS ECHO implementation
Date:   Tue, 13 Nov 2018 14:40:03 +1100
Message-Id: <20181113034007.3878-1-tom@aussec.com>
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
based GPIO API to the descriptor based API.  This does break the backward
compatibility of all devicetree descriptions for this driver as the
descriptor based API appends either "-gpios" or "-gpio" to all names
passed to it and then tries to find a match in the devicetree.

Parts 3 and 4 then add the PPS ECHO functionality.  This is enabled if a
"echo-gpios" entry is found in the devicetree.

Changes in v4:
There is a bugfix in part 2 that was returning an uninitialised variable
and juggling some code that speeds up the probe by not running code when
not using PPS ECHO.

Changes in v5:
Meet all requirements of checkpatch

Changes in v6:
Cosmetic changes to code layout

On the linuxpps mailing list it was suggested to use a hrtimer for
resetting the GPIO ECHO active state to the inactive state.
Please also comment on whether a hrtimer is necessary/desirable for the
purpose of resetting the echo pin active state.  I am happy to implement
it if there is a need.

Please install, test and comment as it is now a quite major change to
the driver.
Please do send suggestions for improvement.

Tom Burkart

Tom Burkart (4):
  dt-bindings: pps: descriptor-based gpio, capture-clear addition
  pps: descriptor-based gpio, capture-clear addition
  dt-bindings: pps: pps-gpio PPS ECHO implementation
  pps: pps-gpio pps-echo implementation

 Documentation/devicetree/bindings/pps/pps-gpio.txt |  15 ++-
 drivers/pps/clients/pps-gpio.c                     | 133 +++++++++++++++++----
 include/linux/pps-gpio.h                           |   5 +-
 3 files changed, 126 insertions(+), 27 deletions(-)

-- 
2.12.3

