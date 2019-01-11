Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78DAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD9E20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ennoqf7r";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lbQZX67Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389343AbfAKOcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:32:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58264 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388788AbfAKOcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:32:06 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4BFF460B7A; Fri, 11 Jan 2019 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547217124;
        bh=ct5t8aTnKDmeGd6CQtFHo+dDdWVL9qBI83GTPbVNbOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ennoqf7rR+p/vostZqJDSLg+M02Ai9bKEiPtoKcUyQ7MrOvS1HMTzaw9FzmQT5T9s
         AdQ7HQxRA5KgAH+URxIZqu4tGt4O5MFiSQsUJvoXzdgRDps7tuGsiIc4GHJGNr19Sm
         T1Q6VrlIdlOkWROlbWtQ9xWG8lqvGsZ9MuDydQNQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 198DE6098C;
        Fri, 11 Jan 2019 14:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547217121;
        bh=ct5t8aTnKDmeGd6CQtFHo+dDdWVL9qBI83GTPbVNbOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lbQZX67Zj8QLZWiKymGJEIQ2qg5qqrPxFYSR1Jvnm+MllSYnm3qDPDTKjEwNynUjS
         YL9OZOX5moaOILGnFArbfb13GAU/FX1E83b3qWqXErPBOszChAf7EVkztfnV5t8iXh
         wppSoylVWtYjBPXn0wV5MaHaMXdVy7ulQlf+MsUw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Jan 2019 20:02:00 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 1/5] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
In-Reply-To: <20190111005532.GC261387@google.com>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-2-bgodavar@codeaurora.org>
 <20181222015947.GF261387@google.com> <20190109143822.GM14782@localhost>
 <2d4ee183e3c2fa964c14a5ac702043c0@codeaurora.org>
 <20190111005532.GC261387@google.com>
Message-ID: <5e4b077bbcc81b624c851643bebc45f7@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-11 06:25, Matthias Kaehlcke wrote:
> On Thu, Jan 10, 2019 at 08:18:37PM +0530, Balakrishna Godavarthi wrote:
>> Hi Johan,
>> 
>> On 2019-01-09 20:08, Johan Hovold wrote:
>> > On Fri, Dec 21, 2018 at 05:59:47PM -0800, Matthias Kaehlcke wrote:
>> > > On Thu, Dec 20, 2018 at 08:16:35PM +0530, Balakrishna Godavarthi
>> > > wrote:
>> > > > wcn3990 requires a power pulse to turn ON/OFF along with
>> > > > regulators. Sometimes we are observing the power pulses are sent
>> > > > out with some time delay, due to queuing these commands. This is
>> > > > causing synchronization issues with chip, which intern delay the
>> > > > chip setup or may end up with communication issues.
>> > > >
>> > > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> > > > ---
>> > > >  drivers/bluetooth/hci_qca.c | 38 ++++++++++++++-----------------------
>> > > >  1 file changed, 14 insertions(+), 24 deletions(-)
>> > > >
>> > > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> > > > index f036c8f98ea3..5a07c2370289 100644
>> > > > --- a/drivers/bluetooth/hci_qca.c
>> > > > +++ b/drivers/bluetooth/hci_qca.c
>> > > > @@ -1013,11 +1013,9 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
>> > > >  		hci_uart_set_baudrate(hu, speed);
>> > > >  }
>> > > >
>> > > > -static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>> > > > +static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
>> > > >  {
>> > > > -	struct hci_uart *hu = hci_get_drvdata(hdev);
>> > > > -	struct qca_data *qca = hu->priv;
>> > > > -	struct sk_buff *skb;
>> > > > +	int ret;
>> > > >
>> > > >  	/* These power pulses are single byte command which are sent
>> > > >  	 * at required baudrate to wcn3990. On wcn3990, we have an external
>> > > > @@ -1029,19 +1027,16 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
>> > > >  	 * save power. Disabling hardware flow control is mandatory while
>> > > >  	 * sending power pulses to SoC.
>> > > >  	 */
>> > > > -	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
>> > > > -
>> > > > -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
>> > > > -	if (!skb)
>> > > > -		return -ENOMEM;
>> > > > -
>> > > > +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);
>> > > >  	hci_uart_set_flow_control(hu, true);
>> > > > +	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
>> > > > +	if (ret < 0) {
>> > > > +		bt_dev_err(hu->hdev, "failed to send power pulse %02x to SoC",
>> > > > +			   cmd);
>> > > > +		return ret;
>> > > > +	}
>> > > >
>> > > > -	skb_put_u8(skb, cmd);
>> > > > -	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> > > > -
>> > > > -	skb_queue_tail(&qca->txq, skb);
>> > > > -	hci_uart_tx_wakeup(hu);
>> > > > +	serdev_device_wait_until_sent(hu->serdev, 0);
>> >
>> > Again, do you really want to wait indefinitely here?
>> >
>> [Bala]: these commands are mandatory to turn ON or OFF the chip.
>>         so blocking to the max time is required.
>>         these commands are sent during the BT chip ON & OFF.
>>         in the latest series, i have flushed the uart before sending 
>> this
>> commands
>>         so the uart FIFO(as just opened the port before calling this
>> function) or the circular
>>         buffer will be empty and also i am disabling the flow control 
>> too.
>>        https://patchwork.kernel.org/patch/10744435/
> 
> The commands may be mandatory for switching the chip on or off, but
> what is better if there is a problem with sending them (e.g. a buggy
> UART driver):
> 
> 1. wait a reasonable time, report an error
> 2. wait forever
> 
> ?
> 
> If the single byte command couldn't be sent after a few milliseconds,
> it likely never will, waiting forever doesn't fix that. An error
> report at least provides some information about the problem and the
> driver is in a not-hanging state.
> 
> Cheers
> 
> Matthias

[Bala]: will update this with a bound TIMEOUT value. But 
wait_until_sent() is void return
         type how could we know that the data is sent out on the lines.


-- 
Regards
Balakrishna.
