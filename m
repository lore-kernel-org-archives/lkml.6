Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD47ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E297F20C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E297F20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJSIyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:54:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43836 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeJSIyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:54:38 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0BFCA140DB56D;
        Thu, 18 Oct 2018 17:50:59 -0700 (PDT)
Date:   Thu, 18 Oct 2018 17:50:58 -0700 (PDT)
Message-Id: <20181018.175058.827953425036498775.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2] isdn: hfc_{pci,sx}: Avoid empty body if statements
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181019004251.GA28878@flashbox>
References: <20181019002117.GA10161@flashbox>
        <20181018.172310.35380794084221855.davem@davemloft.net>
        <20181019004251.GA28878@flashbox>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Oct 2018 17:50:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Thu, 18 Oct 2018 17:42:51 -0700

> On Thu, Oct 18, 2018 at 05:23:10PM -0700, David Miller wrote:
>> From: Nathan Chancellor <natechancellor@gmail.com>
>> Date: Thu, 18 Oct 2018 17:21:17 -0700
>> 
>> > Thanks for the review, I went ahead and compiled with the following diff
>> > on top of v2 and got no warnings from Clang, GCC, or sparse, does this
>> > seem satisfactory for v3?
>> 
>> Well, one thing I notice.
>> 
> 
>> > @@ -86,7 +86,7 @@ release_io_hfcpci(struct IsdnCardState *cs)
>> >         pci_free_consistent(cs->hw.hfcpci.dev, 0x8000,
>> >                             cs->hw.hfcpci.fifos, cs->hw.hfcpci.dma);
>> >         cs->hw.hfcpci.fifos = NULL;
>> > -       iounmap((void *)cs->hw.hfcpci.pci_io);
>> > +       iounmap(cs->hw.hfcpci.pci_io);
>> >  }
>> 
>> Driver uses iounmap().
>> 
>> > @@ -1692,7 +1692,7 @@ setup_hfcpci(struct IsdnCard *card)
>> >                 printk(KERN_WARNING "HFC-PCI: No IRQ for PCI card found\n");
>> >                 return (0);
>> >         }
>> > -       cs->hw.hfcpci.pci_io = (char *)(unsigned long)dev_hfcpci->resource[1].start;
>> > +       cs->hw.hfcpci.pci_io = (void __iomem *)(unsigned long)dev_hfcpci->resource[1].start;
>> >         printk(KERN_INFO "HiSax: HFC-PCI card manufacturer: %s card name: %s\n", id_list[i].vendor_name, id_list[i].card_name);
>> 
>> But does not use iomap().  You won't need any cast here if it did use
>> iomap() properly.
>> 
>> Thanks.
> 
> So this?

That's definitely a lot better, yes!

I wonder what exactly it is checking there though.  I guess it wants to see if the
resource->start value is zero and bail with an error it so.

Anyways, this code has been like this for ages and what you are proposing is
definitely a significant improvement.

Thanks.
