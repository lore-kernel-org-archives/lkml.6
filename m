Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C4DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC87221104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC87221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbeK0Sx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:53:28 -0500
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:55477 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728838AbeK0Sx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:53:28 -0500
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id RYEGgqmRxbGVyRYEJgbYKH; Tue, 27 Nov 2018 08:56:24 +0100
Subject: Re: [PATCH v2 0/2] media: Startech usb2hdcapm hdmi2usb framegrabber
 support
To:     Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, stoth@kernellabs.com,
        laurent.pinchart@ideasonboard.com, kernel@pengutronix.de,
        mchehab@kernel.org, davem@davemloft.net
References: <20181126180937.32535-1-m.grzeschik@pengutronix.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <00f284b0-0462-9748-32c8-bce475f2c314@xs4all.nl>
Date:   Tue, 27 Nov 2018 08:56:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181126180937.32535-1-m.grzeschik@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNIx3lJ305qUZMNbFOhAEOmEO4Xtpodf7Lpljz5EuF4u6vi5/MFXlt2Ft/0Mcu4NatDf4xE73OBskjgTDmqwTFw4hds+ec6X+OXPkF0oULwOq/W3hGYt
 AW/GHduANkrjl10NsgFPcfevTZw5i3AuknypM0ex+9A0RlCGPqsEw1Nj2075JOTH9d4ks7rhpI1DSf5Bkwd6Wh1tw2jhsYfYY85CCiWKcndEr+U1BP6YoESj
 5kq4PNxPfFW2fxr14A/A8rcKJYkSTqNwv2tSp+p3IT3HLDFS5lOlgieTAJIp1bKBKAwD8R05tr9MbrHg5/xGTHyTxiCyHN1+lHN7XcSSYF7zVDfJVw2SXSYb
 2qJ5g1BKKvtDmMOXwjT1QRdFQ0wDkVbM7MPKHGk2fQoJ8/VMOxb6Fh3UPJjOE0K2PE+hxkpawX4p2byJI6IJLC4s1GKG3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Apologies for completely missing your v1 post for this driver. It was
posted just before the ELCE and it looks like it just fell through the
cracks.

Anyway, I did a quick scan and found a few high-level things that need
to be addressed before I will start reviewing:

1) Please add the output of 'v4l2-compliance -s' to this cover letter
   (test with a valid source connected). Obviously any failures should
   be addressed, and if possible also all warnings.

2) Add entries for the new drivers to the MAINTAINERS file.

3) Since you added SPDX lines you can drop the actual license texts. It's
   one or the other, not both.

4) I see references to a firmware, but it appears to be a firmware that's
   loaded from an on-board eeprom or something, not an external firmware
   file. Correct? If I'm wrong and it is an external fw file, then where
   does it come from?

5) s_dv_timings is missing. That can't be right. Drivers shall *never*
   change timings automatically when they detect new timings. Instead
   they should send the SOURCE_CHANGE event to userspace, userspace will
   stop streaming, call QUERY_DV_TIMINGS and, if a valid signal was detected,
   call S_DV_TIMINGS with the new timings and restart streaming.

Regards,

	Hans

On 11/26/2018 07:09 PM, Michael Grzeschik wrote:
> This series adds support for the Startech usb2hdcapm framegrabber. The
> code is based on the external kernel module code from Steven Toth's
> github page:
> 
> https://github.com/stoth68000/hdcapm/
> 
> We applied checkpatch.pl --strict and cleaned up the 80 character
> length, whitespace issues and replaced simple printks with appropriate
> v4l2_* or dev_* helpers, used WARN_ON instead of BUG and changed all
> errors and warnings checkpatch was complaining about.
> 
> Steven Toth (2):
>   media: mst3367: add support for mstar mst3367 HDMI RX
>   media: hdcapm: add support for usb2hdcapm hdmi2usb framegrabber from
>     startech
> 
>  drivers/media/i2c/Kconfig                    |   10 +
>  drivers/media/i2c/Makefile                   |    1 +
>  drivers/media/i2c/mst3367.c                  | 1104 ++++++++++++++++++
>  drivers/media/usb/Kconfig                    |    1 +
>  drivers/media/usb/Makefile                   |    1 +
>  drivers/media/usb/hdcapm/Kconfig             |   11 +
>  drivers/media/usb/hdcapm/Makefile            |    3 +
>  drivers/media/usb/hdcapm/hdcapm-buffer.c     |  230 ++++
>  drivers/media/usb/hdcapm/hdcapm-compressor.c |  782 +++++++++++++
>  drivers/media/usb/hdcapm/hdcapm-core.c       |  743 ++++++++++++
>  drivers/media/usb/hdcapm/hdcapm-i2c.c        |  332 ++++++
>  drivers/media/usb/hdcapm/hdcapm-reg.h        |  111 ++
>  drivers/media/usb/hdcapm/hdcapm-video.c      |  665 +++++++++++
>  drivers/media/usb/hdcapm/hdcapm.h            |  283 +++++
>  include/media/i2c/mst3367.h                  |   29 +
>  15 files changed, 4306 insertions(+)
>  create mode 100644 drivers/media/i2c/mst3367.c
>  create mode 100644 drivers/media/usb/hdcapm/Kconfig
>  create mode 100644 drivers/media/usb/hdcapm/Makefile
>  create mode 100644 drivers/media/usb/hdcapm/hdcapm-buffer.c
>  create mode 100644 drivers/media/usb/hdcapm/hdcapm-compressor.c
>  create mode 100644 drivers/media/usb/hdcapm/hdcapm-core.c
>  create mode 100644 drivers/media/usb/hdcapm/hdcapm-i2c.c
>  create mode 100644 drivers/media/usb/hdcapm/hdcapm-reg.h
>  create mode 100644 drivers/media/usb/hdcapm/hdcapm-video.c
>  create mode 100644 drivers/media/usb/hdcapm/hdcapm.h
>  create mode 100644 include/media/i2c/mst3367.h
> 

