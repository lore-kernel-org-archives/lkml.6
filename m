Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1526C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70DB2173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70DB2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbeHCMWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:22:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39474 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeHCMWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:22:08 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flXHs-0006PL-9O; Fri, 03 Aug 2018 12:26:24 +0200
Date:   Fri, 3 Aug 2018 12:26:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alistair Strachan <astrachan@google.com>
cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, kernel-team@android.com, joel@joelfernandes.com
Subject: Re: [PATCH] x86: vdso: Use $LD instead of $CC to link
In-Reply-To: <20180718224159.18236-1-astrachan@google.com>
Message-ID: <alpine.DEB.2.21.1808031223500.1745@nanos.tec.linutronix.de>
References: <20180718224159.18236-1-astrachan@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Alistair Strachan wrote:
>  export CPPFLAGS_vdso.lds += -P -C
>  
> -VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
> -			-Wl,--no-undefined \
> -			-Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096 \
> -			$(DISABLE_LTO)
> +VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
> +			-z max-page-size=4096 -z common-page-size=4096

Aside of the fact that it does not apply to upstream, why is this dropping
the $(DISABLE_LTO) part?

The changelog is utterly silent about that.

Thanks,

	tglx
