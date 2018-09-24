Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285CCECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B4D214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B4D214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeIYCgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:36:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:15825 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeIYCgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:36:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 13:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,299,1534834800"; 
   d="scan'208";a="266317900"
Received: from sayanbha-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.27.35])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2018 13:32:53 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id F030721E3F; Mon, 24 Sep 2018 23:32:52 +0300 (EEST)
Date:   Mon, 24 Sep 2018 23:32:52 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>
Subject: Re: [PATCH 1/2] [media] imx214: Add imx214 camera sensor driver
Message-ID: <20180924203252.wxeclgjc7zvepyhb@kekkonen.localdomain>
References: <20180921085450.19224-1-ricardo.ribalda@gmail.com>
 <20180921092833.c3bznrhc3yyarmq4@kekkonen.localdomain>
 <CAPybu_2J4b8C_AQu5trH6fLG3FAkSvFiUOYt-HFwG+YXK9PkkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPybu_2J4b8C_AQu5trH6fLG3FAkSvFiUOYt-HFwG+YXK9PkkQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Fri, Sep 21, 2018 at 12:15:55PM +0200, Ricardo Ribalda Delgado wrote:
...
> > > +static struct reg_8 mode_1920x1080[];
> > > +static struct reg_8 mode_4096x2304[];
> >
> > Const. Could you rearrange the bits to avoid the forward declarations?
> Const done, but I prefer to keep the forward declaration. Otherwise
> the long tables will "hide" the mode declaration.

Well, I guess the long tables do "hide" a bunch of other stuff, too. :-)
But... I agree there's no trivial way around those tables either.

It appears I'm not the only one who's commented on the matter of the
forward declaration.

...

> > > +static int imx214_probe(struct i2c_client *client)
> > > +{
> > > +     struct device *dev = &client->dev;
> > > +     struct imx214 *imx214;
> > > +     struct fwnode_handle *endpoint;
> > > +     int ret;
> > > +     static const s64 link_freq[] = {
> > > +             (IMX214_DEFAULT_PIXEL_RATE * 10LL) / 8,
> >
> > You should check the link frequency matches with that from the firmware.
> 
> I am not sure what you mean here sorry.

The system firmware holds safe frequencies for the CSI-2 bus on that
particular system; you should check that the register lists are valid for
that frequency.

...

> > > +     imx214->pixel_rate = v4l2_ctrl_new_std(&imx214->ctrls, NULL,
> > > +                                            V4L2_CID_PIXEL_RATE, 0,
> > > +                                            IMX214_DEFAULT_PIXEL_RATE, 1,
> > > +                                            IMX214_DEFAULT_PIXEL_RATE);
> > > +     imx214->link_freq = v4l2_ctrl_new_int_menu(&imx214->ctrls, NULL,
> > > +                                                V4L2_CID_LINK_FREQ,
> > > +                                                ARRAY_SIZE(link_freq) - 1,
> > > +                                                0, link_freq);
> >
> > Do I understand this correctly that the driver does not support setting
> > e.g. exposure time or gain? Those are very basic features...
> 
> 
> Yep :), this is just a first step. I do not have the register set from
> the device :(. So I am reverse engineering a lot of things.
> I will add more controls as I am done with them.

Looking at the registers you have in the register list, the sensor's
registers appear similar to those used by the smiapp driver (the old SMIA
standard).

I'd guess the same register would work for setting the exposure time. I'm
less certain about the limits though.

> 
> >
> > You'll also need to ensure the s_ctrl() callback works without s_power()
> > being called. My suggestion is to switch to PM runtime; see e.g. the ov1385
> > driver in the current media tree master.
> 
> 
> There is one limitation with this chip on the dragonboard. I2c only
> works if the camss is ON. Therefore whatever s_ctrl needs to be
> cached and written at streamon.

That's something that doesn't belong to this driver. It's the I²C adapter
driver / camss issue, and not necessarily related to drivers only. Is the
I²C controller part of the camss btw.?

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
