Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F437C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447BD2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HCIilymf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I0tC10OC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfA1Nt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:49:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfA1Nt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:49:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 779DE6072E; Mon, 28 Jan 2019 13:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548683397;
        bh=jLekNMlt29VoliIvsUGbMcPHooW3QQi1ouQ1GtV1alY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HCIilymfWuAGrgON5CFiF+lQ4KUfNgpzKIKr6S5nV2LxIoH4zCgmj67QQ/7j3tSR1
         uadbeziK0/AIK6Xsf6UsEcKymmZMGhpHdfGoQqg1FgNr029I4qP/LFyA3a5PPMDfp4
         W7RwkMaWSn5N7GyjuSoZEbwGpCSvaudcBL9X5ShU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3DB74605A5;
        Mon, 28 Jan 2019 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548683396;
        bh=jLekNMlt29VoliIvsUGbMcPHooW3QQi1ouQ1GtV1alY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I0tC10OCo0hnM7GiDbwpTWjqb/BEcyZ8h/jy6bSPJWSslb5qijnazy11iUCouhh+C
         w73G4dJGskK+V6+YFafpIKrboxtNiTqAb+1aSyz8tHfYU/9GSxnxppUBMqmBp2wpmO
         fnSl+GiuKnmt7lXqDRwPmMSxpKq68hNlMDjR/Lxw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 28 Jan 2019 19:19:56 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 1/3] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
In-Reply-To: <20190125011412.GE81583@google.com>
References: <20190124120808.8275-1-bgodavar@codeaurora.org>
 <20190124120808.8275-2-bgodavar@codeaurora.org>
 <20190125011412.GE81583@google.com>
Message-ID: <0fac93a13ee445569659075cf467ad4d@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-01-25 06:44, Matthias Kaehlcke wrote:
> On Thu, Jan 24, 2019 at 05:38:06PM +0530, Balakrishna Godavarthi wrote:
>> wcn3990 requires a power pulse to turn ON/OFF along with
>> regulators. Sometimes we are observing the power pulses are sent
>> out with some time delay, due to queuing these commands. This is
>> causing synchronization issues with chip, which intern delay the
>> chip setup or may end up with communication issues.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> Changes in v9:
>>  * Reverted to 100us sleep.
>>  * used inline call msecs_to_jiffies()
>> 
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
>>  drivers/bluetooth/hci_qca.c | 40 
>> +++++++++++++++----------------------
>>  1 file changed, 16 insertions(+), 24 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index f036c8f98ea3..c08f4d105e73 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -60,6 +60,7 @@
>>  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
>>  #define BAUDRATE_SETTLE_TIMEOUT_MS	300
>> +#define POWER_PULSE_TRANS_TIMEOUT_MS	1000
> 
> I still doubt that this mega-timeout of 1s is needed, but it shouldn't
> do any harm either, so whatever ...
> 

[Bala]: for now let us have it. we can improve it in the improvement 
patch
         based on the results.

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
>> +	int timeout = msecs_to_jiffies(POWER_PULSE_TRANS_TIMEOUT_MS);
>> 
>>  	/* These power pulses are single byte command which are sent
>>  	 * at required baudrate to wcn3990. On wcn3990, we have an external
>> @@ -1029,21 +1029,19 @@ static int qca_send_power_pulse(struct hci_dev 
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
>> +	serdev_device_wait_until_sent(hu->serdev, timeout);
>> 
>> -	/* Wait for 100 uS for SoC to settle down */
>> +	/* Wait for 100 uS for SoC to settle down for the received byte. */
> 
> I don't think 'for the received byte' adds much value here. If you
> respin anyway I'd suggest to leave the comment as is.
> 

[Bala]: will update.

>>  	usleep_range(100, 200);
>>  	hci_uart_set_flow_control(hu, false);
>> 
>> @@ -1116,7 +1114,6 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>> 
>>  static int qca_wcn3990_init(struct hci_uart *hu)
>>  {
>> -	struct hci_dev *hdev = hu->hdev;
>>  	struct qca_serdev *qcadev;
>>  	int ret;
>> 
>> @@ -1139,12 +1136,12 @@ static int qca_wcn3990_init(struct hci_uart 
>> *hu)
>> 
>>  	/* Forcefully enable wcn3990 to enter in to boot mode. */
>>  	host_set_baudrate(hu, 2400);
>> -	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
>> +	ret = qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
>>  	if (ret)
>>  		return ret;
>> 
>>  	qca_set_speed(hu, QCA_INIT_SPEED);
>> -	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWERON_PULSE);
>> +	ret = qca_send_power_pulse(hu, QCA_WCN3990_POWERON_PULSE);
>>  	if (ret)
>>  		return ret;
>> 
>> @@ -1274,13 +1271,8 @@ static const struct qca_vreg_data qca_soc_data 
>> = {
>> 
>>  static void qca_power_shutdown(struct hci_uart *hu)
>>  {
>> -	struct serdev_device *serdev = hu->serdev;
>> -	unsigned char cmd = QCA_WCN3990_POWEROFF_PULSE;
>> -
>>  	host_set_baudrate(hu, 2400);
>> -	hci_uart_set_flow_control(hu, true);
>> -	serdev_device_write_buf(serdev, &cmd, sizeof(cmd));
>> -	hci_uart_set_flow_control(hu, false);
>> +	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
>>  	qca_power_setup(hu, false);
>>  }
>> 
> 
> Looks good to me besides possible minor improvements:
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

-- 
Regards
Balakrishna.
