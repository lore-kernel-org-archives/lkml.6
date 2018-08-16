Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF7FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C803C21470
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOZZnybO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C803C21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392184AbeHPTFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:05:31 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45523 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392167AbeHPTFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:05:30 -0400
Received: by mail-ua1-f67.google.com with SMTP id k8-v6so3954891uaq.12;
        Thu, 16 Aug 2018 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5bGffriBfOvZbbpbez0EejMsP42nbElVz2EjmUZoLAw=;
        b=jOZZnybOfrKvaACY5N96ORWW6x7YtukxxlDCnfCIeVJ+fYAXlCfYFQ8prVUBUNI6ya
         itllwNhO7hcZigFPtB1i0JzYTgCFQKHS945gRoHlKjF6DALBqg32Cn57RPY+Zgsu3ZH7
         LtbgmOrEwNylEjneFPzlfug++02GEQGXw69IjFczJd1VJuHyEX/wcq29YzLYR5mKyLDb
         KJKJJqAaaOr7nJevIN70BWxA35cB6sZUrWyzA2x6XT8SWBcOkvFqSC2Azsu79iqqQjRX
         TkGWRLfagncEYMI0aaKR93KowPiQoF0/IHMSE62CvZ9zr9BrYAqKtLW6/czmEj3GYkzb
         P+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5bGffriBfOvZbbpbez0EejMsP42nbElVz2EjmUZoLAw=;
        b=nrgPEs0i9cz2sktei79W25YcaCzN/IN5URItOcDq44wRwsMP1F2w6BzwSHb2uU2YxP
         1QNx8lO3LLVMWaQwhL25SMOPA7TuSmkS7+WMpaGFdDfs6A7diPF54Z67iGuVxxE5iTNT
         bXsm9vtzHOoq1azvUKQEuRP0DlAve1uSqtvIv48POtzP4VqKRRC0JOqXLEOUfGYX5Cqn
         RQYfcXxJGP/oPXoqN7TYdim5Ej+HCi8xb+H0gxF2cj/C3Gdd5YA1cCzqoh7Ethn0dLCS
         sUZ8z311Dt1sbltqonJ8ErY/BmRfR2ZWLOqyitmzYb3x+tlLbkHPVKGQ7jsSZUyUjmaa
         +YGg==
X-Gm-Message-State: AOUpUlEG+BBso9Q6K5HOWDbuCqT7Xw+145rZG8+Lp5WRxq+9IfadVZ8g
        rZhM06sAfqAc1PlmzoswikUNt3hbSSA4r2ivCqo=
X-Google-Smtp-Source: AA+uWPw+NeUaPPQffZi6N46mQh/s/QOCELh58a+qN8QW5FKeR1VlQlmFK4isNdaf6VM/roSQThM1pCa+24L6KMkt3YQ=
X-Received: by 2002:a9f:2745:: with SMTP id a63-v6mr19892984uaa.175.1534435567179;
 Thu, 16 Aug 2018 09:06:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:7cc8:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 09:05:46
 -0700 (PDT)
In-Reply-To: <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
 <a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com> <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
 <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com> <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Thu, 16 Aug 2018 18:05:46 +0200
Message-ID: <CAJHCu1+Je_eTdvmobUU3ZqeeWDqH5v8gGUTqEF0XWVP4TyxbFg@mail.gmail.com>
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
To:     Kees Cook <keescook@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Sargun Dhillon <sargun@sargun.me>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-15 7:19 GMT+02:00 Kees Cook <keescook@chromium.org>:
> On Tue, Aug 14, 2018 at 4:50 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 8/14/2018 4:22 PM, Jordan Glover wrote:
>>> On August 14, 2018 8:28 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>
>>>>
>>>>>> The blob management part (through "LSM: Sharing of security blobs")
>>>>>> is ready for prime-time. These changes move the management of
>>>>>> security blobs out of the security modules and into the security
>>>>>> module infrastructure. With this change the proposed S.A.R.A,
>>>>>> LandLock and PTAGS security modules could co-exist with any of
>>>>>> the existing "major" security modules. The changes reduce some
>>>>>> code duplication.
>>>>>> Beyond the blob management there's a bit of clean-up.
>>>>>> Mounting filesystems had to be changed so that options
>>>>>> a security module doesn't recognize won't be considered
>>>>>> a fatal error. The mount infrastructure is somewhat
>>>>>> more complex than one might assume.
>>>>> Casey,
>>>>> Do you think you can break out 1 into its own patch? It seems like
>>>>> that'd be valuable to everyone.
>>>> Yes, I think that is a good idea. Landlock, S.A.R.A. and a couple
>>>> other security modules could be added upstream if this part of the
>>>> work was available. It would not provide everything needed to stack
>>>> all the existing modules. I believe there is concern that if this
>>>> much went upstream the work on finishing what's required to make
>>>> everything work might be abandoned.
>>>>
>>> On the other hand there is concern that those security modules might
>>> be abandoned if they have to wait until everything is finished :)
>>
>> There is some truth to that. If we can get commitment from the developers
>> of those security module to push for getting upstream, a statement of
>> intent to support additional modules (e.g. Landlock, S.A.R.A.) from a

I'm the developer of S.A.R.A. I'm working on it in my free time, that
is not so much,
but I can confirm that my goal is to get it upstream as soon as possible.
Not that I want to rush anyone.

>> significant distribution (e.g. Fedora, Ubuntu, SuSE) and ACKs from the
>> maintainers of the existing modules we should be able to breeze right in.
>>
>> Yeah, I think that's about all it would take.
>
> I would strongly recommend Landlock and SARA for every distro. They're
> opt-in, and provide much-needed missing userspace defenses (and attack
> surface reduction).

Thank you very much for your support!

Salvatore
