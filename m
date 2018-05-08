Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755301AbeEHRSE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:18:04 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34618 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeEHRSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:18:02 -0400
X-Google-Smtp-Source: AB8JxZoxV7soEmQ2ZGkO1qWbvT6cBEo3Ld4EMCHqc0ENv3EoGabEQu73XsSPDa/jv1ibtt1w2zmWYw==
Date: Tue, 8 May 2018 10:17:59 -0700
From: Sami Tolvanen <samitolvanen@google.com>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Kees Cook <keescook@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: v4l2-ioctl: fix function types for
 IOCTL_INFO_STD
Message-ID: <20180508171759.GA184279@samitolvanen.mtv.corp.google.com>
References: <44310a2b-2797-223c-fab4-0214490e5201@xs4all.nl>
 <20180507205135.88398-1-samitolvanen@google.com>
 <a627c61e-f227-297c-087e-c2a701b46a64@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a627c61e-f227-297c-087e-c2a701b46a64@xs4all.nl>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 10:18:24AM +0200, Hans Verkuil wrote:
> Just call this v4l_stub_g_fbuf, conform the naming of the other functions.
> 
> So just replace vidioc_ by v4l_stub_ in all these DEFINE_IOCTL_FNC macros.
> 
> This way the function name in the big array matches the name in this macro,
> and the 'stub' part indicates that it is just a stub function.

vidioc_ is actually part of the function name in struct v4l2_ioctl_ops,
which the stub needs to call. I can change the stub name to start with
v4l_stub_, but if you prefer to drop vidioc_ entirely from the name,
the macro still wouldn't end up matching the array. It would have to be
something like this:

  #define DEFINE_IOCTL_FNC(_vidioc) \
	static int v4l_stub_ ## _vidioc( \
	...
		return ops->vidioc_ ## _vidioc(file, fh, p); \
  ...
  DEFINE_IOCTL_FNC(g_fbuf)
  ...
  static struct v4l2_ioctl_info v4l2_ioctls[] = {
	...
	IOCTL_INFO(VIDIOC_G_FBUF, v4l_stub_g_fbuf, ...),

Any thoughts?

	Sami
