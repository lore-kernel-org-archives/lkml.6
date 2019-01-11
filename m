Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407BEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED48C20879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aVLWml4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfAKBhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:37:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43816 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbfAKBhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:37:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so5990395plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 17:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6q/xuJNr3sBokRPwM7RLrMqV7Gur7gMpsOwsUuBthOg=;
        b=aVLWml4XKnApFgE2Q8PtpPD/DlQNKQrKrNsHisKzt8pYhhhOTzn81GWo1lzA7h+A78
         KiEMjzMxh2ENr5rHRRPM0ZD0scmKSA9mX27lBst0k54bw9P54NmKNpl/BHxMWUyW7Ra2
         27pFF0tAgTgNs1fMrnbUpGUM/YcfgI6omo228=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6q/xuJNr3sBokRPwM7RLrMqV7Gur7gMpsOwsUuBthOg=;
        b=F+O8TfqjZvzCDb0rjSKqxzXreZLBaN1TghrCVuBtBB0oXADDljWJoE7iO+T2dvKQnr
         jABDUb869e7DREAptnKfPdOqB6023jRAAj3Yughvx2kmSqVxMBZtaLvNHhi0zrulaqAw
         vjAINoJfPcpdRCHKDsQw6ewBzBUv++Dk0n3bufRM7ab0rdzx1e4HWebyMiCZMXDm8BG8
         PZny9RsD6KJI0CJlnL45xgbvQuMqjFLVG7xYGh2oJ7njaX8aEw/BBr5nYHrpRXMXhwLw
         dyTnYQBismMPHjYmORDHA/yeFem5RO2c6vWrgUbjGTvS7//2mLJKCF9PyD+Hx2JucyDa
         wDFA==
X-Gm-Message-State: AJcUukd0S330FdT94qul7V2w224otsB3aAXWirJNpBycIOP8NBOpPYGJ
        e1JOVzALrbdI6eV5Zea9Wf6PDA==
X-Google-Smtp-Source: ALg8bN4tw0O29N8dG2GqX8fmXJOiKGYbbzqFIdaODZZGVrvW3VYOb1baZENAWKIxOn3FxZhlopy5tQ==
X-Received: by 2002:a17:902:e290:: with SMTP id cf16mr12947722plb.81.1547170628474;
        Thu, 10 Jan 2019 17:37:08 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d80sm216447471pfm.146.2019.01.10.17.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 17:37:07 -0800 (PST)
Date:   Thu, 10 Jan 2019 17:37:07 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
Message-ID: <20190111013707.GD261387@google.com>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-3-bgodavar@codeaurora.org>
 <20190109145224.GN14782@localhost>
 <b5160d8862b49f0369fa58610516d354@codeaurora.org>
 <20190110143928.GE3430@localhost>
 <61301df80bd6a8ee0265b31b7f6a3aa1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61301df80bd6a8ee0265b31b7f6a3aa1@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 08:22:12PM +0530, Balakrishna Godavarthi wrote:
> Hi Johan,
> 
> On 2019-01-10 20:09, Johan Hovold wrote:
> > On Thu, Jan 10, 2019 at 08:04:12PM +0530, Balakrishna Godavarthi wrote:
> > > Hi Johan,
> > > 
> > > On 2019-01-09 20:22, Johan Hovold wrote:
> > > > On Thu, Dec 20, 2018 at 08:16:36PM +0530, Balakrishna Godavarthi wrote:
> > > >> This patch will help to stop frame reassembly errors while changing
> > > >> the baudrate. This is because host send a change baudrate request
> > > >> command to the chip with 115200 bps, Whereas chip will change their
> > > >> UART clocks to the enable for new baudrate and sends the response
> > > >> for the change request command with newer baudrate, On host side
> > > >> we are still operating in 115200 bps which results of reading garbage
> > > >> data. Here we are pulling RTS line, so that chip we will wait to send
> > > >> data
> > > >> to host until host change its baudrate.
> > 
> > > >> +		/* Deassert RTS while changing the baudrate of chip and host.
> > > >> +		 * This will prevent chip from transmitting its response with
> > > >> +		 * the new baudrate while the host port is still operating at
> > > >> +		 * the old speed.
> > > >> +		 */
> > > >> +		qcadev = serdev_device_get_drvdata(hu->serdev);
> > > >> +		if (qcadev->btsoc_type == QCA_WCN3990)
> > > >> +			serdev_device_set_rts(hu->serdev, false);
> > > >> +
> > > >
> > > > This may not do what you want unless you also disable hardware flow
> > > > control.
> > 
> > > Here my requirement here is to block the chip to send its data before
> > > HOST changes it is baudrate. So if i disable flow control lines of
> > > HOST which will be in low state.  so that the chip will send it data
> > > before HOST change the baudrate of HOST. which results in frame
> > > reassembly error.
> > 
> > Not sure I understand what you're trying to say above. My point is that
> > you cannot reliable control RTS when you have automatic flow control
> > enabled (i.e. it is managed by hardware and it's state reflects whether
> > there's room in the UART receive FIFO).
> > 
> > Johan
> 
> [Bala]: Yes i got your point, but our driver

I suppose with "our driver" you refer to a Qualcomm UART driver like
qcom_geni_serial.c. Unless the Bluetooth controller is really tied to
some specific SoC (e.g. because it is on-chip) you shouldn't make
assumptions about the UART driver or hardware beyond standard
behavior.

But even if we assume that the driver you mention is used, I think you
are rather confirming Johan's concern than dispersing it:

> will not support automatic flow control (based on the FIFO status)
> unless we explicitly enabled via software. i.e. if we enable the
> flow, hardware will look for it else it will not looks for CTS or
> RTS Line.

So we agree that the UART hardware may change RTS if hardware flow
control is enabled?

static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
{
  ...
  hci_uart_set_flow_control(hu, false);
  ...
}

I still find it utterly confusing that set_flow_control(false) enables
flow control, but that's what it does, hence after
qca_send_power_pulse() flow control is (re-)enabled.

So far I haven't seen problems with qcom_geni_serial.c overriding the
level set with serdev_device_set_rts(), but I tend to agree with Johan
that this could be a problem (if not with this UART (driver) then with
another). I'm not keen about adding more flow control on/off clutter,
but if that is needed for the driver to operate reliably across
platforms so be it.

Cheers

Matthias
