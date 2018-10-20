Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEC2C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 15:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C9E20892
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 15:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GrnwCr6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C9E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeJTXsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 19:48:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51854 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbeJTXsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 19:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nerEbAYZT83BGSvPddg60RBR7iK7AxVfczTmYf/1hfg=; b=GrnwCr6y1EBxYgeTusZ937bAUA
        hCdJaiI6XxIAdijHwz5+9LXnM8RCbcnsG4ViHrHcouQIJhQ0ffyZBUe1G+8l+lAbUXJDwYOoPsv4C
        JexSJar7NNYG29fKIyrouyEmOqnvN4LbGa4P4Inb+37yrtxwUF2Bb1rHMMHxknwumHcmjMqUkCJDr
        nGYzBx6R2vjOLwEeGL4Q85hKA9yOpozdSCtWqk44iAHxeuBK/Y70j2OIxVYk9ExAr1Q80ZzQWGX3Y
        7I8uGI3fZ7NKlqHmkvVV1FBWZOqkffz3ykpuHdE9SxDVpIO16VmfTUiQM5SQPMYIx6ep68rhzXXw1
        L4jRM77Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDtJi-0006MT-20; Sat, 20 Oct 2018 15:37:30 +0000
Subject: Re: Memory management issue in 4.18.15
To:     Spock <dairinin@gmail.com>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
References: <CADa=ObrwYaoNFn0x06mvv5W1F9oVccT5qjGM8qFBGNPoNuMUNw@mail.gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a655c898-0701-f10d-bbf3-8a0090544560@infradead.org>
Date:   Sat, 20 Oct 2018 08:37:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CADa=ObrwYaoNFn0x06mvv5W1F9oVccT5qjGM8qFBGNPoNuMUNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add linux-mm mailing list + people]


On 10/20/18 4:41 AM, Spock wrote:
> Hello,
> 
> I have a workload, which creates lots of cache pages. Before 4.18.15,
> the behavior was very stable: pagecache is constantly growing until it
> consumes all the free memory, and then kswapd is balancing it around
> low watermark. After 4.18.15, once in a while khugepaged is waking up
> and reclaims almost all the pages from pagecache, so there is always
> around 2G of 8G unused. THP is enabled only for madvise case and are
> not used.
> 
> The exact change that leads to current behavior is
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.18.y&id=62aad93f09c1952ede86405894df1b22012fd5ab
> 


-- 
~Randy
