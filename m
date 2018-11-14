Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196AFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6AF2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6AF2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeKNV25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:28:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56978 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbeKNV25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:28:57 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IAXa0CHwVd4C; Wed, 14 Nov 2018 12:26:05 +0100 (CET)
Received: from zn.tnic (p200300EC2BD0D200D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:d200:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E786A1EC0322;
        Wed, 14 Nov 2018 12:26:04 +0100 (CET)
Date:   Wed, 14 Nov 2018 12:26:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, dyoung@redhat.com, bhe@redhat.com
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181114112600.GD13926@zn.tnic>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114072926.13312-2-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:29:25PM +0800, Lianbo Jiang wrote:
> When load the kernel image and initramfs by kexec_file_load syscall, it can
> not add exact e820 reserved type to kdump kernel e820 table.
> 
> Kdump uses walk_iomem_res_desc() to iterate io resources, then adds matched
> desc to e820 table for kdump kernel. But, when convert the e820 type into
> the iores descriptors, several e820 types are converted to 'IORES_DES_NONE'
> in this function e820_type_to_iores_desc(). So the walk_iomem_res_desc()
> will get these unnecessary types(E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE
> _KERN) when iterate io resources by the 'IORES_DES_NONE'.
> 
> It needs filter out these redundant type(such as E820_TYPE_RAM/E820_TYPE_
> UNUSABLE/E820_TYPE_KERN) in order to add exact e820 reserved type to kdump
> kernel e820 table. Thus it also needs an extra checking in memmap_entry_
> callback() to match the e820 type and resource name.

Ok, it took me a while to parse what this is trying to say so let's
start from the top:

* What resource type do you do need in the second kernel?

* The most important question: why?

* If it is the reserved resource, why aren't you adding
IORES_DESC_RESERVED or so which to look for instead of this hacky string
comparison?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
