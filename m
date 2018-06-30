Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5BAC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 12:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814A6249FE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 12:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814A6249FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936964AbeF3MDs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 08:03:48 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37980 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936201AbeF3MDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 08:03:46 -0400
Received: from localhost (unknown [183.108.164.149])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 945A0144C612D;
        Sat, 30 Jun 2018 05:03:44 -0700 (PDT)
Date:   Sat, 30 Jun 2018 21:03:42 +0900 (KST)
Message-Id: <20180630.210342.804224843120744818.davem@davemloft.net>
To:     lipeng321@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com
Subject: Re: [PATCH net-next 05/10] net: hns3: using modulo for cyclic
 counters in hclge_cmd_send
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1530271385-49668-6-git-send-email-lipeng321@huawei.com>
References: <1530271385-49668-1-git-send-email-lipeng321@huawei.com>
        <1530271385-49668-6-git-send-email-lipeng321@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 30 Jun 2018 05:03:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>
Date: Fri, 29 Jun 2018 19:23:00 +0800

> @@ -228,8 +228,7 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
>  		desc_to_use = &hw->cmq.csq.desc[hw->cmq.csq.next_to_use];
>  		*desc_to_use = desc[handle];
>  		(hw->cmq.csq.next_to_use)++;
> -		if (hw->cmq.csq.next_to_use == hw->cmq.csq.desc_num)
> -			hw->cmq.csq.next_to_use = 0;
> +		hw->cmq.csq.next_to_use %= hw->cmq.csq.desc_num;
>  		handle++;

I would advise against this.

The "%" modulus operation takes many cpu cycles, and the current code
is thus much faster.
