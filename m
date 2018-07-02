Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087F0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF26B25C62
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF26B25C62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965371AbeGBLXb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:23:31 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:43098 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965131AbeGBLXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:23:30 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 1C155634C83;
        Mon,  2 Jul 2018 14:23:28 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1fZwvX-0001Uk-T9; Mon, 02 Jul 2018 14:23:27 +0300
Date:   Mon, 2 Jul 2018 14:23:27 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Steve Longerbeam <slongerbeam@gmail.com>
Cc:     linux-media@vger.kernel.org,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 15/17] media: platform: Switch to
 v4l2_async_notifier_add_subdev
Message-ID: <20180702112327.3rzfxmhghoakbcyz@valkosipuli.retiisi.org.uk>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
 <1530298220-5097-16-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530298220-5097-16-git-send-email-steve_longerbeam@mentor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:49:59AM -0700, Steve Longerbeam wrote:
> diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
> index a96f53c..8464ceb 100644
> --- a/drivers/media/platform/davinci/vpif_capture.c
> +++ b/drivers/media/platform/davinci/vpif_capture.c
> @@ -1553,7 +1553,7 @@ vpif_capture_get_pdata(struct platform_device *pdev)
>  					    sizeof(*chan->inputs),
>  					    GFP_KERNEL);
>  		if (!chan->inputs)
> -			return NULL;
> +			goto err_cleanup;
>  
>  		chan->input_count++;
>  		chan->inputs[i].input.type = V4L2_INPUT_TYPE_CAMERA;
> @@ -1587,28 +1587,30 @@ vpif_capture_get_pdata(struct platform_device *pdev)
>  			rem->name, rem);
>  		sdinfo->name = rem->full_name;
>  
> -		pdata->asd[i] = devm_kzalloc(&pdev->dev,
> -					     sizeof(struct v4l2_async_subdev),
> -					     GFP_KERNEL);
> -		if (!pdata->asd[i]) {
> +		pdata->asd[i] = v4l2_async_notifier_add_fwnode_subdev(
> +			&vpif_obj.notifier, of_fwnode_handle(rem),
> +			sizeof(struct v4l2_async_subdev));
> +		if (IS_ERR(pdata->asd[i])) {
>  			of_node_put(rem);
> -			pdata = NULL;
> -			goto done;
> +			goto err_cleanup;
>  		}
>  
> -		pdata->asd[i]->match_type = V4L2_ASYNC_MATCH_FWNODE;
> -		pdata->asd[i]->match.fwnode = of_fwnode_handle(rem);
> -		of_node_put(rem);
> +		of_node_put(endpoint);

You end up putting the same endpoint twice in the successful case.

One way to address that would be to get the OF node's remote port parent
(i.e. the device) immediately so you can forget OF node use counts in error
handling.

>  	}
>  
>  done:
> -	if (pdata) {
> -		pdata->asd_sizes[0] = i;
> -		pdata->subdev_count = i;
> -		pdata->card_name = "DA850/OMAP-L138 Video Capture";
> -	}
> +	of_node_put(endpoint);
> +	pdata->asd_sizes[0] = i;
> +	pdata->subdev_count = i;
> +	pdata->card_name = "DA850/OMAP-L138 Video Capture";
>  
>  	return pdata;
> +
> +err_cleanup:
> +	v4l2_async_notifier_cleanup(&vpif_obj.notifier);
> +	of_node_put(endpoint);
> +
> +	return NULL;
>  }

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
