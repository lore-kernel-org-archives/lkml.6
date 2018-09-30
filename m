Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46205C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD39B20685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C2ikLI1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD39B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeI3TTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 15:19:36 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51575 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728299AbeI3TTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 15:19:36 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A2E920DC2;
        Sun, 30 Sep 2018 08:37:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 30 Sep 2018 08:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=B5IsJsfB3cNAguwaT3hrkonVwWpmR
        af7ckui15xNVDY=; b=C2ikLI1x4L4/0eL6bIRouII0xBn6+VNmTd3Kh4o8DJffU
        4THpHv9NG5Ao6vu1bnP+z4geFbYuDy00EaBwxFoUQ3CvP/Veo5cRZivkxO9NuYGT
        d886z+hC9v2bdEP4D4+O3KcW8JKrK/b67da1vPaEidvqwiPHM63XAUPLzc4yjzwW
        kb5Ht6NIE/NGSObCXoU0hcxvFdVNVyg4+agKYJeUwnfB+gsUg361ZFSh/bR4Nw6W
        jnuuanOF/MxRewt1Elt7f4NMnVpsc1RVwAVf4g1tnpJM4UMVCD3+VXUL7aLYJf+8
        MYrCZ995cxRtpHvwn6zJeM8DQ7kDicizIVaKQGFqw==
X-ME-Proxy: <xmx:mcOwW-c-wLLw7jf7Mqp6B1s6qWjoZl9QCACTh0HzvbZhvUKz2Zcg_w>
    <xmx:mcOwW8cp-W72mAK-RyLFJ2ZgMCmULWbxrc1IlAyk8P0Vb4vbLQ273A>
    <xmx:mcOwWyo4CXlZuyp0VJqSSIBBEBp5oJkAux9ZclTP2Q0-978k8kTiDw>
    <xmx:mcOwW6Td_Mn20zlrOxLW3E9LY5_g1MxQMYc2QlgKQp4mGJybpRpCfw>
    <xmx:mcOwWz6Kv0orw0eOkEDhxOnnxUp-DH5tR_wMSsVkdJIqSDUHRdcwuA>
    <xmx:ncOwW1t_MfZxJ24GSeAEhWCEncphXZKI9kB4Hr48kitCNykZelzsZA>
X-ME-Sender: <xms:mcOwWz3PSdapqSGNCYtrKOOT0mReCTSfagnm5374JvIrcl79oVtw4A>
Received: from localhost (c-73-221-170-44.hsd1.wa.comcast.net [73.221.170.44])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F52FE46B8;
        Sun, 30 Sep 2018 08:37:45 -0400 (EDT)
Date:   Sun, 30 Sep 2018 05:37:44 -0700
From:   Greg KH <gregkh@linux-foundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        mhocko@kernel.org, mgorman@suse.de, vbabka@suse.cz,
        andrea@kernel.org, kirill@shutemov.name, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [STABLE PATCH] slub: make ->cpu_partial unsigned int
Message-ID: <20180930123744.GA20353@kroah.com>
References: <1538303301-61784-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538303301-61784-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 06:28:21PM +0800, zhong jiang wrote:
> From: Alexey Dobriyan <adobriyan@gmail.com>
> 
> [ Upstream commit e5d9998f3e09359b372a037a6ac55ba235d95d57 ]
> 
>         /*
>          * cpu_partial determined the maximum number of objects
>          * kept in the per cpu partial lists of a processor.
>          */
> 
> Can't be negative.
> 
> I hit a real issue that it will result in a large number of memory leak.
> Becuase Freeing slabs are in interrupt context. So it can trigger this issue.
> put_cpu_partial can be interrupted more than once.
> due to a union struct of lru and pobjects in struct page, when other core handles
> page->lru list, for eaxmple, remove_partial in freeing slab code flow, It will
> result in pobjects being a negative value(0xdead0000). Therefore, a large number
> of slabs will be added to per_cpu partial list.
> 
> I had posted the issue to community before. The detailed issue description is as follows.
> 
> https://www.spinics.net/lists/kernel/msg2870979.html
> 
> After applying the patch, The issue is fixed. So the patch is a effective bugfix.
> It should go into stable.
> 
> Link: http://lkml.kernel.org/r/20180305200730.15812-15-adobriyan@gmail.com
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> Acked-by: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: <stable@vger.kernel.org> # 4.4.x

This didn't apply to 4.14.y and any reason you didn't cc: the stable
mailing list for the other stable developers to see it?

I've fixed up the patch, but next time please always cc: the stable
list.

thanks,

greg k-h
