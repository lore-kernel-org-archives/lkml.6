Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 22EA8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF7720891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF7720891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965375AbeFOCAU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:00:20 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52038 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965063AbeFOCAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:00:19 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7FA9B10080D12;
        Thu, 14 Jun 2018 19:00:18 -0700 (PDT)
Date:   Thu, 14 Jun 2018 19:00:18 -0700 (PDT)
Message-Id: <20180614.190018.1696051015226293779.davem@davemloft.net>
To:     jiazhouyang09@gmail.com
Cc:     santosh@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: cxgb3: add error handling for sysfs_create_group
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1528984571-53320-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528984571-53320-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Jun 2018 19:00:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>
Date: Thu, 14 Jun 2018 21:56:11 +0800

> diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
> index 2edfdbd..73d6aa9 100644
> --- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
> @@ -3362,6 +3362,10 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	err = sysfs_create_group(&adapter->port[0]->dev.kobj,
>  				 &cxgb3_attr_group);
> +	if (err) {
> +		dev_err(&pdev->dev, "cannot create sysfs group\n");
> +		goto out_free_dev;
> +	}

You have to do more than this to cleanup.  For example, you have to
change the LED state back, as it has just been set to indicate that
the interface is operational.
