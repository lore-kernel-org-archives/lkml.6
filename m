Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39040C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13B021567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dpqTBBwA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dpqTBBwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13B021567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeHXOPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:15:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeHXOPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:15:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BC0B76053D; Fri, 24 Aug 2018 10:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535107287;
        bh=hYwDWGunPYpqfE+SibINqPxnIRyFYU2+m1JODfAo5Wc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dpqTBBwAYf64DlVMUxXiakS73BtuBzwvXZROLEssOHbf3nkmOgABjGz73ZI+k5bx8
         Sm4sbKEwARnPy3H19RGGNZdCem4jtP/MjVbBVERNxvACPpKFbYrM5DIKCXL0IOav40
         FJegm8Fvei2rkhE3YuzHH54YFos13HZ36gBaYLw4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id F1B1E6032D;
        Fri, 24 Aug 2018 10:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535107287;
        bh=hYwDWGunPYpqfE+SibINqPxnIRyFYU2+m1JODfAo5Wc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dpqTBBwAYf64DlVMUxXiakS73BtuBzwvXZROLEssOHbf3nkmOgABjGz73ZI+k5bx8
         Sm4sbKEwARnPy3H19RGGNZdCem4jtP/MjVbBVERNxvACPpKFbYrM5DIKCXL0IOav40
         FJegm8Fvei2rkhE3YuzHH54YFos13HZ36gBaYLw4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Aug 2018 16:11:26 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     johan.hedberg@gmail.com, marcel@holtmann.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Bluetooth: hci_qca: Add poweroff support during
 hci down for wcn3990
In-Reply-To: <153509324560.28926.8058929411568681471@swboyd.mtv.corp.google.com>
References: <20180823112935.17342-1-bgodavar@codeaurora.org>
 <20180823112935.17342-2-bgodavar@codeaurora.org>
 <153509324560.28926.8058929411568681471@swboyd.mtv.corp.google.com>
Message-ID: <2c9dd1f73c513a676738a47dd65ffce8@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2018-08-24 12:17, Stephen Boyd wrote:
> Quoting Balakrishna Godavarthi (2018-08-23 04:29:35)
>> This patch enables power off support for hci down and power on support
>> for hci up. As wcn3990 power sources are ignited by regulators, we 
>> will
>> turn off them during hci down, i.e. an complete power off of wcn3990.
>> So while hci up, we will call vendor specific open/close and setup 
>> which
>> will turn on the regulators, requests BT chip version and download the
>> firmware.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index e182f6019f68..98d33c6b8909 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -595,6 +595,9 @@ static int qca_close(struct hci_uart *hu)
>>         struct qca_serdev *qcadev;
>>         struct qca_data *qca = hu->priv;
>> 
>> +       if (!qca)
>> +               return 0;
> 
> Does this happen? If it does it seems like a failure in the caller to
> know what's going on.

[Bala]: yes qca_close() function will execute twice i.e. when we remove 
the BT module.

         while we remove the module,hci_dev_doc_close() will call 
hdev->close() i.e. hci_uart_close() which is Qualcomm specific close.
         in hci_uart_close() we will call qca_close() which will free the 
memory.
         after that proto close will also call qca_close().
         Here hci_uart_close and proto close are assigned to same 
function pointer i.e. qca_close().

-- 
Regards
Balakrishna.
