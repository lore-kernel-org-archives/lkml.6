Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518CBC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 13:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726DE20818
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 13:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="kK28yzJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726DE20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeKQXXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 18:23:01 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:36448 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeKQXXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 18:23:01 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAHD5ubm015913
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Sun, 18 Nov 2018 00:06:15 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1542459976; bh=hYy//AxlMp9zRIDL21dmLPm1sTgyD2LhXBm8iFsIH0o=;
        h=From:To:Cc:Subject:Date;
        b=kK28yzJ/Db1ZmGG7Hq1JMBUciZKYrmN7k7aSEL3yfQv0FBxs3d0NW9eQysbjJuPt8
         oVIhiRyHg0y3j9HKQVxuHe/1wPD+a9U4dZe4ry/O+DsD70ZLkOriklvTxWpPtPDJKy
         7V9a3BI5SeyK8+0iozLFCkboRr0MDovB+lFP0/J2pfPmjCIMh8nhTNj0n9oDDd0b4/
         jKgeMsdxpJ6y7hPiiN9o4RUZED+4PdNosV5iccmI2c6Tl6nlSH5f0FHmUQ9oqehs83
         6cISc3vfxx+yyD0ci0gfxhITHDuH54ovtPK8yzxV174PDcWc3PvpoMbzRdS+sLHf/e
         vFb3RN5DjwkjQ==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>
Subject: [PATCH v8 0/4] PPS: pps-gpio PPS ECHO implementation
Date:   Sun, 18 Nov 2018 00:03:33 +1100
Message-Id: <20181117130337.5856-1-tom@aussec.com>
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
  dt-bindings: pps: capture-clear addition
  pps: descriptor-based gpio, capture-clear addition
  dt-bindings: pps: pps-gpio PPS ECHO implementation
  pps: pps-gpio pps-echo implementation

 Documentation/devicetree/bindings/pps/pps-gpio.txt |  11 ++
 drivers/pps/clients/pps-gpio.c                     | 180 ++++++++++++++++-----
 include/linux/pps-gpio.h                           |   6 +-
 3 files changed, 153 insertions(+), 44 deletions(-)

-- 
2.12.3

