Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E859BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D2A215EB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=compulab.co.il header.i=@compulab.co.il header.b="OB5TwkXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D2A215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=compulab.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeI0SWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:22:22 -0400
Received: from softlayer.compulab.co.il ([50.23.254.55]:37019 "EHLO
        compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbeI0SWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=compulab.co.il; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6qAlrdnnE2ZpKAczA3n99Ijrwbldi0Ismp63gSSegUQ=; b=OB5TwkXRHsXRXw7pEUsms8lHzI
        2Ffi6AxNrV8nKciyJz706R1HVzRWT54JcuTHCgaZ74iw7t8dUYGrWhZxekPR3nXHuF1zcQ4sy1n5g
        TfYEqDSSZrmChxaM72fJrZ+gsruJLEMm4MRsU0B/FvJE9zurqbvF5TlIo24DprI3jyXAHaFMwcwgv
        7gB5NDSYUkuWNcMLM/ysmjdaqqbENqIKEjl+2Iq3tPceO2B37YbdWSMC1u3f+WX/mGLsZnRgNcSa+
        078zU6SWQYnocCz6RQ1IQN8bHDjje5RmOCWTLXYjaPuu+052r5UZcYtKoV6Q2atr0pRkRuW1yFaVJ
        3mApfYgg==;
Received: from [37.142.126.90] (port=35361 helo=zimbra-mta.compulab.co.il)
        by softlayer.compulab.co.il with esmtp (Exim 4.87)
        (envelope-from <kirill.kapranov@compulab.co.il>)
        id 1g5V1q-00071o-TN; Thu, 27 Sep 2018 15:04:23 +0300
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 984974823AF;
        Thu, 27 Sep 2018 15:04:21 +0300 (IDT)
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
        by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QKTrhSpW6oWj; Thu, 27 Sep 2018 15:04:21 +0300 (IDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 2F5854823B4;
        Thu, 27 Sep 2018 15:04:21 +0300 (IDT)
X-Virus-Scanned: amavisd-new at zimbra-mta.compulab.co.il
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
        by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ro7m7Whn4amJ; Thu, 27 Sep 2018 15:04:21 +0300 (IDT)
Received: from [192.168.11.10] (lifshitz-linux.compulab.local [192.168.11.10])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTPSA id F3E654823AF;
        Thu, 27 Sep 2018 15:04:20 +0300 (IDT)
Subject: Re: [PATCH 4.14 31/64] spi: fix IDR collision on systems with both
 fixed and dynamic SPI bus numbers
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Mark Brown <broonie@kernel.org>
References: <CADVatmMTY0NHJFUOeScJGv=Jb=gCQwgrbeTmW6vkedw8rj1ELw@mail.gmail.com>
From:   Kirill Kapranov <kirill.kapranov@compulab.co.il>
Organization: CompuLab Ltd.
Message-ID: <5055ed3a-2f29-505d-ccb3-0e0a35d8fb73@compulab.co.il>
Date:   Thu, 27 Sep 2018 15:04:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CADVatmMTY0NHJFUOeScJGv=Jb=gCQwgrbeTmW6vkedw8rj1ELw@mail.gmail.com>
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

Hi Greg,

Sudip is absolutely right, the patch he mentioned,
  04b2d03a7565 ("spi: Fix double IDR allocation with DT aliases"),
MUST be added too with the mine.

Sudip, thank you for reminding.
-- 
Best Regards,
Kirill

> Hi Greg,
> 
> On Thu, Sep 27, 2018 at 10:03 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> 4.14-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Kirill Kapranov <kirill.kapranov@compulab.co.il>
>>
>> commit 1a4327fbf4554d5b78d75b19a13d40d6de220159 upstream.
>>
>> On systems where some controllers get a dynamic ID assigned and some have
>> a fixed number (e.g. from ACPI tables), the current implementation might
>> run into an IDR collision: in case of a fixed bus number is gotten by a
>> driver (but not marked busy in IDR tree) and a driver with dynamic bus
>> number gets the same ID and predictably fails.
>>
>> Fix this by means of checking-in fixed IDsin IDR as far as dynamic ones
>> at the moment of the controller registration.
>>
>> Fixes: 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
>> Signed-off-by: Kirill Kapranov <kirill.kapranov@compulab.co.il>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> There is another later patch which fixes this patch.
> 
> 04b2d03a7565 ("spi: Fix double IDR allocation with DT aliases") , can
> you please add it to the release also..
> 
> 
> --
> Regards
> Sudip
> 
