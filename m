Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB21C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C52D217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545039222;
	bh=onqeb3V3UzNDrcqV6sesPFdQ71omU6nOFDuW396hAd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mOqXwiGUnkMEqhL/w671AF4dQF71t+THVsxPz9lzfyzMqbx5y917BLT3kI0yidmcH
	 el4gwMqLoBfvXCPVZx2TONcfVS3ZxVB/iSeeL6rDHNYjYRj4cMIjUE/XaxCKCg+iav
	 VFIL1JaEwNCkbwpflGa5b8QgQrC+v0QYNxcqspR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbeLQJdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:33:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:35512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731756AbeLQJdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:33:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D033DAE4B;
        Mon, 17 Dec 2018 09:33:38 +0000 (UTC)
Date:   Mon, 17 Dec 2018 10:33:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hou Tao <houtao1@huawei.com>, phillip@squashfs.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] squashfs: enable __GFP_FS in ->readpage to prevent hang
 in mem alloc
Message-ID: <20181217093337.GC30879@dhcp22.suse.cz>
References: <20181204020840.49576-1-houtao1@huawei.com>
 <20181215143824.GJ10600@bombadil.infradead.org>
 <69457a5a-79c9-4950-37ae-eff7fa4f949a@huawei.com>
 <20181217035157.GK10600@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217035157.GK10600@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 16-12-18 19:51:57, Matthew Wilcox wrote:
[...]
> Ah, yes, that makes perfect sense.  Thank you for the explanation.
> 
> I wonder if the correct fix, however, is not to move the check for
> GFP_NOFS in out_of_memory() down to below the check whether to kill
> the current task.  That would solve your problem, and I don't _think_
> it would cause any new ones.  Michal, you touched this code last, what
> do you think?

What do you mean exactly? Whether we kill a current task or something
else doesn't change much on the fact that NOFS is a reclaim restricted
context and we might kill too early. If the fs can do GFP_FS then it is
obviously a better thing to do because FS metadata can be reclaimed as
well and therefore there is potentially less memory pressure on
application data.
-- 
Michal Hocko
SUSE Labs
