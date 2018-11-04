Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D17FC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 19:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366A72082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 19:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366A72082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbeKEE5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 23:57:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:59816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729616AbeKEE5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 23:57:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8832DACED;
        Sun,  4 Nov 2018 19:41:22 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 8AB58E00A8; Sun,  4 Nov 2018 20:41:21 +0100 (CET)
Date:   Sun, 4 Nov 2018 20:41:21 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     David Miller <davem@davemloft.net>
Cc:     mk.singh@oracle.com, netdev@vger.kernel.org,
        eric.dumazet@gmail.com, j.vosburgh@gmail.com, vfalico@gmail.com,
        andy@greyhouse.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bonding:avoid repeated display of same link status change
Message-ID: <20181104194121.GA29914@unicorn.suse.cz>
References: <20181031105729.7442-1-mk.singh@oracle.com>
 <20181102.233138.738200505012734856.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102.233138.738200505012734856.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 11:31:38PM -0700, David Miller wrote:
> From: mk.singh@oracle.com
> Date: Wed, 31 Oct 2018 16:27:28 +0530
> 
> > -			if (slave->delay) {
> > +			if (slave->delay &&
> > +			    !atomic64_read(&bond->rtnl_needed)) {
>  ...
> > +			    !atomic64_read(&bond->rtnl_needed)) {
>  ...
> > +			atomic64_set(&bond->rtnl_needed, 1);
>  ...
> > +		atomic64_set(&bond->rtnl_needed, 0);
>  ...
> > @@ -229,6 +229,7 @@ struct bonding {
> >  	struct	 dentry *debug_dir;
> >  #endif /* CONFIG_DEBUG_FS */
> >  	struct rtnl_link_stats64 bond_stats;
> > +	atomic64_t rtnl_needed;
> 
> There is nothing "atomic" about a value that is only set and read.
> 
> And using a full 64-bit value for something taking on only '0' and
> '1' is unnecessary as well.

Part of the misunderstanding is caused by the fact that this is actually
a v4 but not marked as such:

  v1: https://patchwork.ozlabs.org/patch/955789/
  v2: https://patchwork.ozlabs.org/patch/970421/
  v3: https://patchwork.ozlabs.org/patch/988241/

When commenting v3, I didn't know about the v2 discussion where Eric
Dumazet NACKed the patch because of potential conflict issues:

  https://patchwork.ozlabs.org/patch/970421/#1992397
  https://patchwork.ozlabs.org/patch/988241/#2017317

On the other hand, there is no need for atomic64_t. Simple atomic_t
(with explaining comment) would suffice. On architectures allowing
atomic read/write for 32-bit integers, there would be no performance
penalty. On architectures not allowing it, atomic_read() and
atomic_set() are implemented to be safe.

Michal Kubecek
