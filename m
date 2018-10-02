Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F3CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C9A2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ate2HoCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C9A2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeJBV1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:27:54 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33951 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeJBV1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:27:54 -0400
Received: by mail-yb1-f194.google.com with SMTP id 184-v6so881140ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i/m6cNuwDQR65poY90TV5hhjfZE+DR6UM2c0BpvLWSE=;
        b=ate2HoCrzNYmzPqH2d/JSNTq8USy9L1MbApztE5qGuRzFEKc7Q1hNrGn/QfzlwA46Q
         ke4i25NLe+niCaQAXhzkn09GztnpnzOxUyAHTKDsKEOee8apHck502Thnrsom2NdXM9U
         M0+Xr5WZJovKptEMWMcPysnilD58VRDWaoHhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i/m6cNuwDQR65poY90TV5hhjfZE+DR6UM2c0BpvLWSE=;
        b=Zi4hUN+rYmp3X4sbPvrlwyzcO0OW0RCBjsHaT6sgTRTzLukXxHxkEsfvs9LqbW4GSm
         o2AAfMZiixTy61VvoVpQWFv1TqrxPLlj5MEYoDUT26r+P3S69Saxb936/XH0d/evbc/D
         SWqNLHLz8CB70mpqoROlZvVUTLsEJiek70uGW99KxiNf6unAz45f8b5JOpdCKMyBqxIJ
         AKCBml+Ru+aGkjwyV4d8E5Cd7aQJRVHHTB2jj5u5O1ErXDmsqMWRhVcADslNOByO1ec9
         1lZcgGKk9271i6PO3vyS0bFheyBk6QwF1jJ0+0Oi0jVyqMMJL/xwIcsOp7AXbt4pHM7D
         VUlw==
X-Gm-Message-State: ABuFfohPiEangwimtWcp8kbolU6PdVPriWp/dA6OMqvPxKypjY8FTTGj
        ODxx/2bnidcPPEMQXev/h0h8qS6pjnE=
X-Google-Smtp-Source: ACcGV60urgYHsjCejfhFTjYDNw9i4XMLdg/uN/i6U9XShBIejkC3bKWgMqN79qDLKnSIovEYTc+PRA==
X-Received: by 2002:a5b:c45:: with SMTP id d5-v6mr8859087ybr.136.1538491448653;
        Tue, 02 Oct 2018 07:44:08 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id n6-v6sm6216243ywe.89.2018.10.02.07.44.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 07:44:07 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id y14-v6so839052ywa.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 07:44:06 -0700 (PDT)
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr547127yws.168.1538491446427;
 Tue, 02 Oct 2018 07:44:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 07:44:05 -0700 (PDT)
In-Reply-To: <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com> <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Oct 2018 07:44:05 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
Message-ID: <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 6:42 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/02/2018 08:12 AM, Paul Moore wrote:
>>
>> On Mon, Oct 1, 2018 at 9:04 PM Kees Cook <keescook@chromium.org> wrote:
>>>
>>> Since LSM enabling is now centralized with CONFIG_LSM_ENABLE and
>>> "lsm.enable=...", this removes the LSM-specific enabling logic from
>>> SELinux.
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>   .../admin-guide/kernel-parameters.txt         |  9 ------
>>>   security/selinux/Kconfig                      | 29 -------------------
>>>   security/selinux/hooks.c                      | 15 +---------
>>>   3 files changed, 1 insertion(+), 52 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>> b/Documentation/admin-guide/kernel-parameters.txt
>>> index cf963febebb0..0d10ab3d020e 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -4045,15 +4045,6 @@
>>>                          loaded. An invalid security module name will be
>>> treated
>>>                          as if no module has been chosen.
>>>
>>> -       selinux=        [SELINUX] Disable or enable SELinux at boot time.
>>> -                       Format: { "0" | "1" }
>>> -                       See security/selinux/Kconfig help text.
>>> -                       0 -- disable.
>>> -                       1 -- enable.
>>> -                       Default value is set via kernel config option.
>>> -                       If enabled at boot time, /selinux/disable can be
>>> used
>>> -                       later to disable prior to initial policy load.
>>
>>
>> No comments yet on the rest of the patchset, but the subject line of
>> this patch caught my eye and I wanted to comment quickly on this one
>> ...
>>
>> Not a fan unfortunately.
>>
>> Much like the SELinux bits under /proc/self/attr, this is a user
>> visible thing which has made its way into a lot of docs, scripts, and
>> minds; I believe removing it would be a big mistake.
>
>
> Yes, we can't suddenly break existing systems that had selinux=0 in their
> grub config.  We have to retain the support.

Is it okay to only support selinux=0 (instead of also selinux=1)?

-Kees

-- 
Kees Cook
Pixel Security
