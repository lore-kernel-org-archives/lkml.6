Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D36C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DCE20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="gDSygDlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DCE20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbeITB3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:29:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47055 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbeITB3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:29:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so3220118pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bzyfvbrR/LHN7Wn4QNbtu6FWbxbPrPUtwbxxperCojo=;
        b=gDSygDlYuxjvk29iodPYikGSp1PxDeOW9ymjfkV2ZDdIraBQbV2uL32jXuWE51DiX+
         4NW/kLK0EuW7NVpU53VEAnx78WbqnP7AZkPa7woZ0RMwv20OCzIQGemYaTfrwKihHom+
         J3rLq06r0wl+9khpynmAjh0bX124nXddmsBHf4SJMVOX9ow7Jjsrd7G4PsDcRwbjuDSU
         +0ZMOB9KrUOoFJYrCHoEJS3nvTIaL9O1NArlUiQblS0LAY/7X1KSGuOrh/JTXfLr6MsW
         wOxD7MOm5O3DcXAEuLnChzY1lLF8sXgj6cdFUPu7Yy/lh1jeiVIx76eDr1Ufw6niIPMM
         50Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bzyfvbrR/LHN7Wn4QNbtu6FWbxbPrPUtwbxxperCojo=;
        b=C7i1McmVfUDLRgOQnY0uOieQ2F3WRtHwCYx4xg4E9QCdgWV3gVLVAC79PeaMxGAJXH
         POzdLytN8kcel6WT1Bcs3GkkxZ6jI8aq2ZoIFQYbecwWA9dgseU0HCd9+k1qQB7kZFT/
         jsjwwAIhWriU6F76hljx5YZS7O/6tohPWoT8k8/7R00cbpaBxbgI8pK3BJj6KG5vImo7
         z+ZEjtHHZN8vUVO2WYZCFZuYKt3YYSJbM8ffmnwubCC1cEIuZxukhsYpXHYq3bceoXYt
         NSEF6zbyBO8OdBfgHSUU2ASOULcqCmr+ooFTfnxQNTL2vHLNhQ18+LLE/jd0liqIAPbP
         Sk8A==
X-Gm-Message-State: APzg51AkStrBJiEdA69ad9DBwiAh0DPubAUgK/q0ogq+CvDVewzNDDb1
        gbNahNuCZUdKz7hTfyqPEGbTfg==
X-Google-Smtp-Source: ANB0VdYJrFHajabyjvKQWM5zQy1yzXEV+4CWSItNsPjhOuNkI85PwDUkQaDGAUlkroBZUb6BW5DVLA==
X-Received: by 2002:a63:165f:: with SMTP id 31-v6mr12757840pgw.103.1537386577095;
        Wed, 19 Sep 2018 12:49:37 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:ad:6d57:4d4:12f6? ([2601:646:c200:7429:ad:6d57:4d4:12f6])
        by smtp.gmail.com with ESMTPSA id h190-v6sm36847591pge.18.2018.09.19.12.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 12:49:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 04/10 v2 ] x86/fpu: eager switch PKRU state
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <099b9f82-e162-c91a-bc51-aa1ac0cd50aa@redhat.com>
Date:   Wed, 19 Sep 2018 12:49:35 -0700
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <27496B23-92A0-462C-A198-6A4413634488@amacapital.net>
References: <8e5b64e4-b3e6-f884-beb6-b7b69ab2d8c1@redhat.com> <20180914203501.qibhpmueosvkr74w@linutronix.de> <a239e97a-d1a1-388e-5db9-10758c33d702@redhat.com> <20180918142701.atfb4ul45k7tl6ew@linutronix.de> <7e9a13f3-93f5-fe4a-20d2-f4f9407bd43b@redhat.com> <83e271e1298d603c1105dd0dbea32d67da9cf1fa.camel@surriel.com> <36e8493f-f994-e885-8fe6-2f0d4a9904a1@redhat.com> <20180918160419.2zeru6xnufxixcax@linutronix.de> <11aa7d0f4ba36eff8b61a5dc1bd35ee5195fd576.camel@surriel.com> <c3492a53-74cd-4474-b664-f227ef37b7de@redhat.com> <20180919165719.iepvc7tg6aabp5mm@linutronix.de> <099b9f82-e162-c91a-bc51-aa1ac0cd50aa@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 19, 2018, at 10:00 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>> On 19/09/2018 18:57, Sebastian Andrzej Siewior wrote:
>>> On 2018-09-19 07:55:51 [+0200], Paolo Bonzini wrote:
>>> A kthread can do use_mm/unuse_mm.
>>=20
>> indeed. The FPU struct for the kernel thread isn't valid / does not
>> contain the expected PKRU value. So loading the pkru value from the
>> struct FPU does not work as expected. We could set it to 0 for a kernel
>> thread so we don't end up with a random value.
>> If we want to get this usecase working then we would have to move pkru
>> value from FPU to mm_struct and consider it in use_mm(). Do we want
>> this?
>=20
> As a start, I think keeping it in the FPU struct but loading it
> unconditionally will work.  kthreads will not obey PKU but it will be
> better already.
>=20
> I honestly don't know if PKRU should be per-mm, I don't know mm very
> well despite my brilliant observation above. :)
>=20
>=20

It must be per thread.  I don=E2=80=99t think it=E2=80=99s possible to have s=
ane semantics per mm.

I also think that use_mm should set PKRU to the same value that signal handl=
ers use.  If we use 0, it=E2=80=99s a recipe for accidental PK bypass.=
