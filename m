Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA2DC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C770A22518
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xMWi0K+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C770A22518
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934046AbeFUWtE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933828AbeFUWtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:49:02 -0400
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07EA022522
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 22:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529621342;
        bh=C7ZnpsE+Bvumge+SIQm9IA73k80yAdSl5exqjZJJT54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xMWi0K+iSDJ8uYU8drnVWcJGXZyVeC4ptvbvIP9GzFC4Rc5yFDFwCew6sw25LCsgd
         YqzUlsOItGiCf7FLe8BAIy3YcCNLYVSUFT7pMvOydATmtEq2pFNpnZMejWIiiMGfEr
         v4fXBxtIJFGTIPcSez+vEi6QfrGWl0gqhO69MDDI=
Received: by mail-wm0-f54.google.com with SMTP id v131-v6so330015wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:49:01 -0700 (PDT)
X-Gm-Message-State: APt69E3yHpvyFVMafQdxKXyNU/yPQ7x7xKtqIBNufonGVdtevCNYAKRE
        ckj+cqLPCq25y2mHGwm8UoqnGHCNZev7YqtSRgy09w==
X-Google-Smtp-Source: ADUXVKJvzy6Os40P2meSJb/7JLKnsVfJBIitjQDqFqB1u6ewdhmR2tUCwHOQLMOAiWdFssRDs3mOb+OJBpL1KJE6M/g=
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr6148668wmh.116.1529621340396;
 Thu, 21 Jun 2018 15:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org> <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
 <20180612174535.GE19168@hmswarspite.think-freely.org> <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
 <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
 <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com> <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
 <20180620210158.GA24328@linux.intel.com> <CAOASepN1AtgEhobJUVh=rcsQ_Qt8ujoEhnivV-29y=-AiyJwZQ@mail.gmail.com>
 <20180621152903.GB1324@hmswarspite.think-freely.org> <CAOASepOPxte6aDHQB2dsd+VMPqWOuZZH4j8OKoqaHZ2cBsc38g@mail.gmail.com>
In-Reply-To: <CAOASepOPxte6aDHQB2dsd+VMPqWOuZZH4j8OKoqaHZ2cBsc38g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 21 Jun 2018 15:48:49 -0700
X-Gmail-Original-Message-ID: <CALCETrVCVeen+foJbW-yXgg2ivkPNmUx31tPT8rV4cYOAqcSfQ@mail.gmail.com>
Message-ID: <CALCETrVCVeen+foJbW-yXgg2ivkPNmUx31tPT8rV4cYOAqcSfQ@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
To:     npmccallum@redhat.com
Cc:     nhorman@redhat.com,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 12:11 PM Nathaniel McCallum
<npmccallum@redhat.com> wrote:
>
> If this is acceptable for everyone, my hope is the following:
>
> 1. Intel would split the existing code into one of the following
> schemas (I don't care which):
>   A. three parts: UEFI module, FLC-only kernel driver and user-space
> launch enclave
>   B. two parts: UEFI module (including launch enclave) and FLC-only
> kernel driver
>
> 2. Intel would release a reproducible build of the GPL UEFI module
> sources signed with a SecureBoot trusted key and provide an
> acceptable[0] binary redistribution license.
>
> 3. The kernel community would agree to merge the kernel driver given
> the above criteria (and, obviously, acceptable kernel code).
>
> The question of how to distribute the UEFI module and possible launch
> enclave remains open. I see two options: independent distribution and
> bundling it in linux-firmware. The former may be a better
> technological fit since the UEFI module will likely need to be run
> before the kernel (and the boot loader; and shim). However, the latter
> has the benefit of already being a well-known entity to our downstream
> distributors. I could go either way on this.

This is a lot of complication and effort for a gain that is not
entirely clear.  I really really really do *not* want to see Intel or
anyone else start enforcing policy on which programs can and cannot
run using this mechanism.  (This is exactly why non-FLC systems aren't
about to be supported upstream.)  So my preference is to not merge
anything that supports this type of use case unless there is
compelling evidence that it is (a) genuinely useful, (b) will be used
to improve security and (c) won't be abused for, say, revenue
purposes.

--Andy
