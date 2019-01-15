Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD753C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACAC205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547586724;
	bh=ULbTOIItaV3S1BpmZkmwXCm8jnsZBgMz1XXUR89blz4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YgtX3jpnADwxMbz+ediO48dfK2syRXRa0SVRSdxNkk5613ZtzmS2/JjPE3ykGON52
	 PugL/WkhzfymQbsw6Y0Q1I3WydogFW8zKgUqBeBTnUOQmyD3tvkq+TdXWnUZraHJqD
	 6BgeqGn3FFGcHV3Pd8F/duP1aLSLQHNMzoIF8FoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390288AbfAOVMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:12:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732985AbfAOVMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:12:02 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C74E520883
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547586722;
        bh=ULbTOIItaV3S1BpmZkmwXCm8jnsZBgMz1XXUR89blz4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WnmUyYml3obKjQYnyTI9FthcsfjrX+OVE2J+WPD1DGRiknND3nCFgJ8scaQtKFyRR
         58pprr/SSzWSgoDPKLxqrwJwUfx2uqZhz2fzPL6C8ydMACwYJaiGaX/j7jnHGnYFW4
         ehHvcPvDSlUQbmxJldxKa3SIiBM9KsgXFRaHtWvg=
Received: by mail-wm1-f51.google.com with SMTP id t200so4774679wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 13:12:01 -0800 (PST)
X-Gm-Message-State: AJcUukf0VbDfsE1TK9CScYuVFtDpoZzLuPF5y5F+oJrxqptw3tQxDhrT
        Im2rFKiD64Vx6Scn9oXGGJWeHpdpK9wJRtpQZr4Hhg==
X-Google-Smtp-Source: ALg8bN52EpAxEqh7TaDROmfaMLs3XdYvfcOXa8OAXXWUjLAxO+saeZftGDTYmGxTeLJy7UAsxZmbvHD6rsCReV1GxDo=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr5086843wmf.32.1547586720193;
 Tue, 15 Jan 2019 13:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20190109114744.10936-1-bigeasy@linutronix.de> <2e396dbcbb1c4cc191b4208626baed07@AcuMS.aculab.com>
 <dc9e3308-4e2a-2ce8-495e-6fdb868c60b2@intel.com> <CALCETrX0RNgiVop+9uSkLyfxoy-cDyWk2G09svGD_UPsVyLAhA@mail.gmail.com>
 <39ab2f2b-81bb-636e-933d-f3a5225aa020@intel.com>
In-Reply-To: <39ab2f2b-81bb-636e-933d-f3a5225aa020@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 15 Jan 2019 13:11:48 -0800
X-Gmail-Original-Message-ID: <CALCETrXq8GFAzunui7d-seaK-on6_xiZOv0A4wc=sAur0wuDzg@mail.gmail.com>
Message-ID: <CALCETrXq8GFAzunui7d-seaK-on6_xiZOv0A4wc=sAur0wuDzg@mail.gmail.com>
Subject: Re: [PATCH v6] x86: load FPU registers on return to userland
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Laight <David.Laight@aculab.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 12:54 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/15/19 12:26 PM, Andy Lutomirski wrote:
> > I don't think we'd ever want kernel_fpu_end() to restore anything,
> > right?  I'm a bit confused as to when this optimization would actually
> > be useful.
>
> Using AVX-512 as an example...
>
> Let's say there was AVX-512 state, and a kernel_fpu_begin() user only
> used AVX2.  We could totally avoid doing *any* AVX-512 state save/restore.
>
> The init optimization doesn't help us if there _is_ AVX-512 state, and
> the modified optimization only helps if we recently did a XRSTOR at
> context switch and have not written to AVX-512 state since XRSTOR.
>
> This probably only matters for AVX-512-using apps that have run on a
> kernel with lots of kernel_fpu_begin()s that don't use AVX-512.  So, not
> a big deal right now.

On top of this series, this gets rather awkward, I think -- now we
need to be able to keep track of a state in which some of the user
registers live in the CPU and some live in memory, and we need to be
able to do the partial restore if we go back to user mode like this.
We also need to be able to do a partial save if we end up context
switching.  This seems rather complicated.

Last time I measured it (on Skylake IIRC), a full save was only about
twice as slow as a save that saved nothing at all, so I think we'd
need numbers.
