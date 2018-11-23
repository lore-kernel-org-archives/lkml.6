Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8E8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355FC20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YdYY8hk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355FC20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeKXHa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:30:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59780 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbeKXHa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:30:26 -0500
Received: from zn.tnic (p200300EC2BDC9100DCA0409AA15535E1.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:9100:dca0:409a:a155:35e1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 366721EC023A;
        Fri, 23 Nov 2018 21:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543005874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FxXMLAkRavY78RZwHdRkqS++IBNNyJojGCSQFBEgaM0=;
        b=YdYY8hk5OvmO3lspblHF4EmtELrEUbwqg7NSjp1tcJix8qatlBbQmUV2nqUyOHsWaV43L0
        x77HKkzTI2+1eI5ftjIheP8EB5cTglOA+7QTPmtiw8iU5bqy790vk5n8WrUKl0bPPRpxHV
        NkB3ZoRu+DaXnediWOI4sbJBV4Bejiw=
Date:   Fri, 23 Nov 2018 21:44:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/TSC: Use RDTSCP
Message-ID: <20181123204425.GN30697@zn.tnic>
References: <20181119184556.11479-1-bp@alien8.de>
 <20181123200307.GA6223@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181123200307.GA6223@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 12:03:07PM -0800, Guenter Roeck wrote:
> [    0.762832] EIP: read_tsc+0x4/0x10
> [    0.762832] Code: 00 01 00 eb 89 90 55 89 e5 5d c3 90 90 90 90 90 90 90 90 90 90 90 55 a1 44 5a 8b c5 89 e5 5d c3 8d b6 00 00 00 00 55 89 e5 57 <0f> ae f0b

Where does that 'b' in f0b come from?

But ok, I was able to reproduce and decode myself. So if the Code:
section is correct, qemu chokes on MFENCE.

[ 0.854209] Code: 90 90 90 90 90 90 90 a1 84 37 11 cd c3 8d b4 26 00 00 00 00 8d 76 00 c3 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00 90 55 89 e5 <0f> ae f0 0f 31 5d c3 8d b6 00 00 00 00 55 89 e5 57 31 ff 56 53 89
All code
========
   0:   90                      nop
   1:   90                      nop
   2:   90                      nop
   3:   90                      nop
   4:   90                      nop
   5:   90                      nop
   6:   90                      nop
   7:   a1 84 37 11 cd          mov    0xcd113784,%eax
   c:   c3                      ret    
   d:   8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
  14:   8d 76 00                lea    0x0(%esi),%esi
  17:   c3                      ret    
  18:   8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
  1f:   8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
  26:   90                      nop
  27:   55                      push   %ebp
  28:   89 e5                   mov    %esp,%ebp
  2a:*  0f ae f0                mfence          <-- trapping instruction
  2d:   0f 31                   rdtsc  
  2f:   5d                      pop    %ebp
  30:   c3                      ret    
  31:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
  37:   55                      push   %ebp
  38:   89 e5                   mov    %esp,%ebp
  3a:   57                      push   %edi
  3b:   31 ff                   xor    %edi,%edi
  3d:   56                      push   %esi
  3e:   53                      push   %ebx
  3f:   89                      .byte 0x89

Doing this:

        asm volatile(ALTERNATIVE_2("mfence", ...

fails too which confirms that P3 can't do MFENCE.

I need to think about how to handle that old cruft.

Thx for the report.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
