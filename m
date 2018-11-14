Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D01C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0519822360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="Eoz4XBYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0519822360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbeKNW62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:58:28 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:48334 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeKNW62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:58:28 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAECsstV003333
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Wed, 14 Nov 2018 23:55:10 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1542200110; bh=TnnasEFWanrOaCrgNwZ9Yo6u3mdSfrsK1XA2RCHHYs0=;
        h=From:To:Cc:Subject:Date;
        b=Eoz4XBYVNmeFt6Fbcz3N4TsD2omusPXPcRnxvR3Eis+sClTZvLw+7sTAbfnuLUmJ0
         qB0hDUukXhZYmIhk8xBJHdcWZm3HGnSVvWKUnqDnfe+L8eGW26HQgzHTRlB2Y8PDl7
         qc6I6IRHofW5/rVDwWxdgoPR0i3jlnraBGY8dygly/VdgQl2KlCcR+kIr1RY7Fpf9j
         YZcM8JlVtVtJ7wl5COSee08bR+D/3SVh0ZAiGII/s15EUHffgjJNOxdc1vd3/rQNb8
         pKdaaWlX8RZsmZVD+xM5VuMEEQtqxvyOU7hvg1ner4DMMr6ZjD0XtfeVj314gTePbB
         K/NyaZ+qxaCMQ==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>
Subject: [PATCH v7 0/4] PPS: pps-gpio PPS ECHO implementation
Date:   Wed, 14 Nov 2018 23:54:28 +1100
Message-Id: <20181114125432.16044-1-tom@aussec.com>
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
based GPIO ABI to the descriptor based ABI.  This has been modified
to not break backward compatibility.

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

Changes in v7:
Also accept the DEPRECATED "gpios" devicetree entry to ensure backward
compatibility.

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

 Documentation/devicetree/bindings/pps/pps-gpio.txt |  17 +-
 drivers/pps/clients/pps-gpio.c                     | 225 +++++++++++++++++----
 include/linux/pps-gpio.h                           |   6 +-
 3 files changed, 203 insertions(+), 45 deletions(-)

-- 
2.12.3

