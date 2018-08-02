Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D11C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4AB208D8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4AB208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeHBGsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:48:25 -0400
Received: from nautica.notk.org ([91.121.71.147]:50752 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbeHBGsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:48:25 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id BF190C009; Thu,  2 Aug 2018 06:59:06 +0200 (CEST)
Date:   Thu, 2 Aug 2018 06:58:51 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH v2 2/2] net/9p: add a per-client fcall
 kmem_cache
Message-ID: <20180802045851.GA15564@nautica>
References: <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
 <1533177452-2165-1-git-send-email-asmadeus@codewreck.org>
 <1533177452-2165-2-git-send-email-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1533177452-2165-2-git-send-email-asmadeus@codewreck.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Thu, Aug 02, 2018:
> [...]
> +	clnt->fcall_cache = kmem_cache_create("9p-fcall-cache", clnt->msize,
> +					      0, 0, NULL);


Well, my gut feeling that I'd need a v3 was right, after a bit more time
testing (slightly different setup), I got this warning:
Bad or missing usercopy whitelist? Kernel memory overwrite attempt
detected to SLUB object '9p-fcall-cache' (offset 23, size 55078)!

So this kmem_cache_create needs to change to kmem_cache_create_usercopy,
but I'm not sure how to best specify the range -- this warning was about
writing data to the buffer so a TWRITE:
size[4] Twrite tag[2] fid[4] offset[8] count[4] data[count]
(the data[count] part comes from user - this matches 4+1+2+4+8+4 = 23)

Similarily RREAD has data that can be copied to userspace, which has a
similar check:
size[4] Rread tag[2] count[4] data[count]

So I could hardcode offset = 4+1+2+4=11, usercopy size = msize - 11...


We have some P9_*HDR*SZ macros but none are really appropriate:
---
/* ample room for Twrite/Rread header */
#define P9_IOHDRSZ      24

/* Room for readdir header */
#define P9_READDIRHDRSZ 24

/* size of header for zero copy read/write */
#define P9_ZC_HDR_SZ 4096
---

It's actually been bugging me for a while that I see hardcoded '7's for
9p main header size (len + msg type + tag) everywhere, I could add a
first P9_HDRSZ of 7 and use that + 4?

-- 
Dominique
