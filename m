Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9FEC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4A520837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eaXlWAUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4A520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeHaFAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:00:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43736 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeHaFAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:00:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id x6-v6so4597964plv.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 17:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gd7QqOfw2854NyYILH8bl0+BF4VPOE0NIs0RGVhGMMg=;
        b=eaXlWAUj2bYgjQDysQra6K4UBVdagMTk/miVxDdo0X19UqPNX+6wpehFn1YTQsDWYe
         kOi5ddsoLAqV60SQf/6w3okzV68UCXhj/txeJb8/MUm3j9u5Dg4XR4ZSVYmPwSfLv/sy
         r4dQu3Vdpyo5ShD3vZqmzjG08OdNNt1WppVbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gd7QqOfw2854NyYILH8bl0+BF4VPOE0NIs0RGVhGMMg=;
        b=heAa/4mrTxyCRhVD5W4rRxSJWuTbS2+ugQFWE42IP827XWrxWIf5mONVf6mfQa1fFt
         Nhregf832ih2L39x8me8z3en4fe1IVdn39k8z41I4upKGKAseJNe1B1+m30lzpVHAQbK
         A1ePJS2DKQhTMx7dsr4dGcP519iYHsuGY91SpJY1z1j23lFTBer5BKnPAcZFFNVPiQrM
         MvW0wT+SwOkjPaJDV3OdTQKLQc+e0iBJefH153pd16iTab89E/hJF/saWOXlPsavCETH
         xielZZ95JTNqP1xhwH7gV02Kpacl+CvFNl9PIDeUg9yuCV8LnyyPZJqVgvA27HgZr74B
         Opkg==
X-Gm-Message-State: APzg51Dujo239nzjv2rvOYrYZfEeAIGfJ9kKd7uiFQ1pazRVnp0UJuy1
        3UD/1cxODBFe0o8JQCj7mUWsVw==
X-Google-Smtp-Source: ANB0VdYkKJMfF7YkeqtpwU7XNCDxVGFyK92tlp9vyuucFhWuT7L7cWJJup0zXO+LAtOyTi9dU7yH8g==
X-Received: by 2002:a17:902:1001:: with SMTP id b1-v6mr12761842pla.155.1535676929351;
        Thu, 30 Aug 2018 17:55:29 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id h12-v6sm11059661pfo.135.2018.08.30.17.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 17:55:27 -0700 (PDT)
Date:   Thu, 30 Aug 2018 17:55:25 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH v1 0/3] device property: Support MAC address in VPD
Message-ID: <20180831005524.GA67271@ban.mtv.corp.google.com>
References: <20180814223758.117433-1-briannorris@chromium.org>
 <a240b3f9-d41b-30d7-ef11-5dcd1a981c0f@gmail.com>
 <20180815002204.GA258561@ban.mtv.corp.google.com>
 <bb1b2b7d-2c47-a6b3-7618-063351f379b2@gmail.com>
 <20180815014436.GA17200@ban.mtv.corp.google.com>
 <153437082071.28926.11684780766239178367@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153437082071.28926.11684780766239178367@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for the delayed response here)

Hi,

On Wed, Aug 15, 2018 at 03:07:00PM -0700, Stephen Boyd wrote:
> Quoting Brian Norris (2018-08-14 18:44:36)
> > But anyway, would the idea be that you just put 'ethernet{0,1,...}' and
> > 'wifi{0,1,...}' aliases in the /chosen node, then require boot firmware
> > to insert any {ethernet,wifi}_mac{0,1,...} into the paths represented by
> > the corresponding aliases? I suppose that would reduce the problems with
> > (1), but it still doesn't really help with (2).
> 
> Yes. Aliases are the way to do this. It obviates much of this discussion
> about finding things in DT by directly pointing to the node the
> bootloader wants to go modify.

Sure, that does seem to help.

> > > > And finally, this may be surmountable, but the existing APIs seem very
> > > > device tree centric. We use this same format on ACPI systems, and the
> > > > current series would theoretically work on both [1]. I'd have to rewrite
> > > > the current (OF-only) helpers to get equivalent support...
> 
> Where does it go on ACPI systems? Does the firmware stick it into some
> ACPI table by reading from VPD?

I'm not aware of any ACPI system that needs to do something quite like
this. The closest I see is a Coreboot board for some Chromeboxes [1],
which handles Ethernet MAC addresses -- it does this by reading similar
VPD fields, but then it just goes and programs the MAC directly into the
Ethernet card's registers. This is a Realtek PCI Ethernet chip, and
apparently it even needs firmware to program its product and vendor ID
for it.

I'm not really sure what lesson to get out of that though. That
discoverable hardware is a giant dirty mess (even PCI gets a lot of help
from system firmware!)?

Or I guess maybe the lesson is: ACPI systems will always find a way to
do it in firmware, no matter how much bloat it costs. So I don't really
need to consider "does this solution work with ACPI"? But just, does it
work with {device,fwnode}_get_mac_address() -- e.g., by teaching them to
call of_get_nvmem_mac_address()?

Brian

[1] Here, and similar variants in other boards throughout the tree:
https://review.coreboot.org/cgit/coreboot.git/tree/src/mainboard/google/beltino/lan.c
