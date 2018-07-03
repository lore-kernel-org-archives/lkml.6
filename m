Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5279FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063DC24C4F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="w35AYoNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063DC24C4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754819AbeGCKj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:39:58 -0400
Received: from imap.thunk.org ([74.207.234.97]:54234 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754665AbeGCKj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zSiXfeCiKipYwsvQg6zRtYDgP8T/JcZc7910YKEnrnU=; b=w35AYoNsQGY5pR3jqBvA5FbfSB
        E2/Fyyn0wnA5Ue0aR3F36K6M4UFhhfxl62CUN6N9Quo/UVsQYLGZwoieI9UvyBu7FJ7HphKvZYjQX
        OujHact0gG+CI5CIXwdyJsnUKadogX2d1QhBCSSNOHIHpy/z25NeRFgIE0fXxteLGaJA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1faIir-0000x3-KT; Tue, 03 Jul 2018 10:39:49 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A17747A01EA; Tue,  3 Jul 2018 06:39:48 -0400 (EDT)
Date:   Tue, 3 Jul 2018 06:39:48 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, adilger.kernel@dilger.ca,
        darrick.wong@oracle.com, dchinner@redhat.com,
        akpm@linux-foundation.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: ext4: use BUG_ON if writepage call comes from
 direct reclaim
Message-ID: <20180703103948.GB27426@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Yang Shi <yang.shi@linux.alibaba.com>, mgorman@techsingularity.net,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        dchinner@redhat.com, akpm@linux-foundation.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1530591079-33813-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530591079-33813-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 12:11:18PM +0800, Yang Shi wrote:
> direct reclaim doesn't write out filesystem page, only kswapd could do
> it. So, if the call comes from direct reclaim, it is definitely a bug.
> 
> And, Mel Gormane also mentioned "Ultimately, this will be a BUG_ON." In
> commit 94054fa3fca1fd78db02cb3d68d5627120f0a1d4 ("xfs: warn if direct
> reclaim tries to writeback pages").
> 
> Although it is for xfs, ext4 has the similar behavior, so elevate
> WARN_ON to BUG_ON.
> 
> And, correct the comment accordingly.
> 
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

What's the upside of crashing the kernel if the file sytsem can handle it?

       	   	     	      	  	    - Ted
