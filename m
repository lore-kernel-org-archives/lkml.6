Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03798C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA84D21902
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550074717;
	bh=+dsVqmrHA7YqMuFtOO9liuuXg7WvYJ/pQRPw864c2mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ufOPaeVthibSIJxA6dX7XnzXGA7CP+SzoAeoBbmbRabkMJC509xP3LN6+LPWBgKsl
	 rckqG+mMZd5K/LS8gDAbbc4NLUuv3eKf/7urJFRQaIX3xnJuDJFTDABIznIHxWytjR
	 adz42nkNQDHbGqruxE4R2KoUhnwx/gtTFADGnKjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392628AbfBMQSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:18:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:49098 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730572AbfBMQSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:18:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85ED4AD74;
        Wed, 13 Feb 2019 16:18:34 +0000 (UTC)
Date:   Wed, 13 Feb 2019 17:18:32 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, Pingfan Liu <kernelfans@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v3 2/2] mm: be more verbose about zonelist initialization
Message-ID: <20190213161832.GT4525@dhcp22.suse.cz>
References: <20190212095343.23315-3-mhocko@kernel.org>
 <20190213094315.3504-1-mhocko@kernel.org>
 <1433a7e9-87b2-7e8d-a87d-dcffe486635c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433a7e9-87b2-7e8d-a87d-dcffe486635c@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-02-19 08:14:50, Dave Hansen wrote:
> On 2/13/19 1:43 AM, Michal Hocko wrote:
> > 
> > We have seen several bugs where zonelists have not been initialized
> > properly and it is not really straightforward to track those bugs down.
> > One way to help a bit at least is to dump zonelists of each node when
> > they are (re)initialized.
> 
> Were you thinking of boot-time bugs and crashes, or just stuff going
> wonky after boot?

Mostly boot time. I haven't seen hotplug related bugs in this direction.
All the issues I have seen so far is that we forget a node altogether
and it ends up with no zonelists at all. But who knows maybe we have
some hidden bugs where zonelists is initialized only partially for some
reason and there is no real way to find out.

> We don't have the zonelists dumped in /proc anywhere, do we?  Would that
> help?

I would prefer to not export such an implementation detail into proc

-- 
Michal Hocko
SUSE Labs
