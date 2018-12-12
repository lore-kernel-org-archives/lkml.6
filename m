Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A111C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C21B20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 01:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHV0kssu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C21B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeLLBZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 20:25:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39052 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLLBZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 20:25:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so8017828pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 17:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L39WCp8AxvhR/l4yS6pELUyTr3cXP/cgOqOF4fuUhUk=;
        b=ZHV0kssuZYF1MTJVNYU97cHo10V1xY1m6lumN05r/KEJbxczO4otmex59kO7yTCYSE
         XiI0HLp7dn2t1ikJgwdnsckkT7K1J8tkqpD4XP7ujPhIKVy75NMSNIASynhSTm9hZajI
         MWPv3HjdGYflHA8IyaUzquXCefo9W3SoOoPw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=L39WCp8AxvhR/l4yS6pELUyTr3cXP/cgOqOF4fuUhUk=;
        b=o5wEqurnCH6ljPAeJVjXyZF0i8Crwlq9/JmcS5alf70mbOaLIGaWELm8w5BPm7JD/6
         FLv3stBniH4mfd0rnONWNFhBbdzXsXs0/0k4ebT+GtCtrgKdtrFiyXP9AxG2lEq4nglY
         Kvq2hGfl9ZUPtlgHNPLzM/YlsXL4vEypI8AkHxrlzRVTP7I6hf3/p+zWQ66f/uo8UE6D
         UF9Fb1N43JbXdgKI0LK4THSc9vJZ30Z6FkC1NujZFcnCozriDMW6aTG53gpe7prtKnBz
         eugMUMKxmhIuHVOionZMxacmOSbm0gBPia3jd7My9Z5MbInr+WyWU5KQKekWPV5hz0ig
         SxKA==
X-Gm-Message-State: AA+aEWaqdarck8glNCf9Jz+rW5DQLFkuBoeu/cVJyRinSjCmr0G5Awkp
        rTGHKDDVzvbYPZVQ0e6l1RZShQ==
X-Google-Smtp-Source: AFSGD/Xr5aT6Ks/5LCdeflLsdpc3K1lWxxLJxyvX8a819NiOz1jxnv4d557+SO2Z5AvhJ6ax28meUA==
X-Received: by 2002:a65:560e:: with SMTP id l14mr16670645pgs.168.1544577918462;
        Tue, 11 Dec 2018 17:25:18 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id r130sm30409734pfr.48.2018.12.11.17.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 17:25:17 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:28:31 +0900
From:   "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        prudo@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v16 06/16] lib: fdt: add a helper function for handling
 memory range property
Message-ID: <20181212012830.GJ21466@linaro.org>
Mail-Followup-To: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, prudo@linux.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, bhsharma@redhat.com,
        kexec@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
 <20181115055254.2812-7-takahiro.akashi@linaro.org>
 <CAL_JsqL4_Z5pVfoB3opjL7eTzZvhBJW7_aQS443quAAR0gGH1w@mail.gmail.com>
 <20181206155424.GA4422@arm.com>
 <681e1265-2f0c-2a62-3778-09911b2be7fc@arm.com>
 <20181211061715.GF21466@linaro.org>
 <654bffae-7edb-bda4-d01d-99a8b455b186@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <654bffae-7edb-bda4-d01d-99a8b455b186@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:09:07AM +0000, James Morse wrote:
> Hi Akashi,
> 
> On 11/12/2018 06:17, AKASHI, Takahiro wrote:
> > On Fri, Dec 07, 2018 at 10:12:47AM +0000, James Morse wrote:
> >> On 06/12/2018 15:54, Will Deacon wrote:
> >>> On Thu, Dec 06, 2018 at 08:47:04AM -0600, Rob Herring wrote:
> >>>> On Wed, Nov 14, 2018 at 11:52 PM AKASHI Takahiro
> >>>> <takahiro.akashi@linaro.org> wrote:
> >>>>>
> >>>>> Added function, fdt_setprop_reg(), will be used later to handle
> >>>>> kexec-specific property in arm64's kexec_file implementation.
> >>>>> It will possibly be merged into libfdt in the future.
> >>>>
> >>>> You generally can't modify libfdt files. Any changes will be blown
> >>>> away with the next dtc sync (there's one in -next now). Though here
> >>>> you are creating a new location with fdt code. lib/ is just a shim to
> >>>> the actual libfdt code. Don't put any implementation there. You can
> >>>> add this to drivers/of/fdt_address.c for the short term, but it still
> >>>> needs to go upstream.
> >>>>
> >>>> Otherwise, the implementation looks fine to me.
> >>>
> >>> I agree, but I don't think there's a real need for us to hack
> >>> drivers/of/fdt_address.c in the meantime -- let's just target upstream
> >>> and not carry this in the kernel.
> >>>
> >>> Akashi -- for now, I'll drop the kdump parts of this series which rely
> >>> on this helper. The majority of the series is actually independent and
> >>> can go in as-is.
> >>>
> >>> I've pushed out a kexec branch to the arm64 tree for you to take a look
> >>> at:
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kexec
> >>
> >> I gave this a quick spin. Without the elfcorehdr/usable-memory-range arm64 needs
> >> to explicitly forbid kdump via kexec_file_load. (like powerpc does already).
> > 
> > Thank you for pointing this out.
> > 
> >> Without this kdump works, but the second kernel overwrites the first as those DT
> >> properties are missing.
> >>
> >> I'll post a patch momentarily,
> > 
> > Fine, but anyhow I'm going to submit a new version (*without* kdump),
> > I will fix the issue along with others.
> 
> I had a quick look at the arm64 for-next/core branch. Will has queued the
> non-kdump parts of this series.
> 
> If you have changes, they need to be against the arm64 tree.

Okay!

-Takahiro Akashi

> 
> Thanks,
> 
> James
