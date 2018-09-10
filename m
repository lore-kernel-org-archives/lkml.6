Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1456FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0AC20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KTR48XMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0AC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeIJQkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:40:15 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:42182 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeIJQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:40:15 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0905B10C1498;
        Mon, 10 Sep 2018 04:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536579995; bh=NcR9Qih7PKeA8A6p0AIGw7IU1WZ6V51t2SCEKpINu1w=;
        h=From:To:Cc:Subject:Date:From;
        b=KTR48XMe0w8kxDCQx1USjJaiTRO2gMWwhna2e2+mN/WVMASdhECFtvy3w+tFXA2LG
         OoEeoEgKRArgL+eN1t9Fivqxp/xDZFn6S1CBvosxcx6KQu9xbGvvJ8fLcN/6OuAEiu
         YCL7OmgUW4BEiCB9U6BUa1UkjKEK6Tn1JFEmW/hrIuLfIrLfYR0tmsiDKCX5TLGdaE
         cLcreyVRVAnVMWcuhTO+eOdS6fYYoGowtAl3iBuUBF+qELRVCXMLK+LLufOUjXTpet
         xpFEYXB2SvKG+SR2KAL6Jmaf4dJCzm+8RSgL/f0A9i99j0rCj/zIQ5D8EqKdNFyMP5
         mFYp2r3gCNK8g==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.37])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4EF7E5543;
        Mon, 10 Sep 2018 04:46:31 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 0/2] MTD: spi-nor: add support for sst26wf016, sst26wf032
Date:   Mon, 10 Sep 2018 14:46:26 +0300
Message-Id: <20180910114628.19156-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SST sst26wf016 and sst26wf032 flash IC:

sst26wf*** flash series block protection implementation differs from other
SST series, so we add implementation for sst26wf*** lock/unlock/is_locked
functions.

Add sst26wf016 and sst26wf032 flash IC info to spi_flash_ids list.

NOTE:
these patches is basically following mine u-boot commits port:
http://git.denx.de/?p=u-boot.git;a=commitdiff;h=3d4fed87a5fa3ffedf64ff2811cd95c5ac4503ac
http://git.denx.de/?p=u-boot.git;a=commitdiff;h=a19e97157c3721ef9c4b15c68c1773467a3b4a98

Changes v1->v2:
 * Check return value of {read | write}_reg callbacks.

Eugeniy Paltsev (2):
  mtd: spi-nor: Add support of sst26wf* flash ICs protection ops
  mtd: spi-nor: add support for sst26wf016, sst26wf032

 drivers/mtd/spi-nor/spi-nor.c | 179 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |   4 +
 2 files changed, 183 insertions(+)

-- 
2.14.4
