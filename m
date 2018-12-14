Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A935FC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54B72086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="GMdqXOqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54B72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbeLNCbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 21:31:52 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:38696 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbeLNCbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 21:31:52 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from localhost.localdomain ([1.128.229.148])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wBE2UxcB004738
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 14 Dec 2018 13:31:15 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1544754678; bh=DvwUpB+mFUEaKfr9gIhRbQLIJUfzFvfQDVH/YSe9shs=;
        h=From:To:Cc:Subject:Date;
        b=GMdqXOqCA6ycujJ3w7dHDXYR4/aicl2x1hcMjKs4fcz7+dcTY+In49B/MJ1idAhTa
         EzMc9t3lxcB8wZ4LyDvmFy2pKIB2yPxZ4Ex2Y2suBBaPIeysAjvVXGC2D+K5IbA6Ch
         9H3IhjOpaAKZt2orsYKVE+X4YLLLKKWwP+ZQgSfN8QWdGYwV8VcbLwq5nH46LFPw/W
         Jdu03rMMHM9z6zJcoG1wQYuAt4yQlXySsImQazbHpMu2iauv35slbDykkfJwNHGjKq
         jcY8kHxTk55ELfrgwHvEc5Y1TkR1NInbvUsz827fnqCfzgo2tzDEDCq8sR3b60/GrS
         FP26iP3nnP3sQ==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Ricardo Martins <rasm@fe.up.pt>,
        James Nuss <jamesnuss@nanometrics.ca>
Subject: [PATCH v13 0/3] PPS: pps-gpio PPS ECHO implementation
Date:   Fri, 14 Dec 2018 13:30:16 +1100
Message-Id: <20181214023019.18805-1-tom@aussec.com>
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

Change in v13:
Patch 2/3 (DT bindings) now reviewed. Thanks a lot, Rob!

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

