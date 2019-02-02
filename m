Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1618C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB792086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lXdRXZkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfBBPdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:33:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43274 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfBBPda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:33:30 -0500
Received: from zn.tnic (p200300EC2BDC2600410D52EDB16488FE.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:2600:410d:52ed:b164:88fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD0811EC0229;
        Sat,  2 Feb 2019 16:33:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549121609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FVkUz1AEMRcQwwFKaLDjP100bI8f4/B8agoUhhViTeY=;
        b=lXdRXZkh5TvD6PKXiNO8QKBnimOhKfPJD4coRZzs7LqSU8OdbNJrOnvh9PiPt39YIZK0ZJ
        1R9AONwFwGbdx6SktXmb62/ZQf33oDpgAM9y2/mI0zXNaq/HDjojmQruQF7a/8RfXLYlHY
        u4WQb3kb4FQ3H5FWhZoEb/2jdEt5RaM=
Date:   Sat, 2 Feb 2019 16:33:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Initialize "bank" when we find a fatal error in
 mce_no_way_out()
Message-ID: <20190202153318.GD27822@zn.tnic>
References: <20190201003341.10638-1-tony.luck@intel.com>
 <20190201095553.GC31854@zn.tnic>
 <20190201183616.GA24278@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190201183616.GA24278@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 10:36:17AM -0800, Luck, Tony wrote:
> > so it'll be more robust if we moved it there.
> 
> It would be redundant to move it there for both
> existing uses.

Maybe. But if the bank write happens there, it won't be "forgotten"
again.

I don't care what the functions are called. If they need to do something
more, like *fully* populating struct mce so that a proper record gets
logged further down the line, then we need to make them do so. That's
the point I'm trying to make.

Sure, the stable fix should be simple for easier backporting but in
order to avoid this thing happening again in the future, we should
probably look at unifying and making those paths easier to use.

Right now we have

1. mce_setup() - initial population of struct mce, called from
mce_gather_info(), a.o.
2. mce_gather_info() collects global regs
3. mce_read_aux() reading aux regs

and at the very end, we hand it into mce_log().

And in-between we poke (or don't poke) in some fields.

IOW, if the struct mce finishing population is concentrated in a single
function, it will be much harder to forget setting such fields in the
future.

In this case, the devil is in the detail so I'll have a look at this
when more time.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
