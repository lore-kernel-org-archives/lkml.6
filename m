Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A66C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5EE2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dy+kgERA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xo3ghD6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbeL1LZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:25:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbeL1LZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:25:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 822FA6053B; Fri, 28 Dec 2018 11:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545996338;
        bh=wjrL2rEhZUVUpTPdWN6/twFVaY62HNxrxxejuWi7Omk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dy+kgERA99gIXaz81t2HSwYyl4KNRPJzeEzl6TV/MP9g2ZljvXQl6n9Q3KtBeKQHl
         +kpRRtJg8/7O4b8ZrIwWGHbJjJKBw2msnjQoZjY6AMWinxoZgO7EvVtYpo7NZfurNM
         MYpDZONvEx5/c/8JH3oZC7VG4Jb/+bmXOw0B24qY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BCB8560364;
        Fri, 28 Dec 2018 11:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545996337;
        bh=wjrL2rEhZUVUpTPdWN6/twFVaY62HNxrxxejuWi7Omk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xo3ghD6BNBiGWVa7f/m/5iM5Ncxo59j8MzoTbsFIbocnix9C+XK5Gtm7EdeZ2LG9x
         OOVFT1cAtevbcNVa5f6Q4M6gFRG+o0Kv6uXEvolR7oEReqCBJKyRgglMHyRHh10H54
         +abECGLfCzRKf4OmMunQb6tIov3sFmJgtDb/plL4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Dec 2018 16:55:37 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 5/6] Bluetooth: hci_qca: Update baudrate change wait
 time for wcn3990
In-Reply-To: <20181227210023.GL261387@google.com>
References: <20181227073136.8431-1-bgodavar@codeaurora.org>
 <20181227073136.8431-6-bgodavar@codeaurora.org>
 <20181227210023.GL261387@google.com>
Message-ID: <b527c36b08400bf8737814a7dc9bd736@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-12-28 02:30, Matthias Kaehlcke wrote:
> On Thu, Dec 27, 2018 at 01:01:35PM +0530, Balakrishna Godavarthi wrote:
>> This patch will update the baudrate change request wait time from
>> 300 ms to 100 ms. When host sends the change baudrate request to
>> the controller, controller sets its clock and wait until the
>> clocks settle down. Here the Wait time is required for both
>> host and controller to be on sync.
> 
> Ultimately up to you, but I would advise against adding 'improvement'
> changes to this series. The scope of the series is already fairly
> vague ("Bug fixes for Qualcomm BT chip wcn3990"), with at least some
> patches that could be sent individually, which would reduce churn when
> respinning.

[Bala]: yes your correct will send this as improvement patch once the 
series is merged.

> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> 
>> Changes in v6:
>>  * intial patch.
>> 
>> ---
>>  drivers/bluetooth/hci_qca.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 4677a6a2716a..61b0fb1ff32f 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -60,7 +60,8 @@
>> 
>>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
>> -#define BAUDRATE_SETTLE_TIMEOUT_MS	300
>> +#define ROME_BD_SETTLE_TIMEOUT_MS	300
>> +#define WCN3990_BD_SETTLE_TIMEOUT_MS	100
> 
> My testing suggests that even the lower 100 ms delay isn't needed, if
> different parts that require a delay are addressed more specifically,
> instead of using a single long 'settle' delay
> (https://lore.kernel.org/patchwork/patch/1026795/#1212816 has some
> details).
> 
[Bala]: i to agree with you. but from the point 1, we have many chances 
of getting
         baudrate change delay. after lot of stress test and experiments 
we found 100 ms is reasonable to handle all
         of them together.

> My idea was to sent a patch after this series has landed to avoid
> interfering with it.
> 

[Bala]: sure will drop this change from the series.

> Cheers
> 
> Matthias

-- 
Regards
Balakrishna.
