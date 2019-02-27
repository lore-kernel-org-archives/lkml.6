Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B816DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837BD21850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551284074;
	bh=1UOsGkthyloNHAJyb+ve0Mu/alfUaPpbjU9axOrWrpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=twqm9NAfIfzWXLBkQ2/Pj95s8nn7cffwKyUwkhh172IeDg159NaDHWp26vPh0+ZjE
	 cRQz4Kiy5f+Fr2bkxSydi7l8WICiyPwEKr2c9c4cRU4nJgbenYcFXDdayy4ZtQtVIS
	 0NZ6/puljXxEzoJQ94LwAYH3USv2FXsoHlZOL7AE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfB0QOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:14:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45043 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfB0QOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:14:32 -0500
Received: by mail-lf1-f66.google.com with SMTP id v185so1543783lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 08:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZ271I2BxrBYnWRa3tyhNr47JvEXyHm4KMsKp69FcOE=;
        b=VmIwsflD4byBzh4jj6fs2yYhshYrMXOXfGH+IXXdFuiqnTk7E+4TO9uNA6+wKKOd6B
         6o/YUYcQwIfl+iptVKbToYn4ihc2VeYe05O2yQQuioqNzgJdnuYc4TC95fFpSDMd+PVO
         OL5DVG2ddtlzyp8gAN80sou2wBFa4V1UiZaxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZ271I2BxrBYnWRa3tyhNr47JvEXyHm4KMsKp69FcOE=;
        b=nt4G2HabNzW/uZre6330GBxyYaRR/USj7hHPJoRli9jKVYVjM0lpOhnuSXC/EmneuH
         +GquGNXShoDUhErNhXj7WhU+NW3a0g+qoryjvRjIwiwffVXbPKY02BVeRuNMNZC3aItg
         Cah9hNPPa+wc/k60SVzHADxvKzCuniI0Zrgp/Cs7rsSIQ0cDSFnyu3IS3HDxcVLaSI4B
         pEryVCvUtBuRVP5kA7c2XaY2xdOJqY+YySE3vqkteZ43D5YuEiChQDiZwGzrLsU3hPz7
         +/weP0AqQ7mOYrSZAPD621702B/wkruzFfTJ0rd8C2m6NVP2YXBo7h29xKGz6NFxaAMF
         +UVw==
X-Gm-Message-State: AHQUAuYeCskMy0mhNed5TCt/4MFJhqwZRb867B1IHpVbC6vIOYKF1/Z5
        vFurNiOnUkWq8R6EosBc/3PK1WQHzcU=
X-Google-Smtp-Source: AHgI3IZKm1Vr8w7D3SSN5GB+UIfhEomJUqVp1GdtAM442f1rTxK5RVo43f6k9S1PFQW9RR/g/P2v1g==
X-Received: by 2002:a19:8094:: with SMTP id b142mr1358784lfd.117.1551284069803;
        Wed, 27 Feb 2019 08:14:29 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id g65sm3873697lji.74.2019.02.27.08.14.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 08:14:27 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id q128so14449813ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 08:14:26 -0800 (PST)
X-Received: by 2002:a2e:208a:: with SMTP id g10mr1959596lji.135.1551284066206;
 Wed, 27 Feb 2019 08:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20190227101252.413192716@infradead.org> <20190227101544.210748832@infradead.org>
In-Reply-To: <20190227101544.210748832@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Feb 2019 08:14:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiv6dgJDj81wukpJCJBVhAVn-CYJdhj+o8JGN1LfRwb0g@mail.gmail.com>
Message-ID: <CAHk-=wiv6dgJDj81wukpJCJBVhAVn-CYJdhj+o8JGN1LfRwb0g@mail.gmail.com>
Subject: Re: [PATCH 1/5] x86/percpu: Differentiate this_cpu_{}() and __this_cpu_{}()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000b6842c0582e277a3"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b6842c0582e277a3
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 27, 2019 at 2:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Nadav Amit reported that commit:
>
>   b59167ac7baf ("x86/percpu: Fix this_cpu_read()")
>
> added a bunch of constraints to all sorts of code; and while some of
> that was correct and desired, some of that seems superfluous.

Hmm.

I have the strong feeling that we should instead relax this_cpu_read()
again a bit.

In particular, making it "asm volatile" really is a big hammer
approach. It's worth noting that the *other* this_cpu_xyz ops don't
even do that.

I would suggest that instead of making "this_cpu_read()" be asm
volatile, we mark it as potentially changing the memory location it is
touching - the same way the modify/write ops do.

That still means that the read will be forced (like READ_ONCE()), but
allows gcc a bit more flexibility in instruction scheduling, I think.

Trivial (but entirely untested) patch attached.

That said, I didn't actually check how it affects code generation.
Nadav, would you check the code sequences you originally noticed?

                   Linus

--000000000000b6842c0582e277a3
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jsnegv090>
X-Attachment-Id: f_jsnegv090

IGFyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oIHwgMjQgKysrKysrKysrKysrLS0tLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGVyY3B1LmggYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9wZXJjcHUuaAppbmRleCAxYTE5ZDExY2ZiYmQuLjYzYjBmMzYxNTMzZiAxMDA2NDQK
LS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGVyY3B1LmgKKysrIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vcGVyY3B1LmgKQEAgLTE4NSwyNCArMTg1LDI0IEBAIGRvIHsJCQkJCQkJCQlcCiAJdHlw
ZW9mKHZhcikgcGZvX3JldF9fOwkJCQlcCiAJc3dpdGNoIChzaXplb2YodmFyKSkgewkJCQlcCiAJ
Y2FzZSAxOgkJCQkJCVwKLQkJYXNtIHZvbGF0aWxlKG9wICJiICJfX3BlcmNwdV9hcmcoMSkiLCUw
IlwKLQkJICAgIDogIj1xIiAocGZvX3JldF9fKQkJCVwKLQkJICAgIDogIm0iICh2YXIpKTsJCQlc
CisJCWFzbShvcCAiYiAiX19wZXJjcHVfYXJnKDEpIiwlMCJcCisJCSAgICA6ICI9cSIgKHBmb19y
ZXRfXyksCQkJXAorCQkgICAgICAiK20iICh2YXIpKTsJCQlcCiAJCWJyZWFrOwkJCQkJXAogCWNh
c2UgMjoJCQkJCQlcCi0JCWFzbSB2b2xhdGlsZShvcCAidyAiX19wZXJjcHVfYXJnKDEpIiwlMCJc
Ci0JCSAgICA6ICI9ciIgKHBmb19yZXRfXykJCQlcCi0JCSAgICA6ICJtIiAodmFyKSk7CQkJXAor
CQlhc20ob3AgIncgIl9fcGVyY3B1X2FyZygxKSIsJTAiXAorCQkgICAgOiAiPXIiIChwZm9fcmV0
X18pLAkJCVwKKwkJICAgICAgIittIiAodmFyKSk7CQkJXAogCQlicmVhazsJCQkJCVwKIAljYXNl
IDQ6CQkJCQkJXAotCQlhc20gdm9sYXRpbGUob3AgImwgIl9fcGVyY3B1X2FyZygxKSIsJTAiXAot
CQkgICAgOiAiPXIiIChwZm9fcmV0X18pCQkJXAotCQkgICAgOiAibSIgKHZhcikpOwkJCVwKKwkJ
YXNtKG9wICJsICJfX3BlcmNwdV9hcmcoMSkiLCUwIlwKKwkJICAgIDogIj1yIiAocGZvX3JldF9f
KSwJCQlcCisJCSAgICAgICIrbSIgKHZhcikpOwkJCVwKIAkJYnJlYWs7CQkJCQlcCiAJY2FzZSA4
OgkJCQkJCVwKLQkJYXNtIHZvbGF0aWxlKG9wICJxICJfX3BlcmNwdV9hcmcoMSkiLCUwIlwKLQkJ
ICAgIDogIj1yIiAocGZvX3JldF9fKQkJCVwKLQkJICAgIDogIm0iICh2YXIpKTsJCQlcCisJCWFz
bShvcCAicSAiX19wZXJjcHVfYXJnKDEpIiwlMCJcCisJCSAgICA6ICI9ciIgKHBmb19yZXRfXyks
CQkJXAorCQkgICAgICAiK20iICh2YXIpKTsJCQlcCiAJCWJyZWFrOwkJCQkJXAogCWRlZmF1bHQ6
IF9fYmFkX3BlcmNwdV9zaXplKCk7CQkJXAogCX0JCQkJCQlcCg==
--000000000000b6842c0582e277a3--
