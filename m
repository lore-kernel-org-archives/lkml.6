Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ADBC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804DC20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h1R3G9vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804DC20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJAHgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:36:48 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37504 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeJAHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:36:48 -0400
Received: by mail-yw1-f68.google.com with SMTP id y14-v6so4853052ywa.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 18:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hrDNhPObw6e1fWHKYJ1uWfvaXZbb4Utsc/+r7Rmskdw=;
        b=h1R3G9vqqazOU05O83Sa8ly0oQTdyB9kCm7HW1a+/205zbM4n1UkY76CTYRQ8E8cWH
         63Ag3zvrjvff4t3a5S11whIW/PtjpJENrlToTEDrOJN5kFdgXRH2UIkaITmmuCZLvXzv
         FIfJYnIWbJ9KSBIUbJ4sYYoMnb0dldLiPC1Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hrDNhPObw6e1fWHKYJ1uWfvaXZbb4Utsc/+r7Rmskdw=;
        b=EQoKgE9FDGQEY2h1XsJJMCrRQ9D7c4si1Cngxmib6iAqN1bXbJU8zHMDwS0xM+jnX7
         GJz/qlgcY7wksfy6ILN2Kd6oML9drbp4lAOX+0UMA0Y5Bw6rPkniJyWD44OpPHG0JGaz
         XjEq1/7gOdgaQvWrtipzxA8K35RSBBFchFhwHDxt/3WpcuxfFXXu4MuRhc0XQoKFqPVs
         yrwqvDHABqjH88lS7jHKtPpJcWrqeKx5Hub+WnLZICVZeXMQxCYQE/BOyQzb+yjoWfJW
         fxIEiG02j0X08GuZRp0xgzbBUc8YNTn4KHSxLXlrkcSe/3X8cIeQSyTsMfbHYLi6eF3m
         Yc1w==
X-Gm-Message-State: ABuFfoj7ex5JwM9i2p6hv7dTfKM2Enmf6V9EJJXACXE3528GShRi7rjU
        +dEmf7WoqLTZGg6USRD7SPAZmMRcqas=
X-Google-Smtp-Source: ACcGV61E0k0TC/TT7c4/wqBso/JIX2oAH73AhPpBezZIV45b6fobOGZHKcs4IOVRtQxkjtJiqIQGsQ==
X-Received: by 2002:a81:5a89:: with SMTP id o131-v6mr4721307ywb.121.1538355694740;
        Sun, 30 Sep 2018 18:01:34 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id l69-v6sm2836527ywl.51.2018.09.30.18.01.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 18:01:31 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id l79-v6so735901ywc.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 18:01:30 -0700 (PDT)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr4726475ywd.124.1538355690627;
 Sun, 30 Sep 2018 18:01:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Sun, 30 Sep 2018 18:01:29
 -0700 (PDT)
In-Reply-To: <20180930192526.4480231c@vmware.local.home>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-5-keescook@chromium.org>
 <20180926123522.4080d9eb@vmware.local.home> <CAGXu5jJyL7FuLRj1XxujpGs9=wUQgS4dRfeGB+HUBqy4mkEBhQ@mail.gmail.com>
 <20180930192526.4480231c@vmware.local.home>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 30 Sep 2018 18:01:29 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJsVv9bMh831yx1y8KjhgA204hkpOEVpWzvifATw-w0cw@mail.gmail.com>
Message-ID: <CAGXu5jJsVv9bMh831yx1y8KjhgA204hkpOEVpWzvifATw-w0cw@mail.gmail.com>
Subject: Re: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 4:25 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 26 Sep 2018 11:35:21 -0700
> Kees Cook <keescook@chromium.org> wrote:
>
>> On Wed, Sep 26, 2018 at 9:35 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> > On Mon, 24 Sep 2018 17:18:07 -0700
>> > Kees Cook <keescook@chromium.org> wrote:
>> >
>> >> This partially reverts commit 58eacfffc417 ("init, tracing: instrument
>> >> security and console initcall trace events") since security init calls
>> >> are about to no longer resemble regular init calls.
>> >
>> > I'm not against the change, but how much are they going to "no longer
>> > resemble regular init calls"?
>>
>> My take on "regular" init calls is that they're always run, link-time
>> ordered, etc. The changes proposed here will make it so not all
>> initialization are run depending on runtime configurations, ordering
>> will be flexible, etc.
>>
>
> Will it still be a good idea to have a tracepoint for those calls?
> Perhaps not an  initcall tracepoint but some other kind?

I'm not opposed. It could be a follow-up patch, I assume?

-Kees

-- 
Kees Cook
Pixel Security
