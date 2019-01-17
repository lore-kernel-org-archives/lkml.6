Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946EEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628182054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NJ7PYJST";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NJ7PYJST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfAQKZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:25:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33708 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfAQKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:25:19 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DDE5260388; Thu, 17 Jan 2019 10:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547720717;
        bh=qZO8Vw1n57Ms4HPecyITg3sQ4OOYVquA9/mV22uu4y4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NJ7PYJSTOUWmQs44xcgwtK2irtMkfwP5EqNYjUrSQbavwLgtNxKiZaSXEC/+EY0Nb
         g3p+mLpMFdhaxMQdnFIhJ99iD00thvRYR5D6BiQ6L331UK/gO5FgfDu/O7AUbXpltz
         nMaxJ27fhBx/Rx4mcHEIN2RbdwVyUCH+zSxd8yhk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 58CE560300;
        Thu, 17 Jan 2019 10:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547720717;
        bh=qZO8Vw1n57Ms4HPecyITg3sQ4OOYVquA9/mV22uu4y4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NJ7PYJSTOUWmQs44xcgwtK2irtMkfwP5EqNYjUrSQbavwLgtNxKiZaSXEC/+EY0Nb
         g3p+mLpMFdhaxMQdnFIhJ99iD00thvRYR5D6BiQ6L331UK/gO5FgfDu/O7AUbXpltz
         nMaxJ27fhBx/Rx4mcHEIN2RbdwVyUCH+zSxd8yhk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Jan 2019 15:55:17 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 1/3] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
In-Reply-To: <20190116202253.GS261387@google.com>
References: <20190116114603.500-1-bgodavar@codeaurora.org>
 <20190116114603.500-2-bgodavar@codeaurora.org>
 <20190116202253.GS261387@google.com>
Message-ID: <482d8987d38f60dae1844bc30050cd06@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-01-17 01:52, Matthias Kaehlcke wrote:
> On Wed, Jan 16, 2019 at 05:16:01PM +0530, Balakrishna Godavarthi wrote:
>> wcn3990 requires a power pulse to turn ON/OFF along with
>> regulators. Sometimes we are observing the power pulses are sent
>> out with some time delay, due to queuing these commands. This is
>> causing synchronization issues with chip, which intern delay the
>> chip setup or may end up with communication issues.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> Changes in v8:
>>  * Updated 1 second timeout instead of indefinite wait.
>> 
>> Changes in v7:
>>  *  updated the wait time to 5 ms after sending power pulses.
>> 
>> Changes in v6:
>>  * added serdev_device_write_flush() in qca_send_power_pulse
>>    instead during the power off pulse.
>> 
>> Changes in v5:
>>  * added serdev_device_write_flush() in qca_power_off().
>> ---
>>  drivers/bluetooth/hci_qca.c | 46 
>> ++++++++++++++++---------------------
>>  1 file changed, 20 insertions(+), 26 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index f036c8f98ea3..681bfa30467e 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -60,6 +60,7 @@
>>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
>>  #define BAUDRATE_SETTLE_TIMEOUT_MS	300
>> +#define POWER_PULSE_TRANS_TIMEOUT_MS	1000
> 
> nit: Not that it should make a different in normal operation, but 1s
> seems extreme. Is there really any chance that the byte hasn't been
> sent after say 100ms (which is still an eternity for a single byte)?
> 
>>  /* susclk rate */
>>  #define SUSCLK_RATE_32KHZ	32768
>> @@ -1013,11 +1014,10 @@ static inline void host_set_baudrate(struct 
>> hci_uart *hu, unsigned int speed)
>>  		hci_uart_set_baudrate(hu, speed);
>>  }
>> 
>> -static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>> +static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
>>  {
>> -	struct hci_uart *hu = hci_get_drvdata(hdev);
>> -	struct qca_data *qca = hu->priv;
>> -	struct sk_buff *skb;
>> +	int ret;
>> +	int timeout = __msecs_to_jiffies(POWER_PULSE_TRANS_TIMEOUT_MS);
> 
> use msecs_to_jiffies()
> 
[Bala]: will upadte.

>>  	/* These power pulses are single byte command which are sent
>>  	 * at required baudrate to wcn3990. On wcn3990, we have an external
>> @@ -1029,22 +1029,22 @@ static int qca_send_power_pulse(struct hci_dev 
>> *hdev, u8 cmd)
>>  	 * save power. Disabling hardware flow control is mandatory while
>>  	 * sending power pulses to SoC.
>>  	 */
>> -	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
>> -
>> -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
>> -	if (!skb)
>> -		return -ENOMEM;
>> +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to controller", cmd);
>> 
>> +	serdev_device_write_flush(hu->serdev);
>>  	hci_uart_set_flow_control(hu, true);
>> +	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
>> +	if (ret < 0) {
>> +		bt_dev_err(hu->hdev, "failed to send power pulse %02x", cmd);
>> +		return ret;
>> +	}
>> 
>> -	skb_put_u8(skb, cmd);
>> -	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> -
>> -	skb_queue_tail(&qca->txq, skb);
>> -	hci_uart_tx_wakeup(hu);
>> -
>> -	/* Wait for 100 uS for SoC to settle down */
>> -	usleep_range(100, 200);
>> +	serdev_device_wait_until_sent(hu->serdev, timeout);
>> +	/* Wait of 5ms is required for assuring to send the byte on the Tx
>> +	 * line and also for the controller to settle down for the received
>> +	 * byte.
>> +	 */
>> +	usleep_range(5000, 6000);
> 
> I incorrectly claimed that there might be still bytes sitting in the
> UART FIFO when serdev_device_wait_until_sent() returns, Johan
> corrected me on that (thanks!). So if it takes the SoC 100us to settle
> down we should be good with the original code.

[Bala]: sure will revert, i think he commented that wait_until_sent()
         will only guarantee circular buffer is empty. if 
wait_until_sent()
         guarantee us that the data was transmitted from the FIFO, then 
100us will work.
> 
> Cheers
> 
> Matthias

-- 
Regards
Balakrishna.
