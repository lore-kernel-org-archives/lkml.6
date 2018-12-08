Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F03BC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 13:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E241320892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 13:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544275218;
	bh=CjYODOZFdiZE1LVsY0cajjslPhWdjEj6Q/0FtmXmeGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H2IVYwtXGRAWx5uKJweJQUXX78u6MQwl9OJPC82aVrg+SatqJ9TwNuMK+IuV7ytYl
	 XV+Fgu2t7X95CllxbxqYYzVLC47f7ZzJKFVHMHfSWocOlJg0X7MKPaievtCsNeDK9a
	 FxHfHfVqQmJAgZmxI2tr0sa7bTn+L5RvNGw/7YcQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E241320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeLHNUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 08:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeLHNUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 08:20:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAAB72081C;
        Sat,  8 Dec 2018 13:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544275215;
        bh=CjYODOZFdiZE1LVsY0cajjslPhWdjEj6Q/0FtmXmeGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfE2wmMMMiXF7A6qbDuw1hS+XoFEdwvMKFXQaC/xycJgicqccMPw/3NquPM8E8wH3
         lZVtnZEwmiTTGa+ycSz4vH3AMIxRcAW4wkQ29VPUcNEH/zz0H1PJCdhFIEDatsseG5
         ND3saHHOTUooGOmg40ZsGvYF54wviqklGV70Nzdg=
Date:   Sat, 8 Dec 2018 14:20:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kirill Marinushkin <k.marinushkin@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/retpoline: Fix forcing me to update my compiler
Message-ID: <20181208132005.GA658@kroah.com>
References: <20181208123816.22952-1-k.marinushkin@gmail.com>
 <20181208124240.GE30399@zn.tnic>
 <7d8aa04f-9611-fb69-b11c-21ebcf4580fd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d8aa04f-9611-fb69-b11c-21ebcf4580fd@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 02:14:47PM +0100, Kirill Marinushkin wrote:
> >> First problem: I cannot compile the kernel with my version of compiler
> 
> >> Second problem: when I disable the feature - it cannot take effect,
> >> because the parse-time error happens before `syncconfig`
> 
> On 12/08/18 13:42, Borislav Petkov wrote:
> > Does this help?
> > 
> > https://git.kernel.org/tip/25896d073d8a0403b07e6dec56f58e6c33678207
> > 
> 
> The patch which you mentioned fixes the second problem: now I can disable
> CONFIG_RETPOLINE.
> But, the first problem is still here: with defconfig and gcc v6.4.0, kernel
> doesn't build, with this message:
> 
> ~~~~
> $ make
> scripts/kconfig/conf  --syncconfig Kconfig
> You are building kernel with non-retpoline compiler.
> Please update your compiler.
> make: *** [arch/x86/Makefile:311: checkbin] Error 1
> ~~~~
> 
> I don't think that this is a proper behavior. I suggest to allow compilation

No, you asked for retpoline, and your compiler can not provide that, so
erroring out is the correct behavior.  It is worse for you to have an
option enabled and it not being enabled just because your compiler does
not support it.  That way you do not have the false sense of security.

thanks,

greg k-h
