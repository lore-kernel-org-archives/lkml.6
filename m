Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AE0C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4DF2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4DF2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbeGLOuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:50:19 -0400
Received: from nautica.notk.org ([91.121.71.147]:44673 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeGLOuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:50:19 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 4D021C009; Thu, 12 Jul 2018 16:40:27 +0200 (CEST)
Date:   Thu, 12 Jul 2018 16:40:12 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Greg Kurz <groug@kaod.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, Ron Minnich <rminnich@sandia.gov>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH v2 4/6] 9p: Embed wait_queue_head into
 p9_req_t
Message-ID: <20180712144012.GA21574@nautica>
References: <20180711210225.19730-1-willy@infradead.org>
 <20180711210225.19730-5-willy@infradead.org>
 <20180712163649.36057b6e@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180712163649.36057b6e@bahia.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kurz wrote on Thu, Jul 12, 2018:
> This is true when all tags have been used at least once. But the current code
> lazily allocates the wait_queue_head_t, ie, only when a tag is used for the
> first time. Your patch causes a full row of wait_quest_head_t to be pre-allocated.
> 
> ie, P9_ROW_MAXTAG * 24 = 255 * 24 = 6120
> 
> instead of (P9_ROW_MAXTAG * 8) + 24 = 255 * 8 + 24 = 2064
> 
> This is nearly a page of allocated memory that might be never used.
> 
> Not sure if this is a problem though...

I thought the exact same, but the next patch in the serie removes that
array and allocates even more lazily with a slab, so this was a
no-brainer :)

-- 
Dominique Martinet
