Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3D3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B614920851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SbEGfWea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfAQRVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:21:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39359 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfAQRVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:21:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so5136913pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pj6X9tOOCfkZoM+MJ1COk9HYEyQOdqx584QyCZWE8RU=;
        b=SbEGfWea6iltjztfTZBjLMBQ+c23sFpW5670JQ/EVn2kFcQd9BI8ivAY1qySo4TnpQ
         e9aYO9bqBqHid8iROVr0EdJtSO1a3GPq0DdXsfEXM2ubag2oBQ9xtHPVNKy2Xp+9hom0
         TngvoHUqNOqITZccmUx4+4d/K2VJEIgFLerkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pj6X9tOOCfkZoM+MJ1COk9HYEyQOdqx584QyCZWE8RU=;
        b=FtyOVjxbuvYDqBy88MJ9qAMPp0LICtT3nCizY2GqJQL6OmbIWDkck/pxXcz2jTyL56
         KgSukOncB6WoLEiGcZuOXfRWq8W4GFdqJ/exZbWLhu0hJ+EtMRsR6e7khCqwx0uaDjsB
         KBV6a4RVKm1bYb2LUq1rmsGwzuI744sAA73K6R+tirSMqJLzyYkqDHa2YIgUWNd1W8wa
         yoYlpE3STD7j/ICzmJMKOJd/0fbYCrikJ8Ydp2EQu5mAuJFgA22cicUqICjfM/gzSmvY
         m1a8uUca/tjUEBCSHK813s3+d6F8EQ1eNgq8r8m1aHJGlpon33MxDMEdTqGGE4qbndlt
         NXzQ==
X-Gm-Message-State: AJcUukcJOKEF7voEUgY2Xnp8cUg86Z7mjHsuda90hU+yTlR7T8X0a2NN
        D57b7BGKxWVXvpjEGKfnwVHNWA==
X-Google-Smtp-Source: ALg8bN5P8QVIOYmP6eHNM0LktEbHISHst/wN7hjWOC9iXUAUPVlWhPAL+pbynnhfXBkL4wqdHMYTLg==
X-Received: by 2002:a65:4683:: with SMTP id h3mr13596063pgr.225.1547745671437;
        Thu, 17 Jan 2019 09:21:11 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a4sm2444740pgv.70.2019.01.17.09.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 09:21:10 -0800 (PST)
Date:   Thu, 17 Jan 2019 09:21:09 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
Message-ID: <20190117172109.GU261387@google.com>
References: <20190109145224.GN14782@localhost>
 <b5160d8862b49f0369fa58610516d354@codeaurora.org>
 <20190110143928.GE3430@localhost>
 <61301df80bd6a8ee0265b31b7f6a3aa1@codeaurora.org>
 <20190111013707.GD261387@google.com>
 <194b5d18ea86830b6a24939d483a964c@codeaurora.org>
 <20190111235633.GK261387@google.com>
 <a6e083d245baebc019b6e7163fd6f133@codeaurora.org>
 <20190115234628.GQ261387@google.com>
 <20190117160944.GV3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117160944.GV3691@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 05:09:44PM +0100, Johan Hovold wrote:
> On Tue, Jan 15, 2019 at 03:46:28PM -0800, Matthias Kaehlcke wrote:
> 
> > Using RTS seems|ed like a nice solutions, since it's the native way to
> > prevent the controller from sending data, instead of doing some custom
> > hack. However Johan seems to be fairly convinced that flow control and
> > manual toggling of RTS can be problematic, and we have seen that
> > disabling flow control has its own problems. Maybe it's time to
> > consider other solutions like the DISCARD_RX flag we discussed
> > earlier. Not that I really liked this custom solution, but in the end
> > it might be a more robust way to address the issue.
> > 
> > Johan/Marcel/others: Do you have any further ideas or input on this?
> 
> I don't see why deasserting RTS wouldn't work, well at least as long as
> the RTS signal is wired correctly.
> 
> My point was simply that calling serdev_device_set_rts() will generally
> not work unless you first disable automatic (i.e. hw-managed) flow
> control using serdev_device_set_flow_control(). The exact behaviour is
> serial-controller dependent, but I assume the driver needs to be
> platform agnostic.

I observed that the qcom_geni_serial driver doesn't raise RTS with
flow control disabled. It seems we have to investigate why that's the
case. I agree that the driver should be platform agnostic.

Cheers

Matthias
