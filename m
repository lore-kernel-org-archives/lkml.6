Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDC1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2291C20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2291C20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeHaSDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:03:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59058 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeHaSDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:03:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fvjuJ-0000Nc-8P; Fri, 31 Aug 2018 13:56:15 +0000
Date:   Fri, 31 Aug 2018 14:56:15 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fs: hfs: Possible issue with increment of extent
Message-ID: <20180831135614.GC19965@ZenIV.linux.org.uk>
References: <a519d1f2-81db-26c2-30ba-9ce2bacfecbe@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a519d1f2-81db-26c2-30ba-9ce2bacfecbe@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 02:39:11PM +0100, Colin Ian King wrote:
> Hi,
> 
> Static analysis has picked up a potential issue with an out of bounds
> read in fs/hfs/extent.c; the following for-loop in  hfs_free_fork()
> increments i and also extent while also reading extent[i].count.  This
> looks incorrect to me, I think the increment of extent is not needed:
> 
>         for (i = 0; i < 3; extent++, i++)
>                 blocks += be16_to_cpu(extent[i].count);
> 
>         res = hfs_free_extents(sb, extent, blocks, blocks);
> 
> I'm not familiar enough with the code to conclude that removing the
> increment of extent is necessary a correct fix just in case I'm missing
> something subtle here.

Goes back to commit d1081202f1d0 (in bk-to-git historical tree)
Author: Andrew Morton <akpm@osdl.org>
Date:   Wed Feb 25 16:17:36 2004 -0800

    [PATCH] HFS rewrite
    
    From: Roman Zippel <zippel@linux-m68k.org>

and it's almost certainly a bug in there, judging by the code nearby...
