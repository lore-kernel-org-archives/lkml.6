Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E2AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435B12083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435B12083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeKFORE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:17:04 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39830 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbeKFORE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:17:04 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0325314A6B938;
        Mon,  5 Nov 2018 20:53:42 -0800 (PST)
Date:   Mon, 05 Nov 2018 20:53:42 -0800 (PST)
Message-Id: <20181105.205342.1568518551892125916.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181105.200321.1569039579935458312.davem@davemloft.net>
References: <20181105203447.GA25674@krava>
        <20181105.194542.476367332910923203.davem@davemloft.net>
        <20181105.200321.1569039579935458312.davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Nov 2018 20:53:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jiri,

Because you now run queued_events__queue() lockless with that condvar
trick, it is possible for top->qe.in to be seen as one past the data[]
array, this is because the rotate_queues() code goes:

	if (++top->qe.in > &top->qe.data[1])
		top->qe.in = &top->qe.data[0];

So for a brief moment top->qe.in is out of range and thus
perf_top__mmap_read_idx() can try to enqueue to top->qe.data[2]

We can just do:

	if (top->qe.in == &top->qe.data[1])
		top->qe.in = &top->qe.data[0];
	else
		top->qe.in = &top->qe.data[1];

Or, make top->qe.in an index, and simply go:

	top->qe.in ^= 1;

Either way will fix the bug.
