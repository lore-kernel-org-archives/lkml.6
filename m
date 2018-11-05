Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59520C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB0220892
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eHzDS50A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB0220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbeKFDSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:18:54 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33362 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387530AbeKFDSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:18:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so6840397lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2PSGikp0d0PMeHLkvPmTPgSZ7jehZr91zf3ZOPUPQKE=;
        b=eHzDS50AcnKz5txccY27Cto3GJPzPmbAq3SbTFr7PJZTA6YQ8DqA5VFx/N+EeTa/nA
         pX9Y+X4QLCWwgAqVSCh/zPKczkp6vWks3VPOM0V1s4Jn9f9ucFle/CPLSeu4cusuHNip
         f8OSmjLfP/BShQYKAcsJrGWD3C4NKZlJVEoFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PSGikp0d0PMeHLkvPmTPgSZ7jehZr91zf3ZOPUPQKE=;
        b=Vi6YdPeZ2qg6XCaNjAfSgrtjeRrDscPBafkAEN+YUdC5ONUL/EEXQoCYUDfsKDRTVr
         5gC0NDlerx99aNDVwWbydYRXTbATcmkgu5AXTGDH2379syBIUQNGp+gUHPUpavfFQk7q
         IpwOY+VvjFC/qzFAt6DoOOws9Yq2EhUrLxGLY297br3hZBh58PfagcGWqtzv9kyv0xOe
         YwTnNmZMnBomHXsBX2GVBFNPUOS9nRDWT3VBTiQ7Eqvu1TrvppE9pi+bpQZtkyNu1kSq
         qx+1D9sV1Nppvl9/4H9esmgrOnMh3TOvSTRH4MEnMUcJ7Kj0VVehfh1H3Pv2tlgHRsaX
         Orxw==
X-Gm-Message-State: AGRZ1gICt5K233Cmbs90Gkbreq6jm0g9upl3wK0grRG8TK7CjsoJ9NUV
        aHxYX32g+8w9ZQo0kzQCajO81doFyHvfuQ==
X-Google-Smtp-Source: AJdET5c3m9qspFLDtC+gtzHhorxs3TAhkVL0qpZzXG158GOMX80WVaAswNNr1ih/xaSdPif5BfhfLQ==
X-Received: by 2002:a19:c650:: with SMTP id w77mr13497146lff.56.1541440685177;
        Mon, 05 Nov 2018 09:58:05 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id h21sm6131556lfk.41.2018.11.05.09.58.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 09:58:04 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id j4-v6so8867457ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:58:04 -0800 (PST)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr16226394ljj.6.1541440683423;
 Mon, 05 Nov 2018 09:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20181105070337.GX24195@shao2-debian>
In-Reply-To: <20181105070337.GX24195@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 5 Nov 2018 09:57:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgHY5EdhvPoS458Wu8iUfC9C8UBG8GzEO72=0prT2nVcw@mail.gmail.com>
Message-ID: <CAHk-=wgHY5EdhvPoS458Wu8iUfC9C8UBG8GzEO72=0prT2nVcw@mail.gmail.com>
Subject: Re: [LKP] [xarray] 0e9446c35a: WARNING:at_include/linux/xarray.h:#xa_mk_value
To:     rong.a.chen@intel.com, Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willy,

On Sun, Nov 4, 2018 at 11:03 PM kernel test robot <rong.a.chen@intel.com> wrote:
>
> commit: 0e9446c35a80931044b6d8d2d74a9cabd248539f ("xarray: Add range store functionality")
...
> [   11.880031] WARNING: CPU: 0 PID: 1 at include/linux/xarray.h:54 xa_mk_value+0x7/0x10
> [   11.881944] EIP: xa_mk_value+0x7/0x10
> [   11.883565] Call Trace:
> [   11.883565]  __check_store_range+0xe/0x171
> [   11.883565]  check_store_range+0x5d/0x87

If I read this right, it's simply this case:

                __check_store_range(xa, UINT_MAX + i, UINT_MAX + j);

which turns into negative values on a 32-bit machine, and then
xa_mk_value() warns.

Should that part of the test be surrounded by #ifdef CONFIG_64BIT? Or
did you _want_ the warnings?

                 Linus
