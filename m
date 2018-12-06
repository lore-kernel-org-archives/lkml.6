Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA0DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611A82146F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544136616;
	bh=AQDugY4nh3/WNirV89dHDsIWcEG+qqLLrGxAqtmhGg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XV7Fel9T4nZdZSfZhEW1lzWosg9hLB1NVWQVMl/cu9jCsq3PNOUNf0hP/qlUcNqW2
	 yO+QyWiM9+s8rEujKmtqtkkd1KgAV54xqHbRB2ewUuSJxJgha3W459vp8n7wYdDal9
	 rg+WZ6zmnzbi97GHMnUlH7JdnLd6jPTfBg34f5g4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611A82146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbeLFWuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:50:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeLFWuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:50:15 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 739A22146F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 22:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544136614;
        bh=AQDugY4nh3/WNirV89dHDsIWcEG+qqLLrGxAqtmhGg0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qtwMkMiqGmD4sn/YpTuY7waRurt2pt8Y7YT0fT5i70HPb2mlGoVS0hZbylQIZRlrH
         UtWxgouacE2betUG0w+2vhHt1SdyIPa2WkZy6Epdf1jrVFmPKcxdnf2XsR+LNWjKPg
         i5yEfbD3ipR3fo8YfzyNtTNEQoNE8k/BG1oQjWW4=
Received: by mail-wr1-f46.google.com with SMTP id x10so2051517wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 14:50:14 -0800 (PST)
X-Gm-Message-State: AA+aEWYklLIkEPFeige9dLvG8tG6fG1Pb9Yr54IZSYlmcZzgJuuGI/Bl
        bP2iNtXwFr4hwnMNOvTXTjPYfyE/sTihnmuVOZLYLg==
X-Google-Smtp-Source: AFSGD/V3kiRF/yqufZzKPyIXFnntFRk8zytrrGqJ1YD/jjc7jcYysSl4YQMawzhwPB0gIJe4EJ5ARIy65YpgafrErL8=
X-Received: by 2002:adf:ea81:: with SMTP id s1mr26135004wrm.309.1544136612955;
 Thu, 06 Dec 2018 14:50:12 -0800 (PST)
MIME-Version: 1.0
References: <20181206221922.31012-1-sean.j.christopherson@intel.com> <20181206221922.31012-5-sean.j.christopherson@intel.com>
In-Reply-To: <20181206221922.31012-5-sean.j.christopherson@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Dec 2018 14:50:01 -0800
X-Gmail-Original-Message-ID: <CALCETrXRJ645=08fyeoMQ949fLB1TvhsgERFVx5mAHdViEjq8Q@mail.gmail.com>
Message-ID: <CALCETrXRJ645=08fyeoMQ949fLB1TvhsgERFVx5mAHdViEjq8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] x86/vdso: Add __vdso_sgx_enter_enclave() to
 wrap SGX enclave transitions
To:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 2:19 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
 +
> +       /*
> +        * Invoke the caller's exit handler if one was provided.  The return
> +        * value tells us whether to re-enter the enclave (EENTER or ERESUME)
> +        * or to return (EEXIT).
> +        */
> +       if (exit_handler) {
> +               leaf = exit_handler(exit_info, tcs, priv);
> +               if (leaf == SGX_EENTER || leaf == SGX_ERESUME)
> +                       goto enter_enclave;
> +               if (leaf == SGX_EEXIT)
> +                       return 0;
> +               return -EINVAL;
> +       } else if (leaf != SGX_EEXIT) {
> +               return -EFAULT;
> +       }

This still seems overcomplicated to me.  How about letting the
requested leaf (EENTER or ERESUME) be a parameter to the function and
then just returning here?  As it stands, you're requiring any ERESUME
that gets issued (other than the implicit ones) to be issued in the
same call stack, which is very awkward if you're doing something like
forwarding the fault to a different task over a socket and then
waiting in epoll_wait() or similar before resuming the enclave.

--Andy
