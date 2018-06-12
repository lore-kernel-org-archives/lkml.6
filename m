Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D3AB3C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7B52084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cBOVuPZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7B52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbeFLVsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:48:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55581 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754398AbeFLVst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:48:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so1250096wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHqlBd1xnCMMmDlUd+TsFglfRdN+9mN/tJ/ylPht99w=;
        b=cBOVuPZPTpMzoHskAd0j6Hgvy3pV5LRPdi2Lw6Kjx66lbrBEnINJ9N/3CqR+qq0uLk
         wdi35RZh3PW5fvEBpz6tqHnUWCPJvwKF/OES5Fmleg0h0w3UYL83EqAWHRJvxl2iJ1Oh
         bQGr0wjscEHJ1GZDQoPY7MCOdkAdDSwKF0DZdPPesdf792akb7wPMz23/AsAUgewvRPM
         8VJD9yaDFa4zmxvS6tga5fdsSLkvm8N6E9JpAa+cra6kbcUbSxnfY3uX8eOg7z1YaAQV
         U8oSF66QpeQxY+L0gwuFEtbikWHuWF8/ha8s5OcbZdHxPcLHZ5sW9o44UiLLohONTVrH
         DtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHqlBd1xnCMMmDlUd+TsFglfRdN+9mN/tJ/ylPht99w=;
        b=S9NJ9G+okr59FWg/DpyJlFoQBfECnt+YPh+ISlCVlTIewrO/J5/+gkezjBSO43rItB
         KFpCq6YLv5kU1DXQ4RCZTE490mQ2dMFfBZLJHw8CfaJAAkXgCK6VEmK9YrXNNutozZxs
         ysX+MHecwR2SwrE20dQcxGVypOyd2N3oWk+acNnN8fkQFRml7pnmnA/+6ho5cC0sVyum
         ShV8xroXwoMl3OaFCoffH3ewhB02jhbDomTywU9YYWdqOYXtl64asWoEIlxVOUKoO9Pw
         NfOHjUHAWR4yuzRmjr6IJDauVwKaZIJhQPoPusNsUQa+t1EJNeD94nGX1aMUEXNW/fkc
         oGiA==
X-Gm-Message-State: APt69E2MyFFvjHZAMv4B0FCamyg4DUchGTpby3Pb1c0KoYPI3IU9qybP
        8j2l9TQoag9gCSu/JzYNBS5twA==
X-Google-Smtp-Source: ADUXVKJ+XhwG27/j5CXYEP/TxnRlc0Hkk2gmdklRZmShnz8wZbJ2GmSBbG2x6c73u0Y4HGpgBRHVWw==
X-Received: by 2002:a50:83c2:: with SMTP id 60-v6mr1184221edi.263.1528840127995;
        Tue, 12 Jun 2018 14:48:47 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id i38-v6sm737233ede.41.2018.06.12.14.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:48:47 -0700 (PDT)
Message-ID: <1528840126.26829.72.camel@arista.com>
Subject: Re: [RFC] x86/vdso: Align vdso after searching for free area
From:   Dmitry Safonov <dima@arista.com>
To:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasiliy Khoruzhick <vasilykh@arista.com>, x86@kernel.org
Date:   Tue, 12 Jun 2018 22:48:46 +0100
In-Reply-To: <6d53a9e3-5776-1073-a5ae-60d50db3e467@zytor.com>
References: <20180612204948.4752-1-dima@arista.com>
         <1528838651.26829.69.camel@arista.com>
         <6d53a9e3-5776-1073-a5ae-60d50db3e467@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 14:39 -0700, H. Peter Anvin wrote:
> On 06/12/18 14:24, Dmitry Safonov wrote:
> > > 
> > > Move align_vdso_addr() after get_unmapped_area() to make sure
> > > that
> > > errata for AMD 15h is always applied.
> > 
> > Alternative dirty-hacky idea:
> > specify some (struct file*) to get_unmapped_area() for vdso vma,
> > then
> > mapping would be automatically aligned. Dirty as hell as relies on
> > get_unmapped_area() realization details.
> > 
> 
> 
> I have mentioned several times that I would like to see the vdso
> actually be an actual file in a filesystem, that the kernel *or* user
> space can map (needs to be MAP_SHARED, of course.)

Yeah, I remember I did that previously:
https://lwn.net/Articles/698854/

But hadn't time to fix review replies.
Probably, worth to resurrect the patches and clean the dust out from
them.

> The vdso data page needs to be moved after the ELF object itself for
> this to work. Ideally it should be given an actual ELF segment (and
> ideally an ELF section as well.)  The easy way to do this is to give
> the
> linker a dummy vvar page as a properly aligned section at compile
> time,
> into which space the kernel can map the real vvar page. The only
> downside is that the linker likes to put section headings after the
> actual data, so it may end up taking up an extra page over the
> current
> arrangement. However, I think the gains outweigh the losses.

-- 
Thanks,
             Dmitry
