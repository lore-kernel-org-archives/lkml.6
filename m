Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A264C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183FF20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="c+XCp3F7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183FF20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeKXHxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:53:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35236 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeKXHxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:53:43 -0500
Received: from zn.tnic (p200300EC2BDC9100DCA0409AA15535E1.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:9100:dca0:409a:a155:35e1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25B761EC02D1;
        Fri, 23 Nov 2018 22:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543007268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/vX8gulj6vukEfIyQl5O8Rn5krafebFNqMpo0kP8ZU4=;
        b=c+XCp3F7a86lbVRP6s1hBICDmCRehAyS1IddbCWT/+WvMfqFGHaEA7ZRHvqIYVXMm9jvKj
        OrW4SyGgH6TqgL4V55CfnDu5ppzGW0vVW4pRKeUovMmlcY26s/bzUFu86i0HSGcO0RFPe3
        b4IdHYv3/Y0ui56iGBKewSvaF8uwf4w=
Date:   Fri, 23 Nov 2018 22:07:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/TSC: Use RDTSCP
Message-ID: <20181123210739.GO30697@zn.tnic>
References: <20181119184556.11479-1-bp@alien8.de>
 <20181123200307.GA6223@roeck-us.net>
 <20181123204425.GN30697@zn.tnic>
 <901af2a0-e0d7-586d-5f04-2066cf1ac871@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <901af2a0-e0d7-586d-5f04-2066cf1ac871@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 01:03:25PM -0800, Guenter Roeck wrote:
> It is a cut off screen log. x86 boots change xterm configuration from
> wrap to non-wrap, and I did a cut-and-paste instead of copying the log
> to a file. Sorry for that.

No worries.

It was a head-scratcher though because look what it decodes to with the
'b':

[ 0.854209] Code: 90 90 90 90 90 90 90 a1 84 37 11 cd c3 8d b4 26 00 00 00 00 8d 76 00 c3 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00 90 55 89 e5 <0f> ae f0b 0f 31 5d c3 8d b6 00 00 00 00 55 89 e5 57 31 ff 56 53 89
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
  2a:*  0f ae 0b                fxrstor (%ebx)          <-- trapping instruction
  2d:   0f 31                   rdtsc
  2f:   5d                      pop    %ebp
  30:   c3                      ret

FXRSTOR?!?!?

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
