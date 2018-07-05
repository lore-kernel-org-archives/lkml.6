Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22FBC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956D123FAC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tee1yChx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956D123FAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753954AbeGEVr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753784AbeGEVq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:46:59 -0400
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C329240DF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jul 2018 21:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530827217;
        bh=GqTVS/Rj2AmfOc2IqLNJTGOf8fAM1ND9ms3709b6ncw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Tee1yChxPjpTGlGvQf10j81CaUGcvz5NZsIDeNYkbEslMuQRJdTwd44TjeI/utUtz
         GKTN5o5T/O6gN+rYXVbGU0e9tFvU/Arazc81Ot4DY/NfHtDBR+E5thetnl2BWxtf9b
         SmvqQJqce9ZDFD+ZIhrPE7ei7EWdMcM8/eRU/C5g=
Received: by mail-wm0-f42.google.com with SMTP id s14-v6so12666053wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 14:46:57 -0700 (PDT)
X-Gm-Message-State: APt69E0Hwuv7vxfpORruNXeqasPwS1GIeonRk+q3GrjDBhs2J3JderSq
        o6ngiA2Pt3A8dRJs+DATfASqbyrMX4QcHcA6i02jMQ==
X-Google-Smtp-Source: AAOMgpcstXh+U5bnE02wYzwmCGGb4YmDlozKaUjGvhFCAALNzbefS4w0Nm7PpnEUeviMLBuDFmvRkn36AsSDdXtbolc=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr5302813wma.21.1530827216016;
 Thu, 05 Jul 2018 14:46:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 14:46:35 -0700 (PDT)
In-Reply-To: <2abd8138-0f62-79a5-5a2c-8e08aee171b8@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com> <20180703233430.14416-3-labbott@redhat.com>
 <CALCETrVZi2WYbBSifaNV4wajj52PyG-w7z9DekfJvSuZAKi1nA@mail.gmail.com> <2abd8138-0f62-79a5-5a2c-8e08aee171b8@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 5 Jul 2018 14:46:35 -0700
X-Gmail-Original-Message-ID: <CALCETrUdxS5JGJMKjBGWhaLM8yqzW+MjVcmF4QgczQQfFFOk3w@mail.gmail.com>
Message-ID: <CALCETrUdxS5JGJMKjBGWhaLM8yqzW+MjVcmF4QgczQQfFFOk3w@mail.gmail.com>
Subject: Re: [PATCHv5 2/4] x86: Add build salt to the vDSO
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure.

On Thu, Jul 5, 2018 at 12:08 PM, Laura Abbott <labbott@redhat.com> wrote:
> On 07/05/2018 08:58 AM, Andy Lutomirski wrote:
>>
>> On Tue, Jul 3, 2018 at 4:34 PM, Laura Abbott <labbott@redhat.com> wrote:
>>>
>>>
>>> The vDSO needs to have a unique build id in a similar manner
>>> to the kernel and modules. Use the build salt macro.
>>>
>>
>> Looks good to me.  I have no idea whose tree these would go through.
>>
>
> I was intending this to go through kbuild tree. Can I take this
> as an Ack?
>
>
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>> ---
>>> v5: Switched to using the single line BUILD_SALT macro
>>> ---
>>>   arch/x86/entry/vdso/vdso-note.S   | 3 +++
>>>   arch/x86/entry/vdso/vdso32/note.S | 3 +++
>>>   2 files changed, 6 insertions(+)
>>>
>>> diff --git a/arch/x86/entry/vdso/vdso-note.S
>>> b/arch/x86/entry/vdso/vdso-note.S
>>> index 79a071e4357e..79423170118f 100644
>>> --- a/arch/x86/entry/vdso/vdso-note.S
>>> +++ b/arch/x86/entry/vdso/vdso-note.S
>>> @@ -3,6 +3,7 @@
>>>    * Here we can supply some information useful to userland.
>>>    */
>>>
>>> +#include <linux/build-salt.h>
>>>   #include <linux/uts.h>
>>>   #include <linux/version.h>
>>>   #include <linux/elfnote.h>
>>> @@ -10,3 +11,5 @@
>>>   ELFNOTE_START(Linux, 0, "a")
>>>          .long LINUX_VERSION_CODE
>>>   ELFNOTE_END
>>> +
>>> +BUILD_SALT
>>> diff --git a/arch/x86/entry/vdso/vdso32/note.S
>>> b/arch/x86/entry/vdso/vdso32/note.S
>>> index 9fd51f206314..e78047d119f6 100644
>>> --- a/arch/x86/entry/vdso/vdso32/note.S
>>> +++ b/arch/x86/entry/vdso/vdso32/note.S
>>> @@ -4,6 +4,7 @@
>>>    * Here we can supply some information useful to userland.
>>>    */
>>>
>>> +#include <linux/build-salt.h>
>>>   #include <linux/version.h>
>>>   #include <linux/elfnote.h>
>>>
>>> @@ -14,6 +15,8 @@ ELFNOTE_START(Linux, 0, "a")
>>>          .long LINUX_VERSION_CODE
>>>   ELFNOTE_END
>>>
>>> +BUILD_SALT
>>> +
>>>   #ifdef CONFIG_XEN
>>>   /*
>>>    * Add a special note telling glibc's dynamic linker a fake hardware
>>> --
>>> 2.17.1
>>>
>
