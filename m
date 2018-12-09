Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9712CC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4C820831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iUbDdHVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4C820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLIM47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 07:56:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbeLIM46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 07:56:58 -0500
Received: from zn.tnic (p200300EC2BE9200085D0D60429306F6C.dip0.t-ipconnect.de [IPv6:2003:ec:2be9:2000:85d0:d604:2930:6f6c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B93471EC078A;
        Sun,  9 Dec 2018 13:56:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544360216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kxR83dqUd/DanWYaS5GD+gD5h8+aW5SovCsHFRDAuu0=;
        b=iUbDdHVHADLQIqxWtxlpuHB36XQNvQMxgNMQwxTjOW7C7dkCvkyXeAxl8a8pSkhVuvhSyU
        KQvltGDyZ5SSrm03CmB/GOk7GAqR4gMDP/IYJDCd7kbmVG23jN/GGpG7ov3dDLY8vIOPfl
        lK6a6+PMDuLA6RABvRa5IySMI8xKIBc=
Date:   Sun, 9 Dec 2018 13:56:48 +0100
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
Message-ID: <20181209125648.GA15262@zn.tnic>
References: <7369db0c-4917-0807-eef4-cba5e5ae0d4e@citrix.com>
 <20181203111359.GA31670@zn.tnic>
 <9e392fcd-4829-afe4-6f36-73d5cf03ee7c@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e392fcd-4829-afe4-6f36-73d5cf03ee7c@citrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:23:49AM +0000, Andrew Cooper wrote:
> Right, but the documentation also states that where it says package, it
> means "Node" in AMD's terminology, and the information in CPUID is per
> socket, not per node.
> 
> My point is that the numbers ending up in cpuinfo_x86 don't match the
> semantics described by the documentation.

Ok, I think I know where the issue stems from:

	definition of "package" in the AMD docs != definition of "package" in Documentation/x86/topology.txt

AMD's is "Processor: A package containing one or more Nodes." whereas
ours is:

  "Packages contain a number of cores plus shared resources, e.g. DRAM
   controller, shared caches etc."

and physical sockets we don't care about because they're not relevant to
sw.

Yeah, lemme discuss this with tglx to refresh what we were thinking then. :)

Stay tuned.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
