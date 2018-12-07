Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9508C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B79920838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YvYkgvE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B79920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLGKZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:25:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48570 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeLGKZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:25:50 -0500
Received: from zn.tnic (p200300EC2BCEC90030FF5A381F5D9977.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:c900:30ff:5a38:1f5d:9977])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B10F71EC0B1A;
        Fri,  7 Dec 2018 11:25:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544178348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Lyl0Tx6XlPxJXvouaiHOPHNvDZVz1XbcyHoYKKWiPA0=;
        b=YvYkgvE/UvyhOjmzCBooe6uxGI1HoqVGQRqGgQDfIbwNGUlYRHaC17GHM/bvOdwPdnjXrv
        WwmJkcZd5TrNOexkdXOKt3BU7h57EI09qhIDTbIyvViYG18ELIXSFja8oaBvvAbhgY4npC
        SoO1mIIhyI4rmNgPfMv5DTVaQU38O10=
Date:   Fri, 7 Dec 2018 11:25:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Maran Wilson <maran.wilson@oracle.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jgross@suse.com, bp@suse.de,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, hpa@zytor.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        mchehab@kernel.org, mingo@redhat.com, rdunlap@infradead.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, hch@infradead.org,
        roger.pau@citrix.com, rkrcmar@redhat.com
Subject: Re: [PATCH v8 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
Message-ID: <20181207102546.GC9385@zn.tnic>
References: <1544076152-21637-1-git-send-email-maran.wilson@oracle.com>
 <e8ed34e7-f82a-2314-9919-185d48510715@redhat.com>
 <20181206213752.GL3986@zn.tnic>
 <147cc043-b0af-74e9-5259-8c7854f82d8b@oracle.com>
 <63756df6-6f0b-fdfa-932e-b53d173da5be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63756df6-6f0b-fdfa-932e-b53d173da5be@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 11:14:34PM +0100, Paolo Bonzini wrote:
> > There are some minor changes in non-xen x86 code so it would be good to
> > get x86 maintainers' ack.
> 
> It's not really code, only Kconfig (and I remarked on it just now), but
> it doesn't hurt of course.

Yeah, I don't see anything objectionable.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
