Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2134C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61232082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9oPWpRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61232082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeLKGOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:14:08 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50324 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeLKGOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:14:07 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so1899488iti.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 22:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ygsu3tUgZUUY5/uDHXTU/n86CTw4PpyergSMBneeTmM=;
        b=W9oPWpRkSetpvqu2JArL5IJBL+9XepYEAjTCTvmqSm4ceHKoC5yRRsJfOT+a7pl7CZ
         E8n2NRXFGHCRap+GCN3HgBr1xCy2gvFFGlIN9tn+k80yJUvwdO2oPhVZaxrYpnJfZb+3
         OJJ1OHehxBR9+TE1JoZ0Op5/u0P2z2xNW1f2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Ygsu3tUgZUUY5/uDHXTU/n86CTw4PpyergSMBneeTmM=;
        b=fmUMMTcjKxXs4TCt9b+yQ09SdK3WFClc1IBqu9RjxY/8mug/4ck6NMXjDr+D0qHdU0
         sixend4jshtBdEtgSsUjInrdeBZK0jYjvBFhsO0clXapd1e2g5d5Nf5LQZrkMfCXt9v/
         KurmnnAlfISou9hC6VyoceGHLAeZ/JwlyodVQbvKX/JJf78AWlFv3tOpsV0qSniksCiH
         UM3rTtvWSxFi+98KOAoeci+HMzb+ojMx7CblLoQp+xbh9QhAHxGbNqfzxQA2dcii1oYT
         YpaLJF0RPwDHQ/tShwe7jGR72TwAco8z+9g+xOL5GT90EiJuH0GU5oh7Qc3YTvCZqFhm
         agxg==
X-Gm-Message-State: AA+aEWZkfJ2UtYOi4cClG/KCgaVbKUxNMqCmcp57TwILyxFxcNKvFYKz
        wkkaRoPgW2ojs56ZVBhWD6XXOw==
X-Google-Smtp-Source: AFSGD/XviidQxZ72Bu8O2KqYzD/0/GfY53D1AeAq4CNCkSTRBH6qPQ5PX8nDRwdAjRno9x6tTQ9PCA==
X-Received: by 2002:a24:9fc1:: with SMTP id c184mr1162993ite.8.1544508846272;
        Mon, 10 Dec 2018 22:14:06 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 196sm669244itu.37.2018.12.10.22.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 22:14:05 -0800 (PST)
Date:   Tue, 11 Dec 2018 15:17:16 +0900
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
Message-ID: <20181211061715.GF21466@linaro.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681e1265-2f0c-2a62-3778-09911b2be7fc@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Fri, Dec 07, 2018 at 10:12:47AM +0000, James Morse wrote:
> Hi Akashi, Will,
> 
> On 06/12/2018 15:54, Will Deacon wrote:
> > On Thu, Dec 06, 2018 at 08:47:04AM -0600, Rob Herring wrote:
> >> On Wed, Nov 14, 2018 at 11:52 PM AKASHI Takahiro
> >> <takahiro.akashi@linaro.org> wrote:
> >>>
> >>> Added function, fdt_setprop_reg(), will be used later to handle
> >>> kexec-specific property in arm64's kexec_file implementation.
> >>> It will possibly be merged into libfdt in the future.
> >>
> >> You generally can't modify libfdt files. Any changes will be blown
> >> away with the next dtc sync (there's one in -next now). Though here
> >> you are creating a new location with fdt code. lib/ is just a shim to
> >> the actual libfdt code. Don't put any implementation there. You can
> >> add this to drivers/of/fdt_address.c for the short term, but it still
> >> needs to go upstream.
> >>
> >> Otherwise, the implementation looks fine to me.
> > 
> > I agree, but I don't think there's a real need for us to hack
> > drivers/of/fdt_address.c in the meantime -- let's just target upstream
> > and not carry this in the kernel.
> > 
> > Akashi -- for now, I'll drop the kdump parts of this series which rely
> > on this helper. The majority of the series is actually independent and
> > can go in as-is.
> > 
> > I've pushed out a kexec branch to the arm64 tree for you to take a look
> > at:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kexec
> 
> I gave this a quick spin. Without the elfcorehdr/usable-memory-range arm64 needs
> to explicitly forbid kdump via kexec_file_load. (like powerpc does already).

Thank you for pointing this out.

> Without this kdump works, but the second kernel overwrites the first as those DT
> properties are missing.
> 
> I'll post a patch momentarily,

Fine, but anyhow I'm going to submit a new version (*without* kdump),
I will fix the issue along with others.

-Takahiro Akashi


> 
> Thanks,
> 
> James
> 
