Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35276C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043B1206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043B1206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeJFEYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:24:45 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46536 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJFEYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:24:45 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8682413ADF961;
        Fri,  5 Oct 2018 14:24:12 -0700 (PDT)
Date:   Fri, 05 Oct 2018 14:24:12 -0700 (PDT)
Message-Id: <20181005.142412.601607260441380535.davem@davemloft.net>
To:     ben.dooks@codethink.co.uk
Cc:     netdev@vger.kernel.org, David.Laight@ACULAB.COM, oneukum@suse.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH] usbnet: smsc95xx: simplify tx_fixup code
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181002165602.21033-1-ben.dooks@codethink.co.uk>
References: <59988ed22559410881addfecf58335eb@AcuMS.aculab.com>
        <20181002165602.21033-1-ben.dooks@codethink.co.uk>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Oct 2018 14:24:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue,  2 Oct 2018 17:56:02 +0100

> -	memcpy(skb->data, &tx_cmd_a, 4);
> +	ptr = skb_push(skb, 8);
> +	tx_cmd_a = cpu_to_le32(tx_cmd_a);
> +	tx_cmd_b = cpu_to_le32(tx_cmd_b);
> +	memcpy(ptr, &tx_cmd_a, 4);
> +	memcpy(ptr+4, &tx_cmd_b, 4);

Even a memcpy() through a void pointer does not guarantee that gcc will
not emit word sized loads and stores.

You must use the get_unaligned()/put_unaligned() facilities to do this
properly.

I also agree that making a proper type and structure instead of using
a void pointer would be better.
