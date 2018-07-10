Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5FCC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1CE208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XOMC4pvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1CE208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934601AbeGJQjN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:39:13 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42919 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933593AbeGJQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:39:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id l9-v6so4836224pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lyrOhDGkSPjRymf5ynKh3WaWJ8tf4tUoSUk0CLQT0fk=;
        b=XOMC4pvjlNQhbNKfzedNXC7CI3YX5dBjFRfM+Nps8CcX2/ueGUJWPwW+34/J9iHXV0
         LQCel+sNYq3XZRjZ5goMfoFX+W+lmhmf8eyKkxJZBep9TmKt2q0RY8C6Zlg4yv6SACXr
         DNSK5qBL6NxDOEe8ZKRWBDzzr53SNnghWO/Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lyrOhDGkSPjRymf5ynKh3WaWJ8tf4tUoSUk0CLQT0fk=;
        b=kbIYb9G0Y5F8CL2X1nvOX6utW3gH/IUpmltNcXQmFTpRQpQ1BZ08P6nDtjTR78eMwA
         JoBW3h7B8cLXoqMjp3PMj96esYnBfI0kxHMlefVNex6sSE0vp5mmRc8M8x2+qUdyc38s
         O3CR8bwJ8fYwd85c2VsM+mRai2tvX4qoi/U/FD5x8kGSOsXUc27urd+hFH+BCX6WPWUR
         tj8i3Y0fSg9kHRrstFdNPNAfs2pw3emlAzWpqddYjOT6nnEj66JTFgCniLpPjaxzzvsM
         h/DMBh6H4UcSxrBiMY8e+fribAbVSCUZdToWtNmZETf5z09zGuLeIYJRjpORw1mR9Fql
         QYnQ==
X-Gm-Message-State: APt69E2D+CaQOxHmmIWWMVfNUM0j/YmrWLnT4TmFje+cKySEStVNTSez
        vSQDjE/mEHlVG54tFvLhgha1Hg==
X-Google-Smtp-Source: AAOMgpeCyO8Ct5OMiU9fiZKdHexotIC6cIzOEVLkBEpVMl556zewlLmfmnZxdr79l3QbuixRXPuIXw==
X-Received: by 2002:a63:5d09:: with SMTP id r9-v6mr23162731pgb.303.1531240750254;
        Tue, 10 Jul 2018 09:39:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id 22-v6sm38350890pfl.126.2018.07.10.09.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 09:39:09 -0700 (PDT)
Date:   Tue, 10 Jul 2018 09:39:09 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v9 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
Message-ID: <20180710163909.GQ129942@google.com>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
 <20180705165515.13340-8-bgodavar@codeaurora.org>
 <20180706222110.GK129942@google.com>
 <a5d87ad5d916df5b5ca7c0c69a786e4a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5d87ad5d916df5b5ca7c0c69a786e4a@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bala,

On Tue, Jul 10, 2018 at 06:22:02PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-07-07 03:51, Matthias Kaehlcke wrote:
> > On Thu, Jul 05, 2018 at 10:25:15PM +0530, Balakrishna Godavarthi wrote:
> > > +	 * sending vendor power on and off pulse to SoC.
> > > +	 */
> > 
> > The function is called qca_send_vendor_cmd(), the comment about power
> > on/off pulses seems misplaced here. Are there other 'vendor commands'
> > that require a different flow control behavior?
> > 
> > Perhaps the function should have a different name or we need another
> > wrapper.
> > 
> 
> [Bala]: this function is used to send single byte vendor commands. like
> power on and off pulse.
>         and all single byte vendor commands require an flow control off and
> on.
>         so might be function name change is required.
>         instead of qca_send_vendor_cmd(). i want to change function name to
> qca_send_pulse() as this will be generic.

'pulse' covers power on/off pulses, is it also applicable to other
single byte commands? How are these commands named in the QCA
documentation?

In any case the comment about 'vendor power on and off pulse' should
be updated to refer to 'vendor commands'/'pulses' or whatever
terminology we decide to use.

> > > +	hci_uart_set_flow_control(hu, true);
> > 
> > Should the changing of the flow control be limited to wcn3990? As of
> > now the function is only called for wcn3990, however this is not
> > stated as a requirement and might change in the future.
> > 
> > > +	skb_put_u8(skb, cmd);
> > > +	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
> > > +
> > > +	skb_queue_tail(&qca->txq, skb);
> > > +	hci_uart_tx_wakeup(hu);
> > > +
> > > +	/* Wait for 100 uS for SoC to settle down */
> > > +	usleep_range(100, 200);
> > 
> > Is this needed for any 'vendor command' or directly related with the
> > power on/off pulses?
> > 
> 
> [Bala] : flow control  off/on is needed for power on and off pulses along
> with
>          command to set baudrate.. this is common across all the present
> chips and chips which are in development stages.
>          might be function name is confusing will update the function name.

The current name *might* be ok, depending on if we come up with
something better. If the QCA docs refer to them as 'vendor commands'
and there are no other multi-byte 'vendor commands' I'm fine with it.

Is the settling down of 100us specific to the power on/off pulses or
also applicable to other commands?

Thanks

Matthias
