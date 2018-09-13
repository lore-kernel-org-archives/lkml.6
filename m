Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DC4C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4A120854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="iu/OAsGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4A120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeIMUcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:32:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38784 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeIMUcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:32:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id t84-v6so2908152pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jL23avSdA6tKIdPG6xoqxEoyLoaSgmpxu2m+v+RAclA=;
        b=iu/OAsGXq7oYXbLdTKYVoRtqdw8OM59Ngqh4h+UhBSUUO9y75dkwTEFeEI6KK9RA1/
         7WQ79DfSVVwSC+GMBtK/5rHPhJ8NOJI5hP3nnNJwqQ11aCwZj1z6XSNancgE6n0VM3w1
         Ke8X/F2OoVp30Q8rzwV1KeTbb2AclaLiHQ2Wgrwby7eqXukyAdDvsBOYMHmKem1PlWSb
         fRYJtfI6MT2pK5fbPQdfSFmft7OPHKzQCx0FQBJuEqkqlWdZye/gNfjbA21xIcN3wqOw
         GEf/p4WxIAp9gVu4XIiSrlLzGIXppo1v+YdM3ivpiD990Hl948c3KY2eXqwJt3AqOQjV
         PsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jL23avSdA6tKIdPG6xoqxEoyLoaSgmpxu2m+v+RAclA=;
        b=CFrfOPC71ilFps1HqCy5qS7lR7RCAE8ewPZ8QoRomWTjDxZ/b0cavT6sT4Hr0JL+h+
         KY2BvvugqRz4Zwvl1OFJ9gxBdfWK440m4mQuLXCBi959wlMjw4xBJvkAOe2R+PEaDaQP
         pdfH25KKrOoetFMGRPRwOQSP2FD+156FK4hzwZqV7IW+AzuMZ6JpOcKffM8a02ybm3XQ
         l/Y0Fa2xrOu9CfD0/6S+2ixYnK7Q/8yb0IsmjxqRXbWRY8cZQJskTknaQ5SSMspb85BP
         G+44V+qiGe0Yq9j56aCh7DmDU2WI/KkF1eyXKUnfiLp2086O3KLChkex+gvZheyvUaNx
         8qkQ==
X-Gm-Message-State: APzg51AcbpFcbvtjBiIjm3E7C1E2MIZSFapuGvhjYq0+mUH7U4Xul2ze
        M1TM4FKn4qKCkmVP/HBiwpsJnw==
X-Google-Smtp-Source: ANB0VdZwyUcJcmDX6EKEMquc1agk6hTJOfabD+o0x0Os9tlK3vBnLl8qwvrhXrU2T4SEKBFci7SAuA==
X-Received: by 2002:a62:63c2:: with SMTP id x185-v6mr7923735pfb.13.1536852129329;
        Thu, 13 Sep 2018 08:22:09 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:fd17:5d5e:81e2:8081? ([2601:646:c200:7429:fd17:5d5e:81e2:8081])
        by smtp.gmail.com with ESMTPSA id e26-v6sm5373587pfi.70.2018.09.13.08.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 08:22:08 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <0120ea99-fcac-839a-ef8f-1daa74c17bec@redhat.com>
Date:   Thu, 13 Sep 2018 08:22:07 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5CE2714-B491-490D-9B03-E111A61E333F@amacapital.net>
References: <20180901015935.CCF0B18E20A9@virtux64.softrans.com.au> <CALCETrU4PzskO9pE6G4EkXNRRX3Mu7Vvjv1P8XgrfRMdgGDZSg@mail.gmail.com> <alpine.DEB.2.21.1809092159440.1402@nanos.tec.linutronix.de> <dde36e93-a21b-6223-8ffc-6dd11f687d38@redhat.com> <alpine.DEB.2.21.1809121616040.9957@nanos.tec.linutronix.de> <59403142-1073-3926-65dd-ac55ead357b9@redhat.com> <alpine.DEB.2.21.1809121623430.9957@nanos.tec.linutronix.de> <DEC1E2DC-2D89-4955-81FC-4EDCF3692214@amacapital.net> <0120ea99-fcac-839a-ef8f-1daa74c17bec@redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 13, 2018, at 1:07 AM, Florian Weimer <fweimer@redhat.com> wrote:
>=20
> On 09/12/2018 07:11 PM, Andy Lutomirski wrote:
>>> The multiplexer interfaces need much more surgery and talking about fute=
x,
>>> we'd need to sit down with quite some people and identify the things the=
y
>>> actually care about before just splitting it up and keeping the existing=

>>> overloaded trainwreck the same.
>>>=20
>> There=E2=80=99s also the issue of how much the speedup matters. For futex=
, maybe a better interface saves 3ns, but a futex syscall is hundreds of ns.=
 clock_gettime() is called at high frequency and can be ~25ns. Saving a few n=
s is a bigger deal.
>=20
> My concern is that the userspace system call wrappers currently do not kno=
w how many arguments the individual operations take and what types the argum=
ents have (hence the =E2=80=9Ctype-polymorphic=E2=80=9D nature I mentioned).=
 This could be a problem for on-stack argument passing (where you might read=
 values beyond the end of the stack, and glibc avoids that most of the time b=
y having enough cruft on the stack), and for architectures which pass pointe=
rs and integers in different registers (like some m68k ABIs do for the retur=
n value).
>=20
>=20

Isn=E2=80=99t clock_gettime already special because of the vDSO entry point,=
 though?=
