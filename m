Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96E5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763B120578
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545132755;
	bh=JeyvlRAfYtQIzsTlzgZTDBDm/+h6L7IqHRRkMI3+v7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T/12Fp/p7CMEqSGlHJ/Hp6n7eAW0J/DqgihwRUR0lfmFtveT/xjL4hdQNuc/lCrd8
	 pgLrpnq5Ji5Uw5ImrAAErBqHkK7oneazF5OI7uD7uWYuoHRR8HyNBTDTLrbpUdD0vP
	 iawwItWaC0p65ce1C//7dBnJWIFqskCeoML5RnGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeLRLce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:32:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:49422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbeLRLcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:32:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9D0BB14B;
        Tue, 18 Dec 2018 11:32:31 +0000 (UTC)
Date:   Tue, 18 Dec 2018 12:32:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Matthew Wilcox <willy@infradead.org>, phillip@squashfs.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] squashfs: enable __GFP_FS in ->readpage to prevent hang
 in mem alloc
Message-ID: <20181218113230.GI30879@dhcp22.suse.cz>
References: <20181204020840.49576-1-houtao1@huawei.com>
 <20181215143824.GJ10600@bombadil.infradead.org>
 <69457a5a-79c9-4950-37ae-eff7fa4f949a@huawei.com>
 <20181217035157.GK10600@bombadil.infradead.org>
 <20181217093337.GC30879@dhcp22.suse.cz>
 <00ff5d2d-a50f-4730-db8a-cea3d7a3eef7@I-love.SAKURA.ne.jp>
 <5ba9aba1-e00d-ae07-caf0-3e7eca7de4b6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba9aba1-e00d-ae07-caf0-3e7eca7de4b6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-12-18 14:06:11, Hou Tao wrote:
[...]
> In my understanding (correct me if I am wrong), there are three ways through which
> reclamation will invoked fs related code and may cause dead-lock:
> 
> (1) write-back dirty pages. Not possible for squashfs.

only from kswapd context. So not relevant to OOM killer/

> (2) the reclamation of inodes & dentries. The current file is in-use, so it will be not
>     reclaimed, and for other reclaimable inodes, squashfs_destroy_inode() will
>     be invoked and it doesn't take any locks.

There are other inodes, not only those in use. Do you use any locks that
could be taken from an inode teardown?
-- 
Michal Hocko
SUSE Labs
