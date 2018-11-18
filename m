Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D78DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 11:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076C020815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 11:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="p1K5+xKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076C020815
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeKRWNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 17:13:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33464 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbeKRWNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 17:13:08 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542541979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LpswiqpyDdmIVYcCxoiyfMxBU6eW/IQJJlqgvKbipHk=;
        b=p1K5+xKHixk/9qLRXceitpCBxeW57opgo1qyfSzyk//giXLBvMPcswD0klk/CmpxlXqHfE
        evw6DxVbwWngULSd+/IwyYThXaPxAIc5chDtESUL6dX3+uXPPZ2ClmxDY4hENz0H+97TeK
        r4kWMlH/DcFtZ+OGqjj3DyzSicoK1jc=
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MaikabFO5jU8; Sun, 18 Nov 2018 12:52:59 +0100 (CET)
Received: from zn.tnic (p200300EC2BE2B7004D130AD2F34E6DE4.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:b700:4d13:ad2:f34e:6de4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDAAD1EC014B;
        Sun, 18 Nov 2018 12:52:56 +0100 (CET)
Date:   Sun, 18 Nov 2018 12:52:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, akpm@linux-foundation.org, dyoung@redhat.com,
        bhe@redhat.com
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181118115251.GB19380@zn.tnic>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
 <c3347d48-aa32-e8e4-c99b-baf2e6a21dc2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3347d48-aa32-e8e4-c99b-baf2e6a21dc2@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 11:25:55AM +0800, lijiang wrote:
> For the pci mmconfig issue, it should be good enough that the e820 reserved region
> [mem 0x0000000078000000-0x000000008fffffff] is only passed to the second kernel, but
> the pci mmconfig region is not the same in another machine.

Yes. And now the question is, *which* reserved regions need to be mapped
for the second kernel to function properly? How do we figure that out?

> A simple case, hotplug a pci network card and use the ssh/nfs to dump the vmcore.
> If the pci mmconfig region is not reserved in kdump kernel, the pci hotplug device
> could not be recognized. So the pci network card won't work.

Yes that's a good example; put *that* example in your commit message.

> Here, there is an example about SME kdump. Maybe it can help to better understand.

You keep pasting that and I've read it already. And you keep repeating
that the reserved regions need to be mapped in the second kernel and I'm
asking, how do we determine *which* regions should we pass to the second
kernel?

If we should pass *all* reserved regions, why?

IOW, I'm looking for the *why* first.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
