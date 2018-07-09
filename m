Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC67C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F18920852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f88Z9qF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F18920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeGIGak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:30:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42955 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeGIGai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:30:38 -0400
Received: by mail-pf0-f193.google.com with SMTP id l9-v6so1285002pff.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yi5vgkX1BLOl47glfTMfQXgNLHgAu+/MvTXWG5XQpwI=;
        b=f88Z9qF9IxHQa9NAuKaj97iBDEDjc+hRHUJF0+WbfaP1JXLjaRWVvAYwQp8t0vxeBs
         yhr3yq1do7riNLjyncqZwH663XrRZwr3uR+ELFFSTo5XaTCir1vyvbnchCCoPgqIUMxD
         BqSsYk+ZcfykiBHtwhaQPQV2zfl+0jW79Acis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Yi5vgkX1BLOl47glfTMfQXgNLHgAu+/MvTXWG5XQpwI=;
        b=tL7kdknN3Xjv/R7/xUEKaM+hzRD/7VV3oakMKh26kjKkX3wiW0noFv9o9sn+rkHOOl
         LTQa6X1+T2rN5SeqTcMvQkWUD60yFnbLeaeqXQU1jwAT5mcP5DJGU4AC9cKUJGdoAX8E
         oRSc/kMO28ItQ8ssMOdVUNiQf0He7Ug8sEdgws3EiVrNBv6a1dKUvaTUmeA1XGUIjCfz
         RsFXYJ48y/eAbJOw2eI61eK3YpWhbdxwO4C2tRTz4vSYjDs+/wAyIxfBhf6hzKiWvmde
         C2J8uoegIAOGkSMRV85jFX8F/Tr3aAteytz51KEvLjD0vS+X+AceBO5w35+cgFfgVcXy
         y+Ag==
X-Gm-Message-State: APt69E275KakO5IPgU+C3Hbm9QTeMcMFxmbTa5yMTH0k1GcoG3pFChQY
        9MPn/uKBj4W9BHrpbFCH2pyrnA==
X-Google-Smtp-Source: AAOMgpdpDP26GBxVnfmOW4Mf5m70Rd/VY8jQwB8TKMcmTXkHGt41dXcFZpZ2DmZ7bntvJ/i3Kz9Gjw==
X-Received: by 2002:a65:5106:: with SMTP id f6-v6mr17492259pgq.72.1531117838183;
        Sun, 08 Jul 2018 23:30:38 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id q28-v6sm19912331pfg.144.2018.07.08.23.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 23:30:37 -0700 (PDT)
Date:   Mon, 9 Jul 2018 15:31:56 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 07/14] arm64: enable KEXEC_FILE config
Message-ID: <20180709063136.GS28220@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-8-takahiro.akashi@linaro.org>
 <9545cb7f-9648-660a-f034-a94f186a8224@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9545cb7f-9648-660a-f034-a94f186a8224@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Tue, Jul 03, 2018 at 05:33:20PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 23/06/18 03:20, AKASHI Takahiro wrote:
> > Modify arm64/Kconfig to enable kexec_file_load support.
> 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 42c090cf0292..f68318f61c85 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -835,6 +835,16 @@ config KEXEC
> >  	  but it is independent of the system firmware.   And like a reboot
> >  	  you can start any kernel with it, not just Linux.
> >  
> > +config KEXEC_FILE
> > +	bool "kexec file based system call"
> > +	select KEXEC_CORE
> > +	select BUILD_BIN2C
> 
> Wasn't BIN2C only needed for purgatory?

Right. Will remove it.

> x86/powerpc/s390 all select CRYPTO_SHA256 here, presumably for arch-specific
> verification mechanisms. I assume we're using SIGNED_PE_FILE_VERIFICATION instead.

To be clear, hash check (sha256) will be done at reboot (in purgatory),
while binary verification will be done at load.

> 
> > +	help
> > +	  This is new version of kexec system call. This system call is
> > +	  file based and takes file descriptors as system call argument
> > +	  for kernel and initramfs as opposed to list of segments as
> > +	  accepted by previous system call.
> > +
> >  config CRASH_DUMP
> >  	bool "Build kdump crash kernel"
> >  	help
> 
> 
> Acked-by: James Morse <james.morse@arm.com>

Thanks!
-Takahiro AKASHI

> 
> Thanks,
> 
> James
