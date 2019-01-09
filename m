Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A42C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3DB20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ssi.gouv.fr header.i=@ssi.gouv.fr header.b="RoMGK8Hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfAINlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:41:09 -0500
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:63276 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfAINlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:41:08 -0500
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id E9262D0006C;
        Wed,  9 Jan 2019 14:41:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1547041274;
        bh=H2Is0Q2VN22XBooqXUOSb5VIZ4HVQHkcukWlRAPTp1s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=RoMGK8HvWM8GNKEsVGubLVPZIHc4Q2DRA/jnTE33DG16oWnu89Iag+oHvOzc73KBq
         b06HqB02wINgPuFcY6UVLlNRae0QZn1dTVoJEGiOo4lsOYNgEXY2ZyMKVh+kT3kCaR
         2yqJD9P3CIRKKHhqQ7uNFm4faithFGxt5t6oC6+c/y30yVZKM2fessSiTt+0G5aQv6
         jRUP918avPzGx/TvZEwF1ERmLzifNulJYFGenTZ46kvf+OK+JWLZjvYV2FTxM7Z+Z+
         CO85JFozPsqq7z/2i0etRkdyZCTQ5Vtj4hUnXvN3YRqV45p8SBhDpyg67mcy1hT9zY
         MgqHBlwMSpkag==
Subject: Re: [RFC PATCH v1 3/5] Yama: Enforces noexec mounts or file
 executability through O_MAYEXEC
To:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>
CC:     Jann Horn <jannh@google.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        <thibaut.sautereau@ssi.gouv.fr>, <vincent.strubel@ssi.gouv.fr>,
        Perez Yves-Alexis <yves-alexis.perez@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20181212081712.32347-1-mic@digikod.net>
 <20181212081712.32347-4-mic@digikod.net>
 <CAG48ez3SAW8EyaJ9T1U3qPoRhYwe4CCyL9bAxuc3GxjrXipi-A@mail.gmail.com>
 <f13bf750-f418-343c-baa6-9eee6e0f5e19@ssi.gouv.fr>
 <CAG48ez00CpXOOJPLgpQd_e0gG2KgYb1p8bwssA8FDOugHTxRAA@mail.gmail.com>
 <0f7d39f8-035b-8566-94c9-ea836b280e24@ssi.gouv.fr>
 <CAGXu5jKHPE6WfbXpiwzm=vRbgJ-rCePxsrYmVzZ1+RURp-6nJg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <58c59dbb-ae6b-ce06-d679-175b3ed6f652@ssi.gouv.fr>
Date:   Wed, 9 Jan 2019 14:41:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKHPE6WfbXpiwzm=vRbgJ-rCePxsrYmVzZ1+RURp-6nJg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/01/2019 00:30, Kees Cook wrote:
> On Tue, Jan 8, 2019 at 5:29 AM Mickaël Salaün
> <mickael.salaun@ssi.gouv.fr> wrote:
>>
>>
>> On 03/01/2019 12:17, Jann Horn wrote:
>>> On Thu, Dec 13, 2018 at 3:49 PM Mickaël Salaün
>>> <mickael.salaun@ssi.gouv.fr> wrote:
>>>> On 12/12/2018 18:09, Jann Horn wrote:
>>>>> On Wed, Dec 12, 2018 at 9:18 AM Mickaël Salaün <mic@digikod.net> wrote:
>>>>>> Enable to either propagate the mount options from the underlying VFS
>>>>>> mount to prevent execution, or to propagate the file execute permission.
>>>>>> This may allow a script interpreter to check execution permissions
>>>>>> before reading commands from a file.
>>>>>>
>>>>>> The main goal is to be able to protect the kernel by restricting
>>>>>> arbitrary syscalls that an attacker could perform with a crafted binary
>>>>>> or certain script languages.  It also improves multilevel isolation
>>>>>> by reducing the ability of an attacker to use side channels with
>>>>>> specific code.  These restrictions can natively be enforced for ELF
>>>>>> binaries (with the noexec mount option) but require this kernel
>>>>>> extension to properly handle scripts (e.g., Python, Perl).
> 
> I like this idea, but I think it shouldn't live in Yama (since it is
> currently intended to be a ptrace-policy-only LSM). It was
> _originally_ designed to do various DAC improvements, but the
> agreement was that those should live directly in the VFS instead (i.e.
> the symlink, hardlink and now fifo and regular file defenses).
> 
> This should likely go in similarly. (But if not, it could also be its own LSM.)
> 

I think that Yama is quite handy and make sense here, but I'm fine
putting this knob elsewhere. However, I was thinking, for a future patch
series, to add another sysctl to lock this choice, i.e. generalizing the
way Yama can lock the ptrace_scope.

What matter here is the ability for an LSM to use this O_MAYEXEC flag.
Yama is a good place to showcase this feature and I think it is cleaner
to leverage the LSM framework to put new (optional) security features. I
can easily create a new LSM but it would be pretty similar to Yama...
What do you think about it James and Al?

Side question: wouldn't it be better to use a 0600 mode (instead of
0644) for this kind of sysctl?
