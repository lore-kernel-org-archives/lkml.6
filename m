Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA34BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8B52177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j+cteo0M";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JeDI53oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfAJOsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:48:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50764 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbfAJOsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:48:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BA7C860312; Thu, 10 Jan 2019 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547131718;
        bh=GFg0ojTAe9GSZqRqYornr5jM5G3q2SqoAjeIlVWSHII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j+cteo0M2Im6U5n8vVLtFAZzww+k9cZ7frkXqDX5ya2UoHjOBY1Ir1Zb9MUGN9ahI
         jXRNuSm2nt2kWdXe5TLODsxvj1UGqkasgvXSMaS7lfzn6FRva0gCFFw9MrsLs9+4lG
         KKDf5lLNVy+NcQ9x3kRvMnIt8HLIsXfkSTvhwct4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7C75D60300;
        Thu, 10 Jan 2019 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547131717;
        bh=GFg0ojTAe9GSZqRqYornr5jM5G3q2SqoAjeIlVWSHII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JeDI53oq64ORe4WOTdrzOEksxt4R5E+FAIiCM7ImG9LIhWJwDiz7285TBtc57sdsp
         ns+vR3u6Y1fk+vWjqjVUeWGplcP6g79u9IHH+NsSo3ulGYUAO5ZB/njqUdv277UFx6
         EKvUOLwAoJGd3yzGxThXFC0Dz+flA7ECGo1dR4n4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Jan 2019 20:18:37 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 1/5] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
In-Reply-To: <20190109143822.GM14782@localhost>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-2-bgodavar@codeaurora.org>
 <20181222015947.GF261387@google.com> <20190109143822.GM14782@localhost>
Message-ID: <2d4ee183e3c2fa964c14a5ac702043c0@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 2019-01-09 20:08, Johan Hovold wrote:
> On Fri, Dec 21, 2018 at 05:59:47PM -0800, Matthias Kaehlcke wrote:
>> On Thu, Dec 20, 2018 at 08:16:35PM +0530, Balakrishna Godavarthi 
>> wrote:
>> > wcn3990 requires a power pulse to turn ON/OFF along with
>> > regulators. Sometimes we are observing the power pulses are sent
>> > out with some time delay, due to queuing these commands. This is
>> > causing synchronization issues with chip, which intern delay the
>> > chip setup or may end up with communication issues.
>> >
>> > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> > ---
>> >  drivers/bluetooth/hci_qca.c | 38 ++++++++++++++-----------------------
>> >  1 file changed, 14 insertions(+), 24 deletions(-)
>> >
>> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> > index f036c8f98ea3..5a07c2370289 100644
>> > --- a/drivers/bluetooth/hci_qca.c
>> > +++ b/drivers/bluetooth/hci_qca.c
>> > @@ -1013,11 +1013,9 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
>> >  		hci_uart_set_baudrate(hu, speed);
>> >  }
>> >
>> > -static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>> > +static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
>> >  {
>> > -	struct hci_uart *hu = hci_get_drvdata(hdev);
>> > -	struct qca_data *qca = hu->priv;
>> > -	struct sk_buff *skb;
>> > +	int ret;
>> >
>> >  	/* These power pulses are single byte command which are sent
>> >  	 * at required baudrate to wcn3990. On wcn3990, we have an external
>> > @@ -1029,19 +1027,16 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>> >  	 * save power. Disabling hardware flow control is mandatory while
>> >  	 * sending power pulses to SoC.
>> >  	 */
>> > -	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
>> > -
>> > -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
>> > -	if (!skb)
>> > -		return -ENOMEM;
>> > -
>> > +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);
>> >  	hci_uart_set_flow_control(hu, true);
>> > +	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
>> > +	if (ret < 0) {
>> > +		bt_dev_err(hu->hdev, "failed to send power pulse %02x to SoC",
>> > +			   cmd);
>> > +		return ret;
>> > +	}
>> >
>> > -	skb_put_u8(skb, cmd);
>> > -	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> > -
>> > -	skb_queue_tail(&qca->txq, skb);
>> > -	hci_uart_tx_wakeup(hu);
>> > +	serdev_device_wait_until_sent(hu->serdev, 0);
> 
> Again, do you really want to wait indefinitely here?
> 
[Bala]: these commands are mandatory to turn ON or OFF the chip.
         so blocking to the max time is required.
         these commands are sent during the BT chip ON & OFF.
         in the latest series, i have flushed the uart before sending 
this commands
         so the uart FIFO(as just opened the port before calling this 
function) or the circular
         buffer will be empty and also i am disabling the flow control 
too.
        https://patchwork.kernel.org/patch/10744435/

>> serdev_device_wait_until_sent() might only guarantee that the UART
>> circular buffer is empty (see
>> https://elixir.bootlin.com/linux/v4.19/source/drivers/tty/tty_ioctl.c#L225),
>> not that the data has actually sent (e.g. it might be sitting in
>> the UART FIFO).
> 
> For serial core, uart_wait_until_sent() makes sure also the UART FIFO 
> is
> empty, although it may time out when using flow control (as then the
> FIFO may never empty, and flow control appears to be enabled here).
> 
> Johan


[Bala]: Pls refer the latest patch series 
https://patchwork.kernel.org/patch/10744435/
        where i am flushing the circular buffer before calling the 
qca_send_power_pulse().
        this how the flow

        1. open serial port (gurantess that UART FIFO is empty)
        2. flush the circular buffer
        3. disable the flow control.
        4. send the command byte.
        5. wait for the circular buffer is empty.

        the above is one time process,

-- 
Regards
Balakrishna.
