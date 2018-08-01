Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27718C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE4C208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE4C208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390159AbeHASDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:03:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54384 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389854AbeHASDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:03:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fktns-0001zr-Qx; Wed, 01 Aug 2018 16:16:48 +0000
Date:   Wed, 1 Aug 2018 17:16:48 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Commit "new primitive: discard_new_inode()" introduces a problem
Message-ID: <20180801161648.GP30522@ZenIV.linux.org.uk>
References: <64a0f022-a32d-d4ee-7464-5c5ce0ebd222@virtuozzo.com>
 <20180801151937.GN30522@ZenIV.linux.org.uk>
 <96e3c195-aaca-9214-0dcd-5c2b970a72ae@virtuozzo.com>
 <20180801161151.GO30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801161151.GO30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:11:51PM +0100, Al Viro wrote:
> On Wed, Aug 01, 2018 at 06:43:56PM +0300, Kirill Tkhai wrote:
> > #git status
> > HEAD detached at 22dc9a168272
> 
> Wait a sec - just that commit?  With discard_new_inode() not even
> used anywhere?  Then any of those -ENOMEM is disguised ERR_PTR(-ESTALE)
> from find_inode()/find_inode_fast(), i.e. an inode found by
> iget5_locked() (your /etc is on ext4) with I_CREATING still set.

iget_locked(), that is.

> And that is set only by insert_inode_locked()/insert_inode_locked4(),
> and only until unlock_new_inode().
> 
> Could you slap WARN_ON(1) before these return ERR_PTR(-ESTALE) in
> find_inode{,_fast}() and see if that's what's getting triggered?
