Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E731C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0DA2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuRf2I/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0DA2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeJXWol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJXWok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:44:40 -0400
Received: from jouet.infradead.org (unknown [189.40.65.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4158E2075D;
        Wed, 24 Oct 2018 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540390582;
        bh=B8XKSULsbsXw/XTmHXBM72/MDXxVBJICz3dRk+vlvAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IuRf2I/RL817y0rsbdSH00/pYMxaM8+A2TfeXh5J7CY4Va/9OOSUbfipOSkkbtvYN
         8X/Zs5T7R+VxQguHAtwFmTzOyxdB/36YtQD3wDNqhGVDNkeelM0ZyvLGsZC3Ia75Tj
         YGmlHmDjNcfbANnN2a88DU1o5ePUi7hN/cBqLp88=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id E9779142C5E; Wed, 24 Oct 2018 11:16:18 -0300 (-03)
Date:   Wed, 24 Oct 2018 11:16:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        David Miller <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 17/19] perf scripts python: exported-sql-viewer.py:
 Add All branches report
Message-ID: <20181024141618.GB15106@kernel.org>
References: <20181001062853.28285-18-adrian.hunter@intel.com>
 <20181023075949.18920-1-adrian.hunter@intel.com>
 <20181023181218.GB6114@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C2B8A4D@IRSMSX106.ger.corp.intel.com>
 <20181023192935.GD6114@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C2B8AA7@IRSMSX106.ger.corp.intel.com>
 <20181023200230.GE6114@kernel.org>
 <fa8d2495-0c47-c023-53dd-66718c2e1751@intel.com>
 <04a9bf3a-ff00-2331-d0a5-a3efcc4cdd94@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04a9bf3a-ff00-2331-d0a5-a3efcc4cdd94@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 24, 2018 at 04:56:03PM +0300, Adrian Hunter escreveu:
> However I found kernel disassembly doesn't work, I think due to:
 
>     commit edeb0c90df3581b821a764052d185df985f8b8dc
>     perf tools: Stop fallbacking to kallsyms for vdso symbols lookup
 
> As I mentioned here:
 
> https://lore.kernel.org/lkml/4c682937-3cee-6974-0970-68610e13ad37@intel.com/T/#u
 
> So I will look at a fix for that also.

Ok.

But then that function receives both the addr and the cpumode, so its
callers should take into account the mixed ip/addr cpumodes, i.e. if we
get a sample with an ip in kernel and an addr in userspace, all we know
is that the ip is in the kernel, so we can either check the x86-specific
(well, specific to archs that share the address space for kernel and
userspace) machine__kernel_ip(addr) and pass a kernel cpu mode to
thread__find_addr(), otherwise ask for thread__find(addr, cpumode=user),
no?

Since this is x86 specific stuff, using machine__kernel_ip(addr) to
figure out the addr cpumode seems the way to go, right?

- Arnaldo
