Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83519ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4644920B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4644920B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeGPMhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:37:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeGPMhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:37:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4B25BC3A;
        Mon, 16 Jul 2018 12:10:07 +0000 (UTC)
Date:   Mon, 16 Jul 2018 14:10:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Ladislav Michl <ladis@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
Message-ID: <20180716121005.GA23309@kroah.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
 <20180704070919.GA14051@lenoch>
 <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com>
 <c0ffc590-8064-3b02-9b5c-fcc24628d390@ti.com>
 <CAMRc=McO8H9Aw8a7h318a=hJjKBOgeC+9_hreBnOY3Tc3Fh7sg@mail.gmail.com>
 <d7f03763-982f-5e3e-d0ad-54e024b10f97@ti.com>
 <a70aebb0-408c-c61f-897a-227114888585@linaro.org>
 <3b53a8a7-3f3a-4341-35b0-e7b52854fa9b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b53a8a7-3f3a-4341-35b0-e7b52854fa9b@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 05:27:00PM +0530, Sekhar Nori wrote:
> On Monday 16 July 2018 02:26 PM, Srinivas Kandagatla wrote:
> > 
> > 
> > On 16/07/18 09:50, Sekhar Nori wrote:
> >> On Friday 13 July 2018 11:30 PM, Bartosz Golaszewski wrote:
> >>
> >>> We're getting close to rc5 so I'd like to make a case for this series
> >>> again.
> >>>
> >>> I understand that there's more to do than just the changes introduced
> >>> here, but we shouldn't try to fix several problems in many different
> >>> places at once. There's just too many moving pieces. I'd rather start
> >>> merging small improvements right away.
> >>>
> >>> The idea behind this series is to remove (almost) all users of
> >>> at24_platform_data. The davinci_emac patches are there only because we
> >>> need to remove some MAC adress reading stuff from the board files.
> >>> Having this code there and calling it back from EEPROM/MTD drivers is
> >>> already wrong and we should work towards using nvmem for that anyway.
> >>>
> >>> Currently for MTD the nvmem support series seems to be dead and it's
> >>> going to take some time before anything gets upstream.
> >>>
> >>> So I'd like to again ask you to consider picking up the patches from
> >>> this series to your respective trees or at the very least: I'd like to
> >>> ask Srinivas to pick up the nvmem patches and Sekhar to take the
> >>> first, non-controversial batch of davinci platform changes so that
> >>> we'll have less code to carry for the next release.
> >>
> >> I think those are patches 3-7. I can take those if I get an immutable
> >> commit over v4.18-rc1 from Srinivas with patches 1 & 2 applied.
> 
> > nvmem patches go via Greg KH char-misc tree, if it makes things easy I
> > can provide Ack on nvmem patches, so that you can take these patches via
> > your tree?
> > 
> > Let me know.
> 
> I can do that.
> 
> Greg, are you fine with this? It will be great to have your ack for
> patches 1/8 and 2/18.

I'm not the nvmem maintainer :)

