Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06618ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B5C21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="j+bnPm8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B5C21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeJQXRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:17:36 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.132]:35518 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1539789683;
        s=strato-dkim-0002; d=as-electronics.de;
        h=Date:Message-ID:Subject:From:Cc:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=C6EY7uOX0QNZR871Nv8ev4y4/7sFWMIzE+oda5L4baU=;
        b=j+bnPm8kkeNbdip+qcok4YjWhu3jik73/poEmr6rYAjyLR70LTwfCMhk/YHCMSO0MG
        Owp1Bj0hXl5vxq4oRPdyMJXqQrVmkWwg+QM7WIeY3ZvZWKr90bzljK7QNO0WTDiFw+Xu
        RiJmmumrV1rni/CN9UsuUlJieS77miJ1IwhbzOqGCBXI5FrCYl785igILmkkHS/JI1aw
        QuKXpdD0Xq98TTtPA9rFpKahn68zwRpmWg7nMEinr1LyIhAdudjTROZ0dtB+knB0BEeq
        QYgBWSac9FSyJV3h0uSw8cxuXA0iznbn/LK9ACmVsRxwQcjxWjR6SQlffx7FQb5BRupe
        vOOQ==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyOl37jyAS87PDYc9YKfwuBYn/jMBd7vlJpQPmeB0vtXIc5Jks="
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2001:16b8:2486:2400:6544:b26:3ad8:8c5e]
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id j097e4u9HFLCDgg
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 17 Oct 2018 17:21:12 +0200 (CEST)
To:     Steve Glendinning <steve.glendinning@shawell.net>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: SMSC9730 Autosuspend/Resume Questions
Message-ID: <69e14429-a4d9-dd5c-5e70-c22086490cc0@exceet.de>
Date:   Wed, 17 Oct 2018 17:21:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently tested a board with SMSC9730 connected via USB HSIC to an 
i.MX6S SOC. I used these patches on top of v4.14-rc8 for the USB HSIC 
support: [1].

When I turned on autosuspend, the smsc95xx stopped in the middle of the 
suspending routine and 
/sys/bus/usb/devices/usb3/3-1/power/runtime_status reported "suspending" 
forever.

With some debug logs I found out, that the last line of code that was 
executed is [2], after that I didn't get any further messages.

Then I applied the following diff and the suspend/resume started to work 
reliably:

@@ -1382,10 +1385,11 @@ static int smsc95xx_link_ok_nopm(struct usbnet *dev)
         ret = smsc95xx_mdio_read_nopm(dev->net, mii->phy_id, MII_BMSR);
         if (ret < 0)
                 return ret;
-
+       /*
         ret = smsc95xx_mdio_read_nopm(dev->net, mii->phy_id, MII_BMSR);
         if (ret < 0)
                 return ret;
+       */

         return !!(ret & BMSR_LSTATUS);
  }

So it seems like the dummy read, that is commented with "first, a dummy 
read, needed to latch some MII phys" causes problems in my setup. Do you 
have an idea what could be the reason? Is this a proper fix?

Thanks,
Frieder

[1] https://patchwork.kernel.org/cover/10643089/
[2] 
https://github.com/torvalds/linux/blob/bab5c80b211035739997ebd361a679fa85b39465/drivers/net/usb/smsc95xx.c#L1382
