Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A9CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30BE2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IpXuvCbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfBDTnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:43:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55410 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfBDTnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:43:18 -0500
Received: from zn.tnic (p200300EC2BC6E200742B98B19C68EA29.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:e200:742b:98b1:9c68:ea29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8B551EC0A34;
        Mon,  4 Feb 2019 20:43:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549309397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kfG7PzMYHuJnMh+exa58XAI7OO8Juhc5ObS22KVWNZ0=;
        b=IpXuvCbcpgiw2Fhr95g4LiGgaEN8zbd4tKsnNhHcyhAHH2CvqXrF/GsSomcxjZ7w5VVc5X
        8sbQFYGwBaKDKMtRjN+vE2ecl/VKbYgagjiDbuDAD652CnFumHNJb7Ab2bqqcn45Ug7B2I
        yeVDXRjMlXlIFSbxajI3vW06izI1VF8=
Date:   Mon, 4 Feb 2019 20:43:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest
 filtering
Message-ID: <20190204194306.GI29639@zn.tnic>
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
 <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
 <20190204153827.GG17528@hirez.programming.kicks-ass.net>
 <20190204154411.GC17582@hirez.programming.kicks-ass.net>
 <90e071c0-cdf4-3a31-4e44-2c5b84af5fa3@linux.intel.com>
 <20190204162312.GJ17528@hirez.programming.kicks-ass.net>
 <2c429bbd-00fb-2e3a-7d58-27123400b722@linux.intel.com>
 <20190204181504.GH29639@zn.tnic>
 <134894ac-a43b-7ec7-f313-b5d8de357a7e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <134894ac-a43b-7ec7-f313-b5d8de357a7e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 01:57:49PM -0500, Liang, Kan wrote:
> You mean a given microcode revision X applying to multiple stepping,
> right?

Yes, the range thing. You specify a range of steppings:

kabylake mobile  with steppings 9-12
kabylake desktop with steppings 10-13

> I don't think so. I still think the KABYLAKE case is an uncommon case.

You mean it is uncommon because there are already *two* models which
need it or because this is only kabylake and it won't happen in the
future?

> Can we do something as below just for this case?

Of course not. _FOUR is just silly and if a *fifth* stepping appears,
you need to go fixup again.

If anything and if this kabylake thing is one off, I'd prefer we keep it
as is.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
