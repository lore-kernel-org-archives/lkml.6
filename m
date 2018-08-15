Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A6BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BD1216E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NszKNSEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BD1216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeHOIKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 04:10:03 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37405 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeHOIKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 04:10:03 -0400
Received: by mail-yw1-f67.google.com with SMTP id w76-v6so81837ywg.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 22:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1IN6AG/Y6CI0DPChKgLqZtyiyh4m/MuWhZlv/rchj5s=;
        b=NszKNSEm7aOkEaiDgM+zvCa2tlKJR8qLBgl39EiNVIDAseS9kKlhygkWgdNWl1WYRE
         Ov1P5jbTokBGYoOnkrfk8NGSY+UG0jx05J4DizDvbw4FOQbrGcoWu0O1D7A6oKwLQPJp
         iGwywTS5hOC277p1sdWPttv4sBhy+xlIImt1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1IN6AG/Y6CI0DPChKgLqZtyiyh4m/MuWhZlv/rchj5s=;
        b=HQ8Rt5pJV7E6ojcXe3Ngt9ppYZwfthJfOTqRuJ82P9lTG7JJjYbkph3NJpg6qFLxc2
         EoF5XQHW+400BxUZJgD5L0qCChgcYqwLsxTvN2FPrh06gfWg/2tp55BYMZ7OTocl+MOP
         eBkQj3egqGX7lyBl5Gx7iiJ0ZCgFsZdIHwIcGgJn5H4gxdc+ek26U/f10XfTdMnJOhp/
         mSEcrqeNEywusv5AIGNm8ULqDAaNMRdq4akxT3fJIdfD3SIUCwZXgsONt5pVVfmKPVUx
         FhzkDDm9bMtBSuHWpcju72dR13pkkvZ2zgFvuhlg6zTKjtISB7Izd2MwHaeju5grMIX1
         HOoQ==
X-Gm-Message-State: AOUpUlG+Rnvfo4xRms/0N/H5d+raQKx2R/BMvwmTAd1v/y74hsYJmjhI
        jg/umw4cmaskCWww6Mgns+LlHNcdwEU=
X-Google-Smtp-Source: AA+uWPwUyn+gUEYTF0uc0NhLHLACFsWxMLoqQmAbrv3m+C06hnyUn22jo8aZsOzI1RYcnZRuPiM/ow==
X-Received: by 2002:a81:7d88:: with SMTP id y130-v6mr13824503ywc.269.1534310365617;
        Tue, 14 Aug 2018 22:19:25 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id w6-v6sm10559628ywg.23.2018.08.14.22.19.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 22:19:24 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id z143-v6so74294ywa.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 22:19:23 -0700 (PDT)
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr12674448ywn.88.1534310363296;
 Tue, 14 Aug 2018 22:19:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d94c:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 22:19:22
 -0700 (PDT)
In-Reply-To: <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
 <a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com> <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
 <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 14 Aug 2018 22:19:22 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>
Message-ID: <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
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
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 4:50 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 8/14/2018 4:22 PM, Jordan Glover wrote:
>> On August 14, 2018 8:28 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>
>>>
>>>>> The blob management part (through "LSM: Sharing of security blobs")
>>>>> is ready for prime-time. These changes move the management of
>>>>> security blobs out of the security modules and into the security
>>>>> module infrastructure. With this change the proposed S.A.R.A,
>>>>> LandLock and PTAGS security modules could co-exist with any of
>>>>> the existing "major" security modules. The changes reduce some
>>>>> code duplication.
>>>>> Beyond the blob management there's a bit of clean-up.
>>>>> Mounting filesystems had to be changed so that options
>>>>> a security module doesn't recognize won't be considered
>>>>> a fatal error. The mount infrastructure is somewhat
>>>>> more complex than one might assume.
>>>> Casey,
>>>> Do you think you can break out 1 into its own patch? It seems like
>>>> that'd be valuable to everyone.
>>> Yes, I think that is a good idea. Landlock, S.A.R.A. and a couple
>>> other security modules could be added upstream if this part of the
>>> work was available. It would not provide everything needed to stack
>>> all the existing modules. I believe there is concern that if this
>>> much went upstream the work on finishing what's required to make
>>> everything work might be abandoned.
>>>
>> On the other hand there is concern that those security modules might
>> be abandoned if they have to wait until everything is finished :)
>
> There is some truth to that. If we can get commitment from the developers
> of those security module to push for getting upstream, a statement of
> intent to support additional modules (e.g. Landlock, S.A.R.A.) from a
> significant distribution (e.g. Fedora, Ubuntu, SuSE) and ACKs from the
> maintainers of the existing modules we should be able to breeze right in.
>
> Yeah, I think that's about all it would take.

I would strongly recommend Landlock and SARA for every distro. They're
opt-in, and provide much-needed missing userspace defenses (and attack
surface reduction).

-Kees

-- 
Kees Cook
Pixel Security
