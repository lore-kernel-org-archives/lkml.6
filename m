Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94E1C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA77A217D6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="aoDI0mr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfBBK7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:59:44 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:40228 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfBBK7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:59:43 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from localhost.localdomain ([1.128.141.87])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id x12AwsV7016455
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Sat, 2 Feb 2019 21:59:10 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1549105153; bh=dsIY0n+z8orwZrNC/8i7HWh9FmtUCCnNinT4nrbqufM=;
        h=From:To:Cc:Subject:Date;
        b=aoDI0mr+S9+OfQZExOmBK8kHu0/PA09TvF+noIakR88So5/cT2Bem/fd9HU531R5p
         2DvorC/Ug9JpEvoVanNr+GbJw+rJDN5oxNdifeOF+LiZX4B1XO0r8G3Gvu90UdhVe4
         oLD8RT1Nh6RcP3X+TjZiXeKYH+7z+34AIOvgvG6wiBFsjSDcoEpvz9UG3sGSP5aCL/
         mZydw6+zJh2sUtRJ9iSRdG6yBhiDymh4jwj4VU1CTF0hib+ZMHsHEZUCm5750iSVy/
         SEhxMeoKJ5yWihd035egKOe0eHmG6AoTYX2ZfhOyqlz5wGwFhhfE+W5R/cB2D75mvU
         KVyZkz+vHywdA==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Ricardo Martins <rasm@fe.up.pt>,
        James Nuss <jamesnuss@nanometrics.ca>
Subject: [PATCH v15 0/3] PPS: pps-gpio PPS ECHO implementation
Date:   Sat,  2 Feb 2019 21:57:21 +1100
Message-Id: <20190202105724.4743-1-tom@aussec.com>
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
based GPIO API to the descriptor based API.

Parts 2 and 3 then add the PPS ECHO functionality.  This is enabled if a
"echo-gpios" entry is found in the devicetree.

Changes in v10:
Changes requested by Philipp Zabel:
Mostly cosmetic changes: PATCH 2/4 now reviewed.  Thanks a lot, Philipp!
(Please note that as of v11 PATCH 1 is gone so this has become PATCH 1/3)

Change in v11:
Change requested by Rob Herring:
All changes in regard to the capture-clear DT entry are gone.

Change in v12:
Change requested by Rob Herring:
Deleted superfluous use of invert-pps-echo

Change in v13:
Patch 2/3 (DT bindings) now reviewed. Thanks a lot, Rob!

Changes in v14:
Simplify code enabling PPS ECHO functionality.

Changes in v15:
Changes requested by Rodolfo Giometti.

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
 drivers/pps/clients/pps-gpio.c                     | 153 ++++++++++++++++-----
 include/linux/pps-gpio.h                           |   5 +-
 3 files changed, 125 insertions(+), 40 deletions(-)

-- 
2.12.3

