Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3B7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39F5214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39F5214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeIRUE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:04:29 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:36226 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbeIRUE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:04:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E0FE3606D4A8;
        Tue, 18 Sep 2018 16:31:35 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UDKPOEgKTDit; Tue, 18 Sep 2018 16:31:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A474D606D4A9;
        Tue, 18 Sep 2018 16:31:35 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 26QZwiyEV1v1; Tue, 18 Sep 2018 16:31:35 +0200 (CEST)
Received: from blindfold.localnet (089144196103.atnat0005.highway.a1.net [89.144.196.103])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id EA0C1606D4A8;
        Tue, 18 Sep 2018 16:31:34 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Andrew Worsley <amworsley@gmail.com>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "open list:UNSORTED BLOCK IMAGES (UBI)" 
        <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Round UBI average erase count up to next integer
Date:   Tue, 18 Sep 2018 16:31:33 +0200
Message-ID: <90432329.iuebBMo885@blindfold>
In-Reply-To: <20180918130521.22880-2-amworsley@gmail.com>
References: <20180918130521.22880-1-amworsley@gmail.com> <20180918130521.22880-2-amworsley@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Am Dienstag, 18. September 2018, 15:05:21 CEST schrieb Andrew Worsley:
> Use a slightly larger than average EC so these PEBs will be
> reinitialised with erase counts that make them less likely to
> be reused than other (perhaps less worn or error-prone) PEBs
> 
> We have more frequent ECC failures on reads of page 0 of some PEBs
> which manifest itself commonly during ubiattach. We believe this is due to
> "program disturb" and want those PEB to be re-used later than average.

So the general idea behind the patch is that we want to hold back PEBs
that lost the EC header since they must be less healthy than others?
More precisely such that this PEB will be less likely picked by find_mean_wl_entry().

Did you check, doesn't this make it more likely that such a "bad" PEB is more often
picked by wear leveling? It does not use find_mean_wl_entry().

Thanks,
//richard


