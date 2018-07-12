Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0986EC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E7E20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E7E20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeGLQsu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:48:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37125 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbeGLQsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:48:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 726E5207E8; Thu, 12 Jul 2018 18:38:31 +0200 (CEST)
Received: from localhost (LFbn-1-2035-163.w90-76.abo.wanadoo.fr [90.76.104.163])
        by mail.bootlin.com (Postfix) with ESMTPSA id 415D620719;
        Thu, 12 Jul 2018 18:38:21 +0200 (CEST)
Date:   Thu, 12 Jul 2018 18:38:21 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     hans.verkuil@cisco.com, acourbot@chromium.org,
        sakari.ailus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        tfiga@chromium.org, posciak@chromium.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
Message-ID: <20180712163821.np57u46m7akpubht@flea>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-2-maxime.ripard@bootlin.com>
 <9c80de4e-c070-1051-2089-2d53826c6fc7@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <9c80de4e-c070-1051-2089-2d53826c6fc7@xs4all.nl>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thanks for your feedback, I have a few things I'm not really sure
about though.

On Fri, Jun 15, 2018 at 01:59:58PM +0200, Hans Verkuil wrote:
> > +struct v4l2_ctrl_h264_sps {
> > +	__u8 profile_idc;
> > +	__u8 constraint_set_flags;
> > +	__u8 level_idc;
> > +	__u8 seq_parameter_set_id;
> > +	__u8 chroma_format_idc;
> > +	__u8 bit_depth_luma_minus8;
> > +	__u8 bit_depth_chroma_minus8;
> > +	__u8 log2_max_frame_num_minus4;
> > +	__u8 pic_order_cnt_type;
> > +	__u8 log2_max_pic_order_cnt_lsb_minus4;
> 
> There is a hole in the struct here. Is that OK? Are there alignment
> requirements?

This structure represents an equivalent structure in the H264
bitstream, but it's not a 1:1 mapping, so I don't think there's any
alignment issues.

As of the padding, is it an issue? Isn't it defined by the ABI, and
therefore the userspace will have the same padding rules?

> 
> > +	__s32 offset_for_non_ref_pic;
> > +	__s32 offset_for_top_to_bottom_field;
> > +	__u8 num_ref_frames_in_pic_order_cnt_cycle;
> > +	__s32 offset_for_ref_frame[255];
> 
> Perhaps use a define instead of hardcoding 255? Not sure if that makes sense.
> Same for other arrays below.
> 
> > +	__u8 max_num_ref_frames;
> > +	__u16 pic_width_in_mbs_minus1;
> > +	__u16 pic_height_in_map_units_minus1;
> > +	__u8 flags;
> > +};
> 
> You have to test the struct layout for 32 bit and 64 bit systems
> (the latter for both 64 bit arm and Intel). The layout should be the
> same for all of them since the control framework does not support
> compat32 conversions for compound controls.

I'm not really sure how to test that though? Should I write a program
doing a bunch of offset_of calls to make sure it matches by hand, or
is there anything smarter?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
