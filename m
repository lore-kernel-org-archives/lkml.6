Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E428C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2D120700
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YqkhRdkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2D120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbeKFDLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:11:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43115 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbeKFDLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:11:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so6778105lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7rFNhFYNpFx+njTa5ZPrbfYsc/KM8Wtd7S51oksSYAM=;
        b=YqkhRdklrHcNKU2ppj0dTXNpfvBx4d/ml+GfI8Q2LkxMJ9MnaC1BIu4ReLUO9vcta7
         FD6M+WYJEG9VWJExNr+wNV7M8fTGD9KwEdcYcoDhki9TlYjlG96Y21A6AZ5hhpCypW7Z
         3fLRyvcGbZXDeSLL7IciPhpIhmTLwVmjbaByk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7rFNhFYNpFx+njTa5ZPrbfYsc/KM8Wtd7S51oksSYAM=;
        b=Ta1ewcbyFCRqVfLlmn54K+vw5/PTVl+6rnTLcszLdUdOkGVZnfhGXRpQEy+NuCQX9Q
         lGmDizrfjejsBSWTTWcAM5YtPiXwxgjTnPsa3b/+ed5y3KyFVXa/uZWkRoiqmNMMGNuN
         MWzd+KwcgB2NqnAaYgAMCd9oaprllg2PLcoUmImofSmZaRuZr/Ix+EHl5EwepmCU/i7r
         RFqT9kDz/hPR/UV+qwrAd/Ym4+zSSVyG6tmzjd68/pOlLz4o8rd3EinIRxdpVAqVN3NM
         hFlVONqubEwPQrNWT1jUGUY0PeFpoCigP0Nfamjstf/QeH0qFXsG8i+tImxWlcmF3lnh
         EVgw==
X-Gm-Message-State: AGRZ1gIhzyckJJHhZPYCon8MKrlswW4nVWzKrvdIltBrabr0k5RMr3Vw
        Bx90jC6L3SnYDKmYu2ERuGCLP79jaKaAeQ==
X-Google-Smtp-Source: AJdET5cPVE17lLSakefjA6nvyNkcZJ8Z1tYm8PLfak2Kx25vVs8NPLRzvrdXEWlNq2LLemyULkXjWA==
X-Received: by 2002:a19:702:: with SMTP id 2mr10268448lfh.144.1541440227879;
        Mon, 05 Nov 2018 09:50:27 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id j17sm1165898lfi.43.2018.11.05.09.50.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 09:50:26 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id v5so1812151lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:50:26 -0800 (PST)
X-Received: by 2002:a19:4948:: with SMTP id l8-v6mr12365873lfj.16.1541440225698;
 Mon, 05 Nov 2018 09:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20181105050813.GP24195@shao2-debian>
In-Reply-To: <20181105050813.GP24195@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 5 Nov 2018 09:50:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8BNNTp+Xt4ROz1TqGgFT-c6-Hmmc9yW0B6p2FTFwJTg@mail.gmail.com>
Message-ID: <CAHk-=wi8BNNTp+Xt4ROz1TqGgFT-c6-Hmmc9yW0B6p2FTFwJTg@mail.gmail.com>
Subject: Re: [LKP] [mm] 9bc8039e71: will-it-scale.per_thread_ops -64.1% regression
To:     rong.a.chen@intel.com
Cc:     yang.shi@linux.alibaba.com, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, mhocko@kernel.org,
        willy@infradead.org, ldufour@linux.vnet.ibm.com,
        Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 9:08 PM kernel test robot <rong.a.chen@intel.com> wr=
ote:
>
> FYI, we noticed a -64.1% regression of will-it-scale.per_thread_ops
> due to commit 9bc8039e715d ("mm: brk: downgrade mmap_sem to read when
> shrinking")

Ugh. That looks pretty bad.

> in testcase: will-it-scale
> on test machine: 8 threads Ivy Bridge with 16G memory
> with following parameters:
>
>         nr_task: 100%
>         mode: thread
>         test: brk1
>         ucode: 0x20
>         cpufreq_governor: performance

The reason seems to be way more scheduler time due to lots more
context switches:

>   34925294 =C2=B1 18%    +270.3%  1.293e+08 =C2=B1  4%  will-it-scale.tim=
e.voluntary_context_switches

Yang Shi, would you mind taking a look at what's going on?

              Linus
