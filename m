Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99704C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBB92148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iORd3f0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBB92148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404408AbeKTDwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:52:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52980 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404132AbeKTDwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:52:09 -0500
Received: from zn.tnic (p200300EC2BE2B700F95221CD056129B8.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:b700:f952:21cd:561:29b8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A23B1EC00E5;
        Mon, 19 Nov 2018 18:27:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542648464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+nCaKca84G6GCfmpWOkDvjedl4azQCgcrDGPbOSr8Dg=;
        b=iORd3f0bR81E6tHmdRODEKWh4Bnze8ypjParmx2bQV2odOPkMF3rTztj3qZ0fgZmJxeN0B
        jEfJQDRNKiAzEIawU7WgASFK27jpR+1nJ9Ad1iT0ImrLpILjNY2tId65ePFi9kzAANNf7p
        aVq4gmjRKt0cM0QCRxj8ndlr+yG/SyA=
Date:   Mon, 19 Nov 2018 18:27:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] x86/fpu: Disable BH while while loading FPU registers
 in __fpu__restore_sig()
Message-ID: <20181119172743.GE14688@zn.tnic>
References: <20181119160410.ne7oiq2gkwt6jiqg@linutronix.de>
 <b8684952-69ab-d79d-7fc0-89c0f4745049@intel.com>
 <20181119171128.2lxnhga3pym2zlok@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119171128.2lxnhga3pym2zlok@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 06:11:29PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-11-19 09:02:45 [-0800], Dave Hansen wrote:
> > On 11/19/18 8:04 AM, Sebastian Andrzej Siewior wrote:
> > > v1…v2: A more verbose commit as message.
> > 
> > I was really hoping for code comments. :)
> 
> I though we agreed to make those in the larger series because those
> comments in __fpu__restore_sig() would be removed anyway (as part of the
> series).

Also, over local_bh_disable() does not really fit as this is generic
code and Sebastian said ARM does the whole thing a bit differently, for
one.

We probably should put that comment somewhere prominent in
arch/x86/kernel/fpu/core.c or similar - somewhere people poking at FPU
stuff will see it.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
