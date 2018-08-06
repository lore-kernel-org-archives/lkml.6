Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EE4C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8584421992
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8584421992
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbeHFPKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:10:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37342 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbeHFPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:10:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fmf8t-0005Dt-Hv; Mon, 06 Aug 2018 13:01:47 +0000
Date:   Mon, 6 Aug 2018 14:01:47 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu
Subject: Re: KASAN: use-after-free Read in link_path_walk
Message-ID: <20180806130147.GL15082@ZenIV.linux.org.uk>
References: <20180724034542.GA19283@dragonet>
 <20180724051726.GH30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724051726.GH30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 06:17:26AM +0100, Al Viro wrote:

> Do we have LOOKUP_RCU in nd->flags at that point?  And how in hell
> did we get that dentry there?  In LOOKUP_RCU mode no freeing should
> be happening until after we call rcu_read_unlock(), unless the final
> dput() has happened before rcu_read_lock().  In which case we shouldn't
> have gotten to that dentry in the first place.

... except that we never set DCACHE_RCUACCESS for root dentry.  Which
invalidates the normal "if we run into dentry in lazy mode, its memory
won't be freed until we drop rcu_read_lock"...  d_make_root() definitely
needs to set DCACHE_RCUACCESS; whether it's all there is or you are
hitting something else is a separate question, of course...

>  And in non-LOOKUP_RCU
> mode we are bloody well holding references to everything (vfsmount
> and dentry alike), so that deactivate_super() shouldn't have been
> called as long as we are holding that reference.
> 
> Details, please.  Ideally - how to reproduce that.

Is there any way to tell KASAN that we want a crashdump triggered?
That would've been really useful for post-mortems...
