Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C5AC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EE420870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="q8Oomeaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EE420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeLKUnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:43:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57690 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeLKUnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:43:20 -0500
Received: from zn.tnic (p200300EC2BCD2B0010F6E1EC68D6BA6C.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:10f6:e1ec:68d6:ba6c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 630DD1EC0BFC;
        Tue, 11 Dec 2018 21:43:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544560998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=P44mgAMGgp3wj1POzEQZ98DJ1h8tqjLNtZ1yeU5l3ik=;
        b=q8OomeaqbcTq9hqdnwwTo79RmpzJXSOAsU0/CduhB3KSN5CJlezjIVWiA5mtbBAAPlT5wJ
        WV83Q76hZ8IVNULr4sg89SjD7iJBrZaGFl2zGqeDR7USIsxWWfvskShcc8+jg3Jz8Uijzn
        sXiLmrXoNgXlimAnxLsLYqjMJ/SF9CI=
Date:   Tue, 11 Dec 2018 21:43:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V2] x86/intel_rdt: Ensure usage of CPUs are locked while
 needed
Message-ID: <20181211204310.GQ27375@zn.tnic>
References: <b7b17432a80f95a1fa21a1698ba643014f58ad31.1544476425.git.reinette.chatre@intel.com>
 <20181211123404.GC27375@zn.tnic>
 <ece2581e-d5e5-c26c-53e5-0cef8b37e59f@intel.com>
 <20181211185059.GP27375@zn.tnic>
 <e4ef2e81-defd-c5ca-4892-a0361a4528ba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4ef2e81-defd-c5ca-4892-a0361a4528ba@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:02:08AM -0800, Reinette Chatre wrote:
> I just wanted to emphasize that it is not the schemata writing that
> needs to be protected, but instead the pseudo-locking code that runs
> after schemata programming that needs to run on a particular CPU. The
> new patch subject could be interpreted to mean the former ... but that
> is starting to sound like nitpicking by me.

Nah, that's not nitpicking - it is important that we sort out stuff
fully before committing.

Now, I'm trying to understand what you're telling me and I believe you
mean what update_domains() does, yes?

And I guess a more fitting subject in that case could be:

  x86/intel_rdt: Ensure a CPU remains online for the region's pseudo-locking sequence

or so, and then the commit message explains in more detail what that
title actually means. :)

Hmmm.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
