Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7075AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F5A20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EeMW/mBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F5A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbeG0GlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:41:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45554 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeG0GlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 02:41:10 -0400
Received: by mail-pl0-f65.google.com with SMTP id j8-v6so1807273pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 22:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lIGrVEYlxySY5vG6HPLgklzeIRGh5p/fybcldshXazI=;
        b=EeMW/mBX6GxENuf4vfV6DRImyAglmNvwRN7OVW+Its3B5S+otGYfjDlt2AcoeO70nV
         9MXGTKHcyRFEt+XHOSHRR9sZX1lckQxP9RDgT8kVWtoZJ91tLCFanfyg5puKFrgva595
         aT/ef8VpV9hEx4WrU4Bbs2+rsZxYWM2GlGaHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=lIGrVEYlxySY5vG6HPLgklzeIRGh5p/fybcldshXazI=;
        b=PJIvdmB2nuUJ+yaZngBzC1ccnwHXmd2aJ+uBa8az2qxvpyuOFInW0Kik6d0GqWU7F4
         LxuhwV3Ely8jXzmUmCvTtZ6ZNwl7pkZJGVDkKGA/7BlUKQcisbKbUCbewiBoCVBCBu+D
         2IZd9s8+vBUsyevgqflu4L1mZy1Pyb6PfQUeLB8BqYChr0zuw8ZeCDu2FeiGwWSwOyFy
         PjNgHCZCXo8pXFZPbBpmoqgSju/Q6TvJUKo1VTsOpbVKfvYhHz+y4BlG7Xen44wxPTDG
         kL3hHCWXtVjq5aFdksSjzhoGznPKN2bJ+s+lauCN6TJqXTrQFnfElwt86tRvnZqwFSDU
         RQSA==
X-Gm-Message-State: AOUpUlE5ehBFWhIYc6m9V5BBTAYAwXGpfIAI6aIUalMGbO7frrnuBaCA
        xeKu4VkD3fFiuMlZ/9mP0vOpFw==
X-Google-Smtp-Source: AAOMgpdV6ERLh5EfGsARzHSZ1vlM4CBO3Qgb7B2fi3s7kyq1MXCYVzt8yhDJfoRXxewtD82Wdibp5A==
X-Received: by 2002:a17:902:2006:: with SMTP id n6-v6mr4567247pla.325.1532668863030;
        Thu, 26 Jul 2018 22:21:03 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id q5-v6sm3298486pgv.61.2018.07.26.22.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 22:21:02 -0700 (PDT)
Date:   Fri, 27 Jul 2018 14:22:37 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 01/16] asm-generic: add kexec_file_load system call
 to unistd.h
Message-ID: <20180727052235.GD11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-2-takahiro.akashi@linaro.org>
 <f77fe157-f9f6-8dfc-eca0-1ecd687f671f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f77fe157-f9f6-8dfc-eca0-1ecd687f671f@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 02:35:50PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 24/07/18 07:57, AKASHI Takahiro wrote:
> > The initial user of this system call number is arm64.
> 
> This patch conflicts with commit db7a2d1809a5 ("asm-generic: unistd.h: Wire up
> sys_rseq") in the arm64 tree.

OK. I will try to rebase my code to arm64/for-next/core at v13.

Thanks,
-Takahiro AKASHI

> Thanks,
> 
> James
> 
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index 42990676a55e..c81f4a0df51f 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -734,9 +734,11 @@ __SYSCALL(__NR_pkey_free,     sys_pkey_free)
> >  __SYSCALL(__NR_statx,     sys_statx)
> >  #define __NR_io_pgetevents 292
> >  __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
> > +#define __NR_kexec_file_load 293
> > +__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
> >  
> >  #undef __NR_syscalls
> > -#define __NR_syscalls 293
> > +#define __NR_syscalls 294
> >  
> >  /*
> >   * 32 bit systems traditionally used different
> > 
