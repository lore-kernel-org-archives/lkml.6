Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ECFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B490920856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B490920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbeGXHoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:44:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:45654 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388146AbeGXHoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:44:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6O6dJ0n032110;
        Tue, 24 Jul 2018 01:39:20 -0500
Message-ID: <e3a66e2364db2e5439ca8e08cb0def3195d303a4.camel@kernel.crashing.org>
Subject: Re: linux-next: build warning after merge of the fsi tree
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>, gregkh@linuxfoundation.org
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 24 Jul 2018 16:39:19 +1000
In-Reply-To: <20180724160356.7f5a018d@canb.auug.org.au>
References: <20180724160356.7f5a018d@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-24 at 16:03 +1000, Stephen Rothwell wrote:
> Hi Benjamin,
> 
> After merging the fsi tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:

Ah thanks. It's a pair of missing "z" qualifiers in those dev_dbg.

This normally won't show as this driver can only be enabled on 32-bit
ARM, but COMPILE_TEST will allow you to build it on x86_64 thus
triggering the warning.

I've pushed a fix in the fsi tree.

Greg, do you want a new signed tag with the fix or that can wait
for my next pull request ? I have a last bunch of chardev conversions
and object lifetime fixes being reviewed that I was thinking of sending
later this week.

Cheers,
Ben.

> 
> In file included from include/linux/printk.h:336:0,
>                  from include/linux/kernel.h:14,
>                  from include/linux/delay.h:22,
>                  from drivers/fsi/fsi-master-ast-cf.c:8:
> drivers/fsi/fsi-master-ast-cf.c: In function 'fsi_master_acf_read':
> drivers/fsi/fsi-master-ast-cf.c:609:23: warning: format '%u' expects argument of type 'unsigned int', but argument 6 has type 'size_t {aka long unsigned int}' [-Wformat=]
>   dev_dbg(master->dev, "read id %d addr %x size %ud\n", id, addr, size);
>                        ^
> include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
>    __dynamic_dev_dbg(&descriptor, dev, fmt, \
>                                        ^~~
> include/linux/device.h:1428:23: note: in expansion of macro 'dev_fmt'
>   dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                        ^~~~~~~
> drivers/fsi/fsi-master-ast-cf.c:609:2: note: in expansion of macro 'dev_dbg'
>   dev_dbg(master->dev, "read id %d addr %x size %ud\n", id, addr, size);
>   ^~~~~~~
> drivers/fsi/fsi-master-ast-cf.c: In function 'fsi_master_acf_write':
> drivers/fsi/fsi-master-ast-cf.c:634:23: warning: format '%u' expects argument of type 'unsigned int', but argument 6 has type 'size_t {aka long unsigned int}' [-Wformat=]
>   dev_dbg(master->dev, "write id %d addr %x size %ud raw_data: %08x\n",
>                        ^
> include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
>    __dynamic_dev_dbg(&descriptor, dev, fmt, \
>                                        ^~~
> include/linux/device.h:1428:23: note: in expansion of macro 'dev_fmt'
>   dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                        ^~~~~~~
> drivers/fsi/fsi-master-ast-cf.c:634:2: note: in expansion of macro 'dev_dbg'
>   dev_dbg(master->dev, "write id %d addr %x size %ud raw_data: %08x\n",
>   ^~~~~~~
> 
> Introduced by commit
> 
>   6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
> 

