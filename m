Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41627C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA872088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL24y125"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA872088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeH1SCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbeH1SCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:02:41 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E927C2088E;
        Tue, 28 Aug 2018 14:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535465450;
        bh=2Vb66Cwc1DOT5mJ+0KAaKy/vfKUE43ekrYhNZ2WAWfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OL24y12537hXrQP8FhWCwv7liS1a9riOkzxLP46SvLYp8FLWYnRKjoMpbA1nOrdN/
         mNOPRNL6Sm/qNCKF142DwxltGLLwt1EVsLBT2/Sq9jzrKevM1YHtlgXxKMFjxL2oPZ
         5dMp5VGKUD81hcnBcGqn21RmA5Jba/ASMnsiLlho=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 1A376141C3F; Tue, 28 Aug 2018 11:10:47 -0300 (-03)
Date:   Tue, 28 Aug 2018 11:10:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-perf-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] Properly interpret indirect call in perf annotate.
Message-ID: <20180828141047.GG22309@kernel.org>
References: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
 <20180823141219.GA4766@kernel.org>
 <64684c59-492c-3310-a5d2-14b467602acc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64684c59-492c-3310-a5d2-14b467602acc@suse.cz>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 27, 2018 at 11:06:21AM +0200, Martin Liška escreveu:
> On 08/23/2018 04:12 PM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Aug 23, 2018 at 02:29:34PM +0200, Martin Liška escreveu:
> >> The patch changes interpretation of:
> >> callq  *0x8(%rbx)
> >>
> >> from:
> >>   0.26 │     → callq  *8
> >> to:
> >>   0.26 │     → callq  *0x8(%rbx)
> >>
> >> in this can an address is followed by a register, thus
> >> one can't parse only address.
> > 
> > Please mention one or two functions where such sequence appears, so that
> > others can reproduce your before/after more quickly,
> 
> Sure, there's self-contained example on can compile (-O2) and test.
> It's following call in test function:
> 
> test:
> .LFB1:
>         .cfi_startproc
>         movq    %rdi, %rax
>         subq    $8, %rsp
>         .cfi_def_cfa_offset 16
>         movq    %rsi, %rdi
>         movq    %rdx, %rsi
>         call    *8(%rax) <---- here
>         cmpl    $1, %eax
>         adcl    $-1, %eax
>         addq    $8, %rsp
>         .cfi_def_cfa_offset 8
>         ret
>         .cfi_endproc

Here I'm getting:

Samples: 2K of event 'cycles:uppp', 4000 Hz, Event count (approx.): 1808551484
test  /home/acme/c/perf-callq [Percent: local period]
  0.17 │      mov    %rdx,-0x28(%rbp)
  0.58 │      mov    -0x18(%rbp),%rax
  7.90 │      mov    0x8(%rax),%rax
  8.67 │      mov    -0x28(%rbp),%rcx
       │      mov    -0x20(%rbp),%rdx
  0.08 │      mov    %rcx,%rsi
  6.28 │      mov    %rdx,%rdi
 10.50 │    → callq  *%rax
  1.67 │      mov    %eax,-0x4(%rbp)
 11.95 │      cmpl   $0x0,-0x4(%rbp)
  8.14 │    ↓ je     3d
       │      mov    -0x4(%rbp),%eax
       │      sub    $0x1,%eax
       │    ↓ jmp    42
       │3d:   mov    $0x0,%eax
  7.84 │42:   leaveq
       │    ← retq

Without the patch, will check if something changes with it.

- Arnaldo


