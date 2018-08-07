Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284C4C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D048F21731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZFL9RUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D048F21731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390433AbeHGVym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390099AbeHGVyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:54:41 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 502FB21764
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 19:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533670726;
        bh=YMqVCs7vGgIReXt7TgKTzTt9SKhaCKjm83lNZdM1KyQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=iZFL9RUhkgSTvjeIChSU6cSrDZ8mifUTBlTg2PMJirLW6+ZwIfuqajzkhO2PMmOdZ
         qW/U+5R2Sl1SUyeRUsMD2d6lF4eml8TE7dBt+7SkHbGKzOr08Y2SDNA1Gt+1qeTdC3
         nxw9/0tFa2ZMP08fscvK5AsXfcdcF267MV5coaME=
Received: by mail-wr1-f48.google.com with SMTP id h14-v6so16810686wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 12:38:46 -0700 (PDT)
X-Gm-Message-State: AOUpUlFPd1Spwvmu//a3juFEQIPRROb2hO6ZOJfTZCZW4wwRmdMLyQep
        yfwFd3VgvqOb1LKDpHvs1M7LCoD5lqZAHTxq98mT8g==
X-Google-Smtp-Source: AAOMgpdxcqaVflliQOI6iUgprkkYKLt+fPayZOK8q65oyUrXj+qkMv0a2VXU09v2PU0XoMjRGXjhnXkCidLVMW8Gy5o=
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr12921730wrs.171.1533670724605;
 Tue, 07 Aug 2018 12:38:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 12:38:24 -0700 (PDT)
In-Reply-To: <feea2aff-91ff-89a6-9d7c-5402a1d6a27f@intel.com>
References: <1533637471-30953-1-git-send-email-joro@8bytes.org>
 <1533637471-30953-3-git-send-email-joro@8bytes.org> <feea2aff-91ff-89a6-9d7c-5402a1d6a27f@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 7 Aug 2018 12:38:24 -0700
X-Gmail-Original-Message-ID: <CALCETrXj1-CC-rcnM5s2SvbSFKjZPMYj0O-9d1PY0MRdGEKs-g@mail.gmail.com>
Message-ID: <CALCETrXj1-CC-rcnM5s2SvbSFKjZPMYj0O-9d1PY0MRdGEKs-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/mm/pti: Don't clear permissions in pti_clone_pmd()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 11:34 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> On 08/07/2018 03:24 AM, Joerg Roedel wrote:
>> The function sets the global-bit on cloned PMD entries,
>> which only makes sense when the permissions are identical
>> between the user and the kernel page-table.
>>
>> Further, only write-permissions are cleared for entry-text
>> and kernel-text sections, which are not writeable anyway.
>
> I think this patch is correct, but I'd be curious if Andy remembers why
> we chose to clear _PAGE_RW on these things.  It might have been that we
> were trying to say that the *entry* code shouldn't write to this stuff,
> regardless of whether the normal kernel can.
>
> But, either way, I agree with the logic here that Global pages must
> share permissions between both mappings, so feel free to add my Ack.  I
> just want to make sure Andy doesn't remember some detail I'm forgetting.

I suspect it's because we used to (and maybe still do) initialize the
user tables before mark_read_only().
