Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E67BC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1017420870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jm9jiu+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1017420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbeLLJ7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:59:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59110 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbeLLJ7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:59:48 -0500
Received: from zn.tnic (p200300EC2BCDD8002DC08A63FFF8C6E5.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:d800:2dc0:8a63:fff8:c6e5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 64C851EC0432;
        Wed, 12 Dec 2018 10:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544608786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kCMnAg6KQ41PrBTldao0PLns3z+P7Bxi84CxeA2ECM4=;
        b=jm9jiu+MdBNL//yrYUnXeuRRPQ28V2KZYsmTwGIDCOmfhaW7SOT45knHgX/LhN/PyP7uHZ
        yJsjqe0zTx41zUmR6ut08XILQmkVCVAXd9AsDi+JwlABmt+asumonPHB0maB0ARdc6D3Y5
        dzDxQmAsjZsce0rcFVD+ASSc7TXNSjA=
Date:   Wed, 12 Dec 2018 10:59:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] x86/speculation: Add support for STIBP always-on
 preferred mode
Message-ID: <20181212095938.GA6653@zn.tnic>
References: <20181211224615.5373.65736.stgit@tlendack-t1.amdoffice.net>
 <20181212000518.GX27375@zn.tnic>
 <alpine.DEB.2.21.1812111910520.22893@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812111910520.22893@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 07:37:26PM -0800, Thomas Gleixner wrote:
> Hmmm. I've not seen the V1 of this (it's not in my inbox) but the v1->v2
> changes contain:

You're on CC:

https://lkml.kernel.org/r/20181211190959.28321.56433.stgit@tlendack-t1.amdoffice.net

> 
> > > - Removed explicit SPECTRE_V2_USER_STRICT_PREFERRED mode
> 
> Now I really have to ask why?
> 
> Neither the extra variable nor the cpu feature check are pretty. An
> explicit mode is way better in terms of code clarity and you get the proper
> printout via spectre_v2_user_strings.

Actually, now that I've slept on it, I think we should do this just
like X86_FEATURE_IBRS_ENHANCED - as a modifier for SPECTRE_V2_CMD_AUTO
or _FORCE options.

And that has its own mode SPECTRE_V2_IBRS_ENHANCED.

Makes sense?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
