Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5CBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE84720831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LW9zkQ+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE84720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbeKTHFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:05:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41214 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728938AbeKTHFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:05:53 -0500
Received: from zn.tnic (p200300EC2BE2B700F95221CD056129B8.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:b700:f952:21cd:561:29b8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 050561EC06FB;
        Mon, 19 Nov 2018 21:40:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542660031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tkvbDbdSh7LZSDm5mylBSDPP17cxkrNCLU9z4Plxhb4=;
        b=LW9zkQ+UyyQr+5hgR5D90urlg10ucSAHzLtoTHcK8N7knIuAgdrweAS9J1X7WSQZ/JE/6h
        +uMJX9mZ8pV+tNeNcqU+9L8J+5EsRulcO8u7ITE2Fr4O8hZkH1X21UXwng2BiYhoi3ti86
        +Vc+vohroUzUA6Xkl2QT4tx7zIIUoXg=
Date:   Mon, 19 Nov 2018 21:40:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Tom Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/TSC: Use RDTSCP
Message-ID: <20181119204025.GL14688@zn.tnic>
References: <20181119184556.11479-1-bp@alien8.de>
 <CALCETrV34q-BP2w8A1s82-a8Hg062=RYzk+SCOa31W7ftsznPA@mail.gmail.com>
 <a1b79c06-ab34-e774-df6b-c98323b13bae@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1b79c06-ab34-e774-df6b-c98323b13bae@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 12:17:35PM -0800, H. Peter Anvin wrote:
> On 11/19/18 11:52 AM, Andy Lutomirski wrote:
> > 
> > I thought I benchmarked this on Intel at some point and found the
> > LFENCE;RDTSC variant to be slightly faster.  But I believe you, so:
> > 
> > Acked-by: Andy Lutomirski <luto@kernel.org>
> > 
> 
> As long as the difference isn't significant, the simplicity would seem to be a
> win.

Right, I think by simplicity you mean RDTSCP. :)

Also in the sense that you have a single instruction which gives you
that barrier of waiting for all older insns to retire before reading the
TSC vs two where you don't necessarily know what happens on the uarch
level. I mean, nothing probably happens but RDTSCP is still simpler :)

Also, hpa, isn't LFENCE; RDTSC and RDTSCP equivalent on Intel? In the
sense that RDTSCP microcode practically adds an LFENCE before reading
the TSC?

Because SDM says:

"The RDTSCP instruction is not a serializing instruction, but it does
wait until all previous instructions have executed and all previous
loads are globally visible."

which sounds pretty much like an LFENCE to me:

"LFENCE does not execute until all prior instructions have completed
locally, and no later instruction begins execution until LFENCE
completes."

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
