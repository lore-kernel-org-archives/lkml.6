Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0A9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DA820821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ciSpj/5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfAIHLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:11:00 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50448 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfAIHLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:11:00 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C7B7256D;
        Wed,  9 Jan 2019 08:10:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547017858;
        bh=Y6P+KmtmRz/cEyCru4/X4VKj7dXj9sPjC8dYl9DqxA8=;
        h=From:To:Cc:Subject:Date:From;
        b=ciSpj/5FV+YfkN1a8T83nsiOutXaCaPrH9072GihxtzeXUZkKCddgfXw/aUrh4EiW
         KfbHCH41zk0O06I318dpZ0ZruGoZT2C6t5c1ev0gAWDbOkUv4LMWUKAPTtTnR3xMZc
         /DqxlrvyKq6H6EaZ3hbCaSDdQK1hS3fcCiAOkHKg=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, rogerq@ti.com,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] usb: gadget: uvc: fix racing between uvc_function_set_alt and streamon/off
Date:   Wed,  9 Jan 2019 02:10:35 -0500
Message-Id: <20190109071039.27702-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Down the call stack from the ioctl handler for VIDIOC_STREAMON,
uvc_video_alloc_requests contains a BUG_ON, which in the high level,
triggers when VIDIOC_STREAMON ioctl is issued without VIDIOC_STREAMOFF
being issued previously.

This can happen in a few ways, such as if the userspace uvc gadget
application simply doesn't issue VIDIOC_STREAMOFF. Another way is if
uvc_function_set_alt with alt 0 is called after it is called with 1 but
before VIDIOC_STREAMON is called; in this case, UVC_EVENT_STREAMOFF will
not be queued to userspace, and therefore userspace will never call
VIDIOC_STREAMOFF.

To fix this, add two more uvc states: starting and stopping. The
starting state is entered when uvc_function_set_alt 1 is called, and is
exited in uvc_v4l2_streamon, when the state is changed to streaming. The
stopping state is entered when uvc_function_set_alt 0 is called, and is
exited in uvc_v4l2_streamoff, when the state is changed to connected.

The status phase of the SET_INTERFACE request doesn't need to be delayed
by the uvc gadget driver, so that is removed.

Finally, there is another way to trigger the aforementioned BUG: start
streaming and (physically) disconnect usb. To fix this, call
uvcg_video_enable 0 in uvc_function_disable.


Changes in v3:

- add state guard to uvc_function_set_alt 1
- add documentation for newly added uvc states
- reorder uvc states to more or less follow the flow diagram
- add more state guards to ioctl handlers for streamon and streamoff
- added interrupt-safe uvcg_video_cancel and used instead of the
  non-interrupt-save uvcg_video_enable 0 in uvc_function_disable

Changes in v2:
	1. Remove delay usb status phase

Paul Elder (4):
  usb: gadget: uvc: synchronize streamon/off with uvc_function_set_alt
  usb: gadget: uvc: don't delay the status phase of non-zero
    SET_INTERFACE requests
  usb: gadget: uvc: disable stream when disconnected
  usb: gadget: uvc: remove unused/duplicate function prototypes from
    uvc.h

 drivers/usb/gadget/function/f_uvc.c     | 23 ++++++++----
 drivers/usb/gadget/function/uvc.h       | 47 +++++++++++++++++++------
 drivers/usb/gadget/function/uvc_v4l2.c  | 28 +++++++++++----
 drivers/usb/gadget/function/uvc_video.c | 13 +++++++
 drivers/usb/gadget/function/uvc_video.h |  2 ++
 5 files changed, 91 insertions(+), 22 deletions(-)

-- 
2.20.1

