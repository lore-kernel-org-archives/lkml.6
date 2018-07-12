Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089E4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30AF205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30AF205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeGLD6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 23:58:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:59053 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeGLD4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 23:56:44 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6C3mnNS020207;
        Wed, 11 Jul 2018 22:48:50 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-aspeed@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] fsi: Coldfire coprocessor offload
Date:   Thu, 12 Jul 2018 13:48:42 +1000
Message-Id: <20180712034847.12878-1-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements support for offloading the FSI protocol bitbanging
to the ColdFire secondary core of the Aspeed SoCs. The result increases
FSI performance by a factor of 4, and on systems that don't support async
FSI clock, provide much more regular and continuous clocking which helps
reliability.

This series is much smaller than the previous submissions as I already
merged all the "preparatory" work into the FSI tree. This is now strictly
the coldfire support and is now only waiting for ack of the DT bindings
(and whatever other review comments might come my way) before I put it
into the FSI tree and sends it to Greg.

There are two dependencies to be able to build/use this. The above
prep work:

      https://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git/log/

And the Aspeed GPIO driver changes for handling with GPIO lines ownership and
handshaking. The patches have been merged into the GPIO tree and a dedicated
immutable topic branch and can be found here:

      https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=ib-aspeed

Finally, the driver needs a machine specific firmware file. The firwmare
is open source and available at:

	https://github.com/ozbenh/cf-fsi

I will submit it to linux-firmware if there's enough popular demand ;-)

v2. Fix misuse of devm_kzalloc for objects containing a struct device
    in fsi-master-gpio and fsi-master-ast-cf (similar fixes for the
    various FSI drivers will come later a part of rework to move away
    from misc devs).

v3. Sparse fix and updated DT bindings as per Rob's comments.



