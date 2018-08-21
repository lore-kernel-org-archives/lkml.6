Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF349C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900C8214EE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900C8214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeHULBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:01:03 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:55740 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeHULBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:01:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5A635608D734;
        Tue, 21 Aug 2018 09:41:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IlZuW2WXjSPK; Tue, 21 Aug 2018 09:41:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D368C6088978;
        Tue, 21 Aug 2018 09:41:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0D_ltrcOX-hN; Tue, 21 Aug 2018 09:41:57 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 8B930606D4A1;
        Tue, 21 Aug 2018 09:41:57 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     liu.song11@zte.com.cn
Cc:     dedekind1@gmail.com, adrian.hunter@intel.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Subject: Re: [PATCH] ubifs: remove unnecessary check in ubifs_log_start_commit
Date:   Tue, 21 Aug 2018 09:41:57 +0200
Message-ID: <2441223.E8OYYOjAtB@blindfold>
In-Reply-To: <201808211457448170622@zte.com.cn>
References: <201808211457448170622@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 21. August 2018, 08:57:44 CEST schrieb liu.song11@zte.com.cn:
> Hi Richard,
> 
> In ubifs_log_start_commit, the value of c->lhead_offs is zero or set to zero by code bellow
> 409         /* Switch to the next log LEB */
> 410         if (c->lhead_offs) {
> 411                 c->lhead_lnum = ubifs_next_log_lnum(c, c->lhead_lnum);
> 412                 ubifs_assert(c->lhead_lnum != c->ltail_lnum);
> 413                 c->lhead_offs = 0;
> 414         }
> 
> The value of 'len' can not exceed 'max_len' which assigned value by code bellow
> 370         max_len = UBIFS_CS_NODE_SZ + c->jhead_cnt * UBIFS_REF_NODE_SZ;
> 
> So, the value of c->lhead_offs cannot exceed 'max_len' 
> 429         c->lhead_offs += len;
> 430         if (c->lhead_offs == c->leb_size) {
> 431                 c->lhead_lnum = ubifs_next_log_lnum(c, c->lhead_lnum);
> 432                 c->lhead_offs = 0;
> 433         }
> 
> Usually, the size of PEB is between 64KB and 256KB, and in UBIFS, the value of
> c->lhead_offs far less than UBIFS_BLOCK_SIZE which equal to 4096. So I think
> the value of c->lhead_offs far less than c->leb_size, the check in line 430 seem 
> never to be true.

Okay, now it makes sense.
But what has this do to with UBIFS_BLOCK_SIZE?

Anyway, your patch description needs to be more detailed.
What you explained to me right now needs to go in the commit message.
Then people can understand why the check is not needed.
For the sake of paranoia and debug-ability, please also add a
ubifs_assert(c->lhead_offs < c->leb_size);.

Thanks,
//richard


