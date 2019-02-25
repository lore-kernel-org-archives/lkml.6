Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02C6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837772084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ihZGzOlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfBYJp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:45:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36490 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfBYJp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:45:26 -0500
Received: from zn.tnic (p200300EC2BC68000F50265612EF4EB95.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:8000:f502:6561:2ef4:eb95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 81E471EC0253;
        Mon, 25 Feb 2019 10:45:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551087925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5VDVzRtTdq1HCi3echiZWyul8dtalC0Wv7Xs0hXLp0E=;
        b=ihZGzOlxowqNIyzzvj073tz6/ROkm0sQYyoKBL6Geop3mbPUvKDEhigC5PT/icrGDqHIfM
        7GM2ajZaRGPQLpNhmIpACzW31ERDqDChKAvpixDRrT/zqz95yBSRlghTNwoPPKURi252wm
        j7tk48DQJBHDQLBVcLWZQVSHiQuHPmY=
Date:   Mon, 25 Feb 2019 10:45:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/KASLR: skip the specified crashkernel reserved
 region
Message-ID: <20190225094522.GC26145@zn.tnic>
References: <1551081596-2856-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551081596-2856-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 03:59:56PM +0800, Pingfan Liu wrote:
> crashkernel=x@y option may fail to reserve the required memory region if
> KASLR puts kernel into the region. To avoid this uncertainty, making KASLR
> skip the required region.

Lemme see if I understand this correctly: supplying crashkernel=X@Y
influences where KASLR would put the randomized kernel. And it should be
the other way around, IMHO. crashkernel= will have to "work" with KASLR
to find a suitable range and if the reservation at Y fails, then we tell
the user to try the more relaxed variant crashkernel=M.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
