Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA16C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE8920838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TnoHaN2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE8920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeLFE0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:26:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeLFE0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 23:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0DSY3BfsYM1mDQrvH9LSaCceeBNiWh+dlLPsz3oZfns=; b=TnoHaN2hOX7CclsqhhobofH9gT
        zG/1jZQ8mJ8AOLsBsZe8HekxwiF1zGkOCLCZeod11kLq5RYac4Lt5IroPTZ3HL6br54PHPupzQOtb
        OZ4W1uoMUUvXPXbN12BJSl9MG0X31zGZV1De1OX4GDoeknEGLsOZ6ypRWuNHxHxm5FQi0k382mdoI
        +eKVs78BgjzuxQm7lTgNb3IpbBu8D+1vLrRyIpebOrczCOMt3gvWUEtQSyW2mRnC7AHEk+CE5d70K
        sGMPEQLTNSo52AaEpaCNzWlJYD5xFSoE7Y69vfLwpHPT5oJmxMqOqqcQkO8rexWqJwnVG4qtkk76l
        tib+6RkA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUlF9-0004EQ-FY; Thu, 06 Dec 2018 04:26:31 +0000
Date:   Wed, 5 Dec 2018 20:26:31 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        adobriyan@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        sfr@canb.auug.org.au, kirill.shutemov@linux.intel.com,
        rppt@linux.vnet.ibm.com, mhocko@suse.com,
        alexander.h.duyck@linux.intel.com, hannes@cmpxchg.org,
        miles.chen@mediatek.com, n-horiguchi@ah.jp.nec.com
Subject: Re: [PATCH] /proc/kpagecount: return 0 for special pages that are
 never mapped
Message-ID: <20181206042631.GA24603@bombadil.infradead.org>
References: <1543963526-27917-1-git-send-email-anthony.yznaga@oracle.com>
 <20181205004836.GU10377@bombadil.infradead.org>
 <fa5b667d-ccfb-b11a-2aeb-b1007651f9ec@oracle.com>
 <20181205012534.GW10377@bombadil.infradead.org>
 <540f7690-5fcd-04d6-edb3-a44ebd09e70c@oracle.com>
 <20181205194409.GB11646@bombadil.infradead.org>
 <d9fa0325-690d-47cc-fc49-2606855f6a4f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9fa0325-690d-47cc-fc49-2606855f6a4f@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:44:15PM -0800, Anthony Yznaga wrote:
> On 12/05/2018 11:44 AM, Matthew Wilcox wrote:
> > Nobody seems terribly interested in mapcount overflows.  I got no response
> > to https://lkml.org/lkml/2018/3/2/991
> 
> Okay.  Thanks for the background.
> 
> How about this, then:

Acked-by: Matthew Wilcox <willy@infradead.org>
