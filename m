Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E54C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84492170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84492170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeHTT2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:28:02 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36181 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeHTT2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:28:02 -0400
Received: by mail-qt0-f196.google.com with SMTP id t5-v6so16781090qtn.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 09:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQzIPj8KEooW+TpwVf9xFk2fotCR7vpQav+R+wY95FA=;
        b=ba/v+TZCeA2jGUNyRKHOCmL9rhthfA2tQSJpvycQucxPIra3k7wvB7Z9X1+/Wga/nf
         YZvY0jRA9BYUlrElTQ2FgCY/RfUCJ6Ok23GGcgr+TNGfyBsbGl4mIPytAL8Qsb23HNJv
         dJtOsYndg1PeDahHlut9ukKQnmOD5HtrNfzPQHF2jWYhkHcH+FYAGXYzycO87XtHmpFg
         0XizoKq/fdhitHZXSEyJHrL8uO8n/9ZbPMiSUWVo3eyWxSlTRdycSRgYhahOaZzka249
         GXMO7ftNdXF12lz3/ekmVnWRtFCfeZIKvwvTwiyJl3tLPLrLe6timLDAmtsMBJrz19o9
         8QNA==
X-Gm-Message-State: APzg51Do9gukWu+tJC3N9HMKvNuDKoIruqgTD1MCWs1OImVnjbrC1xW0
        zsSMzdSalnh+cOt/346OpjbKSAmnIa2b/Yfp1yDMAliV
X-Google-Smtp-Source: ANB0VdYCtJbKysLKyCL3OrohZEX+pC336jw1cZtwLlV/EqLKVF5WYGeK37n19II6FIjOImu1f25m0+3VpZvBL4KmD+k=
X-Received: by 2002:a0c:c171:: with SMTP id i46-v6mr3234178qvh.40.1534781507629;
 Mon, 20 Aug 2018 09:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180814091904.2186262-1-arnd@arndb.de> <alpine.DEB.2.21.1808201737330.1551@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808201737330.1551@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Aug 2018 18:11:31 +0200
Message-ID: <CAK8P3a3fF0Xtw_eEbu4oUBMFSWVmMTHUr_=k_CKRWFzi0m370w@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: apm: mark proc_apm_show as __maybe_unused
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jiri Kosina <jikos@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 5:40 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 14 Aug 2018, Arnd Bergmann wrote:
>
> > A new build error appeared with CONFIG_PROC_FS disabled:
> >
> > arch/x86/kernel/apm_32.c:1643:12: error: 'proc_apm_show' defined but not used [-Werror=unused-function]
> >
> > This marks the function as __maybe_unused to let the compiler drop
> > it silently.
> >
> > Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
>
> The proper fix for this is to convert the stub function for proc_apm_show()
> to an inline. The compiler complains because the stub is a macro ....

I even did that
https://patchwork.ozlabs.org/patch/920786/

but then a handful of patches went into the kernel to add #ifdefs
around the other proc_show functions, so it no longer applied.
These two are the only remaining ones.

      Arnd
