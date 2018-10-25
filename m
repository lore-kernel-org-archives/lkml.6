Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA30C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925D22083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gTx9DEVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925D22083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbeJZFBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:01:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJZFBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VvdGvAvVD8ICSjOcIwRufCshwO2hJmYFmWkcGXlrato=; b=gTx9DEVJQhQS1VhWH+WFDTy/y
        2/GXQU30Chzo6Bvnsdgu7V6BZeloRGr1RNLO3pg8rNDdWCu97noFGGJnDMcOMRK4gXq4bbYbvumPp
        nNurvSapdCqh9EihAD6XuX8x3GQzgQmJwKlyCGtT1XOO3/Nddlxu6+OyMqsa8PiqWN3LIZV9BZX/i
        +Bd/NWhdzaVjH7MITa0Iz1VtPNRjfGUqwpbhRdm9m3E9iiXjSj0mgeOyC9MekEZffquIc23A8/LNg
        dMwTrKRMwpUGICNOFDrne5t8ueZBKsN+xCWPxyiUDH1DQCgtRK1vwVRkpAnFmLK8qMJ24mW60lviS
        f5lqOR1tQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFmDk-0005ES-4u; Thu, 25 Oct 2018 20:27:08 +0000
Date:   Thu, 25 Oct 2018 13:27:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Message-ID: <20181025202707.GL25444@bombadil.infradead.org>
References: <20181023164302.20436-1-guro@fb.com>
 <20181024151950.36fe2c41957d807756f587ca@linux-foundation.org>
 <20181025092352.GP18839@dhcp22.suse.cz>
 <20181025124442.5513d282273786369bbb7460@linux-foundation.org>
 <20181025202014.GA216405@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025202014.GA216405@sasha-vm>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 04:20:14PM -0400, Sasha Levin wrote:
> On Thu, Oct 25, 2018 at 12:44:42PM -0700, Andrew Morton wrote:
> > Yup.  Sasha, can you please take care of this?
> 
> Sure, I'll revert it from current stable trees.
> 
> Should 172b06c32b94 and this commit be backported once Roman confirms
> the issue is fixed? As far as I understand 172b06c32b94 addressed an
> issue FB were seeing in their fleet and needed to be fixed.

I'm not sure I see "FB sees an issue in their fleet" and "needs to be
fixed in stable kernels" as related.  FB's workload is different from
most people's workloads and FB has a large and highly-skilled team of
kernel engineers.  Obviously I want this problem fixed in mainline,
but I don't know that most people benefit from having it fixed in stable.
