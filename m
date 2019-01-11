Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69CEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C2720879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RsMMbSiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfAKAzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:55:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36735 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfAKAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:55:36 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so5961298plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YjCyW2GH67YMCpgdeXCFurOp9JBWuqWYPvAFzLefnC0=;
        b=RsMMbSiCTIRrlCcMpHkBgeytNsaijEdpO6bwVs6/eaJBb8CNAtTKpGU42GTaM6E9HD
         3gyuumzejiDbRjd0QuM4BcsV8oiCnY40wubFJ8nRANgD5D9+doZ1RVFWswpyD9hK9eUZ
         guTcKBO8QZyYcVOecWU9AJ+LyiYyc+gqP94kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YjCyW2GH67YMCpgdeXCFurOp9JBWuqWYPvAFzLefnC0=;
        b=Kq9tWK4Y7JIgjmMcK64IEye0XAgmv1sdEaNZOW2+gpe00/4ScO4SJJxZ9LvaMwiV4f
         +sglRrcqGI6q93xaF/sPTnolu9TP29D7aBCqovhhvAJRzzP4s/oNORjCEM2eGGUn8Co/
         lDbD3hGONHwNX/7yXkkyAYMwo90nrof331NCoy/0aqq/f5G0updG9VWi4n6nwIHCOHsz
         RdUcmqiIhmfPtRJbuTHWitBMCuvgBDM8XM07NiTQ49M22pVdFbPRD8f1hHBYKfq+K77G
         OYpQFlqiqvOpQWw0FWvIphEnBw29H085yVvdwZYiNKqctAkOH64mWXzo55P0m641e8h7
         EFNA==
X-Gm-Message-State: AJcUukecSVqEkLAOllSzMtRe38Kjos7YcI6WGkWZvAIQVlvQwVfvsIot
        nXvLtrsGpyqY1CjygYqVIKeoKA==
X-Google-Smtp-Source: ALg8bN5swk/zauv3ghMFWlLsv9y9oVTr+DmGRDMp0DYm2UZiYQ3UuDIPaI/QNJR20sbT4PpJbHBRDw==
X-Received: by 2002:a17:902:7044:: with SMTP id h4mr12378360plt.35.1547168135238;
        Thu, 10 Jan 2019 16:55:35 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y191sm27642057pfg.56.2019.01.10.16.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 16:55:33 -0800 (PST)
Date:   Thu, 10 Jan 2019 16:55:32 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 1/5] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20190111005532.GC261387@google.com>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-2-bgodavar@codeaurora.org>
 <20181222015947.GF261387@google.com>
 <20190109143822.GM14782@localhost>
 <2d4ee183e3c2fa964c14a5ac702043c0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d4ee183e3c2fa964c14a5ac702043c0@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 08:18:37PM +0530, Balakrishna Godavarthi wrote:
> Hi Johan,
> 
> On 2019-01-09 20:08, Johan Hovold wrote:
> > On Fri, Dec 21, 2018 at 05:59:47PM -0800, Matthias Kaehlcke wrote:
> > > On Thu, Dec 20, 2018 at 08:16:35PM +0530, Balakrishna Godavarthi
> > > wrote:
> > > > wcn3990 requires a power pulse to turn ON/OFF along with
> > > > regulators. Sometimes we are observing the power pulses are sent
> > > > out with some time delay, due to queuing these commands. This is
> > > > causing synchronization issues with chip, which intern delay the
> > > > chip setup or may end up with communication issues.
> > > >
> > > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > > ---
> > > >  drivers/bluetooth/hci_qca.c | 38 ++++++++++++++-----------------------
> > > >  1 file changed, 14 insertions(+), 24 deletions(-)
> > > >
> > > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > > index f036c8f98ea3..5a07c2370289 100644
> > > > --- a/drivers/bluetooth/hci_qca.c
> > > > +++ b/drivers/bluetooth/hci_qca.c
> > > > @@ -1013,11 +1013,9 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
> > > >  		hci_uart_set_baudrate(hu, speed);
> > > >  }
> > > >
> > > > -static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
> > > > +static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
> > > >  {
> > > > -	struct hci_uart *hu = hci_get_drvdata(hdev);
> > > > -	struct qca_data *qca = hu->priv;
> > > > -	struct sk_buff *skb;
> > > > +	int ret;
> > > >
> > > >  	/* These power pulses are single byte command which are sent
> > > >  	 * at required baudrate to wcn3990. On wcn3990, we have an external
> > > > @@ -1029,19 +1027,16 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
> > > >  	 * save power. Disabling hardware flow control is mandatory while
> > > >  	 * sending power pulses to SoC.
> > > >  	 */
> > > > -	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
> > > > -
> > > > -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> > > > -	if (!skb)
> > > > -		return -ENOMEM;
> > > > -
> > > > +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);
> > > >  	hci_uart_set_flow_control(hu, true);
> > > > +	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
> > > > +	if (ret < 0) {
> > > > +		bt_dev_err(hu->hdev, "failed to send power pulse %02x to SoC",
> > > > +			   cmd);
> > > > +		return ret;
> > > > +	}
> > > >
> > > > -	skb_put_u8(skb, cmd);
> > > > -	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
> > > > -
> > > > -	skb_queue_tail(&qca->txq, skb);
> > > > -	hci_uart_tx_wakeup(hu);
> > > > +	serdev_device_wait_until_sent(hu->serdev, 0);
> > 
> > Again, do you really want to wait indefinitely here?
> > 
> [Bala]: these commands are mandatory to turn ON or OFF the chip.
>         so blocking to the max time is required.
>         these commands are sent during the BT chip ON & OFF.
>         in the latest series, i have flushed the uart before sending this
> commands
>         so the uart FIFO(as just opened the port before calling this
> function) or the circular
>         buffer will be empty and also i am disabling the flow control too.
>        https://patchwork.kernel.org/patch/10744435/

The commands may be mandatory for switching the chip on or off, but
what is better if there is a problem with sending them (e.g. a buggy
UART driver):

1. wait a reasonable time, report an error
2. wait forever

?

If the single byte command couldn't be sent after a few milliseconds,
it likely never will, waiting forever doesn't fix that. An error
report at least provides some information about the problem and the
driver is in a not-hanging state.

Cheers

Matthias
