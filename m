Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB2C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD23020831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD23020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeKCFiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:38:08 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:43256 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeKCFiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:38:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5F35F60A358C;
        Fri,  2 Nov 2018 21:29:31 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DRaPNQUcX32b; Fri,  2 Nov 2018 21:29:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 233BE60A0E18;
        Fri,  2 Nov 2018 21:29:31 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eJfSYhX0omM7; Fri,  2 Nov 2018 21:29:31 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id C89CA60A072F;
        Fri,  2 Nov 2018 21:29:30 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubifs: replay: fix high stack usage
Date:   Fri, 02 Nov 2018 21:29:30 +0100
Message-ID: <22023095.Sk82ml8AZ4@blindfold>
In-Reply-To: <20181102153932.1750967-1-arnd@arndb.de>
References: <20181102153932.1750967-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 2. November 2018, 16:39:24 CET schrieb Arnd Bergmann:
> Having two shash descriptors on the stack cause a very significant kernel
> stack usage that can cross the warning threshold:
> 
> fs/ubifs/replay.c: In function 'authenticate_sleb':
> fs/ubifs/replay.c:633:1: error: the frame size of 1144 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Normally, gcc optimizes the out, but with CONFIG_CC_OPTIMIZE_FOR_DEBUGGING,
> it does not. Splitting the two stack allocations into separate functions
> means that they will use the same memory again. In normal configurations
> (optimizing for size or performance), those should get inlined and we get
> the same behavior as before.

Thanks for addressing this, applied!

Thanks,
//richard


