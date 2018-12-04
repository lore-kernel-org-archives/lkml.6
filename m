Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F439C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF722081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF722081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeLDRfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:35:14 -0500
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:38398 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbeLDRfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:35:14 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D58E918016848;
        Tue,  4 Dec 2018 17:35:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pain63_84889934f1011
X-Filterd-Recvd-Size: 2630
Received: from XPS-9350 (unknown [172.58.19.243])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  4 Dec 2018 17:35:10 +0000 (UTC)
Message-ID: <062cb874560a1850d7263a8023ce827f32105fc9.camel@perches.com>
Subject: Re: [PATCH 1/4] dma-debug: Use pr_fmt()
From:   Joe Perches <joe@perches.com>
To:     Robin Murphy <robin.murphy@arm.com>, hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com
Date:   Tue, 04 Dec 2018 09:35:08 -0800
In-Reply-To: <7d37a451d27828d487d69c7a0662dbe46ece06ec.1543856576.git.robin.murphy@arm.com>
References: <cover.1543856576.git.robin.murphy@arm.com>
         <7d37a451d27828d487d69c7a0662dbe46ece06ec.1543856576.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 17:28 +0000, Robin Murphy wrote:
> Use pr_fmt() to generate the "DMA-API: " prefix consistently. This
> results in it being added to a couple of pr_*() messages which were
> missing it before, and for the err_printk() calls moves it to the actual
> start of the message instead of somewhere in the middle.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> I chose not to refactor the existing split strings for minimal churn here.
> 
>  kernel/dma/debug.c | 74 ++++++++++++++++++++++++----------------------
>  1 file changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 231ca4628062..91b84140e4a5 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -17,6 +17,8 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
>   */
>  
> +#define pr_fmt(fmt)	"DMA-API: " fmt
> +
>  #include <linux/sched/task_stack.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-mapping.h>
> @@ -234,7 +236,7 @@ static bool driver_filter(struct device *dev)
>  		error_count += 1;					\
>  		if (driver_filter(dev) &&				\
>  		    (show_all_errors || show_num_errors > 0)) {		\
> -			WARN(1, "%s %s: " format,			\
> +			WARN(1, pr_fmt("%s %s: ") format,		\
>  			     dev ? dev_driver_string(dev) : "NULL",	\
>  			     dev ? dev_name(dev) : "NULL", ## arg);	\
>  			dump_entry_trace(entry);			\

I think converting this WARN to

			dev_err(dev, format, ##__VA_ARGS__);
			dump_stack();

would look better and be more intelligible.

Perhaps add a #define for dev_fmt if really necessary.


