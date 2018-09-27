Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289F8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF16E216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NYBjBqQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF16E216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeI0WFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:05:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33641 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727270AbeI0WFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:05:43 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 01FCD21E81;
        Thu, 27 Sep 2018 11:46:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 27 Sep 2018 11:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=Gqsod2o5Yv4m1Ls7P5JWePrCuv80q
        QDPWX0bJi04T1I=; b=NYBjBqQQ+5CIyf5gjeoQKs1oqdd6+N1CxVUKd/mZnaGq4
        sf672WdiIKsqVD2L32D7PsmoCfN1ALucngZbEJzU+uM65xOfSxMoW6R6GK/lrEEm
        isxoGhuIcJ8GVAqZDXUmxYVt/lEO+4nF1Kjv7SaFM+im0rThJrq16fI+zDBL5e/g
        0ljvzoXEoLaK6LrSNx/YmhgbT9cXdr6IsIRVksh/2reT/Whxbqcxb7RY7DTYrCEk
        xqgR3sgGzpbuV/jigvnF+b1ZFZE7nDEjLGuxytK2mrC++/+3Zye/r8TZwErNk47j
        +ttec/3pgr+ozoXi04UNfHCR1SZMORmTCWVKvyFfA==
X-ME-Proxy: <xmx:afusW_2dwCaG-Ar8Mx9x_YNIO1J1DmF7unlniC4G4DdScucqeZjbgw>
    <xmx:afusWwBBSvP9jDna21_Momu_5KZGqgzDS5639KVKW8jSzrYHCjpZ_g>
    <xmx:afusW6SgiehU2ANsr_aqX_ry8dh6HlQ0xgDGvHP22JrndU_21fHaNw>
    <xmx:afusWyLkjtsij0qN5Qcaqa3uo_K_JMD7VvDoYunZDJwotVDmT0ZUkg>
    <xmx:afusWxGwuKEz9XBrYWfhxC5B_0TqA95dkw8ZcZzUD7Pc_gOypm9CQw>
    <xmx:avusW5QMYwN9XxKnqHgPF4BL62gUn0vxPDTuaxaAzmAQCgTI0dVTeQ>
X-ME-Sender: <xms:afusWw8R3pOscPJbyYqVs6vths_LRuLGjWiOJ1j9s33zDa5iYxH70A>
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id 16041102E5;
        Thu, 27 Sep 2018 11:46:48 -0400 (EDT)
Date:   Thu, 27 Sep 2018 17:46:47 +0200
From:   Greg KH <gregkh@linux-foundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     iamjoonsoo.kim@lge.com, rientjes@google.com, cl@linux.com,
        penberg@kernel.org, akpm@linux-foundation.org, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [STABLE PATCH] slub: make ->cpu_partial unsigned int
Message-ID: <20180927154647.GB31654@kroah.com>
References: <1538059420-14439-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538059420-14439-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:43:40PM +0800, zhong jiang wrote:
> From: Alexey Dobriyan <adobriyan@gmail.com>
> 
>         /*
>          * cpu_partial determined the maximum number of objects
>          * kept in the per cpu partial lists of a processor.
>          */
> 
> Can't be negative.
> 
> I hit a real issue that it will result in a large number of memory leak.
> Because Freeing slabs are in interrupt context. So it can trigger this issue.
> put_cpu_partial can be interrupted more than once.
> due to a union struct of lru and pobjects in struct page, when other core handles
> page->lru list, for eaxmple, remove_partial in freeing slab code flow, It will
> result in pobjects being a negative value(0xdead0000). Therefore, a large number
> of slabs will be added to per_cpu partial list.
> 
> I had posted the issue to community before. The detailed issue description is as follows.
> 
> Link: https://www.spinics.net/lists/kernel/msg2870979.html
> 
> After applying the patch, The issue is fixed. So the patch is a effective bugfix.
> It should go into stable.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
