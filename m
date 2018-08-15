Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7319AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A615C21502
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A615C21502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbeHOUfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:35:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729363AbeHOUfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:35:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D8877D84D;
        Wed, 15 Aug 2018 17:42:48 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 500842026D7E;
        Wed, 15 Aug 2018 17:42:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 173C822425E; Wed, 15 Aug 2018 13:42:47 -0400 (EDT)
Date:   Wed, 15 Aug 2018 13:42:47 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Yannik Sembritzki <yannik@sembritzki.me>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Justin M. Forbes" <jforbes@redhat.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform
 keys to boot
Message-ID: <20180815174247.GB29541@redhat.com>
References: <20180815100053.13609-1-yannik@sembritzki.me>
 <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
 <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 15 Aug 2018 17:42:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 15 Aug 2018 17:42:48 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vgoyal@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 07:27:33PM +0200, Yannik Sembritzki wrote:
> Would this be okay?

[ CC dave young, Baoquan, Justin Forbes]

Hi Yannik,

I am reading that bug and wondering that what broke it. It used to work,
so some change broke it. 

Justin said that we have been signing fedora kernels with fedora keys so
looks like no change there.

Previously, I think all the keys used to go in system keyring and it
used to work. Is it somehow because of split in builtin keyring and
secondary system keyring. Could it be that fedora key used to show
up in system keyring previously and it worked but now it shows up
in secondary system keyring and by default we don't use keys from
that keyring for signature verification?

Thanks
Vivek

> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c
> b/arch/x86/kernel/kexec-bzimage64.c
> index 7326078e..2ba47e24 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -41,6 +41,9 @@
>  #define MIN_KERNEL_LOAD_ADDR   0x100000
>  #define MIN_INITRD_LOAD_ADDR   0x1000000
>  
> +// Allow both builtin trusted keys and secondary trusted keys
> +#define TRUST_FULL_KEYRING     (void *)1UL
> +
>  /*
>   * This is a place holder for all boot loader specific data structure which
>   * gets allocated in one call but gets freed much later during cleanup
> @@ -532,7 +535,7 @@ static int bzImage64_cleanup(void *loader_data)
>  static int bzImage64_verify_sig(const char *kernel, unsigned long
> kernel_len)
>  {
>         return verify_pefile_signature(kernel, kernel_len,
> -                                      NULL,
> +                                      TRUST_FULL_KEYRING,
>                                        VERIFYING_KEXEC_PE_SIGNATURE);
>  }
>  #endif
> --
> 
> On 15.08.2018 18:54, Linus Torvalds wrote:
> > This needs more people involved, and at least a sign-off.
> >
> > It looks ok, but I think we need a #define for the magical (void *)1UL
> > thing. I see the use in verify_pkcs7_signature(), but still.
> >
> >               Linus
> >
> >
> >
> > On Wed, Aug 15, 2018 at 3:11 AM Yannik Sembritzki <yannik@sembritzki.me> wrote:
> >> ---
> >>  arch/x86/kernel/kexec-bzimage64.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> >> index 7326078e..eaaa125d 100644
> >> --- a/arch/x86/kernel/kexec-bzimage64.c
> >> +++ b/arch/x86/kernel/kexec-bzimage64.c
> >> @@ -532,7 +532,7 @@ static int bzImage64_cleanup(void *loader_data)
> >>  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
> >>  {
> >>         return verify_pefile_signature(kernel, kernel_len,
> >> -                                      NULL,
> >> +                                      (void *)1UL,
> >>                                        VERIFYING_KEXEC_PE_SIGNATURE);
> >>  }
> >>  #endif
> >> --
> >> 2.17.1
> >>
> >> The exact scenario under which this issue occurs is described here:
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1554113
> >>
> 
