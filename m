Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262E6C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD14120844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD14120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=magewell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeGYLyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:54:24 -0400
Received: from out20-39.mail.aliyun.com ([115.124.20.39]:35322 "EHLO
        out20-39.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbeGYLyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:54:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07539167|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e04486;MF=yong.deng@magewell.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.CVF5o.V_1532515343;
Received: from John(mailfrom:yong.deng@magewell.com fp:SMTPD_---.CVF5o.V_1532515343)
          by smtp.aliyun-inc.com(10.147.43.230);
          Wed, 25 Jul 2018 18:42:24 +0800
Date:   Wed, 25 Jul 2018 18:42:24 +0800
From:   Yong <yong.deng@magewell.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Thierry Reding <treding@nvidia.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v10 2/2] media: V3s: Add support for Allwinner CSI.
Message-Id: <20180725184224.cab5172f8558162cc74bde9e@magewell.com>
In-Reply-To: <20180718095513.4cm77g2iuilvfmd6@paasikivi.fi.intel.com>
References: <1525417745-37964-1-git-send-email-yong.deng@magewell.com>
        <20180626110821.wkal6fcnoncsze6y@valkosipuli.retiisi.org.uk>
        <20180705154802.03604f156709be11892b19c0@magewell.com>
        <20180718095513.4cm77g2iuilvfmd6@paasikivi.fi.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Wed, 18 Jul 2018 12:55:14 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> Hi Yong,
> 
> On Thu, Jul 05, 2018 at 03:48:02PM +0800, Yong wrote:
> > > > +
> > > > +/* -----------------------------------------------------------------------------
> > > > + * Media Operations
> > > > + */
> > > > +static int sun6i_video_formats_init(struct sun6i_video *video,
> > > > +				    const struct media_pad *remote)
> > > > +{
> > > > +	struct v4l2_subdev_mbus_code_enum mbus_code = { 0 };
> > > > +	struct sun6i_csi *csi = video->csi;
> > > > +	struct v4l2_format format;
> > > > +	struct v4l2_subdev *subdev;
> > > > +	u32 pad;
> > > > +	const u32 *pixformats;
> > > > +	int pixformat_count = 0;
> > > > +	u32 subdev_codes[32]; /* subdev format codes, 32 should be enough */
> > > > +	int codes_count = 0;
> > > > +	int num_fmts = 0;
> > > > +	int i, j;
> > > > +
> > > > +	pad = remote->index;
> > > > +	subdev = media_entity_to_v4l2_subdev(remote->entity);
> > > > +	if (subdev == NULL)
> > > > +		return -ENXIO;
> > > > +
> > > > +	/* Get supported pixformats of CSI */
> > > > +	pixformat_count = sun6i_csi_get_supported_pixformats(csi, &pixformats);
> > > > +	if (pixformat_count <= 0)
> > > > +		return -ENXIO;
> > > > +
> > > > +	/* Get subdev formats codes */
> > > > +	mbus_code.pad = pad;
> > > > +	mbus_code.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> > > > +	while (!v4l2_subdev_call(subdev, pad, enum_mbus_code, NULL,
> > > > +				 &mbus_code)) {
> > > 
> > > The formats supported by the external sub-device may depend on horizontal
> > > and vertical flipping. You shouldn't assume any particular configuration
> > > here: instead, bridge drivers generally just need to make sure the formats
> > > match in link validation when streaming is started. At least the CSI-2
> > > receiver driver and the DMA engine driver (video device) should check the
> > > configuration is valid. See e.g. the IPU3 driver:
> > > drivers/media/pci/intel/ipu3/ipu3-cio2.c .
> > 
> > Can mbus_code be added dynamically ?
> > The code here only enum the mbus code and get the possible supported
> > pairs of pixformat and mbus by SoC. Not try to check if the formats
> > (width height ...) is valid or not. The formats validation will be 
> > in link validation when streaming is started as per your advise. 
> 
> The formats that can be enumerated from the sensor here are those settable
> using SUBDEV_S_FMT. The enumeration will change on raw sensors if you use
> the flipping controls. As the bridge driver implements MC as well as subdev
> APIs, generally the sensor configuration is out of scope of this driver
> since it's directly configured from the user space.
> 
> Just check that the pipeline is valid before starting streaming in your
> driver.

Sorry. I am still confused.
As the CSI driver does not enum the formats supported by sensor.
How to get a valid format if I do not want to open the subdev? 
Many applications still only open /dev/video*.

> 
> -- 
> Kind regards,
> 
> Sakari Ailus
> sakari.ailus@linux.intel.com


Thanks,
Yong
