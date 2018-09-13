Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B6CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0018420869
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0018420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeIMUO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:14:28 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:47992 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726824AbeIMUO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:14:27 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 8D379634C84;
        Thu, 13 Sep 2018 18:04:31 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1g0TAV-0000P3-CK; Thu, 13 Sep 2018 18:04:31 +0300
Date:   Thu, 13 Sep 2018 18:04:31 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Todor Tomov <ttomov@mm-sol.com>
Cc:     hans.verkuil@cisco.com, linux-media@vger.kernel.org,
        Todor Tomov <todor.tomov@linaro.org>, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 16/23] camss: vfe: Support for frame padding
Message-ID: <20180913150431.e5auwpqkostav5qz@valkosipuli.retiisi.org.uk>
References: <1500287629-23703-1-git-send-email-todor.tomov@linaro.org>
 <1500287629-23703-17-git-send-email-todor.tomov@linaro.org>
 <20170720151732.h4wmqr56j4tuhk7r@valkosipuli.retiisi.org.uk>
 <90fecd27-3255-fbec-a73f-598cc66a3b31@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90fecd27-3255-fbec-a73f-598cc66a3b31@mm-sol.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Todor,

Apologies for the late reply.

On Mon, Sep 03, 2018 at 06:38:20PM +0300, Todor Tomov wrote:
> Hi Sakari and all,
> 
> I'm sorry to up this thread from an year ago but I'm currently thinking
> about a problem which is related to this so I decided to ask here.
> 
> On 20.07.2017 18:17, Sakari Ailus wrote:
> > Hi Todor,
> > 
> > On Mon, Jul 17, 2017 at 01:33:42PM +0300, Todor Tomov wrote:
> >> Add support for horizontal and vertical frame padding.
> >>
> >> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> >> ---
> >>  drivers/media/platform/qcom/camss-8x16/camss-vfe.c | 86 +++++++++++++++++-----
> >>  .../media/platform/qcom/camss-8x16/camss-video.c   | 69 ++++++++++++-----
> >>  .../media/platform/qcom/camss-8x16/camss-video.h   |  2 +
> >>  3 files changed, 121 insertions(+), 36 deletions(-)
> >>
> 
> ...
> 
> >> diff --git a/drivers/media/platform/qcom/camss-8x16/camss-video.c b/drivers/media/platform/qcom/camss-8x16/camss-video.c
> >> index c5ebf5c..5a2bf18 100644
> >> --- a/drivers/media/platform/qcom/camss-8x16/camss-video.c
> >> +++ b/drivers/media/platform/qcom/camss-8x16/camss-video.c
> 
> ...
> 
> >> @@ -542,28 +537,68 @@ static int video_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
> >>  	return 0;
> >>  }
> >>  
> >> -static int video_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
> >> +static int video_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
> >>  {
> >>  	struct camss_video *video = video_drvdata(file);
> >> +	struct v4l2_plane_pix_format *p;
> >> +	u32 bytesperline[3] = { 0 };
> >> +	u32 sizeimage[3] = { 0 };
> >> +	u32 lines;
> >>  	int ret;
> >> +	int i;
> >>  
> >> -	if (vb2_is_busy(&video->vb2_q))
> >> -		return -EBUSY;
> >> +	if (video->line_based)
> >> +		for (i = 0; i < f->fmt.pix_mp.num_planes && i < 3; i++) {
> >> +			p = &f->fmt.pix_mp.plane_fmt[i];
> >> +			bytesperline[i] = clamp_t(u32, p->bytesperline,
> >> +						  1, 65528);
> >> +			sizeimage[i] = clamp_t(u32, p->sizeimage,
> >> +					       bytesperline[i],
> >> +					       bytesperline[i] * 4096);
> >> +		}
> >>  
> >>  	ret = video_get_subdev_format(video, f);
> >>  	if (ret < 0)
> >>  		return ret;
> > 
> > If you take the width and height from the sub-device format, then for the
> > user to figure out how big a buffer is needed for a particular format it
> > takes to change the sub-device format.
> > 
> > I wouldn't do this but keep the image dimensions on the video node
> > independent of what's configured on the sub-device.
> 
> So the question is whether the video device node should:
> a) keep its format and framesize always in sync with what is set on the
>    subdev node with active link to it. This means all s_fmt and enum_fmt
>    will return only the value which is in sink with the subdev node;
> b) allow to set all possible allowed formats and framesizes. This however
>    allows the userspace to try to start the streaming with format and
>    framesizes not in sync (on video and subdev node) in which case the
>    start streaming will fail.
> 
> Currently the driver is implemented as in b) and I hit this problem (in b))
> when I try to use it from opencv. I wonder how this can be overcome, the
> userspace cannot be blamed that it tried to start streaming for format
> and framesize which were allowed to be set.
> 
> Are there any new insights on this lately - what can be done to avoid
> the problems in a) and b)?

I'd like to refer to Linux camera user space that hasn't yet materialised,
yet there are plans to implemnt that. One of the aims are to support
regular V4L2 applications on complex devices.

<URL:https://linuxtv.org/news.php?entry=2018-07-13.mchehab>

There's unfortunately nothing more concrete than that I could refer to at
the moment.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
