Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F22C63685
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3502086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="0EdeSMS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3502086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeINAqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:46:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41495 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeINAqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:46:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so3125636pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 12:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rsL/qQZd3OZcI4R0N70mfkuBXhbCop6r+N1Z8XkdT0E=;
        b=0EdeSMS1pc78klaQN6i+TTBBWIEPwI5jogqzzhHXdf+ai7l+BAmHggD/1a2L2g+k9Q
         oXeBhIN0Av+k6qij/FTbPNK04n2ftzOdgjLiR0BRGBH6PG+TqhpUfvTjfFnl07PezG3K
         0ZgiIjPF41MHpo2iTVE/wWUBz+yy2iQr3dUlS6z6c+0sm/tyqXPgy/OCX8Hs6RBrDNT8
         +AK+Q5jSw2pw4pj3brU7rO6Av7FjOjWRRKtYso2B86tGfmop1otuZmNckRmIkW/t/vV3
         Vw7InuFRRwOnHKeIrebJIsPrioJXZlrz82g1HPe7+s2O9jvW3g43R/r7fVTuE0+cVuxR
         +LoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rsL/qQZd3OZcI4R0N70mfkuBXhbCop6r+N1Z8XkdT0E=;
        b=m60KpwdfbehsgCR3kfdAtUmC3LA2ltro2nz4jgMTzJdp9cQb7/3k6MRcSJAjOl9dAu
         J54YRR67gYIC3ru5otGNPNOwNKKATNHofConVVHBMx/lnG14Hm25QflYGGW2f9r9ruFm
         m5q1DlaKTIgx25TvBU1TXNrWGnNwPVjZ95Ti8NEXgID6VBib2JmNAzQ3r9B5ASY14S77
         KV9sLCsyPsrSONdBrAJUHziXq2Obiakj/p1vgOlszxgNOhG4IGUwoPJyBPdJMcCwULQD
         Z32nlAeZY5dbeAg6XMcTR9EUy20lBEMFJtX40l17FD9pNJRELsYGeT4jkfDuGDLDX4RM
         p6FA==
X-Gm-Message-State: APzg51AW+Pc7l9fnVTEn9h6w7GJThtZtO64VVkXcSMNpBJMzdOejcbjX
        WbMwVpqPMTUgv4ZmzoBJVYeZ3g==
X-Google-Smtp-Source: ANB0Vdag1vQegY87WFmuDeP/6ngW4TKzF5KhkNGvqH+tfvm24Y/VB9F7YRmhprrvgXEFK3NaiuPC9A==
X-Received: by 2002:a63:4826:: with SMTP id v38-v6mr8483446pga.379.1536867358085;
        Thu, 13 Sep 2018 12:35:58 -0700 (PDT)
Received: from ?IPv6:2600:1010:b010:5d82:811e:589c:a336:e7f4? ([2600:1010:b010:5d82:811e:589c:a336:e7f4])
        by smtp.gmail.com with ESMTPSA id r64-v6sm6564350pfk.157.2018.09.13.12.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 12:35:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <5f9e890c-fd67-2e39-42ca-64290301b20a@redhat.com>
Date:   Thu, 13 Sep 2018 12:35:54 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B47AF238-71A6-4FC1-BC5A-55893C2D76B0@amacapital.net>
References: <20180901015935.CCF0B18E20A9@virtux64.softrans.com.au> <CALCETrU4PzskO9pE6G4EkXNRRX3Mu7Vvjv1P8XgrfRMdgGDZSg@mail.gmail.com> <alpine.DEB.2.21.1809092159440.1402@nanos.tec.linutronix.de> <dde36e93-a21b-6223-8ffc-6dd11f687d38@redhat.com> <alpine.DEB.2.21.1809121616040.9957@nanos.tec.linutronix.de> <59403142-1073-3926-65dd-ac55ead357b9@redhat.com> <alpine.DEB.2.21.1809121623430.9957@nanos.tec.linutronix.de> <DEC1E2DC-2D89-4955-81FC-4EDCF3692214@amacapital.net> <0120ea99-fcac-839a-ef8f-1daa74c17bec@redhat.com> <F5CE2714-B491-490D-9B03-E111A61E333F@amacapital.net> <5f9e890c-fd67-2e39-42ca-64290301b20a@redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 13, 2018, at 12:07 PM, Florian Weimer <fweimer@redhat.com> wrote:
>=20
> On 09/13/2018 05:22 PM, Andy Lutomirski wrote:
>>> On Sep 13, 2018, at 1:07 AM, Florian Weimer <fweimer@redhat.com> wrote:
>>>=20
>>> On 09/12/2018 07:11 PM, Andy Lutomirski wrote:
>>>>> The multiplexer interfaces need much more surgery and talking about fu=
tex,
>>>>> we'd need to sit down with quite some people and identify the things t=
hey
>>>>> actually care about before just splitting it up and keeping the existi=
ng
>>>>> overloaded trainwreck the same.
>>>>>=20
>>>> There=E2=80=99s also the issue of how much the speedup matters. For fut=
ex, maybe a better interface saves 3ns, but a futex syscall is hundreds of n=
s. clock_gettime() is called at high frequency and can be ~25ns. Saving a fe=
w ns is a bigger deal.
>>>=20
>>> My concern is that the userspace system call wrappers currently do not k=
now how many arguments the individual operations take and what types the arg=
uments have (hence the =E2=80=9Ctype-polymorphic=E2=80=9D nature I mentioned=
). This could be a problem for on-stack argument passing (where you might re=
ad values beyond the end of the stack, and glibc avoids that most of the tim=
e by having enough cruft on the stack), and for architectures which pass poi=
nters and integers in different registers (like some m68k ABIs do for the re=
turn value).
>=20
>> Isn=E2=80=99t clock_gettime already special because of the vDSO entry poi=
nt, though?
>=20
> Somewhat special, yes, but not overly so, and not in the type-polymorphic s=
ense.  We can't give direct access of the vDSO implementation to application=
s because the kernel does not know about the userspace errno variable.  We d=
o that for time on x86_64, where applications call into the vDSO directly, b=
ypassing glibc completely after binding.

If the vDSO adds special helpers for CLOCK_MONOTONIC and CLOCK_REALTIME, I t=
hink we can reasonably safely promise that they never fail. (seccomp can obv=
iously break that promise if there=E2=80=99s no TSC, but I think that seccom=
p users who do that get to keep both pieces.)
