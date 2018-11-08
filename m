Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141EFECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76B2206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76B2206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeKIC7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:59:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41660 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbeKIC7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:59:03 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y35k2CV3_SyP; Thu,  8 Nov 2018 18:22:33 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B05681EC0A1D;
        Thu,  8 Nov 2018 18:22:33 +0100 (CET)
Date:   Thu, 8 Nov 2018 18:22:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Matz <matz@suse.de>
Cc:     Yi Wang <wang.yi59@zte.com.cn>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        suravee.suthikulpanit@amd.com, puwen@hygon.cn,
        davidwang@zhaoxin.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH v2] x86/cpu: fix prototype warning
Message-ID: <20181108172225.GH7543@zn.tnic>
References: <1541639548-11149-1-git-send-email-wang.yi59@zte.com.cn>
 <20181108150318.GD7543@zn.tnic>
 <20181108153226.GF7543@zn.tnic>
 <alpine.LSU.2.21.1811081538120.21712@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1811081538120.21712@wotan.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:47:32PM +0000, Michael Matz wrote:
> What tglx said.  If you don't intend such functions to be called 
> from other units make them static, if you do intend them to be callable 
> declare the properly.
> 
> [There's also one subtle issue with argument promotions.  prototypeless 
> functions are called as if they are declared "int name()" that is 
> default argument promotions take place (float->double, {char,short}->int), 
> which won't happen with prototypes, and argument type conversions won't 
> take place (as no parameter types are known).  This might lead to 
> different values between calling a prototyped and a prototype-less 
> function arriving at the function even though the call expression looked 
> the same]

Eww, that's yucky.

Ok, so we should enalbe this warning by default then. And doing that in
the main Makefile gives ~1400 warnings on an allmodconfig build.

Yi Wang, I guess you have a long road in front of you. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
