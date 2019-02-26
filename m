Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C054C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A35217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551193293;
	bh=wm/URQCea1WImYu0fsuu4AOwupC/OHhZTfIYPDm8SkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t9yoiczN2vEqs2UuFsclUEJuAtGHGMU8cG4ilW7fQcHyVG2A8Gf4PMASXatMhdtBm
	 dgsUWwNKyvOyUnirHsNM7CKFyMcR3gs84gVdRC3xbmm/JFafgzD177WwAzF/veLGlS
	 5ER61WscUeCNwQY/hBQzMvAUGruJLrdYhZAAslhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfBZPBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:41648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfBZPBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:01:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A30217F5;
        Tue, 26 Feb 2019 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551193290;
        bh=wm/URQCea1WImYu0fsuu4AOwupC/OHhZTfIYPDm8SkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbW+laZ3DrDaoC6Ce0IW5IV+ZI5jpdD9dTwFtND97SQuFcC4Bv1OqvD094kTcK+Ld
         ac8OkF71gBsatEH3oXRk8ph7Rei0L/oTxbBwgwCqL80eclGATNIDw+506Ct97IUb+/
         nidQifdNHvnmgYqvEwdgCbaf1RRCxDjLPVKsRwEo=
Date:   Tue, 26 Feb 2019 16:01:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.20 129/183] net: sfp: do not probe SFP module before
 were attached
Message-ID: <20190226150128.GB28178@kroah.com>
References: <20190225195054.748060397@linuxfoundation.org>
 <20190225195116.455060281@linuxfoundation.org>
 <20190226142919.GG10616@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226142919.GG10616@sasha-vm>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 09:29:19AM -0500, Sasha Levin wrote:
> On Mon, Feb 25, 2019 at 10:11:42PM +0100, Greg Kroah-Hartman wrote:
> > 4.20-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Russell King <rmk+kernel@armlinux.org.uk>
> > 
> > [ Upstream commit b5bfc21af5cb3d53f9cee0ef82eaa43762a90f81 ]
> > 
> > When we probe a SFP module, we expect to be able to call the upstream
> > device's module_insert() function so that the upstream link can be
> > configured.  However, when the upstream device is delayed, we currently
> > may end up probing the module before the upstream device is available,
> > and lose the module_insert() call.
> > 
> > Avoid this by holding off probing the module until the SFP bus is
> > properly connected to both the SFP socket driver and the upstream
> > driver.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This one got fixed by 87454b6edc1b0143fdb3d9853285477e95af74a4 .

Thanks for catching this, I'll go queue this up now.

greg k-h
