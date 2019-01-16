Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C144C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFDC20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Djjg6HJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfAPVbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:31:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34952 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729425AbfAPVbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:31:07 -0500
Received: from zn.tnic (p200300EC2BC98A005C5A6BB989505731.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:8a00:5c5a:6bb9:8950:5731])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAC421EC0B59;
        Wed, 16 Jan 2019 22:31:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547674265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dtys+NmIRT0opIiV30YuHca9dgjL9piQ9Ytb2fj5jxU=;
        b=Djjg6HJYlOhSD+E3+wXrjolFDjvW5SAda1VvM2HOvi3ne3/H9lRclElLbz+p+uSMhqO/eP
        7aId2l2yD8DEs0NYoWBhzbFijeTlyflPQcG+tgLYy8C041FyF4B/UB1sPw6XVklp6TxJfy
        sfpED6fu1Di+LMkbAQjdO38TYQXZ+68=
Date:   Wed, 16 Jan 2019 22:30:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Stefan Schaeckeler <schaecsn@gmx.net>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        andrew@aj.id.au, mchehab@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-edac@vger.kernel.org,
        sschaeck@cisco.com
Subject: Re: [PATCH 1/2] EDAC: Add Aspeed AST2500 EDAC driver
Message-ID: <20190116213059.GM15409@zn.tnic>
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
 <1545026517-64069-2-git-send-email-schaecsn@gmx.net>
 <20190110095049.GB17621@zn.tnic>
 <20190115175749.01E3C6E85603@corona.crabdance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115175749.01E3C6E85603@corona.crabdance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 09:57:48AM -0800, Stefan Schaeckeler wrote:
> That's interesting. I did a grep over all 16944 GPL licensed files with an SPDX
> identifier.
> 
> 785 of them have a license text while 16159 don't.

Goes to show that we're still in the process of converting stuff to SPDX.

> When stripping off aspeed_edac_, some static function names will become quite
> "bare-bone":
> 
> aspeed_edac_init(), aspeed_edac_exit(), aspeed_edac_probe(),
> aspeed_edac_remove(), aspeed_edac_of_match(), aspeed_edac_isr(),
> aspeed_edac_config_irq().

So namespaced function names we normally use for globally visible
symbols and those are not but only driver-specific. So, for example,

aspeed_edac_config_irq()

is a mouthful, at least to me, and not needed. config_irq(), OTOH, is
clear at a very quick glance.

The others, aspeed_edac_init(), etc, you could call aspeed_init(),
aspeed_exit() or so.

But since you're going to be stare at that code, this was just a
suggestion. Your call. :)

> Does your suggestion also apply to static variables? E.g. aspeed_edac_regmap,
> aspeed_edac_regmap_config, aspeed_edac_driver? Also, here some variable names
> would become quite "bare-bone".

Same as above.

HTH.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
