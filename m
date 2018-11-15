Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2255AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF323208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ivwMDfEM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LAbmLrXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF323208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbeKPAml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:42:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51322 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKPAml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:42:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 47A8461310; Thu, 15 Nov 2018 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542292476;
        bh=xaFaJuhxeA0F2SUUV8a2E1LPngaLvBnPIYiWLBbAG9o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ivwMDfEMsKx35AGnS9yqPOS4bh12isGWNjJBSboOCUyZGZH9qLmZo2TYuSlVOLoKQ
         m3GU+GKOONG/Vgb3n5ccvUM6981FnJ1nAhlrUf7ty63NSs5O5UV9dNHNT7CwqfwvFZ
         F3ywwu67w654SPr2D8a4v+kysTxmfi2hn6/OHjyg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 72C7161320;
        Thu, 15 Nov 2018 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542292469;
        bh=xaFaJuhxeA0F2SUUV8a2E1LPngaLvBnPIYiWLBbAG9o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LAbmLrXL7JzMSXqQBwNVVRf/RKps9a7H7xyLxnGItcw0xnpW5/pa5G47ajMkv74OC
         dQiqz7KslEPBRABLcqYLgNturzip0s01B0lEJCgZmp8SySDOReMSOYHAAEVcIXY7Vs
         KUYjnqxOq0u4K3h9UAADXzue9X+FbQzduCcCEdP4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Nov 2018 20:04:29 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v1 1/4] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
In-Reply-To: <20181114152722.GA19900@localhost>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-2-bgodavar@codeaurora.org>
 <20181114152722.GA19900@localhost>
Message-ID: <e2362ad539463a3a139419b93ccca831@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 2018-11-14 20:57, Johan Hovold wrote:
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
> 
> Don't you want a non-zero timeout here? Otherwise you might as well 
> call
> serdev_device_write() directly.
> 

[Bala]: we need an in definite timeout for these commands. will use 
HCI_UART_TX_WAKEUP.

> Also have you made sure that serdev_device_write_wakeup() is called in
> the drivers write-wakeup callback as serdev_device_write() requires?
> 
> See this series in case what you really wanted was to wait indefinitely
> (you can use MAX_SCHEDULE_TIMEOUT):
> 
> 	https://lkml.kernel.org/r/<20181114150904.19653-1-johan@kernel.org>
> 

[Bala]: thanks for pointers. from 
https://lore.kernel.org/patchwork/patch/1012358/
         it was clear to me that i need call below functions in order to 
wait until full data is sent.

         serdev_device_write_wakeup()
         serdev_device_write()
         serdev_device_wait_until_sent()

         correct me whether my understanding is correct.

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
>> @@ -1283,7 +1278,8 @@ static void qca_power_shutdown(struct hci_uart 
>> *hu)
>> 
>>  	host_set_baudrate(hu, 2400);
>>  	hci_uart_set_flow_control(hu, true);
>> -	serdev_device_write_buf(serdev, &cmd, sizeof(cmd));
>> +	serdev_device_write(serdev, &cmd, sizeof(cmd), 0);
> 
> Same here.
> 
>> +	serdev_device_wait_until_sent(serdev, 0);
>>  	hci_uart_set_flow_control(hu, false);
>>  	qca_power_setup(hu, false);
>>  }
> 
> Johan

-- 
Regards
Balakrishna.
