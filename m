Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71862C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0614F208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0614F208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeH0XGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:06:22 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:34534 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeH0XGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:06:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 67432606D4A7;
        Mon, 27 Aug 2018 21:18:26 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id K5uRc8nUl_qN; Mon, 27 Aug 2018 21:18:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 109F7603B56E;
        Mon, 27 Aug 2018 21:18:26 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XFyZhlcCEQMF; Mon, 27 Aug 2018 21:18:26 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id BE129608D734;
        Mon, 27 Aug 2018 21:18:25 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/25] ubifs: Add hashes to the tree node cache
Date:   Mon, 27 Aug 2018 21:18:25 +0200
Message-ID: <3260968.WmIi4lir0Q@blindfold>
In-Reply-To: <20180704124137.13396-13-s.hauer@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de> <20180704124137.13396-13-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Juli 2018, 14:41:24 CEST schrieb Sascha Hauer:
> As part of the UBIFS authentication support every branch in the index
> gets a hash covering the referenced node. To make that happen the tree
> node cache needs hashes over the nodes. This patch adds a hash argument
> to ubifs_tnc_add() and ubifs_tnc_add_nm(). The hashes are calculated
> from the callers of these functions which actually prepare the nodes.
> With this patch all the leaf nodes of the index tree get hashes, but
> currently nothing is done with these hashes, this is left for a later
> patch.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  fs/ubifs/journal.c | 93 ++++++++++++++++++++++++++++++++++------------
>  fs/ubifs/replay.c  |  4 +-
>  fs/ubifs/tnc.c     | 10 ++++-
>  fs/ubifs/ubifs.h   |  7 +++-
>  4 files changed, 84 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index 754d969eb27e..55b35bc33c31 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -517,6 +517,9 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
>  	struct ubifs_dent_node *dent;
>  	struct ubifs_ino_node *ino;
>  	union ubifs_key dent_key, ino_key;
> +	u8 hash_dent[UBIFS_MAX_HASH_LEN];
> +	u8 hash_ino[UBIFS_MAX_HASH_LEN];
> +	u8 hash_ino_host[UBIFS_MAX_HASH_LEN];

With authentication enabled, this makes perfectly sense.
But if someone builds UBIFS without and has a memory constraint system,
we could save by setting UBIFS_MAX_HASH_LEN to 0. What do you think?
Although, we need another define to not influence ubifs-media.h.

Thanks,
//richard


