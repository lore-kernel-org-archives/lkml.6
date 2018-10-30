Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104AEC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD91D2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mPFmG2px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD91D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeJaG1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:27:47 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46747 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaG1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:27:46 -0400
Received: by mail-yw1-f65.google.com with SMTP id j202-v6so5566885ywa.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TKlVqK1niLEC8fP9S1q2z+Hkwf9doq+mPKOaiJ5zglE=;
        b=mPFmG2pxuyw83+auc2DE6g96oiFiaRsrt3G/qfabFXmDxvG7jraheCaDzR7By5Kzba
         /BnFJ6xKTBG21/+jWo9tQNCQnlP3tLXId1Pyaih3Ur8KVMbwBOgl0cwAOfvgZlRbE3Ka
         4PWJKh1ng+IgSk+QrCOZwVYYiZATD6eoG7lcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TKlVqK1niLEC8fP9S1q2z+Hkwf9doq+mPKOaiJ5zglE=;
        b=bwbvgXdDULpPyFmCCj5KcFISpR4d2AAUzCDyaUVJI29dH/nNGUH7hRut0jDT+kHDtS
         NZkQrUHWlJV50Jlzj5EFplA2jhogI9gCRHgh5D5//sWayj+hh7WXCWM+e55TqRPzxdsR
         XA/xCoJmjPOy3Zv92XJRnCJF9vOWMF1IkqFbnb38ViXaUqRmmjJxImloafxM2waLezNj
         XlCGhrP400FDpaAjzn/16mf0Dr0Apm/gH7j3d25iBxzgtcl2FCZXHVsT98mxCI/bGqu3
         cl7Vl2ygH4sjbu3W4cVl431SRpY81AxI5mFEPrKSi54h2/KI86wS9fUP1zle4fvV7U0G
         0+UQ==
X-Gm-Message-State: AGRZ1gJiMBF+36nJSw3BhY622orhy1xgmZmeZ6foitXMKaX+4jgrBvKp
        2X+TGlQ/+gpE6iE1qXLqrkAPOqCF9fc=
X-Google-Smtp-Source: AJdET5cABEir5VUNdNATMH7y5FANPJp9gY7Mbxo0k48W1usPXXp6T8ggT91fPoXGapg/CrEyT8OWuA==
X-Received: by 2002:a81:4686:: with SMTP id t128-v6mr510630ywa.52.1540935156966;
        Tue, 30 Oct 2018 14:32:36 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id h84-v6sm3073621ywh.61.2018.10.30.14.32.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 14:32:35 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id l2-v6so1066679ywb.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:32:35 -0700 (PDT)
X-Received: by 2002:a81:2953:: with SMTP id p80-v6mr442964ywp.407.1540935154512;
 Tue, 30 Oct 2018 14:32:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 14:32:33
 -0700 (PDT)
In-Reply-To: <20181030172143.GD7343@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws> <20181029224031.29809-2-tycho@tycho.ws>
 <20181030150254.GB3385@redhat.com> <20181030155403.GC7343@cisco>
 <20181030162752.GB7643@redhat.com> <20181030163926.GC7643@redhat.com> <20181030172143.GD7343@cisco>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Oct 2018 14:32:33 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+MYbAiSxdhLnQHdOZC-B=FWZoODxzwkYVEUqDc9SHnBQ@mail.gmail.com>
Message-ID: <CAGXu5j+MYbAiSxdhLnQHdOZC-B=FWZoODxzwkYVEUqDc9SHnBQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:21 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> On Tue, Oct 30, 2018 at 05:39:26PM +0100, Oleg Nesterov wrote:
>> On 10/30, Oleg Nesterov wrote:
>> >
>> > On 10/30, Tycho Andersen wrote:
>> > >
>> > > @@ -828,6 +823,11 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>> > >    */
>> > >   rmb();
>> > >
>> > > + if (!sd) {
>> > > +         populate_seccomp_data(&sd_local);
>> > > +         sd = &sd_local;
>> > > + }
>> > > +
>> >
>> > To me it would be more clean to remove the "if (!sd)" check, case(SECCOMP_RET_TRACE)
>> > in __seccomp_filter() can simply do populate_seccomp_data(&sd_local) unconditionally
>> > and pass &sd_local to __seccomp_filter().
>>
>> Ah, please ignore, emulate_vsyscall() does secure_computing(NULL).

Right.

>>
>> Btw. why __seccomp_filter() doesn't return a boolean?

Because it was wrapped by __secure_computing(). *shrug* The common
method in the kernel is to use int and 0=ok.

>> Or at least, why can't case(SECCOMP_RET_TRACE) simply do
>>
>>       return __seccomp_filter(this_syscall, NULL, true);
>>
>> ?
>
> Yeah, at least the second one definitely makes sense. I can add that
> as a patch in the next version of this series unless Kees does it
> before.

I'd like to avoid changing the return value of __secure_computing() to
just avoid having to touch all the callers. And I'd prefer not to
change __seccomp_filter() to a bool, since I'd like the return values
to be consistent through the call chain.

I find the existing code more readable than a single-line return, just
because it's very explicit. I don't want to have to think any harder
when reading seccomp. ;)

-Kees

-- 
Kees Cook
