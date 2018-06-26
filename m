Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CE8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71318269A5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71318269A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754529AbeFZXXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:23:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:46284 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbeFZXXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:23:54 -0400
Received: from pasglop.au.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5QNNMmn022709;
        Tue, 26 Jun 2018 18:23:26 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] fsi: Fixes and Coldfire coprocessor offload
Date:   Wed, 27 Jun 2018 09:23:07 +1000
Message-Id: <20180626232321.12372-1-benh@kernel.crashing.org>
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

Patch 1 may go a different route and was already posted a few weeks ago,
I included it for completeness.

Patches 2..9 add some infrastructure to the FSI core to control some
of the FSI protocol delays and adjustements/fixes to the existing GPIO
bitbanging master. They are "mechanical" dependencies

Patch 10 moves some protocol definitions to a common place where the
new master driver can find them

Patch 11 is the DT binding for the new driver with comes with patch 12

Finally patch 13 and 14 update the Romulus and Palmetto board device-trees
to use the new driver.

There's another dependency on the Aspeed GPIO driver changes for handling
with GPIO lines ownership and handshaking. The patches have been submitted
and can be found for reference there:

        https://github.com/ozbenh/linux-ast/commits/gpio

Finally, the driver needs a machine specific firmware file. The firwmare
is open source and available at:

        https://github.com/ozbenh/cf-fsi

I will submit it to linux-firmware if there's enough popular demand ;-)


