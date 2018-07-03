Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F68C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF8824DD4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF8824DD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753955AbeGCEhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:37:45 -0400
Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:47705 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753877AbeGCEho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:37:44 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail01.adl2.internode.on.net with ESMTP; 03 Jul 2018 14:07:39 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1faD4M-000872-Nd; Tue, 03 Jul 2018 14:37:38 +1000
Date:   Tue, 3 Jul 2018 14:37:38 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        dchinner@redhat.com, akpm@linux-foundation.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: xfs: use BUG_ON if writepage call comes from
 direct reclaim
Message-ID: <20180703043738.GG2234@dastard>
References: <1530591079-33813-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530591079-33813-2-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530591079-33813-2-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 12:11:19PM +0800, Yang Shi wrote:
> direct reclaim doesn't write out filesystem page, only kswapd could do
> this. So, if it is called from direct relaim, it is definitely a bug.
> 
> And, Mel Gorman mentioned "Ultimately, this will be a BUG_ON." in commit
> 94054fa3fca1fd78db02cb3d68d5627120f0a1d4 ("xfs: warn if direct reclaim
> tries to writeback pages"),
> 
> It has been many years since that commit, so it should be safe to
> elevate WARN_ON to BUG_ON now.

NACK.

The existing code warns and then handles the situation gracefully -
this is the appropriate way to handle incorrect calling contexts.
There is absolutely no good reason to panic production kernels
in situations like this.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
