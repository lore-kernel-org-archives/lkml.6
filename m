Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B7FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072472087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549296592;
	bh=Kz0C01YmPi5vfpxm/eGmdrM52DnEjP7I7rO040J01M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p3iZISHNED3GB4LoFrPoC3LP0l+LBfgpuaXztpsanko15abEUWgPhWpB04KgiWxCD
	 QmVKtjDhV4Gd+Y4+dc6f9FxeQdZiLo/+P5+IQg98wySEgPtOjtBqWyWeZxPxD4iwae
	 laH3iiUZ31szhJpFMEHScHlv+3D4Qj+dOFz+sN3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbfBDQJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:09:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46392 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfBDQJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:09:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so264348lfc.13;
        Mon, 04 Feb 2019 08:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fv99+Akl3eqzmFl2HQwYKe+5QOknTplGEtgB+QNZ7OM=;
        b=Z+RgxC7cU8VHT2AZaMfHMOF53pFRYmrhT7ht2Dhef77qlVCeCEj1/xc6xVVB2BK1tR
         u05cCE9+2qhfPO3lt3HuRYFqS7DPpyUKWEfa7XCeFC8FsQPf3sSjzOOpNP9We5CPdOCk
         Qzy7NKB+9a4Wvj/R4PZ9yqq2UmksVIVjeFSwAJuXZ6GzlSLJhOl+jdQ5+zIl5OqFzcwg
         P8cSnY7ebiLS5kLxvdT1JankYjLu5UZPySwwcbfo5ojoAxYiaWJ1nbqP1NcZyH8ELK6y
         VIEqBXd3mc/Qf827Z5aCb9ggsAEP7vr0IqxBmurZgFSJxGb/ekTDiAj2qi8Rp3XUdWm3
         9cCw==
X-Gm-Message-State: AHQUAuYXo+obsgArArjEholv2Mw7ZPO8iApQOWgpoiji5P5/uuRXP9LI
        hw/7rlpt7rsy0I7uGo9I6Ss=
X-Google-Smtp-Source: AHgI3IZJbykkEA4ptnQr0AoeCmUTzVfVUF9ptFMec/CPt+sgDDqaz6142X+vjtL72NH5uAUNLsMrcA==
X-Received: by 2002:ac2:4432:: with SMTP id w18mr81108lfl.140.1549296587767;
        Mon, 04 Feb 2019 08:09:47 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g12-v6sm2739519lja.74.2019.02.04.08.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 08:09:46 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gqgoa-0006sx-RL; Mon, 04 Feb 2019 17:09:45 +0100
Date:   Mon, 4 Feb 2019 17:09:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: Fix GPIO in autosuspend
Message-ID: <20190204160944.GH4686@localhost>
References: <20190115085743.GL3691@localhost>
 <20190114194352.4579-1-pados@pados.hu>
 <15f71a61af66817847d4b11b9e2e60e8@pados.hu>
 <20190115092607.GN3691@localhost>
 <20190115102942.GO3691@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115102942.GO3691@localhost>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 11:29:42AM +0100, Johan Hovold wrote:
> On Tue, Jan 15, 2019 at 10:26:07AM +0100, Johan Hovold wrote:
> > On Tue, Jan 15, 2019 at 09:17:58AM +0000, Karoly Pados wrote:
> > > > I think it's better to add the autopm call to gpio210x_gpio_get/set
> > > > only. This will allow for a simpler patch, and keeps the autopm handling
> > > > confined to the gpio paths.
> > > 
> > > I'll submit a v2.
> > > 
> > > >> @@ -1383,6 +1397,7 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int
> > > >> value)
> > > >> } else {
> > > >> u16 wIndex = buf.state << 8 | buf.mask;
> > > >> 
> > > >> + usb_autopm_get_interface(serial->interface);
> > > > 
> > > > Also make sure to always check for errors from autopm_get().
> > > 
> > > I checked everywhere else, the reason I didn't check here is on
> > > purpose based on your previous feedback. The caller function here
> > > doesn't have a return value, so the only way to return errors is to
> > > log, but in my last patch to ftdi_sio you made clear that errors from
> > > autopm_get shouldn't get logged. Trying to call usb_control_msg() even
> > > though the device could not wake does not cause issues, and the return
> > > value from usb_control_msg() clearly identifies the reason for failure
> > > (failure due to autosuspend), so error information is not lost either.
> > > So I thought not checking here has no real disadvantage and I still
> > > stay conformant to your previous guidance.
> > 
> > Ok, I understand your reasoning, but please do check for errors and bail
> > out early if autopm_get() fails. No need to log errors.
> 
> Actually, we should probably add the missing error handling to the
> callers and have gpio_set() propagate errors too. If you want to take a
> stab at that, that could be a follow-on patch.

Karoly, did you plan on sending a v2 of this one?

Thanks,
Johan
