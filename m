Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2A4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80728214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fLwBQ6Fv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfAIHJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:09:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50348 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfAIHJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:09:50 -0500
Received: from localhost.localdomain (unknown [96.44.9.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 663B956D;
        Wed,  9 Jan 2019 08:09:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547017788;
        bh=BJynhH9mypxANJnO1LpiQa9iGnwtTCFnDSLF69vkr9o=;
        h=From:To:Cc:Subject:Date:From;
        b=fLwBQ6FvLUFzlR8bX/6+zbM3YQ4MR7tlB8xTlsx8hl5DvJk11XpreZTtqqT7oApos
         EZOQghg3QMgjTPqOkBARv+NlPv4uoXIYmRTjbDzHSnIowsOm+fzocuVS0xHLpz0Hvz
         7qlpD/fkFqaTYoRmUWrGniZpXz+DousFk8/Y/H5w=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        stern@rowland.harvard.edu, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] usb: gadget: add mechanism to asynchronously validate data stage of ctrl out request
Date:   Wed,  9 Jan 2019 02:08:50 -0500
Message-Id: <20190109070856.27460-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a mechanism to allow asynchronously validating
the data stage of a control OUT request, and for stalling or suceeding
the request accordingly. This mechanism is implemented for MUSB, and is
used by UVC. At the same time, UVC packages the setup stage and data
stage data together to send to userspace to save on a pair of context
switches per control out request.

This patch series does change the userspace API. We however believe that
it is justified because the current API is broken, and because it isn't
being used (because it's broken).

The current API is broken such that it is subject to race conditions
that cause fatal errors with a high frequency. This is actually what
motivated this patch series in the first place. In the current API, not
only is there no way to asynchronously validate the data stage of a
control OUT request, but an empty buffer is expected to be provided to
hold the data stage data -- which is more likely than not to be late.
There is even a warning in musb_g_ep0_queue:

/* else for sequence #2 (OUT), caller provides a buffer
 * before the next packet arrives.  deferred responses
 * (after SETUP is acked) are racey.
 */

This problem has never been reported in years, which is a sign that the
API isn't used. Furthermore, the vendor kernels that we have seen using
the UVC gadget driver (such as QC and Huawei) are heavily patched with
local changes to the API. This corroborates the suspicion that the
current mainline API is not being used.

Additionally, this API isn't meant to be used by generic applications,
but by a dedicated userspace helper. uvc-gadget is one such example, but
it has bitrotten and isn't compatible with the current kernel API. The
fact that nobody has submitted patches nor complained for a long time
again shows that it isn't being used.

The conclusion is that since the API hasn't been used for a long time,
it is safe to fix it.

Changes in v5:

- Change parameter of usb_gadget_control_complete to simply take a
  usb_request
- Make usb_gadget_control_complete do nothing if the request has no
  length (ie. no data stage)
- musb: call usb_gadget_control_complete before
  usb_gadget_giveback_request
- set musb ep0 state to statusin in ep0_send_ack
- make sure to not double-write musb register in ep0_rxstate, since
  musb_g_ep0_giveback will take care of writing them

Changes in v4:

- Change wording and fix typo in patch 4/6 "usb: gadget: add mechanism
  to specify an explicit status stage"
- Set explicit_status in usb_gadget_control_complete
- Change explicit_status from unsigned int to bool

Changes in v3:

- Function driver send STALL status stage by simply calling
  usb_ep_set_halt, and ACK by enqueueing request
- Fix signature of usb_gadget_control_complete to check the status of the
  request that was just given back.
- Corresponding changes to musb and uvc gadget

Changes in v2:

Overhaul of status stage delay mechanism/API. Now if a function driver
desires an explicit/delayed status stage, it specifies so in a flag in
the usb_request that is queued for the data stage. The function driver
later enqueues another usb_request for the status stage, also with the
explicit_status flag set, and with the zero flag acting as the status.
If a function driver does not desire an explicit status stage, then it
can set (or ignore) the explicit_status flag in the usb_request that
is queued for the data stage.

To allow the optional explicit status stage, a UDC driver should call
the newly added usb_gadget_control_complete right after
usb_gadget_giveback_request, and in its queue function should check if
the usb_request is for the status stage and if it has been requested to
be explicit, and if so check the status that should be sent. (See 5/6
"usb: musb: gadget: implement optional explicit status stage" for an
implementation for MUSB)

Paul Elder (6):
  usb: uvc: include videodev2.h in g_uvc.h
  usb: gadget: uvc: enqueue usb request in setup handler for control OUT
  usb: gadget: uvc: package setup and data for control OUT requests
  usb: gadget: add mechanism to specify an explicit status stage
  usb: musb: gadget: implement optional explicit status stage
  usb: gadget: uvc: allow ioctl to send response in status stage

 drivers/usb/gadget/function/f_uvc.c    | 32 ++++++++++++++++++------
 drivers/usb/gadget/function/uvc.h      |  1 +
 drivers/usb/gadget/function/uvc_v4l2.c | 18 ++++++++++++++
 drivers/usb/gadget/udc/core.c          | 34 ++++++++++++++++++++++++++
 drivers/usb/musb/musb_gadget.c         |  2 ++
 drivers/usb/musb/musb_gadget_ep0.c     | 29 ++++++++++++++++++++--
 include/linux/usb/gadget.h             | 10 ++++++++
 include/uapi/linux/usb/g_uvc.h         |  4 ++-
 8 files changed, 119 insertions(+), 11 deletions(-)

-- 
2.20.1

