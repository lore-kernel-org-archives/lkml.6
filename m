Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C253CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A80C20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lON9v+LK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A80C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeK0E74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:59:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37934 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbeK0E74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:59:56 -0500
Received: from zn.tnic (p200300EC2BDEFE00DCA0409AA15535E1.dip0.t-ipconnect.de [IPv6:2003:ec:2bde:fe00:dca0:409a:a155:35e1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F0D1F1EC0322;
        Mon, 26 Nov 2018 19:05:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543255502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ChvP+UjJ7prXGEQ3jKDqJr2y9tMZ8xxMzhAsQHE/AzQ=;
        b=lON9v+LKRr14FAl7ApzmzkGLHJFg/Bp1B+/K7WuJVpVSdH36rMceiqaTPLHCSRN0Dzwy+7
        akztekR99vEZ58HadsS7Qc1FydMIJVHNieZ2n94hvpyBQxlz7iU3m4qmR4if/otRnJ6ycn
        Ilz8lYkSmsLQ3rskFTPHDOlc+E+CNdc=
Date:   Mon, 26 Nov 2018 19:04:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        ard.biesheuvel@linaro.org, tony.luck@intel.com,
        fenghua.yu@intel.com, dyoung@redhat.com, bhe@redhat.com
Subject: Re: [PATCH 0/2 RESEND v7] add reserved e820 ranges to the kdump
 kernel e820 table
Message-ID: <20181126180455.GI4843@zn.tnic>
References: <20181124051223.19994-1-lijiang@redhat.com>
 <d457ed46-d983-20b2-ad7f-9eaa6d98f2bf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d457ed46-d983-20b2-ad7f-9eaa6d98f2bf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 09:44:46AM -0800, Dave Hansen wrote:
> On 11/23/18 9:12 PM, Lianbo Jiang wrote:
> > These patches add the new I/O resource descriptor 'IORES_DESC_RESERVED'
> > for the iomem resources search interfaces, and in order to make it still
> > work after the new descriptor is added, these codes originally related
> > to 'IORES_DESC_NONE' have been updated.
> 
> I'm having a really hard time figuring out what problem these patches solve.
> 
> What end-user visible behavior does this set change?

Yeah, that was a long process of digging out the "why".

I'd recommend reading the previous threads and, more specifically:

https://lkml.kernel.org/r/CABhMZUUscS3jUZUSM5Y6EYJK6weo7Mjj5-EAKGvbw0qEe%2B38zw@mail.gmail.com

in short: we need to export e820 reserved ranges to the second kernel so
that it can talk to PCI devices properly. (And I'm wondering how it did
work until now...)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
