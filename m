Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B932C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC32F22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kW7MwNvn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ROoaTi+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC32F22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbeKNQeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:34:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46320 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbeKNQeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 11:34:09 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 35858607B9; Wed, 14 Nov 2018 06:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542177138;
        bh=VSeSrAA4QLB+KdBPvzpw3SiKtST4OOVMqtb4rGQNfbc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kW7MwNvn/q5ve2PykoFaRF+IgSAS6eqF+Ld7BZV3TnFomDlEy45CcTKCbVHoGa/fW
         CrnbT23HzC1RlvKeJcgiHaIfk34/MB5ezK5cGK6YxhkDsz6xjR1pCRgG9fj0/4u3K3
         1RBcDBuYLJNbBw3S66g0R78qIIpfGQfk43Va95TQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9A5296071B;
        Wed, 14 Nov 2018 06:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542177136;
        bh=VSeSrAA4QLB+KdBPvzpw3SiKtST4OOVMqtb4rGQNfbc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ROoaTi+hTD64c3DXzdrjoUWQMICdMhvWGBeu6W1rLhfdbMsg9t3nLJw3Wr7v/3a1Z
         W+cgJJBhFdUCBbwtPRc6JUKoIllCBajgSeW3xlA/ltmkKKt3hE4OCXyvH/FAsvoIjg
         RVvHKvxzhYTWxqoq/S+YtUDsFza6knrkxWpduWXA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Nov 2018 12:02:16 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 2/4] Bluetooth: hci_qca: Pull RTS line high for
 baudrate change command
In-Reply-To: <20181114015504.GH22824@google.com>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-3-bgodavar@codeaurora.org>
 <20181114015504.GH22824@google.com>
Message-ID: <25c29e35b32ca71fe6d0b02f4d6ed559@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-11-14 07:25, Matthias Kaehlcke wrote:
> On Tue, Nov 06, 2018 at 05:35:26PM +0530, Balakrishna Godavarthi wrote:
>> This patch will pull the RTS line high instead of turning off the
>> flow control, while changing baudrate of host and chip.
> 
> Please don't only describe what is changed, but also why this change
> is necessary.
> 
> IIUC the BT chip honors flow control during baudrate changes, however
> it sometimes sends 'garbage' which results in "Bluetooth: hci0: Frame
> reassembly failed (-84)" messages.
> 

[Bala]: will update the commit text.

>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 051f081d1835..8301663f0004 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -963,7 +963,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>  	struct hci_uart *hu = hci_get_drvdata(hdev);
>>  	struct qca_data *qca = hu->priv;
>>  	struct sk_buff *skb;
>> -	struct qca_serdev *qcadev;
>>  	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
>> 
>>  	if (baudrate > QCA_BAUDRATE_3200000)
>> @@ -977,13 +976,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>  		return -ENOMEM;
>>  	}
>> 
>> -	/* Disabling hardware flow control is mandatory while
>> -	 * sending change baudrate request to wcn3990 SoC.
>> -	 */
>> -	qcadev = serdev_device_get_drvdata(hu->serdev);
>> -	if (qcadev->btsoc_type == QCA_WCN3990)
>> -		hci_uart_set_flow_control(hu, true);
>> -
>>  	/* Assign commands to change baudrate and packet type. */
>>  	skb_put_data(skb, cmd, sizeof(cmd));
>>  	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> @@ -999,9 +991,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>  	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
>>  	set_current_state(TASK_RUNNING);
>> 
>> -	if (qcadev->btsoc_type == QCA_WCN3990)
>> -		hci_uart_set_flow_control(hu, false);
>> -
>>  	return 0;
>>  }
>> 
>> @@ -1086,6 +1075,7 @@ static int qca_check_speeds(struct hci_uart *hu)
>>  static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type 
>> speed_type)
>>  {
>>  	unsigned int speed, qca_baudrate;
>> +	struct qca_serdev *qcadev;
>>  	int ret;
>> 
>>  	if (speed_type == QCA_INIT_SPEED) {
>> @@ -1097,6 +1087,14 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  		if (!speed)
>>  			return 0;
>> 
>> +		/* Pulling RTS line to high is mandatory while sending change
>> +		 * baudrate request to SoC and also while setting the host
>> +		 * baudrate.
>> +		 */
> 
> Instead of just stating that this is 'mandatory' explain why it is
> needed. Also better say 'Deassert RTS' instead of the more lower level
> 'Pulling RTS line to high'. It could be something like 'Deassert RTS
> to prevent the BT controller from sending garbage during the baudrate
> change.'
> 

[Bala]: will update the comment.

>> +		qcadev = serdev_device_get_drvdata(hu->serdev);
>> +		if (qcadev->btsoc_type == QCA_WCN3990)
>> +			serdev_device_set_rts(hu->serdev, false);
>> +
>>  		qca_baudrate = qca_get_baudrate_value(speed);
>>  		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
>>  		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
>> @@ -1104,6 +1102,9 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  			return ret;
>> 
>>  		host_set_baudrate(hu, speed);
>> +
>> +		if (qcadev->btsoc_type == QCA_WCN3990)
>> +			serdev_device_set_rts(hu->serdev, true);
>>  	}
>> 
>>  	return 0;
> 
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

Thanks for testing.

-- 
Regards
Balakrishna.
