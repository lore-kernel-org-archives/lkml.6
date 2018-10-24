Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB98C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CBF2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PtKeUZP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CBF2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeJXRnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:43:40 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41198 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJXRnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HI/x6pwbVziVUfcNL/ZOmudUw/dS4zQcju2Ty8yfOIE=; b=PtKeUZP5HmstrwxaFzIqklO5M
        Oqj7HWAkml2UiPV5i+jTmdc69Lf8iQE6D+x0bCBu0hJ89hEGQsPd+ym7ra3EiY+qFRN47qWWedptz
        F96wxRcQKiaYB/+jl5WoO6RTbW95UN7bk0491yfrwPjk94GyatsrtKx/pAa7pkICfR47k=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:58212)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gFFGt-0001FE-O6; Wed, 24 Oct 2018 10:16:11 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gFFGm-0007SI-SU; Wed, 24 Oct 2018 10:16:05 +0100
Date:   Wed, 24 Oct 2018 10:16:00 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Maksym Kokhan <maksym.kokhan@globallogic.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 5/8] arm: convert to generic builtin command line
Message-ID: <20181024091600.GT30658@n2100.armlinux.org.uk>
References: <1538067393-5926-1-git-send-email-maksym.kokhan@globallogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538067393-5926-1-git-send-email-maksym.kokhan@globallogic.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 07:56:33PM +0300, Maksym Kokhan wrote:
> From: Daniel Walker <danielwa@cisco.com>
> 
> This updates the arm 32bit code to use the CONFIG_GENERIC_CMDLINE
> option.

Sorry, I can't accept this change.  While it may seem to be a good idea
to unify this between different architectures, the problem this presents
is that it breaks people's existing .config, and almost every single
defconfig that we have in arch/arm/configs/

The breakage is such that it will end up wiping out (eg) the setting of
CONFIG_CMDLINE entirely, and only if it's realised and retrieved
immediately from .config.old, it will be lost.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
