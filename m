Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484D6ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E08E20866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E08E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeJSGp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:45:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41942 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeJSGp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:45:28 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 80606140A9E01;
        Thu, 18 Oct 2018 15:42:19 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:42:19 -0700 (PDT)
Message-Id: <20181018.154219.1246620018001438422.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2] isdn: hfc_{pci,sx}: Avoid empty body if statements
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181018034935.16819-1-natechancellor@gmail.com>
References: <20181017180657.9410-1-natechancellor@gmail.com>
        <20181018034935.16819-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Oct 2018 15:42:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Wed, 17 Oct 2018 20:49:36 -0700

> @@ -228,8 +228,8 @@ typedef union {
>  } fifo_area;
>  
>  
> -#define Write_hfc(a, b, c) (*(((u_char *)a->hw.hfcpci.pci_io) + b) = c)
> -#define Read_hfc(a, b) (*(((u_char *)a->hw.hfcpci.pci_io) + b))
> +#define Write_hfc(a, b, c) (writeb(c, (a->hw.hfcpci.pci_io) + b))
> +#define Read_hfc(a, b) (readb((a->hw.hfcpci.pci_io) + b))

This will add new kinds of warnings.

The problem is that readb/writeb/etc. take an __iomem pointer, but pci_io
is declared as plain "unsigned char *".  It should be something like
"void * __iomem" of similar.
