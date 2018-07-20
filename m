Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E27CECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C495C20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C495C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbeGTMC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:02:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58898 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeGTMC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:02:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fgTNN-0005XD-Mk; Fri, 20 Jul 2018 11:15:09 +0000
Date:   Fri, 20 Jul 2018 12:15:09 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs/seq_file: remove kmalloc(ops) for single_open seqfiles
Message-ID: <20180720111509.GB30522@ZenIV.linux.org.uk>
References: <20180720102952.30935-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720102952.30935-1-vbabka@suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 12:29:52PM +0200, Vlastimil Babka wrote:
> single_open() currently allocates seq_operations with kmalloc(). This is
> suboptimal, because that's four pointers, of which three are constant, and
> only the 'show' op differs. We also have to be careful to use single_release()
> to avoid leaking the ops structure.
> 
> Instead of this we can have a fixed single_show() function and constant ops
> structure for these seq_files. We can store the pointer to the 'show' op as
> a new field of struct seq_file. That's also not terribly elegant, because the
> field is there also for non-single_open() seq files, but it's a single pointer
> in an already existing (and already relatively large) structure instead of
> an extra kmalloc of four pointers, so the tradeoff is OK.

... except that piling indirect calls is costly and ->show() is called a lot more
than open() is.
