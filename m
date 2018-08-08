Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEC3C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE6A2175F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE6A2175F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeHHSWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:22:10 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:43702 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeHHSWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:22:09 -0400
Received: by mail-qk0-f172.google.com with SMTP id z74-v6so1847867qkb.10;
        Wed, 08 Aug 2018 09:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9v/itfTDh1VWtBC0ExiB+0Qvk6wMkAVtOQeluJuN0E=;
        b=s8WifD19vY570tAcDH5T10LJDDGWjH8q7ilQrLh0KSeaRrxf2Anq3OKAqVhEIcKrVy
         omZQpwqISyLx+4NHCmcHglrV8PXHY4q9ailc2JQcjUT9ESWS5nv9zBod0Io+tHc9KL69
         pU4QTxuNibZOBCApp5pi+kP9Gsc9QPHLsQ04tGI+PwOT9wAkk0ykMaCkMRFPjZ4BfQBP
         joo/wYC/UVxl+cWQF8oRhK1tHNJQ72/TmGnhEdAPHtPTlnPw024UgqRYgGsSw3jRmmRr
         /3YZfUs52apArbBWkBJX03uJWlLleAkIk6lgP2xFfhUvRcFZImSuRFSO5MFYfkF4OgqT
         u+Pw==
X-Gm-Message-State: AOUpUlF5n9//kgdEWEUdKxYIVSJDznw3CxPi4Z1xY0Ko5RouXJ0lN8wu
        rCoiA+UEtw7oefaj92RihRtt6IYj/TR/BrTwrbE=
X-Google-Smtp-Source: AA+uWPzz4gG73omJL6cGyj3yPQP2Mi295cQQEiA8ou9571120n9b5AC3dyI4IS8eibBTG7lnL5AhRaEYGmSJUuRhcaU=
X-Received: by 2002:a37:7946:: with SMTP id u67-v6mr2907626qkc.283.1533744109911;
 Wed, 08 Aug 2018 09:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com> <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <20180808113927.GA24736@iMac.local> <alpine.LRH.2.02.1808081011110.9997@file01.intranet.prod.int.rdu2.redhat.com>
 <b1a0dac5-3cf2-1a7f-ac7f-649126eb7873@arm.com> <20180808151444.GF24736@iMac.local>
In-Reply-To: <20180808151444.GF24736@iMac.local>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Aug 2018 18:01:31 +0200
Message-ID: <CAK8P3a2=rVvvW8bBcrPm3nXNNP56Ygxchu4ThD2ZgZ_cVcd8wQ@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Richard.Earnshaw@arm.com, Mikulas Patocka <mpatocka@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        neko@bakuhatsu.net, linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 5:15 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Aug 08, 2018 at 04:01:12PM +0100, Richard Earnshaw wrote:
> > On 08/08/18 15:12, Mikulas Patocka wrote:
> > > On Wed, 8 Aug 2018, Catalin Marinas wrote:
> > >> On Fri, Aug 03, 2018 at 01:09:02PM -0400, Mikulas Patocka wrote:
> - failing to write a few bytes
> - writing a few bytes that were written 16 bytes before
> - writing a few bytes that were written 16 bytes after
>
> > The overlapping writes in memcpy never write different values to the
> > same location, so I still feel this must be some sort of HW issue, not a
> > SW one.
>
> So do I (my interpretation is that it combines or rather skips some of
> the writes to the same 16-byte address as it ignores the data strobes).

Maybe it just always writes to the wrong location, 16 bytes apart for one of
the stp instructions. Since we are usually dealing with a pair of overlapping
'stp', both unaligned, that could explain both the missing bytes (we write
data to the wrong place, but overwrite it with the correct data right away)
and the extra copy (we write it to the wrong place, but then write the correct
data to the correct place as well).

This sounds a bit like what the original ARM CPUs did on unaligned
memory access, where a single aligned 4-byte location was accessed,
but the bytes swapped around.

There may be a few more things worth trying out or analysing from
the recorded past failures to understand more about how it goes
wrong:

- For which data lengths does it fail? Having two overlapping
  unaligned stp is something that only happens for 16..96 byte
  memcpy.

- What if we use a pair of str instructions instead of an stp in
  a modified memcpy? Does it now write to still write to the
  wrong place 16 bytes away, just 8 bytes away, or correctly?

- Does it change in any way if we do the overlapping writes
  in the reverse order? E.g. for the 16..64 byte case:

diff --git a/sysdeps/aarch64/memcpy.S b/sysdeps/aarch64/memcpy.S
index 7e1163e6a0..09d0160bdf 100644
--- a/sysdeps/aarch64/memcpy.S
+++ b/sysdeps/aarch64/memcpy.S
@@ -102,11 +102,11 @@ ENTRY (MEMCPY)
        tbz     tmp1, 5, 1f
        ldp     B_l, B_h, [src, 16]
        ldp     C_l, C_h, [srcend, -32]
-       stp     B_l, B_h, [dstin, 16]
        stp     C_l, C_h, [dstend, -32]
+       stp     B_l, B_h, [dstin, 16]
 1:
-       stp     A_l, A_h, [dstin]
        stp     D_l, D_h, [dstend, -16]
+       stp     A_l, A_h, [dstin]
        ret

        .p2align 4

        Arnd
