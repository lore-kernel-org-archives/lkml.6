Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259BCC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36B921480
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kf8be1H/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36B921480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbeGLQ6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:58:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60644 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbeGLQ6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=c7BYbFOUtss8RRqBwYYaU8G9kwuFbv7ibhvpWyf3uEE=;
        b=kf8be1H/KliMGqNGnLdva3YZot31ijkqbgpzpdrHS0MxEWmnqKL7Tyo7ciJKXIYjV5Q/8yud+TuW9kKCNee3A2DvaeFBMixi3eG0XgiN7y5LJrAoMEvTVIC59tcCDWYIN1gJj7p2Ex5Nu80noFkxGHIofnaBZhsK++dWCsFOH6c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fdekZ-0003X9-6j; Thu, 12 Jul 2018 18:47:27 +0200
Date:   Thu, 12 Jul 2018 18:47:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        acourbot@chromium.org, jenskuske@gmail.com,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        tfiga@chromium.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, hans.verkuil@cisco.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        sakari.ailus@linux.intel.com, Guenter Roeck <groeck@chromium.org>,
        nicolas.dufresne@collabora.com, posciak@chromium.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
Message-ID: <20180712164727.GB10740@lunn.ch>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-2-maxime.ripard@bootlin.com>
 <9c80de4e-c070-1051-2089-2d53826c6fc7@xs4all.nl>
 <20180712163821.np57u46m7akpubht@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712163821.np57u46m7akpubht@flea>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:38:21PM +0200, Maxime Ripard wrote:
> Hi Hans,
> 
> Thanks for your feedback, I have a few things I'm not really sure
> about though.
> 
> On Fri, Jun 15, 2018 at 01:59:58PM +0200, Hans Verkuil wrote:
> > > +struct v4l2_ctrl_h264_sps {
> > > +	__u8 profile_idc;
> > > +	__u8 constraint_set_flags;
> > > +	__u8 level_idc;
> > > +	__u8 seq_parameter_set_id;
> > > +	__u8 chroma_format_idc;
> > > +	__u8 bit_depth_luma_minus8;
> > > +	__u8 bit_depth_chroma_minus8;
> > > +	__u8 log2_max_frame_num_minus4;
> > > +	__u8 pic_order_cnt_type;
> > > +	__u8 log2_max_pic_order_cnt_lsb_minus4;
> > 
> > There is a hole in the struct here. Is that OK? Are there alignment
> > requirements?
> 
> This structure represents an equivalent structure in the H264
> bitstream, but it's not a 1:1 mapping, so I don't think there's any
> alignment issues.
> 
> As of the padding, is it an issue? Isn't it defined by the ABI, and
> therefore the userspace will have the same padding rules?

Hi Maxime

It gets interesting when you have a 64 bit kernel and a 32 bit userspace.

   Andrew
