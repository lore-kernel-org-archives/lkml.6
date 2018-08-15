Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DBFC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333672156F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=compulab.co.il header.i=@compulab.co.il header.b="XC6xrx1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333672156F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=compulab.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbeHORVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:21:22 -0400
Received: from softlayer.compulab.co.il ([50.23.254.55]:48861 "EHLO
        compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbeHORVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=compulab.co.il; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q2iOGqvRX4JidMPIiwvTe87c1fEiiFbJAPaYn4vO3s0=; b=XC6xrx1yIbHg3z4UdsnQU0sxbz
        VYs40cSPOIwkbWNa/V+KBhhcy797bA1jfkt4HFJCc10PFkJgWy+QlO0bKSFrKv7PK3TfY3XV+xUSE
        SLgjvtZ8TB/JHiRQLrprlnkFPbM5u34mS76wJT1Xu/gw2a08UlyxRTHBL4ettVKlOBQnuSplVuS0S
        ekUqtdH5MLnuGOxZPslN5paQ30IwVqFxBu08C3Xd6HixEMUcklln222HPBncfQiE+mi17OuVhzeXs
        7T7b+jvuj7Xqv3RNVsu1OskNQ3HMz+RCdtDwC3Gj3pDb+D0Z7vyQz18A1rtWnAbycIuGp0Gsxapct
        837NQAyg==;
Received: from [37.142.126.90] (port=53455 helo=zimbra-mta.compulab.co.il)
        by softlayer.compulab.co.il with esmtp (Exim 4.87)
        (envelope-from <kirill.kapranov@compulab.co.il>)
        id 1fpwnC-0003LQ-Iq; Wed, 15 Aug 2018 17:28:58 +0300
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 3A29B483148;
        Wed, 15 Aug 2018 17:28:57 +0300 (IDT)
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
        by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bCcDD_hmfxhb; Wed, 15 Aug 2018 17:28:56 +0300 (IDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id AED4048314A;
        Wed, 15 Aug 2018 17:28:56 +0300 (IDT)
X-Virus-Scanned: amavisd-new at zimbra-mta.compulab.co.il
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
        by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OCG2HcOq-VGx; Wed, 15 Aug 2018 17:28:56 +0300 (IDT)
Received: from [192.168.11.10] (lifshitz-linux.compulab.local [192.168.11.10])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTPSA id 8753A483148;
        Wed, 15 Aug 2018 17:28:56 +0300 (IDT)
From:   Kirill Kapranov <kirill.kapranov@compulab.co.il>
Organization: CompuLab Ltd.
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.stach@pengutronix.de
Subject: Re2: [PATCH] spi:fix IDR collision on systems with both fixed and
 dynamic SPI bus numbers
Message-ID: <13c72347-d1fc-6250-3ec4-2066f9fd5e1c@compulab.co.il>
Date:   Wed, 15 Aug 2018 17:28:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - softlayer.compulab.co.il
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - compulab.co.il
X-Get-Message-Sender-Via: softlayer.compulab.co.il: acl_c_recent_authed_mail_ips_text_entry: kirill.kapranov@compulab.co.il|compulab.co.il
X-Authenticated-Sender: softlayer.compulab.co.il: kirill.kapranov@compulab.co.il
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 05:18 PM, Mark Brown wrote:
 > Is this something that's actually happened for you?

Yes, I observed it.

Background:
The platform: fitlet2 [1] , CPU Intel(R) Celeron(R) CPU J3455 @ 1.50GHz.
On an extension board there are three SPI master controllers "Intel 
Corporation Atom/Celeron/Pentium Processor N4200/N3350/E3900 Series SPI 
Controller", controlled with spi_pxa2xx_platform  driver,
and two USB/SPI bridges "FT232H Single HS USB-UART/FIFO IC".

I'm working on a driver for FT232H bridge and saw the following:
spi_pxa2xx driver occupy IDs 1,2,3 this way [2].
Thus when my code tries to get ID automatically (set spi_master.bus_num= 
-1), it gets IDs 0 and 1, that leads a crash.

BTW, I haven't the faintest idea, how to cure this problem in the 
opposite case: when a device that gets ID dynamically squats an ID 
purposed for a device that uses a fixed numbering order.

 >> +    } else {
 >> +    /* devices with a fixed bus num must check-in with the num */
 >> +        mutex_lock(&board_lock);
 > The indentation here is weird, the comment isn't aligned with the code
 > it's commenting on.
I'm sorry for the oversight, it'll be fixed.

[1] https://fit-iot.com/web/products/fitlet2/
[2] 
https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-pxa2xx.c#L1361

