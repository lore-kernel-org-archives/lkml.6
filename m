Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330B4C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD9A215B2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD9A215B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbeHOPgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 11:36:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:43392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbeHOPgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 11:36:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6059AACC3;
        Wed, 15 Aug 2018 12:44:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5EC9DDAC96; Wed, 15 Aug 2018 14:44:25 +0200 (CEST)
Date:   Wed, 15 Aug 2018 14:44:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     clm@fb.com, jbacik@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/3] fs/btrfs/disk-io: change
 btrfs_destroy_delayed_refs to be void function
Message-ID: <20180815124425.GM24025@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, zhong jiang <zhongjiang@huawei.com>,
        clm@fb.com, jbacik@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533736075-8691-1-git-send-email-zhongjiang@huawei.com>
 <1533736075-8691-2-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533736075-8691-2-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 09:47:53PM +0800, zhong jiang wrote:
> btrfs_destroy_delayed_refs defines the variable "ret" for return value, but
> it is not modified after initialization. Further, I find that any of the
> callees do not handle the return value.  So it is safe to drop the
> unneeded value "ret".

The callers care about the return values, not the callees. My point in
the previous patch iterations was to make sure that none of the callees,
ie. the functions that are called by btrfs_destroy_delayed_refs, do not
lack error handling.

And I found one that does, btrfs_pin_extent, near the end of the while
loop. So, there's more work and I can't apply this patch until it's
fixed, which may make this patch obsolete as the return value would be
actually needed.
