Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B43CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CD9207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qSdPPtW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfBVNAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:00:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38718 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbfBVNAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:00:35 -0500
Received: from zn.tnic (p200300EC2BCB3900BC7373EE60FA5555.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:3900:bc73:73ee:60fa:5555])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA1B11EC0573;
        Fri, 22 Feb 2019 14:00:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550840434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UsgC/BzhkNyN1XCJF2SjocUn0g/+vyNcLraLnhaukGQ=;
        b=qSdPPtW1F/B5al7xdqUqQzgExYbKIgW+Fglj/bJNTlj4TmqvCgSxveMnpFEtZigo/4vKDm
        94wuYxuDZvHz4MkpNHvQ3Bou/4/E4a8w8bCfVFEbXIZ7GgOItVeCpQxL1rxMsmYuhHsF+n
        wCi/tJ5rrpXAX6rhuLhk9Yf3qdIg+yw=
Date:   Fri, 22 Feb 2019 14:00:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>, Dave Young <dyoung@redhat.com>
Cc:     bhe@redhat.com, Jerry Hoemann <jerry.hoemann@hpe.com>,
        x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190222130026.GA30766@zn.tnic>
References: <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
 <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
 <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190222084241.GC8380@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 09:42:41AM +0100, Joerg Roedel wrote:
> The current default of 256MB was found by experiments on a bigger
> number of machines, to create a reasonable default that is at least
> likely to be sufficient of an average machine.

Exactly, and this is what makes sense.

The code should try the requested reservation and if it fails, it should
try high allocation with default swiotlb size because we need to reserve
*some* range.

If that reservation succeeds, we should say something along the lines of

"... requested range failed, reserved <X> range instead."

And then in Documentation/admin-guide/kernel-parameters.txt above the
crashkernel= explanations, the allocation strategy of best effort should
be explained in short. That the kernel will try to allocate high if the
requested allocation didn't succeed and that the user can tweak the
allocation with the below options.

Bottom line is: the kernel should assist the user and try harder to
allocate *some* range for a crash kernel when there's no detailed
specification what that range should be.

*If* the user adds ,low, high, then the kernel should try only that
specified range because the assumption is that the user knows what she's
doing.

But if the user simply wants a range for a crash kernel without stating
where that range should be in particular and it's placement is a don't
care - as long as there is a range - then the kernel should simply try
high, etc.

Makes sense?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
