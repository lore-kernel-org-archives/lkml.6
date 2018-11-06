Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CC1C46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE72A20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE72A20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbeKFN0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:26:33 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39312 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbeKFN0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:26:33 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1E1B314920CDE;
        Mon,  5 Nov 2018 20:03:22 -0800 (PST)
Date:   Mon, 05 Nov 2018 20:03:21 -0800 (PST)
Message-Id: <20181105.200321.1569039579935458312.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181105.194542.476367332910923203.davem@davemloft.net>
References: <20181104.165039.878682622135788379.davem@davemloft.net>
        <20181105203447.GA25674@krava>
        <20181105.194542.476367332910923203.davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Nov 2018 20:03:22 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 05 Nov 2018 19:45:42 -0800 (PST)

> Build fix for sparc below, I'm playing with this now.

I get various assertion failures and crashes during make -j128 kernel
builds on my sparc64 box:

====================
perf: Segmentation fault
-------- backtrace --------
/lib/sparc-linux-gnu/libc.so.6(+0x38918)[0xf7264918]
./perf(thread__set_namespaces+0x30)[0x10b2f0]
./perf(machine__process_namespaces_event+0x134)[0xfad54]
./perf[0x517b8]
./perf(queued_events__flush+0xc8)[0x109288]
./perf[0x5133c]
/lib/sparc-linux-gnu/libpthread.so.0(+0x6714)[0xf7c7e714]
/lib/sparc-linux-gnu/libc.so.6(+0xf70b4)[0xf73230b4]
/lib/sparc-linux-gnu/libpthread.so.0(+0x6a84)[0xf7c7ea84]
davem@patience:~/src/GIT/sparc/tools/perf$ 
====================

and:

====================
perf: /home/davem/src/GIT/sparc/tools/include/linux/refcount.h:131: refcount_sub_and_test: Assertion `!(new > val)' failed.
====================

I don't have a lot of time to try and debug this, but let me know if you
want any fixes tested.

I did look at the changes and I like what you're trying to do.
