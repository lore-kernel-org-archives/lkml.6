Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B8DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309132157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309132157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeHXH3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 03:29:53 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:51661 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeHXH3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 03:29:53 -0400
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 1C1611681
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 03:57:07 +0000 (UTC)
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 7725D5B;
        Fri, 24 Aug 2018 03:57:06 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 0DC104C;
        Fri, 24 Aug 2018 03:57:06 +0000 (UTC)
Date:   Thu, 23 Aug 2018 22:57:05 -0500
From:   Russ Anderson <rja@hpe.com>
To:     minyard@acm.org
Cc:     Andrew Banman <abanman@hpe.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, frank.ramsay@hpe.com,
        justin.ernst@hpe.com
Subject: Re: [PATCH 0/2] ipmi: Fix issues in the BT code.
Message-ID: <20180824035705.bu4gnt3m622qa3pa@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <1535056623-26634-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535056623-26634-1-git-send-email-minyard@acm.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 03:37:01PM -0500, minyard@acm.org wrote:
> The first change fixes the race condition at startup between
> capabilities detection and the startup of the upper layers of
> the IPMI driver.
> 
> The second is cleanup code that I'm doing as I touch things in the
> driver.

Quick testing looks good.  This was with your patch backported to RHEL7.6.

More testing tomorrow but so far so good.


[root@ah-038 ~]# dmesg | grep -i ipmi
[   76.409474] ipmi message handler version 39.2
[   76.529702] ipmi device interface
[   76.773727] IPMI System Interface driver.
[   76.778277] ipmi_si ipmi_si.0: ipmi_platform: probing via SMBIOS
[   76.784999] ipmi_si: SMBIOS: mem 0xce4 regsize 1 spacing 1 irq 6
[   76.806979] ipmi_si: Adding SMBIOS-specified bt state machine
[   76.813903] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[   76.833722] ipmi_si IPI0001:00: [io  0x0ce4-0x0ce6] regsize 1 spacing 1 irq 6
[   76.842593] ipmi_si: Adding ACPI-specified bt state machine
[   76.842980] ipmi_platform: probing via SPMI
[   76.842982] ipmi_si: SPMI: io 0xce4 regsize 1 spacing 1 irq 6
[   76.845116] ipmi_si: Trying SMBIOS-specified bt state machine at mem address 0xce4, slave address 0x20, irq 6
[   76.845123] ipmi_si ipmi_si.0: Could not set up I/O space
[   76.939459] ipmi_si: Trying ACPI-specified bt state machine at i/o address 0xce4, slave address 0x0, irq 6
[   76.959709] ipmi_si IPI0001:00: Using irq 6
[   76.993053] ipmi_si IPI0001:00: Found new BMC (man_id: 0x000000, prod_id: 0x0101, dev_id: 0x20)
[   77.063491] ipmi_si IPI0001:00: IPMI bt interface initialized

Thanks.
-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
