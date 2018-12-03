Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9381FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582072081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582072081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbeLCE5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:57:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57084 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLCE5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:57:55 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8451314F2BB25;
        Sun,  2 Dec 2018 20:57:53 -0800 (PST)
Date:   Sun, 02 Dec 2018 20:57:52 -0800 (PST)
Message-Id: <20181202.205752.1359988041150979586.davem@davemloft.net>
To:     tiny.windzz@gmail.com
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        sparclinux@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sunsu: add missing of_node_put()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181121160615.23666-1-tiny.windzz@gmail.com>
References: <20181121160615.23666-1-tiny.windzz@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Dec 2018 20:57:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>
Date: Wed, 21 Nov 2018 11:06:15 -0500

> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> This place is not doing this, so fix it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Several coding style problems and you are adding two new
leaks.

> +		struct device_node *tmp;
>  		const char *keyb = of_get_property(ap, "keyboard", NULL);
>  		const char *ms = of_get_property(ap, "mouse", NULL);

Always order local variable declarations from longest to
shortest line.

>  
>  		if (keyb) {
> -			if (dp == of_find_node_by_path(keyb))
> -				return SU_PORT_KBD;
> +			tmp = of_find_node_by_path(keyb);
> +			if (tmp && dp == tmp){

Always put a space between ")" and the "{" openning a new basic
block.

> +				rc = SU_PORT_KBD;
> +				goto out;
> +			}
>  		}
>  		if (ms) {
> -			if (dp == of_find_node_by_path(ms))
> -				return SU_PORT_MS;
> +			tmp = of_find_node_by_path(ms);
> +			if (tmp && dp == tmp){
> +				rc = SU_PORT_MS;
> +				goto out;
> +			}
>  		}
>  	}
>  
> -	return SU_PORT_PORT;
> +out:
> +	of_node_put(ap);
> +	return rc;

Now you have two references, one held by 'ap' and one held by 'tmp'.

You are not releasing the one held by 'tmp', and you must release
'tmp' even if it equals 'dp'.

It's pretty obvious you have no way by which to test these changes and
therefore are not doing so.

