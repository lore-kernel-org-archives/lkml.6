Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D20C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B727F2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CumXi7Jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B727F2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeKBBgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:36:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45172 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbeKBBgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:36:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id b20so4325843lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AlgqOPGsDOUGIQvIEsT1UNe9JCt68axNFJ//Kqhkmo=;
        b=CumXi7Jwik7pxBsG08c5NwEfZaVNsrgfOeFMnWz/rMOoDgFs5c/CwQxtl3wEJzQwHn
         3Se3qiTgansLAzrH6PtHbmpb82bByKwo+7P28vZX4gELZ+ZWSDxBpWPDEvZF/AR29wsG
         pCD2arfota4BrJWj5eCnmfEunGMb/RuaxJpKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AlgqOPGsDOUGIQvIEsT1UNe9JCt68axNFJ//Kqhkmo=;
        b=QrLsm/+YUi6PS2k4z3FEPoMlk/q94rar/GnXA9+P103XvA0AOyukQJpQgiqnuHovIc
         oXhnYVqTOSLXzxCScG6LJelbxh8nb7VGuoz/8kn+g5NR+zIlZhpDgmR4KE/bdYmfUoBh
         PNnThXYIgeAgiJXXfIcZ3c21pfpWQMNs5IPsOI6saNtsxtp4K6/vTJtFhVIY9FePzrto
         3OgNbIEe9QRtU0YjdGl0TuVirrfou25oVpfiNVi5KyGQm0+9uBJ6BhMzsT5f3ODdN8po
         GIOfIW+EfpVmwRNhglfO24h6ngVmfWMtg8pyNc7oj6tmGFck1HMqYvWHbFbRgyWhH7n6
         R+Qg==
X-Gm-Message-State: AGRZ1gIAaC68Z36eR+8KsKedXVoaZF+SMY6uGwX+N0/LB9UEEjpMr0QZ
        BeHNV3YkMm4uw0JW91ZQexLWRR026XHD2g==
X-Google-Smtp-Source: AJdET5cnMoZinOm41SRvqPyuyjzQNBwVt7od0utvOW1SJh5jZE8HICFPVeGfwfAnM8UwP3PSuYCwNA==
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr4614048lfi.138.1541089979365;
        Thu, 01 Nov 2018 09:32:59 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id t9-v6sm878761lfd.93.2018.11.01.09.32.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 09:32:58 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id z80-v6so12547833ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:32:58 -0700 (PDT)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr5819581ljj.6.1541089977729;
 Thu, 01 Nov 2018 09:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181101151240.GA48711@dennisz-mbp.dhcp.thefacebook.com>
In-Reply-To: <20181101151240.GA48711@dennisz-mbp.dhcp.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 09:32:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuPczJzcvLrR4TXHQOw_A3RSdrtU2bRXcoxHad19V59g@mail.gmail.com>
Message-ID: <CAHk-=wjuPczJzcvLrR4TXHQOw_A3RSdrtU2bRXcoxHad19V59g@mail.gmail.com>
Subject: Re: [GIT PULL] percpu changes for v4.20-rc1
To:     dennis@kernel.org
Cc:     tj@kernel.org, Christoph Lameter <cl@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 8:12 AM Dennis Zhou <dennis@kernel.org> wrote:
>
> Two small things for v4.20. The first fixes a clang uninitialized
> variable warning for arm64 in the default path calls BUILD_BUG(). The
> second removes an unnecessary unlikely() in a WARN_ON() use.

Pulled,

                  Linus
