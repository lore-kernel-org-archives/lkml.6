Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3702C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F81217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bOeAn9H1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfBFPVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:21:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59340 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbfBFPVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:21:53 -0500
Received: from zn.tnic (p200300EC2BCEF1005C27BB339FB20F69.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:f100:5c27:bb33:9fb2:f69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90B9D1EC0253;
        Wed,  6 Feb 2019 16:21:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549466512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=r7L2QRjbby7JI5M+tVwgkVMWvJYnfojKDjotPL68V7g=;
        b=bOeAn9H1j1wkInEudzs/owyFBmiNZ8coCdK+ILIXeugoMvF5XGuGcWgcSTGj7FfcjgximQ
        RvILHz9tj5iFHRi1L24dpg+vlpayUcCBV2O0eEDfc13WWwIpDKg5JlROCGvw68UuVx+YUk
        Ty3lqZahPOD0kSz28MA2cqv7rfHYlGQ=
Date:   Wed, 6 Feb 2019 16:21:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Kyle D Pelton <kyle.d.pelton@intel.com>,
        Wei Huang <wei@redhat.com>
Subject: Re: [PATCH] x86/boot/compressed/64: Do not corrupt EDX on EFER.LME=1
 setting
Message-ID: <20190206152141.GF7314@zn.tnic>
References: <20190206115253.1907-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190206115253.1907-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 02:52:53PM +0300, Kirill A. Shutemov wrote:
> RDMSR in the trampoline code overrides EDX, but we use the register to
> indicate if 5-level paging has to enabled. It leads to failure to boot
> on a 5-level paging machine.
> 
> Preserve EDX on the stack while we are dealing with EFER.

Comment says:

 * Non zero RDX on return means we need to enable 5-level paging.

Is that per-chance refering to struct paging_config which
paging_prepare() returns and on that return rdx contains
paging_config.l5_required which is 1 when 5 level is to be enabled?

If so, is that written somewhere explicitly? Because it is not
immediately clear at least to me why that RDX is live...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
