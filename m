Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52043C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA7B26F38
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MvrpS/hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA7B26F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932761AbeFZTx0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:53:26 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42765 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932160AbeFZTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:53:24 -0400
Received: by mail-pl0-f67.google.com with SMTP id w17-v6so9032893pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D50wDSvGDdc5oXm7XCfJorKROIZXxT9/fGHpILvjCgg=;
        b=MvrpS/hn5l92IUiN8JqweJ9wKK4XnzwvonAQS8bkbHILLaS3NIhQ549Cvp8PApMhny
         FUngnPd38VahxVKLPjuFlGb9TB6hVU3vZS8wjlI4nJKvxGUDxg+8rX1/OVBM07+1GC0t
         9+uBGQVufkZsg2t6p6kTpydAp0PFWtrZXgPQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D50wDSvGDdc5oXm7XCfJorKROIZXxT9/fGHpILvjCgg=;
        b=gR2BR7g0GVoHHu/o6/vzNlgJz0aBzXcC36MCnDv7Gy/w3jJhIYzirgQg4x76VopCsY
         NzMA5ft8PXx1jqpk/CBsmmoNkYv/EwLGsenaS603GvdloRAIkAYsjn5GnSUWqXUd+yDW
         QcY24CwHSms01+AimVkzIqJxUZOucSw0gm5Z39XVKDade8F9kxkMOedZxExAiNCrX/Iu
         YQfkjynzbuWg1V9iVg6sgB6mP+EqI6KHItPDsop4f9gXYSX+v1p1xzpANM2YLc3IiT5A
         piOhUlIRHz1BLuYJP34CsZCGaj130D7pVjv8hUYsY3cy72Fxg0y5wRLMycYXn/67GoMo
         ajGQ==
X-Gm-Message-State: APt69E3a2MjL7vZZ88owPr/Xg1kvzBJd2q96hSA92yKA7igPHRue5I+R
        6tTT45AbCnQ4qwsl8bEYrY6f6A==
X-Google-Smtp-Source: ADUXVKKGfd3jYpuvMcWf1Q2bxlJ4ji4+uVPp/nplSv5zUZuasyCRgNhBwzzYGH1MGtVt0mMjzEUJPg==
X-Received: by 2002:a17:902:2f84:: with SMTP id t4-v6mr3021705plb.24.1530042803571;
        Tue, 26 Jun 2018 12:53:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id n26-v6sm4174717pfi.168.2018.06.26.12.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 12:53:22 -0700 (PDT)
Date:   Tue, 26 Jun 2018 12:53:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
Message-ID: <20180626195322.GO129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-4-bgodavar@codeaurora.org>
 <20180625232057.GH129942@google.com>
 <2ed980b7cd83a87dd76b05a4bca014ce@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ed980b7cd83a87dd76b05a4bca014ce@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 06:53:47AM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-06-26 04:50, Matthias Kaehlcke wrote:
> > On Mon, Jun 25, 2018 at 07:10:09PM +0530, Balakrishna Godavarthi wrote:
> > > Redefinition of qca_uart_setup will help future Qualcomm Bluetooth
> > > SoC, to use the same function instead of duplicating the function.
> > > Added new arguments soc_type and soc_ver to the functions.
> > > 
> > > These arguments will help to decide type of firmware files
> > > to be loaded into Bluetooth chip.
> > > soc_type holds the Bluetooth chip connected to APPS processor.
> > > soc_ver holds the Bluetooth chip version.
> > > 
> > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > ---
> > > Changes in v8:
> > >     * updated soc_type with enum.
> > > 
> > > Changes in v7:
> > >     * initial patch
> > >     * redefined qca_uart_setup function to generic.
> > > ---
> > >  drivers/bluetooth/btqca.c   | 23 ++++++++++++-----------
> > >  drivers/bluetooth/btqca.h   | 13 +++++++++++--
> > >  drivers/bluetooth/hci_qca.c |  3 ++-
> > >  3 files changed, 25 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> > > index c5cf9cab438a..3b25be1be19c 100644
> > > --- a/drivers/bluetooth/btqca.c
> > > +++ b/drivers/bluetooth/btqca.c
> > > @@ -327,9 +327,9 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev,
> > > const bdaddr_t *bdaddr)
> > >  }
> > >  EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
> > > 
> > > -int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
> > > +int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> > > +		   enum qca_btsoc_type soc_type, u32 soc_ver)
> > >  {
> > > -	u32 rome_ver = 0;
> > >  	struct rome_config config;
> > >  	int err;
> > > 
> > > @@ -337,19 +337,20 @@ int qca_uart_setup(struct hci_dev *hdev,
> > > uint8_t baudrate)
> > > 
> > >  	config.user_baud_rate = baudrate;
> > > 
> > > -	/* Get QCA version information */
> > > -	err = qca_read_soc_version(hdev, &rome_ver);
> > > -	if (err < 0 || rome_ver == 0) {
> > > -		bt_dev_err(hdev, "QCA Failed to get version %d", err);
> > > -		return err;
> > > +	if (!soc_ver) {
> > > +		/* Get QCA version information */
> > > +		err = qca_read_soc_version(hdev, &soc_ver);
> > > +		if (err < 0 || soc_ver == 0) {
> > > +			bt_dev_err(hdev, "QCA Failed to get version (%d)", err);
> > > +			return err;
> > > +		}
> > > +		bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
> > >  	}
> > 
> > I thought we agreed in the discussion on "[v7,4/8] Bluetooth: btqca:
> > Redefine qca_uart_setup() to generic function" to call
> > qca_read_soc_version() in common code. Did I misinterpret that?
> > 
> [Bala]: After integrating wcn3990, calling qca_read_soc_version() in
> qca_setup()
>         is not preferable. as we will have multiple common blocks of code in
> qca_setup.
>         calling function to set an operator speed is required in the both
> the if -else blcoks

We can probably agree that there is no ideal solution, there is some
ugliness in on way or the other. IMO the conditional
qca_read_soc_version() in qca_uart_setup() based on the vale of
'soc_ver' is far worse than a small piece of redundant code.

If qca_read_soc_version() was done in qca_setup() the code could look
something like this:

static int qca_setup(struct hci_uart *hu)
{
	...
	if (qcadev->btsoc_type == QCA_WCN3990) {
		...
		qca_read_soc_version();
		ret = qca_set_speed(hu, QCA_OPER_SPEED);
                if (ret)
                        return ret;
	} else {
		ret = qca_set_speed(hu, QCA_OPER_SPEED);
                if (ret)
                        return ret;
                qca_read_soc_version();
	}

	speed = qca_get_speed(hu, QCA_OPER_SPEED);
	qca_baudrate = qca_get_baudrate_value(speed);

	 /* Setup patch / NVM configurations */
        ret = qca_uart_setup(hdev, qca_baudrate, qcadev->btsoc_type, soc_ver);
	...
}

Yes, 'qca_set_speed(hu, QCA_OPER_SPEED)' and the error handling is
redundant, but it's only 3 lines of trivial code in exchange for
making qca_uart_setup() more consistent and not spreading
the qca_read_soc_version() calls over multiple files, depending on the
SoC version.

If you are super-convinced that the split is superior leave it as is,
I might already be doing too much bike-shedding, and after all it
isn't my code.

> > > diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> > > index 5c9851b11838..24d6667eecf1 100644
> > > --- a/drivers/bluetooth/btqca.h
> > > +++ b/drivers/bluetooth/btqca.h
> > > ...
> > > -static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t
> > > baudrate)
> > > +static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t
> > > baudrate,
> > > +				 enum qca_btsoc_type soc_type, u32 soc_ver);
> > 
> > Remove trailing semicolon.
> 
> [Bala]: i didn't get you.

Sorry, I should have left more context:

> static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> 				 enum qca_btsoc_type soc_type, u32 soc_ver);
> {
> 	return -EOPNOTSUPP;
> }

This is a function definition, not just a declaration. The semicolon
would make it a declaration and make the compiler unhappy about a
function body where it doesn't expect it.
