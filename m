Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFB3C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A622082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A622082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJ3Cc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:32:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36950 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJ3Cc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:32:59 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0215E136DD16E;
        Mon, 29 Oct 2018 10:43:21 -0700 (PDT)
Date:   Mon, 29 Oct 2018 10:43:21 -0700 (PDT)
Message-Id: <20181029.104321.1657526975436362699.davem@davemloft.net>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, namhyung@kernel.org, kan.liang@intel.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <9ad642b0-1a15-b3d9-781f-893f782f8867@linux.intel.com>
References: <0247fca0-5a94-9a83-cefa-282804316729@linux.intel.com>
        <20181029143506.GF21857@kernel.org>
        <9ad642b0-1a15-b3d9-781f-893f782f8867@linux.intel.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 29 Oct 2018 10:43:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liang, Kan" <kan.liang@linux.intel.com>
Date: Mon, 29 Oct 2018 11:11:25 -0400

> The processing time for each perf_top__mmap_read_idx() should not that
> long. We may check it after each perf_top__mmap_read_idx(). Also
> change the ui_warning to one-time warning. The patch as below can do
> that (not test).

You cannot make ui__*() calls from the event processing thread.

I tried to make this point strongly over the weekend.

It hangs the event thread, because the ui call waits for a keypress
but the display thread will eat them up and the event thread thus
hangs in select().

So, once more, all ui calls must be avoided in event processing code.

Said another way, it is not legal to call UI interfaces from any
code that could be called by the event thread.
