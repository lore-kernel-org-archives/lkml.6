Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F3C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954682084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="CnXSmnHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfAUJT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:19:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51034 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfAUJT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:19:56 -0500
Received: from zn.tnic (p200300EC2BC625005DE3D5B66D6AB027.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:2500:5de3:d5b6:6d6a:b027])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FF891EC01B6;
        Mon, 21 Jan 2019 10:19:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548062394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qM8uOzEO8hqOV68rWBgYNkCpQYriFK9dvd7WXZvqU3k=;
        b=CnXSmnHh8uHSeyx1pXYzqcoIcf6zobPYI6Ru8FgYbkZO1y+hgb8F96ZuGU+XJGpcu6Sy/3
        Zo4ICwckwJsupegeTWps6nLrQiccSBfHZJAgkMna+iZ8opVB8JrOMV2RQhmmPF60ajzlX7
        ml9gTGQZl4HsSfjuaV0jx3eF0zztsXA=
Date:   Mon, 21 Jan 2019 10:19:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        akpm@linux-foundation.org, robert.moore@intel.com,
        erik.schmauss@intel.com, rafael.j.wysocki@intel.com,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
Message-ID: <20190121091939.GC29166@zn.tnic>
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic>
 <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190118102636.GB622@zn.tnic>
 <20190121011830.GA1554@localhost.localdomain>
 <20190121082932.GA29166@zn.tnic>
 <20190121084352.GA15754@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121084352.GA15754@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 04:43:52PM +0800, Chao Fan wrote:
> Since I didn't see where Xen to fill the value, if
> boot_params->acpi_rsdp_addr is filled before my code, I just need to
> read it. If when I try to read it but not found, then parse RSDP and
> fill the RSDP address to boot_params->acpi_rsdp_addr.

And you can't simply do:

	if (boot_params.acpi_rsdp_addr)
		return;

at the beginning of that function?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
