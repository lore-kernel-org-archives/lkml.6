Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D601C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB52E20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MoPcnpAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB52E20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeLKNSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:18:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43656 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeLKNSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:18:36 -0500
Received: from zn.tnic (p200300EC2BCD2B00BD72DD1FE93D9839.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:bd72:dd1f:e93d:9839])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDE101EC0BAA;
        Tue, 11 Dec 2018 14:18:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544534314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=O2ja6+sw44dlk32VxUC6G9dhbnuSlTN56i1/htLnlTc=;
        b=MoPcnpAVXvW4pU5V9q6q7EdT7AkSMbwwxwVcHVFo97wCNF3p5Hh43zrQZtsRRwY7CYjMXx
        N0JMMS1dTnzBAaQAL/JgPI50qddmqNeIIylSOwj2BR4QnDeXiElFaAZxnUmPL3cqaFgnZ4
        XOC1wC++bLNhpbbIv4ppLWSTGkkKKBA=
Date:   Tue, 11 Dec 2018 14:18:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Maran Wilson <maran.wilson@oracle.com>
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        bp@suse.de, dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, hpa@zytor.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        mchehab@kernel.org, mingo@redhat.com, rdunlap@infradead.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, hch@infradead.org,
        roger.pau@citrix.com, rkrcmar@redhat.com
Subject: Re: [PATCH v9 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
Message-ID: <20181211131825.GD27375@zn.tnic>
References: <1544468734-32763-1-git-send-email-maran.wilson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1544468734-32763-1-git-send-email-maran.wilson@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:05:34AM -0800, Maran Wilson wrote:
> For certain applications it is desirable to rapidly boot a KVM virtual
> machine. In cases where legacy hardware and software support within the
> guest is not needed, Qemu should be able to boot directly into the
> uncompressed Linux kernel binary without the need to run firmware.
> 
> There already exists an ABI to allow this for Xen PVH guests and the ABI
> is supported by Linux and FreeBSD:
> 
>    https://xenbits.xen.org/docs/unstable/misc/pvh.html
> 
> This patch series would enable Qemu to use that same entry point for
> booting KVM guests.

How would I do that, practically?

Looking at those here:

>  * Qemu and qboot RFC patches have been posted to show one example of how
>    this functionality can be used. Some preliminary numbers are available
>    in those cover letters showing the KVM guest boot time improvement.
>       Qemu:
>       http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg00957.html
>       qboot:
>       http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg00953.html

I might still need to do some dancing to get stuff going.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
