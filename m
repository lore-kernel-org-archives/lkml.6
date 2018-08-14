Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1EBC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A6321580
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S/Jdy/0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A6321580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbeHOAto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:49:44 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50959 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHOAto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:49:44 -0400
Received: by mail-it0-f67.google.com with SMTP id j81-v6so20601828ite.0;
        Tue, 14 Aug 2018 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jmn2RyXaFJdHhO+o8iJGouaocEcuQe0RmDVn88MI+ms=;
        b=S/Jdy/0U6dlepMQBZe+Ju+7iKCaD9tKLC+XDcOlXbMiz86a3nmzmaiY7sT3TyHEGCL
         oGYZ28uIzPeYl2hTfWhZyHgLx9nsS66hfg9/5o2IUKhZPjCEVNkT8G7zKXfNmQ5u5H8W
         vyo6xq2z6YTcHprbPee6EBORIccUcYYSL+ugc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jmn2RyXaFJdHhO+o8iJGouaocEcuQe0RmDVn88MI+ms=;
        b=D3pgl0/XuJaDanVnFMi8rWizfLFxyKqkfc67Hh5Mro/RZdPJkbweblDy2eZeKuaThc
         iOJzzBMKhplhw/XvICTvbp+TOERsXxtAndtJ2+qm1NhM18O1II3llE7HEzd9lzu/D2a7
         9wkrKLJL+ALk/cV4Bd3Bb2bRD6aggJnO67Xj45FZ/oyZhDkX4e0d+L04ZqTDePN+RGB5
         RrFuZuHomiF9TEQdjyjBN5YLP/aFy0r6y7y5GyCtqZZmMyeCoFzz9jMJZE7PX+jTI1r4
         Hz5Fu38B/+aD7p4ZrkXhlej7XHM9Tbxtanv94d3zE3yyK53JxesyH2A899BERUbm2e0+
         eDAw==
X-Gm-Message-State: AOUpUlG4F1BVXBq6YR/vavxkGRK4I2oWY69R/cAEUDwXVcBjmNWXGFVd
        t8R90PGEuQKfIhyN5p0su3MUN/lnoCNlYPh8xHQ=
X-Google-Smtp-Source: AA+uWPyTvleeu1PcVBNfymXzHcFYrVTgMhCdnEkl7jR+KToDwSf39qG8FgWpjGh96EmTKpkydwepj6puWtyFLfAjtfg=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr21127585jaf.70.1534284031998;
 Tue, 14 Aug 2018 15:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180814213857.18779-1-vbabka@suse.cz>
In-Reply-To: <20180814213857.18779-1-vbabka@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Aug 2018 15:00:20 -0700
Message-ID: <CA+55aFyZoZFYztUjqT4m_HLhh4uoBg38ypAsZ3ufTYVnQr4s0w@mail.gmail.com>
Subject: Re: [PATCH] x86/smp: fix non-SMP broken build due to redefinition of apic_id_is_primary_thread
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 2:39 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> The function has an inline "return false;" definition with CONFIG_SMP=3Dn=
 but the
> "real" definition is also visible leading to "redefinition of
> =E2=80=98apic_id_is_primary_thread=E2=80=99" compiler error. Guard it wit=
h #ifdef CONFIG_SMP

Applied.

                Linus
