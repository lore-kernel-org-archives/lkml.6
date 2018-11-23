Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF34C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E11A20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IbxMXrIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E11A20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437378AbeKXFaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:30:10 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41012 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437341AbeKXFaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:30:10 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so9317390lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 10:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fgWduHwk1hI7fv1bLGNNmWYCSMeECFNIa3NBV87Bb50=;
        b=IbxMXrIwT1tM0WiKiXkMaR0Nta2CXysttsag+M/709ewvJyg2ZSZEH/eWM/VgUfmd3
         D+D8UdQnvG236SKhAITX0YSZS6H8Tz8XKN61DMyMiHAVv2fR4226qFQikICCmKxILBV9
         KaaNOIQwBos1DaHVrZtno1WpRPcBiLo63GJuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fgWduHwk1hI7fv1bLGNNmWYCSMeECFNIa3NBV87Bb50=;
        b=m8heih+uY2xQAj68uWV0tnCeqX3tH9C2KWIrU4fAXW47/pLrVCdDkb2QtdUhCnOHdZ
         OcTsEfnofjaZ5zMzimpjd1nRPhIyvaKq1PFpFTy317Gqeq/vXq1QU34ngWl/7QDNn5ik
         9ZvxiOcI9tpaIn40U7qNyPzDYqhrTYv73LV7j65H051UuD83gMP0UBdHDmXTiooKtpDA
         8EZwKflkgTfwFmmulLNR2IZUqHz4Tyt5aNXYo1SZePdnx/E9b7xBuShSTdXhvXIdWMWy
         3DtsrGE38ct9+wzK9YZAGMXBSx6lIv1ozAPm5kkBb76Mt0xa5ecN2uXZHAjFnA9RvTKZ
         s7kg==
X-Gm-Message-State: AGRZ1gIZMwItuaunT7vofunmNdRos8voZ5k2WPqK06Fiaao5/9gH/KMS
        48Az4X1Xbvsw9HADVksSVaxpJrfSUupyeQ==
X-Google-Smtp-Source: AJdET5e/EmB/E6Ap4WX2IQAafVIrSUrmUrR4RAc5+QoA8Rma6XfJiqhXfLRDJ7YDW7EZ/i26SIOUag==
X-Received: by 2002:a19:9904:: with SMTP id b4mr9624516lfe.95.1542998680701;
        Fri, 23 Nov 2018 10:44:40 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id m13-v6sm8260309ljg.56.2018.11.23.10.44.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 10:44:39 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id u6-v6so11426635ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 10:44:38 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr10363714lja.148.1542998678380;
 Fri, 23 Nov 2018 10:44:38 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com> <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
 <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com>
 <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com>
 <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com>
 <cd11d9423c8b46ecbf97753f8317c294@AcuMS.aculab.com> <64fd67993af04579b5262c270a7a4694@AcuMS.aculab.com>
 <CAHk-=wj9DA-mH8jahuEPUWxO4EgbCcPRgdOJAQD58DBtCCrHcQ@mail.gmail.com>
 <CAHk-=wjrdrZW5VgnKXqdayafYmQC2HBEA4kzMWYTyaj5jgURdA@mail.gmail.com> <C74CD745-0E6D-410C-B942-416AF365B492@amacapital.net>
In-Reply-To: <C74CD745-0E6D-410C-B942-416AF365B492@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Nov 2018 10:44:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgpmV2B=s2xE5385Jzy2tEZuiW+MSPveJBfpqUoFdGydg@mail.gmail.com>
Message-ID: <CAHk-=wgpmV2B=s2xE5385Jzy2tEZuiW+MSPveJBfpqUoFdGydg@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David.Laight@aculab.com, Andrew Lutomirski <luto@kernel.org>,
        dvlasenk@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 10:39 AM Andy Lutomirski <luto@amacapital.net> wrot=
e:
>
> What is memcpy_to_io even supposed to do?  I=E2=80=99m guessing it=E2=80=
=99s defined as something like =E2=80=9Ccopy this data to IO space using at=
 most long-sized writes, all aligned, and writing each byte exactly once, i=
n order.=E2=80=9D  That sounds... dubiously useful.

We've got hundreds of users of it, so it's fairly common..

> I could see a function that writes to aligned memory in specified-sized c=
hunks.

We have that. It's called "__iowrite{32,64}_copy()". It has very few users.

                  Linus
