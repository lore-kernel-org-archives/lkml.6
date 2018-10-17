Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B53ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C2C214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C2C214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeJRAjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:39:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44586 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeJRAjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:39:05 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F105D136DD15A;
        Wed, 17 Oct 2018 09:42:34 -0700 (PDT)
Date:   Wed, 17 Oct 2018 09:42:32 -0700 (PDT)
Message-Id: <20181017.094232.2240871178683881504.davem@davemloft.net>
To:     acme@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Add Sparc annotate support.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181017123902.GA4041@redhat.com>
References: <20181016.205555.1070918198627611771.davem@davemloft.net>
        <20181017123902.GA4041@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 17 Oct 2018 09:42:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Wed, 17 Oct 2018 09:39:02 -0300

> Em Tue, Oct 16, 2018 at 08:55:55PM -0700, David Miller escreveu:
> 
> Great!
> 
> Could you try something like:
> 
> # perf record some_workload
> # perf annotate --stdio2 hot_function
> 
> So that we can see this thing in action, i.e. sparc assembly annotated?
> :-)
> 
> With 'perf annotate --tui hot_function' or 'perf top' 'A' you can
> navigate, but for showing it in action in a git changelog comment
> example --stdio is more convenient :-)

Sure :-)

This is run on __gettimeofday when running perf record on your "gtod"
test.  (Still working on getting glibc to use the VDSO properly on
sparc :-( )

Samples: 7K of event 'cycles:ppp', 4000 Hz, Event count (approx.): 3086733887                                   
__gettimeofday  /lib32/libc-2.27.so [Percent: local period]                                                     
Percent│
       │
       │
       │    Disassembly of section .text:
       │
       │    000a6fa0 <__gettimeofday@@GLIBC_2.0>:
  0.47 │      save   %sp, -96, %sp
  0.73 │      sethi  %hi(0xe9000), %l7
       │    → call   __frame_state_for@@GLIBC_2.0+0x480
  0.30 │      add    %l7, 0x58, %l7     ! e9058 <nftw64@@GLIBC_2.3.3+0x818>
  1.33 │      mov    %i0, %o0
       │      mov    %i1, %o1
  0.43 │      mov    0x74, %g1
       │      ta     0x10
 88.92 │    ↓ bcc    30
  2.95 │      clr    %g1
       │      neg    %o0
       │      mov    1, %g1
  0.31 │30:   cmp    %g1, 0
       │      bne,pn %icc, a6fe4 <__gettimeofday@@GLIBC_2.0+0x44>
       │      mov    %o0, %i0
  1.96 │    ← return %i7 + 8
  2.62 │      nop
       │      sethi  %hi(0), %g1
       │      neg    %o0, %g2
       │      add    %g1, 0x160, %g1
       │      ld     [ %l7 + %g1 ], %g1
       │      st     %g2, [ %g7 + %g1 ]
       │    ← return %i7 + 8
       │      mov    -1, %o0
