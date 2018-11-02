Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA81C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E6020831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiGKDhiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E6020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeKCGUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:20:18 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33200 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeKCGUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:20:18 -0400
Received: by mail-yw1-f65.google.com with SMTP id z72-v6so1325751ywa.0;
        Fri, 02 Nov 2018 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BeJmC4AmAsWdpXlgK55iLlOwRYQpI5sykBJJFBJdXzs=;
        b=RiGKDhiH1VGlb6l62xZIomzQwUX3sesNq/40uJcF+2fDIr00g5uhOhQuSPi0Qm7hEG
         6r0D2S1AklloFioOKWEibhrsLD2bfyS2I9mz8UQz4r/4nyABPOBzVtHS2aH5azcDJooB
         vbQBFaGmvRSuBImLJOUWkEh3kZZCdSkyWEIn8o18y0kVM7phFLIHLIeY0qtr7DJ42EB3
         1ARJHuL+ZJmC0SrsMUut8HpkpiKfqP0I+Y+QdeK9gYkQX+MB6pgaFQbr2p/DRxfvWBER
         KZa9jSESMAho+5jRVBBUUQHeK9weAqrGpteBWSnicqgpwt84zYbnkg5Sh5rZAOgUI4dL
         HM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BeJmC4AmAsWdpXlgK55iLlOwRYQpI5sykBJJFBJdXzs=;
        b=Ed/+D60GNodFp7kdT4eStHdXSi6SiitXObPHDlwuuQHGpv17c1UPNQa4shXa4DNPt6
         +x3FAjCzpj22NwZrx0rGgqKZsLC5BR0HFUCTz9xdQQolTyYnJ4cS1wgDTN6jLaevZkIF
         FQogOEBzeO+dpvXMClJD4bqJLntLXcn/w/vTIQuTAQ0azJw69+iu40xpKFjCZmrcZJW+
         4P6eEBeAv+moXxNGaN+ZWSEsUZmpDPJknPyHpcVbipKTq/Latu15ZWH0qA1kyt1B0Fwr
         IgQmQkfz7XMwbiHF+4ZNbqclSBwiJvt9Bjsh0vWucSgc4oWETZUrbA56a59QTqgbr9fG
         9heQ==
X-Gm-Message-State: AGRZ1gJiZ6OOl2LqlBSB8D9Ufh0QAH5SC2F5PZspJfspu1EzApRdgNKb
        LYcrnSr6bmMIHqYapgorMUc=
X-Google-Smtp-Source: AJdET5cHD2a32hUHlmAaHi4IzDmr3FFX/JCOTIjm47cjFORT3BJ69cYnKCqLr0u3iD4HHRdH0R+8Og==
X-Received: by 2002:a81:a0cd:: with SMTP id x196-v6mr12466127ywg.73.1541193093953;
        Fri, 02 Nov 2018 14:11:33 -0700 (PDT)
Received: from [172.20.31.92] ([12.228.154.70])
        by smtp.gmail.com with ESMTPSA id f68-v6sm9211332ywh.60.2018.11.02.14.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 14:11:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 10/17] prmem: documentation
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <59E8A6FB-9762-499F-89AC-D85E1498BE38@gmail.com>
Date:   Fri, 2 Nov 2018 16:11:30 -0500
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1ECE02D5-2D80-4234-8523-E481B930A66D@gmail.com>
References: <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
 <28C8CD2A-BDC0-49A5-854E-1E18968528B8@amacapital.net>
 <CAC99157-7A9B-4AC6-BA41-EAA7A99FE53D@gmail.com>
 <20181031090835.GG744@hirez.programming.kicks-ass.net>
 <59E8A6FB-9762-499F-89AC-D85E1498BE38@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit
Sent: November 1, 2018 at 4:31:59 PM GMT
> To: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@amacapital.net>, Matthew Wilcox =
<willy@infradead.org>, Kees Cook <keescook@chromium.org>, Igor Stoppa =
<igor.stoppa@gmail.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave =
Chinner <david@fromorbit.com>, James Morris <jmorris@namei.org>, Michal =
Hocko <mhocko@kernel.org>, Kernel Hardening =
<kernel-hardening@lists.openwall.com>, linux-integrity =
<linux-integrity@vger.kernel.org>, linux-security-module =
<linux-security-module@vger.kernel.org>, Igor Stoppa =
<igor.stoppa@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>, =
Jonathan Corbet <corbet@lwn.net>, Laura Abbott <labbott@redhat.com>, =
Randy Dunlap <rdunlap@infradead.org>, Mike Rapoport =
<rppt@linux.vnet.ibm.com>, open list:DOCUMENTATION =
<linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas =
Gleixner <tglx@linutronix.de>
> Subject: Re: [PATCH 10/17] prmem: documentation
>=20
>=20
> From: Peter Zijlstra
> Sent: October 31, 2018 at 9:08:35 AM GMT
>> To: Nadav Amit <nadav.amit@gmail.com>
>> Cc: Andy Lutomirski <luto@amacapital.net>, Matthew Wilcox =
<willy@infradead.org>, Kees Cook <keescook@chromium.org>, Igor Stoppa =
<igor.stoppa@gmail.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave =
Chinner <david@fromorbit.com>, James Morris <jmorris@namei.org>, Michal =
Hocko <mhocko@kernel.org>, Kernel Hardening =
<kernel-hardening@lists.openwall.com>, linux-integrity =
<linux-integrity@vger.kernel.org>, linux-security-module =
<linux-security-module@vger.kernel.org>, Igor Stoppa =
<igor.stoppa@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>, =
Jonathan Corbet <corbet@lwn.net>, Laura Abbott <labbott@redhat.com>, =
Randy Dunlap <rdunlap@infradead.org>, Mike Rapoport =
<rppt@linux.vnet.ibm.com>, open list:DOCUMENTATION =
<linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas =
Gleixner <tglx@linutronix.de>
>> Subject: Re: [PATCH 10/17] prmem: documentation
>>=20
>>=20
>> On Tue, Oct 30, 2018 at 04:18:39PM -0700, Nadav Amit wrote:
>>>> Nadav, want to resubmit your series? IIRC the only thing wrong with =
it was
>>>> that it was a big change and we wanted a simpler fix to backport. =
But
>>>> that=E2=80=99s all done now, and I, at least, rather liked your =
code. :)
>>>=20
>>> I guess since it was based on your ideas=E2=80=A6
>>>=20
>>> Anyhow, the only open issue that I have with v2 is Peter=E2=80=99s =
wish that I would
>>> make kgdb use of poke_text() less disgusting. I still don=E2=80=99t =
know exactly
>>> how to deal with it.
>>>=20
>>> Perhaps it (fixing kgdb) can be postponed? In that case I can just =
resend
>>> v2.
>>=20
>> Oh man, I completely forgot about kgdb :/
>>=20
>> Also, would it be possible to entirely remove that kmap fallback =
path?
>=20
> Let me see what I can do about it.

My patches had several embarrassing bugs. I=E2=80=99m fixing and will =
resend later,
hopefully today.

