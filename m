Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A224C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16784208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTdIQtZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16784208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389075AbeKOIcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:32:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388219AbeKOIci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:32:38 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B3222419;
        Wed, 14 Nov 2018 21:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542232480;
        bh=ku/m8oJ/yMjnlDfVTMOykKrf4v5YJCtFLWLT0/11K2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTdIQtZNXYWr9pzGTAlw0oUye0lBiJKPjtvtlsd5Jx+Ti4Q+3gjFVP1ro48HxbpMg
         pbrp5IUX0WT5sY08acZHNIEROzjsLQDGRB9qVh1S26q/jq4BQQvGWxZdJj2CChHcoW
         XG2T+Ut1j7aUTtzkr/eFPAQ9CrEQ8WpiwWWwWAzU=
Date:   Wed, 14 Nov 2018 13:54:39 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, Yunlong Song <yunlong.song@huawei.com>,
        yunlong.song@icloud.com, miaoxie@huawei.com,
        bintian.wang@huawei.com, shengyong1@huawei.com,
        heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: avoid GC causing encrypted file corrupted
Message-ID: <20181114215439.GA45824@jaegeuk-macbookpro.roam.corp.google.com>
References: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
 <19e63fa7-1a48-c1de-eef5-cde242e8300d@kernel.org>
 <5c3d6053-e03a-8c61-0a07-07d0090ba349@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3d6053-e03a-8c61-0a07-07d0090ba349@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13, Chao Yu wrote:
> Jaegeuk,
> 
> On 2018/9/18 21:21, Chao Yu wrote:
> > On 2018/9/18 20:39, Yunlong Song wrote:
> >> The encrypted file may be corrupted by GC in following case:
> >>
> >> Time 1: | segment 1 blkaddr = A |  GC -> | segment 2 blkaddr = B |
> >> Encrypted block 1 is moved from blkaddr A of segment 1 to blkaddr B of
> >> segment 2,
> >>
> >> Time 2: | segment 1 blkaddr = B |  GC -> | segment 3 blkaddr = C |
> >>
> >> Before page 1 is written back and if segment 2 become a victim, then
> >> page 1 is moved from blkaddr B of segment 2 to blkaddr Cof segment 3,
> >> during the GC process of Time 2, f2fs should wait for page 1 written back
> >> before reading it, or move_data_block will read a garbage block from
> >> blkaddr B since page is not written back to blkaddr B yet.
> >>
> >> Commit 6aa58d8a ("f2fs: readahead encrypted block during GC") introduce
> >> ra_data_block to read encrypted block, but it forgets to add
> >> f2fs_wait_on_page_writeback to avoid racing between GC and flush.
> >>
> >> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> > 
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> I've reviewed this patch, could you add missing tag in the patch located in
> dev-test branch?

Sorry, done.

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > .
> > 
