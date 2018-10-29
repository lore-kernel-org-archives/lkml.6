Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C4FC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4D520870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4D520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeJ3GH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:07:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40500 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJ3GH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:07:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 902B413ADD5D4;
        Mon, 29 Oct 2018 14:16:59 -0700 (PDT)
Date:   Mon, 29 Oct 2018 14:16:56 -0700 (PDT)
Message-Id: <20181029.141656.565374870463385142.davem@davemloft.net>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, namhyung@kernel.org, kan.liang@intel.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <d3626e3f-5993-7ee7-f817-48e9dcee17f4@linux.intel.com>
References: <b488a063-276c-ab8f-954e-f68e951146b4@linux.intel.com>
        <20181029.104827.680192866924184016.davem@davemloft.net>
        <d3626e3f-5993-7ee7-f817-48e9dcee17f4@linux.intel.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 29 Oct 2018 14:16:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liang, Kan" <kan.liang@linux.intel.com>
Date: Mon, 29 Oct 2018 14:20:15 -0400

> You didn't see any warning before the patch. I think it is just
> because perf top hides the problem.

Quite honestly, the last time I played around with this:

1) The new ring buffer mode didn't exist

2) perf started up much more quickly and was much more responsive
   than it is these days

It used to handle a 128-cpu system doing a parallel kernel build
with no problems, no dropped events, nothing.

Something has changed to make perf more bloated and slow, and one by
one I'm trying to identify and deal with these issues rather than
just make perf abort when it can't keep up which is the approach
that has seem to have taken over.  That's to me is just wrong.

One point I want to make clear, dropping things like mmap events will
make perf run more slowly not more fast.

I keep trying to explain this over and over.

If you drop map events, you have no range into which to fit samples.

Therefore samples create a unique histogram entries, and the histogram
table grows to be quite huge.  And this slows down perf significantly
because every new sample and histogram decay walks this table, sorting
it, killing off old entries, finding a place for new ones, etc.

I really think dropping events causes more harm than good in this
case, therefore.

This also happens when perf cannot find a symbol, for example in a
binary or library with no symbols.  I see this as an area for
significant improvement.


