Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075E7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64A0222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MCF5Gbp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfBORQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:16:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfBORQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ooGmETeAMfU5WngSU05Ee1Ynx92AHDeGIIebdL4CHw0=; b=MCF5Gbp2jwQST1+kskq7BCogZ
        yLJ04gp3VEiMQK5dNfjFJzV5Il16yADz8CfgwZlbi4tFduPzcyOpCByjun9FojEiNArJiTjErZdXQ
        gH5HF3YWG5E/2GT7PnyXmTjuLz26bF+GIOsZ9kv84p+RQsZSe4BW0o7YAcilSiMJGjjxIsQDge9cz
        fmd4rAxHh9FZFxzpB85JSvHZVbc0fQOutDIHDrbXHIV9Tq853kzjgrLNK6zQXOND1xAvTseyLAB7R
        XyZfjNEV3pCHZrncBG2pqy7TNEPcOuM5GBw2cmKlw/9x5DMSDM+OFMuhAKBeTez27HuK8p5g+iNuw
        +DZVLTgng==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guh63-0004um-DE; Fri, 15 Feb 2019 17:16:19 +0000
Date:   Fri, 15 Feb 2019 09:16:19 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Watson <davejwatson@fb.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Maged Michael <magedmichael@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [LSF/MM TOPIC] Improve performance of fget/fput
Message-ID: <20190215171619.GI12668@bombadil.infradead.org>
References: <20190215163852.6ls6bchssazma6bm@davejwatson-mba.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215163852.6ls6bchssazma6bm@davejwatson-mba.local>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 04:38:05PM +0000, Dave Watson wrote:
> There might also be ways to rearrange the file* struct or fd table so
> that we're not taking so many cache misses for sockfd_lookup_light,
> since for sockets we don't use most of the file* struct at all.

I don't think there's too much opportunity to rearrange the fd table.
We go from task_struct->files_struct->fdtable->fd[i].  I have a plan
to use the Maple Tree data structure I'm currently working on to change
that to task_struct->files_struct->maple_node->fd[i], but it'll be
the same number of cache misses.
