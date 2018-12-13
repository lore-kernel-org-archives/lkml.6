Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FA2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B4120870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B4120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeLMFmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:42:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47236 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLMFmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:42:24 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9D49814B3D316;
        Wed, 12 Dec 2018 21:42:23 -0800 (PST)
Date:   Wed, 12 Dec 2018 21:42:23 -0800 (PST)
Message-Id: <20181212.214223.211216727717464391.davem@davemloft.net>
To:     mkubecek@suse.cz
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        posk@google.com, eric.dumazet@gmail.com, gfigueira@suse.com
Subject: Re: [PATCH net] net: ipv4: do not handle duplicate fragments as
 overlapping
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181213022800.9D298E1116@unicorn.suse.cz>
References: <20181213022800.9D298E1116@unicorn.suse.cz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Dec 2018 21:42:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Thu, 13 Dec 2018 03:28:00 +0100 (CET)

> Since commit 7969e5c40dfd ("ip: discard IPv4 datagrams with overlapping
> segments.") IPv4 reassembly code drops the whole queue whenever an
> overlapping fragment is received. However, the test is written in a way
> which detects duplicate fragments as overlapping so that in environments
> with many duplicate packets, fragmented packets may be undeliverable.
> 
> Add an extra test and for (potentially) duplicate fragment, only drop the
> new fragment rather than the whole queue. Only starting offset and length
> are checked, not the contents of the fragments as that would be too
> expensive.  Check for duplicity with last (tail) fragment first as in real
> life scenarios this should be the most frequent case and we would have to
> iterate through the whole "run" otherwise.
> 
> Fixes: 7969e5c40dfd ("ip: discard IPv4 datagrams with overlapping segments.")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

I'll give Eric a chance to review this, thanks Michal.
