Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0BBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46D8214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="g6kPoS9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46D8214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJJKJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:09:19 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44258 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeJJKJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:09:18 -0400
Received: from garnet.amanokami.net (unknown [96.44.9.229])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CAD186F;
        Wed, 10 Oct 2018 04:49:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539139759;
        bh=5WyFblDlCAZpgejOqgQXHeE7ELGis7zDPJABUZTUXtk=;
        h=From:To:Cc:Subject:Date:From;
        b=g6kPoS9FAKD04vS7ZbHwKmpBl1uVZsMJaEuij37ZgA4VgIgBrdxYi0UdWJmhbHfpb
         wLti0g61/TU7J7WDtOOmTQtVpfQem7xQYD/NqIZo4pCz7rMBPnSxjVPkWpq3hRAnuj
         Rkj8ISLHI8C/6EW19SMSXLYMVykaZpkLHc2v9+uw=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
Cc:     Paul Elder <paul.elder@ideasonboard.com>, b-liu@ti.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        stern@rowland.harvard.edu, rogerq@ti.com
Subject: [PATCH 0/6] usb: gadget: add mechanism to asynchronously validate data stage of ctrl out request
Date:   Tue,  9 Oct 2018 22:48:57 -0400
Message-Id: <20181010024903.1633-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a mechanism to allow asynchronously validating
the data stage of a control out request, and for stalling or suceeding
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

Paul Elder (6):
  usb: uvc: include videodev2.h in g_uvc.h
  usb: gadget: uvc: enqueue usb request in setup handler for control OUT
  usb: gadget: uvc: package setup and data for control OUT requests
  usb: gadget: add functions to signal udc driver to delay status stage
  usb: musb: gadget: implement send_response
  usb: gadget: uvc: allow ioctl to send response in status stage

 drivers/usb/gadget/function/f_uvc.c    | 33 ++++++++++++++++-----
 drivers/usb/gadget/function/uvc.h      |  1 +
 drivers/usb/gadget/function/uvc_v4l2.c | 21 +++++++++++++
 drivers/usb/gadget/udc/core.c          | 40 +++++++++++++++++++++++++
 drivers/usb/musb/musb_gadget_ep0.c     | 41 ++++++++++++++++++++++++++
 include/linux/usb/gadget.h             | 11 +++++++
 include/uapi/linux/usb/g_uvc.h         |  4 ++-
 7 files changed, 142 insertions(+), 9 deletions(-)

-- 
2.18.0

