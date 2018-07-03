Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C3CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B2324625
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GNBqE2fS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B2324625
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753640AbeGCT3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:29:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeGCT3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PvIUjRiz9jjoGESc5a6F/I6t/Rz1cXcAqCrE9ddnZtE=; b=GNBqE2fS0wqk6KtmJ51cfaDSW
        2D6f+1pfekAFmYZBSzxMuLCTydk5y23OpxWrtjcFfTsScy2W3vXl9yw5CMgEAbDG229XjQgvIcoBJ
        vJmt4ryyrjTvfOrSKDK7wQ27SouVsP6tY/Jbv3qPg9CkUM2g/ZMiI3keUq2gmF2EIqZVPRfdYjexx
        XuTns1JaUtpjLsn7yFvYPLbVFg0Pn2iobpapNzVvQD0gcgapGp4j4dGylh6GCDJtH1ypfFFZ82ytj
        a6lse9w8WZdFtyRb7EWZSitXKXwqrKc5gEIXzuODMB/OtEMHYeSe4yw0dKynwxy9blouh4u2otr65
        Z5pPtVaBA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faQzC-0005yL-9R; Tue, 03 Jul 2018 19:29:14 +0000
Subject: Re: [PATCH 11/14] rq-qos: introduce dio_bio callback
To:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Cc:     Josef Bacik <jbacik@fb.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
 <20180703151503.2549-12-josef@toxicpanda.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <be66a8be-f55b-3899-b6a6-3db6446acf2b@infradead.org>
Date:   Tue, 3 Jul 2018 12:29:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703151503.2549-12-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 08:15 AM, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> wbt cares only about request completion time, but controllers may need

Please spell out wt^Hbt.
whatever it is.

> information that is on the bio itself, so add a done_bio callback for
> rq-qos so things like blk-iolatency can use it to have the bio when it
> completes.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>  block/bio.c        |  4 ++++
>  block/blk-rq-qos.c | 10 ++++++++++
>  block/blk-rq-qos.h |  2 ++
>  3 files changed, 16 insertions(+)


-- 
~Randy
