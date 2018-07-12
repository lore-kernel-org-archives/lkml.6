Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E4BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D7321471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D7321471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeGLGGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:06:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54488 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeGLGGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:06:20 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 917FE13FE78A7;
        Wed, 11 Jul 2018 22:58:21 -0700 (PDT)
Date:   Wed, 11 Jul 2018 22:58:21 -0700 (PDT)
Message-Id: <20180711.225821.1348569242901912298.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: hso: use swap macro in hso_kick_transmit
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180709154048.GA32345@embeddedor.com>
References: <20180709154048.GA32345@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Jul 2018 22:58:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 9 Jul 2018 10:40:48 -0500

> @@ -1748,14 +1747,11 @@ static void hso_kick_transmit(struct hso_serial *serial)
>  		goto out;
>  
>  	/* Switch pointers around to avoid memcpy */
> -	temp = serial->tx_buffer;
> -	serial->tx_buffer = serial->tx_data;
> -	serial->tx_data = temp;
> +	swap(serial->tx_buffer, serial->tx_data);
>  	serial->tx_data_count = serial->tx_buffer_count;
>  	serial->tx_buffer_count = 0;
>  
> -	/* If temp is set, it means we switched buffers */
> -	if (temp && serial->write_data) {
> +	if (serial->write_data) {

I think temp can be NULL here, you have to retain this check.
