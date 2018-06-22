Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288B5C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA83223D14
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA83223D14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751206AbeFVEby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 00:31:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:60861 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbeFVEbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 00:31:53 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5M4VZ5Y007407;
        Thu, 21 Jun 2018 23:31:36 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     openbmc@lists.ozlabs.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [RFC PATCH 00/14] fsi: Fixes and Coldfire coprocessor offload
Date:   Fri, 22 Jun 2018 14:31:20 +1000
Message-Id: <20180622043134.18238-1-benh@kernel.crashing.org>
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


