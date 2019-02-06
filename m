Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70952C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AD420844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q9XL504p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfBFOSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:18:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50158 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfBFOSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:18:05 -0500
Received: from zn.tnic (p200300EC2BCEF10055133BB909886643.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:f100:5513:3bb9:988:6643])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F9951EC0338;
        Wed,  6 Feb 2019 15:18:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549462683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6+r8WM1MY+7PnsC4p0VPh831+GeJusolDBDKvyGZyjI=;
        b=Q9XL504pPzDuYEQxYTDl/CNK37nFpAkZjvrMwW9hNxFpT7SaVMDGbIFnQJznrygWfM538q
        sU4wI6Du6aSgrESetqN8inM3xSfDezPnx8r+iQgn5mqPImw4LCUgF6xWUEpCVR4n0JSU8/
        wmp5IVt+UHoIQ9TSnrr1VCHLm+ZO+Is=
Date:   Wed, 6 Feb 2019 15:17:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Julian Stecklina <jsteckli@amazon.de>
Cc:     Julian Stecklina <js@alien8.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jschoenh@amazon.de,
        Dave Jiang <dave.jiang@intel.com>,
        Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] x86/boot: increase maximum number of avoided KASLR
 regions
Message-ID: <20190206141753.GE7314@zn.tnic>
References: <1548866403-13390-1-git-send-email-js@alien8.de>
 <1548866403-13390-2-git-send-email-js@alien8.de>
 <20190205144441.GS21801@zn.tnic>
 <ciirm8womdaxn2.fsf@u54ee758033e858cfa736.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ciirm8womdaxn2.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 01:50:57PM +0100, Julian Stecklina wrote:
> Because at this point, we are not in a good position to handle an
> unlimited amount of regions.

We could save only the regions which are ok to kaslr into. And we do,
apparently:

static struct slot_area slot_areas[MAX_SLOT_AREA];

but I guess there was a reason to do the mem_avoid thing too instead of
collecting only OK ranges directly. Maybe Kees will know.

> As for the choice of "16", I took our usecase and multiplied it by two.
> FWIW, this could be even larger.

Because our kernel is not fat enough huh?

Btw, you missed a spot:

static unsigned long find_random_phys_addr(unsigned long minimum,
                                           unsigned long image_size)
{
        /* Check if we had too many memmaps. */
        if (memmap_too_large) {
                debug_putstr("Aborted memory entries scan (more than 4 memmap= args)!\n");
								^^^^^^^^^^^^^
-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
