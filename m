Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F1BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE2522360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kHeCwmRA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NsOhAXZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE2522360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbeKNQbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:31:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeKNQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 11:31:43 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0D6FE60251; Wed, 14 Nov 2018 06:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542176993;
        bh=hKEJMHuitp0A32a7sK1SD2ksIg5m79C8I1x34r1dVvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kHeCwmRAGiZabjwt9OL9rT4xbzvfLaDJWjaQUKOuCNEYJ9frSHEAptn3d+gHj4pDT
         n/tWQTuqKaqrIQwyIE74CbH1/6GKkJ6y15UgzOGOVblvgNCaf7X3lwjSBeHLfkzhh/
         8VbUtmnYFQoohJpwVJMSwjDSIXudBtXCIlPlQjqU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 313016022B;
        Wed, 14 Nov 2018 06:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542176992;
        bh=hKEJMHuitp0A32a7sK1SD2ksIg5m79C8I1x34r1dVvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NsOhAXZ+cZzwmDBeFAs5OjBcquvvwRz8AxJaZFPYtT/ETCHDDuTmLHoyWBEHJR/GB
         cZc0pm/e5B3TPf1dwcw+6/bul+1PvaJ2CqzRqBcd6MsLfY2q9cRIEoD95fxXzKjri9
         FxGfl87Z6SuKv3uF1wuhOjBe2tDevwQTkd4Pe2Nc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Nov 2018 11:59:52 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 1/4] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
In-Reply-To: <20181114001717.GG22824@google.com>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-2-bgodavar@codeaurora.org>
 <20181114001717.GG22824@google.com>
Message-ID: <e535e67b3abdb4c98edb2c9e8312ff3d@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-11-14 05:47, Matthias Kaehlcke wrote:
> On Tue, Nov 06, 2018 at 05:35:25PM +0530, Balakrishna Godavarthi wrote:
>> wcn3990 requires a power pulse to turn ON/OFF along with
>> regulators. Sometimes we are observing the power pulses are sent
>> out with some time delay, due to queuing these commands. This is
>> causing synchronization issues with chip, which intern delay the
>> chip setup or may end up with communication issues.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 22 +++++++++-------------
>>  1 file changed, 9 insertions(+), 13 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index f72ded4ec9ae..051f081d1835 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1016,8 +1016,7 @@ static inline void host_set_baudrate(struct 
>> hci_uart *hu, unsigned int speed)
>>  static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>>  {
>>  	struct hci_uart *hu = hci_get_drvdata(hdev);
>> -	struct qca_data *qca = hu->priv;
>> -	struct sk_buff *skb;
>> +	int ret;
>> 
>>  	/* These power pulses are single byte command which are sent
>>  	 * at required baudrate to wcn3990. On wcn3990, we have an external
>> @@ -1030,18 +1029,14 @@ static int qca_send_power_pulse(struct hci_dev 
>> *hdev, u8 cmd)
>>  	 * sending power pulses to SoC.
>>  	 */
>>  	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
>> -
>> -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
>> -	if (!skb)
>> -		return -ENOMEM;
>> -
>>  	hci_uart_set_flow_control(hu, true);
>> +	ret = serdev_device_write(hu->serdev, &cmd, sizeof(cmd), 0);
>> +	if (ret < 0) {
>> +		bt_dev_err(hdev, "failed to send power pulse %02x to SoC", cmd);
>> +		return ret;
>> +	}
>> 
>> -	skb_put_u8(skb, cmd);
>> -	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> -
>> -	skb_queue_tail(&qca->txq, skb);
>> -	hci_uart_tx_wakeup(hu);
>> +	serdev_device_wait_until_sent(hu->serdev, 0);
>> 
>>  	/* Wait for 100 uS for SoC to settle down */
>>  	usleep_range(100, 200);
> 
> Is the delay still needed now that we wait for the pulse to be sent? I
> didn't observe any problems without it in a few dozens of iterations.
> 
[Bala]: chip require some time to boot up
         so this delay will helps us to be in sync with the chip. for now
         we will go with this delay, if really required we can change 
100us to some where
         around 10us.

>> @@ -1283,7 +1278,8 @@ static void qca_power_shutdown(struct hci_uart 
>> *hu)
>> 
>>  	host_set_baudrate(hu, 2400);
>>  	hci_uart_set_flow_control(hu, true);
>> -	serdev_device_write_buf(serdev, &cmd, sizeof(cmd));
>> +	serdev_device_write(serdev, &cmd, sizeof(cmd), 0);
>> +	serdev_device_wait_until_sent(serdev, 0);
>>  	hci_uart_set_flow_control(hu, false);
> 
> You could call qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE)
> instead, as an earlier patch set did before skbs were used to send the
> power pulse.
> 

[Bala]: will update.

> You can also consider to set the baudrate in qca_send_power_pulse()
> depending on the power pulse. On the plus side this would reduce a bit
> of clutter in the callers of qca_send_power_pulse(), on the negative
> side it would be harder to follow when baudrate changes occur (not
> sure this is a problem). Up to you, just an idea.
> 
[Bala]:  moving bd change request to power_pulse has both plus & minus 
side.
          but my opinion is let us we leave qca_send_power_pulse() to be 
generic
          might be feature chip will use the same function with an 
different bd.

> Thanks
> 
> Matthias

-- 
Regards
Balakrishna.
