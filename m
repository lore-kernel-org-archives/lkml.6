Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0834FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20312086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xb/sauwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20312086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935260AbeFMN3f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:29:35 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:41501 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934436AbeFMN3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:29:33 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5DDTBsS030644;
        Wed, 13 Jun 2018 08:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528896551;
        bh=uQqP+tBnAJBIjixZ3mQzlWE9UjQiVis5lNqKoAZBVuQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Xb/sauwObNkWzF/z/bPRMZnrpZiDx96WxXc3EdQdJDrXiHc4YQW59RIFN/GhSf/ko
         5v7jVgm7tKxzUuL/g4Q/Qt2PR0Lki8DXaWlziVCFO42u/oqaTG85bJGHoWDJHB/Egs
         hbQ1t0ToOK1B7Sj6NEFgby4n8H7yCzhXByC95Z4o=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5DDTB6I005979;
        Wed, 13 Jun 2018 08:29:11 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 13
 Jun 2018 08:29:10 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 13 Jun 2018 08:29:10 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5DDTAbo027986;
        Wed, 13 Jun 2018 08:29:10 -0500
Date:   Wed, 13 Jun 2018 08:29:10 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
CC:     Tony Lindgren <tony@atomide.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of
 BTB) for secondary cores
Message-ID: <20180613132910.wr7ngq4nvxlgaoqi@kahuna>
References: <20180612213611.2484-1-nm@ti.com>
 <20180613101153.GD6920@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180613101153.GD6920@n2100.armlinux.org.uk>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:11-20180613, Russell King - ARM Linux wrote:
> On Tue, Jun 12, 2018 at 04:36:11PM -0500, Nishanth Menon wrote:
> > Call secure services to enable ACTLR[0] (Enable invalidates of BTB with
> > ICIALLU) when branch hardening is enabled for kernel.
> 
> As mentioned elsewhere, I don't think this is a good idea - if the secure
> world is not implementing the Spectre workarounds, then the _system_ is
> exploitable.
> 
> If the secure world is implementing the spectre workarounds, it will
> already have enabled the IBE bit (which is r/w from secure, read only
> from non-secure.)
> 
> So, basically, lack of the IBE bit being set is basically telling the
> kernel that it's running on a vulnerable platform _even if the kernel
> were to set it through some means_.

On GP devices OMAP5/DRA7, there is no possibility to update secure side
since "secure world" is ROM and there are no override mechanisms possible.
on HS devices, I agree, appropriate PPA will do the workarounds as well.

However, this patch is to enable the IBE enable on GP device for _a_
core can only be done via SMC services that ROM provides for
specifically the reasons you have already stated. u-boot will only
enable the IBE for the boot core, by the time the secondary cores start
up, u-boot is long gone.. so someone has to invoke the SMC call to
enable the IBE bit for the secondary core.

This is what the patch does.

If the above explanation makes sense, I will add that to the commit log
as well.

-- 
Regards,
Nishanth Menon
