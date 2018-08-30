Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B29C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F6720661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Nf6bpcAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F6720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeH3HRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:17:53 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47127 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbeH3HRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=x6lOFO8axt5lNjw4SxnvQZfOf3U10ri8LWL9iM+0skg=;
        b=Nf6bpcAseX0LYgv/zvg0KJB4wiNQEpnunDMju1JNIDuwev8ZqMD+3TVHIV4v4IV5tJ8Lg83jr6ieESIa3YYfaLuGrVpww7rCpSdLYrrVgrjhtntHdQGvPT3SOWj8VEwzJsQH3L3Axa8zSOjdaryV3WhNkby9OU9szNz02OD/5l4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fvDSs-0004wJ-59; Thu, 30 Aug 2018 05:17:46 +0200
Date:   Thu, 30 Aug 2018 05:17:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     xiongsujuan <xiongsujuan.xiongsujuan@huawei.com>
Cc:     davem@davemloft.net, zhaochen6@huawei.com,
        aviad.krawczyk@huawei.com, romain.perier@collabora.com,
        bhelgaas@google.com, keescook@chromium.org,
        colin.king@canonical.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] add huawei ibma driver modules The driver is used for
 communication between in-band management agent(iBMA) and out-of-band
 management controller(iBMC) via pcie bus in Huawei V3 server. The driver
 provides character device,VNIC and black box interface for application
 layer.
Message-ID: <20180830031746.GD16896@lunn.ch>
References: <1535591472-44997-1-git-send-email-xiongsujuan.xiongsujuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535591472-44997-1-git-send-email-xiongsujuan.xiongsujuan@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:11:12AM +0800, xiongsujuan wrote:

Hi xiongsujuan

Please add a real commit message. Talk about the architecture, etc.

You are also missing a Signed-off-by:

> +const struct file_operations g_bma_cdev_fops = {
> +	.owner = THIS_MODULE,
> +	.open = cdev_open,
> +	.release = cdev_release,
> +	.poll = cdev_poll,
> +	.read = cdev_read,
> +	.write = cdev_write,
> +};
> +
> +static int __init bma_cdev_init(void)
> +{
> +	int i = 0;
> +
> +	int ret = 0;
> +	int err_count = 0;
> +
> +	if (!bma_intf_check_edma_supported())
> +		return -ENXIO;
> +
> +	if (dev_num <= 0 || dev_num > CDEV_MAX_NUM)
> +		return -EINVAL;
> +
> +	memset(&g_cdev_set, 0, sizeof(struct cdev_dev_set));
> +	g_cdev_set.dev_num = dev_num;
> +
> +	for (i = 0; i < dev_num; i++) {
> +		struct cdev_dev *pDev = &g_cdev_set.dev_list[i];
> +
> +		sprintf(pDev->dev_name, "%s%d", CDEV_NAME_PREFIX, i);
> +		pDev->dev_struct.name = pDev->dev_name;
> +		pDev->dev_struct.minor = MISC_DYNAMIC_MINOR;
> +		pDev->dev_struct.fops = &g_bma_cdev_fops;
> +
> +		pDev->dev_id = CDEV_INVALID_ID;
> +
> +		ret = misc_register(&pDev->dev_struct);
> +
> +		if (ret) {
> +			CDEV_LOG(DLOG_DEBUG, "misc_register failed %d", i);
> +			err_count++;
> +			continue;
> +		}
> +
> +		pDev->dev_id = MKDEV(MISC_MAJOR, pDev->dev_struct.minor);
> +
> +		ret = bma_intf_register_type(TYPE_CDEV + i, 0, INTR_DISABLE,
> +					     &pDev->dev_data);
> +
> +		if (ret) {
> +			CDEV_LOG(DLOG_ERROR,
> +				 "cdev %d open failed ,result = %d",
> +				 i, ret);
> +		misc_deregister(&pDev->dev_struct);

I've never seen a Ethernet driver with a cdev. You need to explain
this. What is it, why does it exist, etc.

      Andrew
