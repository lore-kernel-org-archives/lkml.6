Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D52C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C736720881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ZW++bNBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C736720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJPUAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:00:02 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:45470 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJPUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:00:02 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 257C65C01E8;
        Tue, 16 Oct 2018 14:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1539691790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vc7OfA8K90wk3LmnhZR1nunIfmX0CyAv0TExfiih588=;
        b=ZW++bNBYYa3zM8xllZpFcKHKCrQ3tL7QipGfskAhJC5E/C2XawQXp0sOTfb8gPKn8UHjGy
        Cul2vhpHfRKVyu4hbebXBjFMoCOhyTGVoKTTZ7VS4jk1v4gey5wTXLp9ydVZfEamG8FQj0
        x+QfVuY0Kr+fefnTKS9Z2lrt1F4FjOY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Oct 2018 14:09:49 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>, arnd@arndb.de,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, ulli.kroll@googlemail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: copypage: do not use naked functions
In-Reply-To: <20181016083341.GE30658@n2100.armlinux.org.uk>
References: <20181015222621.14673-1-stefan@agner.ch>
 <nycvar.YSQ.7.76.1810151831040.1498@knanqh.ubzr>
 <20181015224152.GA30658@n2100.armlinux.org.uk>
 <4e598f27e3dc7ae9fd96a6cf097d1154@agner.ch>
 <nycvar.YSQ.7.76.1810151908450.1498@knanqh.ubzr>
 <20181016083341.GE30658@n2100.armlinux.org.uk>
Message-ID: <473d9036247c467d1d3c0573ebad09c1@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.2018 10:33, Russell King - ARM Linux wrote:
> On Mon, Oct 15, 2018 at 07:27:43PM -0400, Nicolas Pitre wrote:
>> It's hard to see what that commit was actually fixing, but the operands
>> usage is wrong as explained already. Maybe the generated code has been
>> OK for all those years but that is due to luck rather than correctness.
> ...
>> No idea. Maybe Russell remembers?
>> Maybe digging into the mailing list archive might tell.
> 
> I found this as a reply to the patch by Mikael Pettersson:
> 
> I've tested and verified that this bit enables a gcc-4.5 compiled kernel
> to boot on TS-119 (Kirkwood) when combined with my fix for __naked.
> With neither or only one of the patches applied, the kernel oopses hard
> in copy_user_page() as it tries to start /sbin/init.
> ...
> - the asm() bodies of these __naked functions have inadequate input
>   parameter constraints, in particular they fail to declare any
>   dependencies on the functions' formal parameters; gcc-4.5 sees this
>   and skips the parameter setup before calling these functions, causing
>   runtime crashes; Khem's patch (this one) fixes that
>   (copypage-xscale.c already had correct asm() constraints so it works
>   with only the __naked fix, these other copypage-*.c files need both
>   patches to work)
> 
> So, while wrong to the GCC manual, it's fixing a bug that is present
> with gcc-4.5 and who-knows what other GCC versions.  Reverting the
> commit has the chance to cause regressions with GCC.

The build system requires at least GCC 4.6 currently, so we do not have
to deal with 4.5.

> 
> It looks like any change here needs to be validated on a range of
> GCC versions, because there are versions of GCC known not to follow
> it's manual!

The commit message as well as the above message sounds more like it was
a newly introduced behavior in 4.5. I would suggest to at least check
4.6 to make sure it has been corrected.

--
Stefan
