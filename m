Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EFDC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9B32075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mwekw5b1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GJAW8nDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9B32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030223AbeFSQpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:45:02 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:41832 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966510AbeFSQo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:44:59 -0400
Received: by mail-yw0-f193.google.com with SMTP id s201-v6so112140ywg.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=2KJHuGkD8O6G6YdNnuX77vrmOBGTnuwDsUK1xF62luE=;
        b=mwekw5b1VQhgLwQavFW97KlAAMo5wwYIrdkCGFbslv3773VUfH8B46n1QmFxlCqoXT
         3z2Rmmj0ryFsFrwarFALqH7gWZUR2MDBsc0og7kxRwdy4V66tpHYV/WLJOSH7TOKtn4/
         GQfcTZfZq8nnkUtKlWwr5Hwaq2Gf1S2kKBKy63ynM/UQcEWbya0NJeZKXaQT4PNuekma
         O7hMo/QxJ8/EfS8aAPRDju/v33SZENAjTADWEfz3lhBD98OZygmsipQk2tA1B4uhbPPT
         R1+NTZX/c3SAhlavXauhMYM19Z5g+zhuuYitAvPWwtS/JZcUg5SHTn/Q7ck3Dq6iKYlJ
         Q0DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=2KJHuGkD8O6G6YdNnuX77vrmOBGTnuwDsUK1xF62luE=;
        b=GJAW8nDxQ8i2LZnTNpejpee3SfaZrUV5HsuNUoy0UZasJD3aieL7OgGFQwXzistg3y
         Ayn7DnqXDrrIpUI1KLXblBAV1iiFH6PaQppLLlh1hQiRqbgxRiwxVmlucaMVjTN33NtX
         Itf9+AKgnBDVkHvCUgtQtVRIjmdSkiXUvH4jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=2KJHuGkD8O6G6YdNnuX77vrmOBGTnuwDsUK1xF62luE=;
        b=AkmB2cg3+X/YWdtqRADt2dxYIoZuTUXg66ZdTySF8ZHq4d3wY3o6zW5aXb6D1WbL/N
         bXkxp1SRaOzAXO1Ja806JPTn51dD51H1a1fHdKYBKdIPad9F7oqzFJXgZLYn1E6as3wo
         MTIoq34E/5H2DKvWtpsBWdwl2dI5kPMJbaZsdLGKkZwJZRzGyeoIspJcj5RspNKarKl1
         8zYB5Q/jZEOXRSVBUdaNqRsmF/kt1zYEHlWoO2j3sklxjr+Wiy/fTbXKZYqaqVl+ycRZ
         jsgl+yTpv1t6MFWknYH5P71v265uUftK9VX9Bc//sPfD+rK9T5GE2KqxBnxDqag5vpfM
         6K9w==
X-Gm-Message-State: APt69E3llLY3KoTOdeOZlkm3RoDthHoOaw4Y5bAWgoAVDQl0Q8yzxK71
        gGISp55rUTbQhdpEsSQA7X/ZN9RUr4G42LCxMWhZZw==
X-Google-Smtp-Source: ADUXVKKXsM+lC+qOKc9/QwbxljuCFi7PsMCZ3cVdVFBPO7rE17IUNzFbc454pfgrcK3aNfOtg+VX8tPW/u4ozwjiXSs=
X-Received: by 2002:a0d:d105:: with SMTP id t5-v6mr8683070ywd.53.1529426698214;
 Tue, 19 Jun 2018 09:44:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 09:44:57
 -0700 (PDT)
In-Reply-To: <569B4719-6283-4575-A16E-D0A78D280F4E@amacapital.net>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de>
 <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com>
 <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
 <CAMe9rOpLxPussn7gKvn0GgbOB4f5W+DKOGipe_8NMam+Afd+RA@mail.gmail.com>
 <CALCETrWmGRkQvsUgRaj+j0CP4beKys+TT5aDR5+18nuphwr+Cw@mail.gmail.com>
 <CAMe9rOpzcCdje=bUVs+C1WrY6GuwA-8AUFVLOG325LGz7KHJxw@mail.gmail.com>
 <alpine.DEB.2.21.1806122046520.1592@nanos.tec.linutronix.de>
 <CAMe9rOrGjJf0aMnUjAP38MqvOiW3=iXGQjcUT3O=f9pE85hXaw@mail.gmail.com>
 <CALCETrVsh5t-V1Sm88LsZE_+DS0GE_bMWbcoX3SjD6GnrB08Pw@mail.gmail.com>
 <CAGXu5jK0gospOXRpN6zYiQPXOZeE=YpVAz2qu4Zc3-32v85+EQ@mail.gmail.com> <569B4719-6283-4575-A16E-D0A78D280F4E@amacapital.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 19 Jun 2018 09:44:57 -0700
X-Google-Sender-Auth: kcB5XncFBbn5-_jNfEOXYBUd4F0
Message-ID: <CAGXu5jJNgu4bW_Zthqjfpe9gLxK0zxG8QFEqqK+pJNebz6tUaw@mail.gmail.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com, Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 7:50 AM, Andy Lutomirski <luto@amacapital.net> wrot=
e:
>> On Jun 18, 2018, at 5:52 PM, Kees Cook <keescook@chromium.org> wrote:
>> Following Linus's request for "slow introduction" of new security
>> features, likely the best approach is to default to "relaxed" (with a
>> warning about down-grades), and allow distros/end-users to pick
>> "forced" if they know their libraries are all CET-enabled.
>
> I still don=E2=80=99t get what =E2=80=9Crelaxed=E2=80=9D is for.  I think=
 the right design is:
>
> Processes start with CET on or off depending on the ELF note, but they st=
art with CET unlocked no matter what. They can freely switch CET on and off=
 (subject to being clever enough not to crash if they turn it on and then r=
eturn right off the end of the shadow stack) until they call ARCH_CET_LOCK.

I'm fine with this. I'd expect modern loaders to just turn on CET and
ARCH_CET_LOCK immediately and be done with it. :P

> Ptrace gets new APIs to turn CET on and off and to lock and unlock it.  I=
f an attacker finds a =E2=80=9Cptrace me and turn off CET=E2=80=9D gadget, =
then they might as well just do =E2=80=9Cptrace me and write shell code=E2=
=80=9D instead. It=E2=80=99s basically the same gadget. Keep in mind that t=
he actual sequence of syscalls to do this is incredibly complicated.

Right -- if an attacker can control ptrace of the target, we're way
past CET. The only concern I have, though, is taking advantage of
expected ptracing. For example: browsers tend to have crash handlers
that launch a ptracer. If ptracing disabled CET for all threads, this
won't by safe: an attacker just gains control in two threads, crashes
one to get the ptracer to attach, which disables CET in the other
thread and the attacker continues ROP as normal. As long as the ptrace
disabling is thread-specific, I think this will be okay.

-Kees

--=20
Kees Cook
Pixel Security
