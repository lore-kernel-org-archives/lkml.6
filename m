Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D436EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898002089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898002089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeKSUvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:51:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37512 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbeKSUvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:51:35 -0500
Received: from zn.tnic (p200300EC2BE2B700F95221CD056129B8.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:b700:f952:21cd:561:29b8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E43C1EC01B6;
        Mon, 19 Nov 2018 11:28:20 +0100 (CET)
Date:   Mon, 19 Nov 2018 11:28:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>, lijiang <lijiang@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, akpm@linux-foundation.org, bhe@redhat.com
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181119102812.GA14688@zn.tnic>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
 <20181119095515.GC14045@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119095515.GC14045@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:55:15PM +0800, Dave Young wrote:
> Another thing is it is not worth to get the exact info, the 1st kernel
> reserved part is just fine to be reserved as well in 2nd kernel, no 
> side effects.  Actually there might be some obscure use cases we
> do not find which rely those reserved memory ranges so it is better to
> have.

That makes sense as an argument. The cleaner thing would be to figure
out only *which* ranges we're going to need but that is probably harder
than simply exporting what the first kernel sees. But why we're doing
it, needs to be in the commit message so that it is clear when bug
hunting later.

...

> The basic problem is that this device is in PCI segment 1 and
> the kernel PCI probing cannot find it without all the e820 i/o
> reservations being present in the e820 table. And the crash kernel
> does not have those reservations because the kexec command does not
> pass i/o reservation via the memmap= command line option. (This
> problem does not show up for other vendors, as SGI is apparently the
> only one using extended PCI. The lookup of devices in PCI segment 0
> actually fails for everyone, but devices in segment 0 are then found
> by some legacy lookup method.) The workaround for this is to fix kexec
> to pass i/o reserved areas to the crash kernel.

Yap, this is the *why* I'm looking for. Lianbo, in your next submission,
please add Dave's explanations to your commit messages.

If it says "we need to do X" in the commit message, without a reason
given *why* we need to, then there's no way for us to know *why* we did
it, when looking at this months from now. And we absolutely need the
*why* when staring at the code and fixing the next bug/issue.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
