Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35186C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0349021726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I7ccCNQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfAVVjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:39:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43282 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfAVVjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:39:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so7904pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s1uBC0RAdo9MQ/lPZMxofyh91Ty2fVmSBsf+/Kce4B4=;
        b=I7ccCNQTJeR/B00UEtaVVVLPfimVQBrZH+7e8THmRr/vOfi2AW5v6tYxBxogRxvTKv
         3pUkDwLngBTOJvrv93uQFguYN9OYL4dhbbtHkomYMo1hyzHBbd8qJeHvzixHckrec0av
         u7Ic7zhhEW4YQj5y3A8ulf3vQI5/+RndW4cuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s1uBC0RAdo9MQ/lPZMxofyh91Ty2fVmSBsf+/Kce4B4=;
        b=b0skPiNETRmYxK4nlB/kYDRAsWZ14ktmtWYQDduwfgZ52gBc1Xvl38geVdmEtBcJwe
         hPJHm2h1ByjwtXSJeCNewurOKghB/EBgZ46oWAGrBjeWVt6+2z83Q7Rzi7E6I0P3jGxm
         TEiGKJyegkuU+0dAGbpLysDKB92ajvGKQyWHaecmLFyyOvDZCQ+oNWPyp6UCyXobVYZu
         cbQCh4rvXd8E2lEnMSDHesH9lZAmuTA3oY1318KVI7ZLC1FVVS1cdXoSfILq7+jICePD
         rwtS80MlW2/+DoTjVCckWJfdKY4ns4KSPaA+YA/CFc01dZFy/cp7ZO05I6ilAFMpzxCw
         im/Q==
X-Gm-Message-State: AJcUukeWF4lgQlZf6e0DhDBGLahvZzXKmR6iD9gJAdfA2R7wtXm4JofR
        r+Zxv8XXVztLSUta0jDGoiHpSQ==
X-Google-Smtp-Source: ALg8bN6S4YbWGdSGRk/8ODqL2gEzCmVditL8nDs3gWaxGr62p3HvTqrUU9WblIa3fWCt/D7rwBat0w==
X-Received: by 2002:a62:4851:: with SMTP id v78mr35282757pfa.97.1548193178952;
        Tue, 22 Jan 2019 13:39:38 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b7sm22038119pfa.52.2019.01.22.13.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 13:39:37 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:39:36 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
Message-ID: <20190122213936.GH261387@google.com>
References: <20190111013707.GD261387@google.com>
 <194b5d18ea86830b6a24939d483a964c@codeaurora.org>
 <20190111235633.GK261387@google.com>
 <a6e083d245baebc019b6e7163fd6f133@codeaurora.org>
 <20190115234628.GQ261387@google.com>
 <20190117160944.GV3691@localhost>
 <20190117172109.GU261387@google.com>
 <20190118094416.GB3691@localhost>
 <20190119003109.GD261387@google.com>
 <20190121085613.GG3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121085613.GG3691@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 09:56:13AM +0100, Johan Hovold wrote:
> On Fri, Jan 18, 2019 at 04:31:09PM -0800, Matthias Kaehlcke wrote:
> > On Fri, Jan 18, 2019 at 10:44:16AM +0100, Johan Hovold wrote:
> > > On Thu, Jan 17, 2019 at 09:21:09AM -0800, Matthias Kaehlcke wrote:
> > > 
> > > > I observed that the qcom_geni_serial driver doesn't raise RTS with
> > > > flow control disabled. It seems we have to investigate why that's the
> > > > case. I agree that the driver should be platform agnostic.
> > > 
> > > Sounds like a driver bug, unless the hardware is just "odd". The
> > > driver implementation of this looks very non-standard judging from a
> > > quick peek.
> > > 
> > > In fact, qcom_geni_serial_get_mctrl() is currently a no-op if hardware
> > > flow control is not enabled:
> > > 
> > > 	if (uart_console(uport) || !uart_cts_enabled(uport))
> > > 		return;
> > > 
> > > Perhaps dropping the !uart_cts_enabled() test is sufficient.
> > 
> > Thanks for taking a look Johan, that was indeed the problem (also
> > in set_mctrl()). I posted a fix: https://lore.kernel.org/patchwork/patch/1033611/
> 
> Nice (I did mean set_mctrl() above, as I think you noticed).
> 
> > Balakrishna, the following (applied on top of your patch) works for me
> > with the UART patch above:
> > 
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 9d5e41f159c78f..60bfdf01f72841 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1080,7 +1080,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
> >  {
> >  	unsigned int speed, qca_baudrate;
> >  	struct qca_serdev *qcadev;
> > -	int ret;
> > +	int ret = 0;
> >  
> >  	if (speed_type == QCA_INIT_SPEED) {
> >  		speed = qca_get_speed(hu, QCA_INIT_SPEED);
> > @@ -1097,22 +1097,27 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
> >  		 * the old speed.
> >  		 */
> >  		qcadev = serdev_device_get_drvdata(hu->serdev);
> > -		if (qcadev->btsoc_type == QCA_WCN3990)
> > +		if (qcadev->btsoc_type == QCA_WCN3990) {
> > +			hci_uart_set_flow_control(hu, true);
> 
> Wow, yeah, this parameter inversion is indeed confusing...
> 
> >  			serdev_device_set_rts(hu->serdev, false);
> > +		}
> 
> But looking at hci_uart_set_flow_control() now, it actually also
> deasserts RTS. So all you need here is the hci_uart_set_flow_control()
> call.  

Great, thanks for pointing that out!

> And that makes the inversion make a bit more sense too, even if the
> naming is a bit unfortunate with respect to
> serdev_device_set_flow_control() at least.

