Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F763C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5D92186A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfBZTEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:04:39 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37846 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfBZTEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:04:38 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1gyi1o-0000Ga-C8; Tue, 26 Feb 2019 19:04:32 +0000
Date:   Tue, 26 Feb 2019 19:04:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Dumazet <edumazet@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH v2] iov_iter: optimize page_copy_sane()
Message-ID: <20190226190431.GK2217@ZenIV.linux.org.uk>
References: <20190226184239.49946-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226184239.49946-1-edumazet@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:42:39AM -0800, Eric Dumazet wrote:
> Avoid cache line miss dereferencing struct page if we can.
> 
> page_copy_sane() mostly deals with order-0 pages.
> 
> Extra cache line miss is visible on TCP recvmsg() calls dealing
> with GRO packets (typically 45 page frags are attached to one skb).
> 
> Bringing the 45 struct pages into cpu cache while copying the data
> is not free, since the freeing of the skb (and associated
> page frags put_page()) can happen after cache lines have been evicted.

Applied.
