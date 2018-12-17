Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A804CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7687A20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iqtCUAhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbeLQGCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:02:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53866 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeLQGCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:02:50 -0500
Received: from localhost.localdomain (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4A54A59;
        Mon, 17 Dec 2018 07:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545026568;
        bh=0OOX/rzescZnJqqMIxSzABXvBip+rdAQFRVSoOgbO/c=;
        h=From:To:Cc:Subject:Date:From;
        b=iqtCUAhmXB5oMqfieJEgp5e1WSqLTZhIOzUpEL4YL1sE5PKNThweTLxL65bXpBizb
         CAjbIgyyVAW1LEKkSUiKlvzbk34JyFQGc2YTWxIgMFiL7O9Srs8DeMlkHQAdVqZrwO
         Zl5QbKBivQAmCQT5jChXpKJCkrumLy9evLanPqTo=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        stern@rowland.harvard.edu, rogerq@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] usb: gadget: add mechanism to asynchronously validate data stage of ctrl out request
Date:   Mon, 17 Dec 2018 01:02:10 -0500
Message-Id: <20181217060216.26368-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
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

 drivers/usb/gadget/function/f_uvc.c    | 32 ++++++++++++++++++-------
 drivers/usb/gadget/function/uvc.h      |  1 +
 drivers/usb/gadget/function/uvc_v4l2.c | 20 ++++++++++++++++
 drivers/usb/gadget/udc/core.c          | 33 ++++++++++++++++++++++++++
 drivers/usb/musb/musb_gadget.c         |  1 +
 drivers/usb/musb/musb_gadget_ep0.c     | 28 ++++++++++++++++++++++
 include/linux/usb/gadget.h             | 10 ++++++++
 include/uapi/linux/usb/g_uvc.h         |  4 +++-
 8 files changed, 120 insertions(+), 9 deletions(-)

-- 
2.19.2

