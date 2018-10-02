Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B698C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD0F2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD0F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbeJBUlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:41:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:33171 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbeJBUlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:41:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 06:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,332,1534834800"; 
   d="scan'208";a="95385105"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2018 06:57:39 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id C301520804; Tue,  2 Oct 2018 16:57:38 +0300 (EEST)
Date:   Tue, 2 Oct 2018 16:57:38 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] [media] imx214: device tree binding
Message-ID: <20181002135738.ox3jlujqzvyc4m2b@paasikivi.fi.intel.com>
References: <20181002133058.12942-1-ricardo.ribalda@gmail.com>
 <3927913.3GBmOnKHNx@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3927913.3GBmOnKHNx@avalon>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Tue, Oct 02, 2018 at 04:47:55PM +0300, Laurent Pinchart wrote:
> Hi Ricardo,
> 
> Thank you for the patch.
> 
> On Tuesday, 2 October 2018 16:30:57 EEST Ricardo Ribalda Delgado wrote:

...

> > +- clock-frequency = Frequency of the xclk clock. (Currently the
> > +	driver only supports <24000000>).
> 
> Please don't mention drivers in DT bindings. I would drop the reference to the 
> 24 MHz limitation.
> 
> I would actually drop the property completely :-) I don't see why you need it, 
> and you don't make use of it in the driver.

Would you rely on assigned-clock-rates or what? There's no guarantee it'll
actually be the desired frequency. That said, few (or no) drivers checks
what they get when they set the frequency.

> 
> > +Optional Properties:
> > +- flash-leds: See ../video-interfaces.txt
> > +- lens-focus: See ../video-interfaces.txt
> > +
> > +The imx274 device node should contain one 'port' child node with

s/should/shall/?

If there's a need to support no port nodes, then say "one or none" or such.
Usually that's useful on the receiver side only though.

> > +Example:
> > +
> > +	camera_rear@1a {
> > +		compatible = "sony,imx214";
> > +		reg = <0x1a>;
> > +		vdddo-supply = <&pm8994_lvs1>;
> > +		vddd-supply = <&camera_vddd_1v12>;
> > +		vdda-supply = <&pm8994_l17>;
> > +		lens-focus = <&ad5820>;
> > +		enable-gpios = <&msmgpio 25 GPIO_ACTIVE_HIGH>;
> > +		clocks = <&mmcc CAMSS_MCLK0_CLK>;
> > +		clock-names = "xclk";
> > +		clock-frequency = <24000000>;
> > +		port {
> > +			imx214_ep: endpoint {
> > +				clock-lanes = <0>;

I'd only put clock-lanes if the lane ordering is configurable.

> > +				data-lanes = <1 2 3 4>;
> > +				link-frequencies = /bits/ 64 <480000000>;
> > +				remote-endpoint = <&csiphy0_ep>;
> > +			};
> > +		};
> > +	};

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
