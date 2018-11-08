Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A34CC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C32C20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C32C20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeKHU0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:26:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53010 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeKHU0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:26:32 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9jfF0LORUkr2; Thu,  8 Nov 2018 11:51:37 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5CDF41EC0AC3;
        Thu,  8 Nov 2018 11:51:37 +0100 (CET)
Date:   Thu, 8 Nov 2018 11:51:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        rjw@rjwysocki.net, lenb@kernel.org, ard.biesheuvel@linaro.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181108105129.GA7543@zn.tnic>
References: <20181016191113.GI5212@zn.tnic>
 <20181016195429.tovdgqq77gz3eek2@gabell>
 <20181016195902.GK5212@zn.tnic>
 <20181022154204.kagmdb55jtoez4ca@gabell>
 <20181025103345.GF14020@nazgul.tnic>
 <20181025134050.ggiir77ehntikbwg@gabell>
 <20181106184519.GA16391@zn.tnic>
 <20181106193636.svyjwuwrlgnpuyyf@gabell>
 <20181106204511.GO13712@zn.tnic>
 <20181106222133.lb7674yzszivzihd@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181106222133.lb7674yzszivzihd@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 05:21:34PM -0500, Masayoshi Mizuma wrote:
> On Tue, Nov 06, 2018 at 09:45:11PM +0100, Borislav Petkov wrote:
> > On Tue, Nov 06, 2018 at 02:36:38PM -0500, Masayoshi Mizuma wrote:
> > > Yes, I think I can see what you are saying. However, I'm not sure how
> > > I use the setup_data in legacy BIOS environment.
> > 
> > What is "legacy BIOS environment" and what does that have to do with
> > setup_data?
> 
> My proposed patch [1] is useful only for EFI environment. The patch
> allocates a setup_date structure by efi_call_early() and store the
> KASLR data into the memory area.
> 
> +static void setup_kaslr(struct boot_params *params)
> +{
> +	struct setup_data *kaslr_data = NULL;
> +	struct setup_data *data;
> +	unsigned long size;
> +	efi_status_t status;
> +
> +	size = sizeof(struct setup_data) + sizeof(unsigned long long);
> +
> +	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
> +			size, (void **)&kaslr_data);
> 
> I'm not sure how I allocate such memory on no EFI environment.

A global definition which doesn't need allocation?

Maybe hpa would have another, better idea...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
