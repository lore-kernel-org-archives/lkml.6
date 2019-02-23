Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F910C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6513920652
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfBWUFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 15:05:55 -0500
Received: from smtprelay0212.hostedemail.com ([216.40.44.212]:45567 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbfBWUFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 15:05:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C829C180192C0;
        Sat, 23 Feb 2019 20:05:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: north74_334fca11f0f44
X-Filterd-Recvd-Size: 1872
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 Feb 2019 20:05:52 +0000 (UTC)
Message-ID: <a38ddf4132398ca7f1705fa377fb52a2b09a2801.camel@perches.com>
Subject: Re: [PATCH] nvmet-fc: use zero-sized array and struct_size() in
 kzalloc()
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sat, 23 Feb 2019 12:05:50 -0800
In-Reply-To: <20190223185108.GA6706@embeddedor>
References: <20190223185108.GA6706@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-02-23 at 12:51 -0600, Gustavo A. R. Silva wrote:
> Update the code to use a zero-sized array instead of a pointer in
> structure nvmet_fc_tgt_queue and use struct_size() in kzalloc().
[]
> This code was detected with the help of Coccinelle.

Really?
Impressive script that found this one.

> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
[]
> @@ -128,12 +128,12 @@ struct nvmet_fc_tgt_queue {
>  	struct nvmet_cq			nvme_cq;
>  	struct nvmet_sq			nvme_sq;
>  	struct nvmet_fc_tgt_assoc	*assoc;
> -	struct nvmet_fc_fcp_iod		*fod;		/* array of fcp_iods */
>  	struct list_head		fod_list;
>  	struct list_head		pending_cmd_list;
>  	struct list_head		avail_defer_list;
>  	struct workqueue_struct		*work_q;
>  	struct kref			ref;
> +	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
>  } __aligned(sizeof(unsigned long long));

Moving a pointer from the middle of a struct to
the end seems unusual for coccinelle.


