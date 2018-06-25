Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D577FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984A2254D7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984A2254D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeFYGlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:41:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42178 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeFYGlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:41:15 -0400
Received: from localhost (unknown [106.38.54.61])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 27F7D41C;
        Mon, 25 Jun 2018 06:41:14 +0000 (UTC)
Date:   Mon, 25 Jun 2018 14:41:10 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] drivers/base: introduce some help routines for
 reordering a group of dev
Message-ID: <20180625064110.GA4233@kroah.com>
References: <1529904187-18673-1-git-send-email-kernelfans@gmail.com>
 <1529904187-18673-2-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529904187-18673-2-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 01:23:05PM +0800, Pingfan Liu wrote:
> This patch introduce some help routines used by next patch. It aims to
> ease reviewing, while the next patch will concentrate on algorithm.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> ---
>  drivers/base/core.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 36622b5..8113d2c 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -123,6 +123,44 @@ static int device_is_dependent(struct device *dev, void *target)
>  	return ret;
>  }
>  
> +struct pos_info {
> +	struct device *pos;
> +	struct device *tail;
> +};
> +
> +/* caller takes the devices_kset->list_lock */
> +static int descendants_reorder_after_pos(struct device *dev,
> +	void *data)
> +{
> +	struct device *pos;
> +	struct pos_info *p = data;
> +
> +	pos = p->pos;
> +	pr_debug("devices_kset: Moving %s after %s\n",
> +		 dev_name(dev), dev_name(pos));
> +	device_for_each_child(dev, p, descendants_reorder_after_pos);
> +	/* children at the tail */
> +	list_move(&dev->kobj.entry, &pos->kobj.entry);
> +	/* record the right boundary of the section */
> +	if (p->tail == NULL)
> +		p->tail = dev;
> +	return 0;
> +}
> +
> +/* iterate over an open section */
> +#define list_opensect_for_each_reverse(cur, left, right)	\
> +	for (cur = right->prev; cur == left; cur = cur->prev)
> +
> +static bool is_consumer(struct device *query, struct device *supplier)
> +{
> +	struct device_link *link;
> +	/* todo, lock protection */
> +	list_for_each_entry(link, &supplier->links.consumers, s_node)
> +		if (link->consumer == query)
> +			return true;
> +	return false;
> +}

You are adding code that no one uses yet, making this impossible to
review as I don't know what to expect.  I shouldn't have to read the
second patch and have to flip back and forth to try to figure it out :(

sorry, please break this series up in a better way to make it simpler to
review.

greg k-h
