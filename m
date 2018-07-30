Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555ECC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E045020857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D1vzQbYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E045020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbeG3Vnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:43:43 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42067 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbeG3Vnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:43:42 -0400
Received: by mail-pl0-f67.google.com with SMTP id z7-v6so6028601plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xR5Smy+3JTdomKF8Wyeaw6IS6Col1Z76E1qUla35/RY=;
        b=D1vzQbYa+unIOJjSZNmhwL5G2ZXl4twlqdFu+kkf9qz8wwHoVDe2QYxPfJ4OOopi6f
         p9pWyfLwKiMZl2YN1pznH699CaD9sGx2H2K3pJRVZgfAGhKpC7aWWlxwxMPZajHYbChu
         HnnEeO7DKbifad+HJ5ZQ4HKdmqM0W5xh2a4U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xR5Smy+3JTdomKF8Wyeaw6IS6Col1Z76E1qUla35/RY=;
        b=QWgse7FH+/Pr49obNgiaOePZhe6Rr6J6apQ6wrISDRzJbYHiNNYys9uCPu8QEG9Jqf
         Fp5WV0JsMmWdEYAIvqJsEtjI+vnZFIxD+WiWoIyQGwWtagFh6H+PmoINpAsQj69rMpUl
         jGEmvphg4wrUHBplX9mMPMAzurYho2tbgpIQex8nNUwbdv+2HkHKoP+xIUWmhxjw/H6/
         19n17jHpk0EHMUpmogS64PV7GPT1qK7AhpQfDmWhJ7Vwc15xOyJrrCZhrvkOWBbCjOIr
         vRe2rv7wAnAf+sR5ewQZXKFY321IRdtgBCuaRkFqprGsbZ1ROtK7rfSRvQw3UicBoApq
         o50A==
X-Gm-Message-State: AOUpUlGRpg6YDP/gP4YNE3LWDDjar6pE9H0+G7TmrVkKlCb4RarU4E/7
        kLmfDRNeFvdQ6Wxc5t/Di5XFGQ==
X-Google-Smtp-Source: AAOMgpdzghi5vmHUXtgxseiuBgqj8h32UOjSkzpaa/QfrvGTFwKm8GvBLndKfmK+0qpjkOhJsjMsMg==
X-Received: by 2002:a17:902:b7c6:: with SMTP id v6-v6mr17159920plz.49.1532981225300;
        Mon, 30 Jul 2018 13:07:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id f19-v6sm21342598pfd.147.2018.07.30.13.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 13:07:04 -0700 (PDT)
Date:   Mon, 30 Jul 2018 13:07:03 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
Message-ID: <20180730200703.GB68975@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-8-bgodavar@codeaurora.org>
 <20180723195441.GM129942@google.com>
 <81c324ee9104508cf5c862de3f697e4c@codeaurora.org>
 <20180725183144.GQ129942@google.com>
 <0666f40967de21db9ef3df9d94517ac1@codeaurora.org>
 <20180726195129.GW129942@google.com>
 <ba5c7f6cc8ba7c010ccd6c3573a5d234@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba5c7f6cc8ba7c010ccd6c3573a5d234@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 05:09:02PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-07-27 01:21, Matthias Kaehlcke wrote:
> > On Thu, Jul 26, 2018 at 07:51:13PM +0530, Balakrishna Godavarthi wrote:
> > > Hi Matthias,
> > > 
> > > On 2018-07-26 00:01, Matthias Kaehlcke wrote:
> > > > On Tue, Jul 24, 2018 at 09:25:16PM +0530, Balakrishna Godavarthi wrote:
> > > > > Hi Matthias,
> > > > >
> > > > > On 2018-07-24 01:24, Matthias Kaehlcke wrote:
> > > > > > On Fri, Jul 20, 2018 at 07:02:43PM +0530, Balakrishna Godavarthi wrote:
> > > > > > > +	 * sometimes we will face communication synchronization issues,
> > > > > > > +	 * like reading version command timeouts. In which HCI_SETUP fails,
> > > > > > > +	 * to overcome these issues, we try to communicate by performing an
> > > > > > > +	 * COLD power OFF and ON.
> > > > > > > +	 */
> > > > > > > +	for (i = 1; i <= 10 && ret; i++) {
> > > > > >
> > > > > > Is it really that bad that more than say 3 iterations might be needed?
> > > > > >
> > > > > [Bala]: will restrict to 3 iterations.
> > > >
> > > > Is 3x expected to be enough to 'guarantee' as successful
> > > > initialization? Just wondered about the 10x since it suddendly changed
> > > > from 1x. What is the failure rate without retries?
> > > >
> > > > Could you provide more information about the 'communication
> > > > synchronization issues'? Is the root cause understood? Maybe there is
> > > > a better way than retries.
> > > >
> > > 
> > > [Bala]: basically before sending a every patch series we run a
> > > stress test
> > > to the driver to detect the bugs.
> > >         in recent test results found one interesting bug that BT
> > > setups
> > > fails with version request timeouts,
> > >         after we do a reboot for the device.
> > >         we debugged the issue and found that wcn3900 is not
> > > responding to
> > > the version request commands
> > >         sent by HOST. this is because before reboot, wcn3990 is in
> > > on state
> > > i.e. we are communicating to device.
> > >         then we did a reboot and HOST is not sending a power off
> > > request to
> > > the regulators to turn off.
> > >         so after reboot wcn3990 is still in ON state where it will not
> > > respond to version request commands which in turn fails HCI_SETUP.
> > >         so we are sending the power off pulse and then sending the
> > > power on
> > > pulse.
> > >         coming back to 3x or 10x iteration this is to avoid any such
> > > synchronization issues.
> > >         i agreed for 3x because of stress test results. we have
> > > success rate
> > > of 99% for single iteration, where as 3x iterations will helps to
> > > handle 1%
> > > fails cases.
> > 
> > Thanks for the clarification. Couldn't you assure the device is in a
> > defined state by calling qca_power_shutdown() as one of the first
> > things in qca_wcn3990_init()?
> 
> [Bala]:  we have reasons behind writing qca_power_setup(true) at the start.
> 
>         1. the reason to add iteration here, is to handle BT fails cases
> either due to communication failure of wcn3900 or due to regulator issues.
>            before calling qca_setup(), we have our regulator turned on and
> in qca_setup i.e. init routine if we added power_shutdown as first statement
> before
>            communicating with chip then regulator will be off and again we
> need to call function to ON regulators.
>            so it could be some thing like this
> 
>            init(){
> 
>                for () {
>                      shutdown() // regs are off
>                      poweron(true) // regs are on.
>                      if(!start communicating with chip()) {
>                         break;
>                       }
> 
>                }
>            }
>            as the reason to add the iteration handling is to overcome 1% of
> fail cases, so every time when we call it will turn off the regs and turn it
> back. which require an turning in off regs and on it back for 99% pass
>             cases.

But would turning off the regs really add a significant delay here?
The setup is already really slow, with a 100ms delay in the
loop (still wonder if booting the chip without loading firmware really
takes that long) and later the firmware is loaded.

If the chip needs to be in a defined state we should make sure to put
in into that state, unless there is a significant overhead wrt 'try
first and only reset in case of failure'. As a nice side effect the
code would be cleaner and we probably could get rid of the loop
completely, since it's supposed to address the case where the chip
wasn't properly reset on a reboot.

>         2. this is the one of the main reason for adding
> qca_power_setup(true) in the init() function first.
>            as we know that power management is so critical for long lasting
> of battery.
>            now present implementation is when we off BT from UI i.e. hci0
> down, we put BT into an suspend or low power mode, as soon as we turn ON the
> BT back from UI we make hci0 up.
>            the above is putting device into suspend state and bring it back
> where the regulator are still on state. so we will have leakage currents
> which can be minimal or may be in few mA.
>            to over come the above case, we want to do an cold on/off for BT
> chip wcn3990. i.e. when bt is off from UI, we will off the regulators and
> turn on it again once the BT is ON from UI.
>            every time we disable i.e. off BT from UI we will call
> hdev->shutdown() i.e. completely powering off the chip.
>            so it require an reprogram again, when we turn ON BT from UI. it
> will call qca_setup()--> init().. so here actually qca_power_on(true) will
> turn on the chip and dump the fw files into it.
>            so that is also a reason behind to write power on first.
> 
>            the above feature is under testing state, will post a patch
> series once the driver code merged to bt-next.

Thanks for the info.

If I understand correctly what you describe isn't incompatible with
performing a proper reset. 'vregs_on' can be checked to avoid
disabling already disabled regulators:

  if (qcadev->bt_power->vregs_on)
          qca_power_shutdown(hdev);

  // short delay needed here?

  qca_power_setup(hu, true);

Unless there are drawbacks that I'm missing I think that's preferable
over the retry loop.

> > The code flow with the gotos and the error handling at the end of the
> > loop is a bit messy. Moving the power down to the top of the loop
> > (basically in line with my comment above to get rid of the loop) would
> > help here. In this case checking 'ret' in the loop condition (which I
> > suggested to remove) would make sense, since it elimninates the need
> > for the break/return in the success case. But if we can do without the
> > loop even better :)
> > 
> 
> [Bala]: there is a reason to add the loop here, here we go with reason to
> add.
>         let us assume that qca_setup fails to establish a communication with
> wcn3990
>         then next steps will not be pass and we can't populate hci0 rfkill
> entry.
>         in traditional bluez stack i.e. bluetoothd daemon will looks for
> hci0, if we have entry for hci0
>         then only BT option is visible in UI or else BT option will not be
> available in UI.
>         we don't have any mechanism handled in bluez user space to
> reinitiate the communication at latest to try for second time to make hci0
> up.
>         so that is reason behind to add so that we can handle fault handling
> of wcn3990 and establish the communication to make BT option available in
> BT.

The loop is supposed to address the following case (quoting you from
earlier discussion in the thread):

> found one interesting bug that BT setups fails with version request
> timeouts, after we do a reboot for the device. we debugged the issue
> and found that wcn3900 is not responding to the version request
> commands sent by HOST. this is because before reboot, wcn3990 is in
> on state i.e. we are communicating to device. then we did a reboot
> and HOST is not sending a power off request to the regulators to
> turn off. so after reboot wcn3990 is still in ON state where it will
> not respond to version request commands which in turn fails
> HCI_SETUP. so we are sending the power off pulse and then sending the
> power on pulse.

My suggestion to address this failure case is to reset/power off the
chip before initializing it. With that the loop shouldn't be needed,
actually it wasn't there before you found this specific error.
