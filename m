Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF7CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E925F2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FmyCIeCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E925F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeLKSvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:51:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37512 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbeLKSvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:51:09 -0500
Received: from zn.tnic (p200300EC2BCD2B00A9CB44BC54679BA1.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:a9cb:44bc:5467:9ba1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7EA11EC0BAA;
        Tue, 11 Dec 2018 19:51:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544554267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oZZINlvYBbDILPSJNpIxdmlDy8Lws0mbvmdR00LVZZU=;
        b=FmyCIeCmzyiLWVqKFDGNlbko/62SDCQE8+iZPQ9RraYiHbOFtCI1B0kchbZAjesytNoYss
        VG9/sEja53DR07rDWx5+IrmSWPMlnF+dFnPv6lHRKHKMxG7Z2m1Ue1nRaeMLjhK0/LnRza
        buisavFau49uPKwYvdl6cueamZnSxBM=
Date:   Tue, 11 Dec 2018 19:50:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V2] x86/intel_rdt: Ensure usage of CPUs are locked while
 needed
Message-ID: <20181211185059.GP27375@zn.tnic>
References: <b7b17432a80f95a1fa21a1698ba643014f58ad31.1544476425.git.reinette.chatre@intel.com>
 <20181211123404.GC27375@zn.tnic>
 <ece2581e-d5e5-c26c-53e5-0cef8b37e59f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ece2581e-d5e5-c26c-53e5-0cef8b37e59f@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:33:59AM -0800, Reinette Chatre wrote:
> I am not sure that this is an issue when updating a schemata in the
> general case. In the case when just CAT schemata (without
> pseudo-locking) is updated then the cpu mask associated with the cache
> instance is indeed used to determine which CPUs should have their
> registers changed but only the current CPU is not checked for being
> online, for the other CPUs smp_call_function_many() is used that
> includes an online check.

Well, in your fix rdtgroup_schemata_write() disables hotplug for its
whole duration and doesn't look at what schemata update is being done,
right?

> I had the same question in V1's notes to the maintainer :)

Whoops, and I read that... Sorry. :-\

> My initial concern was the lack of IS_ERR checking. Understanding the
> flow better now it seems to me that this is indeed not a bug now. The
> reasoning is that an ERR_PTR is only returned when a negative id is
> provided in the parameters to rdt_find_domain(). There are currently
> only two places where a negative id could be provided to
> rdt_find_domain(), domain_add_cpu() and domain_remove_cpu(), and both
> locations test the return value using IS_ERR.

Right. I'll queue it for the normal merge window.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
