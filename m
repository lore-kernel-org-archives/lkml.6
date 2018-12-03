Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C7BC07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390A020834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iSNXKpWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390A020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbeLCLOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:14:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44072 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbeLCLOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:14:41 -0500
Received: from zn.tnic (p200300EC2BC7BF00C47B40F3AA4BC2FE.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:bf00:c47b:40f3:aa4b:c2fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B13D1EC0322;
        Mon,  3 Dec 2018 12:14:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543835644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQ+3yACT2kXDF5NJMH2iOdIIz/SxsMvlCkZ8iGTE7bY=;
        b=iSNXKpWSO2Cn1cdngPrnnkq6N9qudprZh4CBD86T+1+HKs+we0atVJsZQMtTz/39RfiS8I
        0WqKx3L9H9RLXx/D3v9ILaifNybD/29uPcUdnZT9IY8y8S2cLNz+d1+8qB7r2oE5JJNE7J
        lT9Pj++HcgF/98tS7vEUMaL8lbksYsI=
Date:   Mon, 3 Dec 2018 12:13:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Xen-devel List <xen-devel@lists.xen.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Beulich <JBeulich@suse.com>,
        Brian Woods <brian.woods@amd.com>,
        SuraveeSuthikulpanit <suravee.suthikulpanit@amd.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijeshkumar.singh@amd.com>
Subject: Re: AMD EPYC Topology problems
Message-ID: <20181203111359.GA31670@zn.tnic>
References: <7369db0c-4917-0807-eef4-cba5e5ae0d4e@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7369db0c-4917-0807-eef4-cba5e5ae0d4e@citrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 08:23:05PM +0000, Andrew Cooper wrote:
> Hello,
> 
> I have dual socket server with the following processor:
> 
> [root@xrtmia-09-01 ~]# head /proc/cpuinfo 
> processor	: 0
> vendor_id	: AuthenticAMD
> cpu family	: 23
> model		: 1
> model name	: AMD EPYC 7281 16-Core Processor
> stepping	: 2
> 
> Which has highlighted a issue in the topology derivation logic. 
> (Actually, it was discovered with Xen, but we share the same topology
> infrastructure and the issue is also present with Linux).
> 
> There are a total of 64 threads in the system, made of two 32-thread
> sockets.  The APIC IDs for this system are sparse - they are 0x0-0x3,
> 0x8-0xb, 0x10-0x13 etc, all the way up to 0x7b.
> 
> This is because the socket is made of 4 nodes with 4 cores each, but
> space has been left in the layout for the maximum possible number of
> APIC IDs.
> 
> In particular, CPUID 0x80000008:ecx reports 0x0000601f.  That is, an
> APIC ID shift of 6 (reporting a maximum of 64 threads per socket), and
> NC as 31 (reporting 32 threads per socket in the current configuration).
> 
> c->x86_max_cores is derived from NC and shifted once to exclude threads,
> giving it a final value of 16 cores per socket.

So far so good.

> Given the sparseness of the APIC IDs, it is unsafe to allocate an array

Do we do this somewhere or is this a hypothetical thing?

> of c->x86_max_cores entries, then index it with c->cpu_core_id, as half
> the cores in the system have a cpu_core_id greater than x86_max_cores. 

You lost me here. ->cpu_core_id comes from CPUID_Fn8000001E_EBX[7:0].
Are you saying, those core IDs on your box are sparse like the APIC IDs
you mention above?

> There is no logical core ID derived during boot which might be a safe to
> use as an index.
> 
> Furthermore, the documentation indicates that these values are expected
> to be per-package, while they are all actually per-socket (with up to 4
> nodes per socket) in the EPYC case.

From Documentation/x86/topology.txt:
"
  - cpuinfo_x86.x86_max_cores:

    The number of cores in a package. This information is retrieved via CPUID."

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
