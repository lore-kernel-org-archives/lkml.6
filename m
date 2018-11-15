Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5841CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D0A21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R1ZeWVXa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VmrMpsVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D0A21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbeKOVsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:48:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44102 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbeKOVsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:48:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ADD27601D4; Thu, 15 Nov 2018 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542282044;
        bh=NR1+yVpy0ze4JO3y3RWNPFaacBEau5G84VAuqZnajcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R1ZeWVXaoZs8rgy9XdxcENqdCi71KWNU18/SQ9byfmA1MfCCz/gNoPXy0Mfq2KjZR
         Uubp+oE1CM/4yl8qdZcWQzgvLwnCk8LELK251h7LdjyDvot8tLT5qhuyXicSvjlrD6
         cARMQp6lfGumvVKCCc5SsudmGgxmBpByVxRGkL40=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B7D1E601D4;
        Thu, 15 Nov 2018 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542282043;
        bh=NR1+yVpy0ze4JO3y3RWNPFaacBEau5G84VAuqZnajcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VmrMpsVqoto2mKVAhwJLvx5DVazzN5/Z6L8CwIsFpPstSGOFqqKW+xUihqzpUAuXV
         zwhmLBwGrbdazdQB3LKxSSvchSmng5TWyGtuzSkKtNU1UTZwb3TSfzZQt/CoflgMnQ
         nrXgNLAjPkCdjSxpZmIiXhio9iTU5UPrNbjGmAts=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Nov 2018 17:10:43 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 4/4] Bluetooth: hci_qca: Fix frame reassembly errors
 for wcn3990
In-Reply-To: <20181114193620.GJ22824@google.com>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-5-bgodavar@codeaurora.org>
 <20181114193620.GJ22824@google.com>
Message-ID: <1416876730c5e097fa084f5c7571db6e@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-11-15 01:06, Matthias Kaehlcke wrote:
> On Tue, Nov 06, 2018 at 05:35:28PM +0530, Balakrishna Godavarthi wrote:
>> [  176.929612] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly 
>> failed (-84)
>> [  176.945734] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly 
>> failed (-84)
>> [  176.953298] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly 
>> failed (-84)
>> [  177.010660] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly 
>> failed (-84)
>> [  177.067633] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly 
>> failed (-84)
>> 
>> The above errors log on console due to receiving of stray bytes
>> when wcn3990 boot up's i.e. when during initial setup procedure.
> 
> Please shortly introduce the topic instead of starting with the log
> messages.
> 
[Bala]:  will update.

>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 97b57e0f4725..341f80606574 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -56,6 +56,7 @@
>> 
>>  /* Controller states */
>>  #define STATE_IN_BAND_SLEEP_ENABLED	1
>> +#define STATE_DISCARD_RX		2
>> 
>>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
>> @@ -511,6 +512,7 @@ static int qca_open(struct hci_uart *hu)
>>  		} else {
>>  			hu->init_speed = qcadev->init_speed;
>>  			hu->oper_speed = qcadev->oper_speed;
>> +			set_bit(STATE_DISCARD_RX, &qca->flags);
>>  			ret = qca_power_setup(hu, true);
>>  			if (ret) {
>>  				destroy_workqueue(qca->workqueue);
>> @@ -903,6 +905,13 @@ static int qca_recv(struct hci_uart *hu, const 
>> void *data, int count)
>>  	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
>>  		return -EUNATCH;
>> 
>> +	/* We discard Rx data received while device is in booting
>> +	 * stage, this is due multiple baudrate switch is causing
>> +	 * UART to read some garbage data.
>> +	 */
> 
> This isn't entirely correct. I saw frame reassembly errors before
> qca_wcn3990_init() is called, i.e. no baudrate changes. Some of the
> garbage seems to be sent shortly after powering on the controller.
> 

[Bala]: yes your correct, will update the comment.

>> +	if (test_bit(STATE_DISCARD_RX, &qca->flags))
>> +		return 0;
>> +
>>  	qca->rx_skb = h4_recv_buf(hu->hdev, qca->rx_skb, data, count,
>>  				  qca_recv_pkts, ARRAY_SIZE(qca_recv_pkts));
>>  	if (IS_ERR(qca->rx_skb)) {
>> @@ -1192,10 +1201,12 @@ static int qca_setup(struct hci_uart *hu)
>>  		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>>  		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
>>  		hu->hdev->shutdown = qca_power_off;
>> +
>>  		ret = qca_wcn3990_init(hu);
>>  		if (ret)
>>  			return ret;
>> 
>> +		clear_bit(STATE_DISCARD_RX, &qca->flags);
>>  		ret = qca_read_soc_version(hdev, &soc_ver);
>>  		if (ret)
>>  			return ret;
>> @@ -1278,8 +1289,15 @@ static void qca_power_shutdown(struct hci_uart 
>> *hu)
>>  	struct serdev_device *serdev = hu->serdev;
>>  	unsigned char cmd = QCA_WCN3990_POWEROFF_PULSE;
>> 
>> -	host_set_baudrate(hu, 2400);
>> +	/* From this point we go into power off state,
>> +	 * disable IBS and discard all the queued data.
>> +	 */
>> +	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> +	set_bit(STATE_DISCARD_RX, &qca->flags);
>> +	qca_flush(hu);
>> +
>>  	hci_uart_set_flow_control(hu, true);
>> +	host_set_baudrate(hu, 2400);
>>  	serdev_device_write(serdev, &cmd, sizeof(cmd), 0);
>>  	serdev_device_wait_until_sent(serdev, 0);
>>  	hci_uart_set_flow_control(hu, false);
> 
> This change won't win a beauty price, but it seems it is needed to
> suppress the 'frame reassembly' spam, unless the controller can be
> convinced to stop sending garbage in the first place.
> 
[Bala]: This is due to serdev_open function call before we trun on the 
regulators.
         where we don't have control over serdev open and close calls.

> Tested-by: Matthias Kaehlcke <mka@chromium.org>

[Bala]: Thanks for testing.

-- 
Regards
Balakrishna.
