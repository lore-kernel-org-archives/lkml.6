Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeC0VGt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:06:49 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:47040 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeC0VGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:06:47 -0400
X-Google-Smtp-Source: AIpwx49QmGYNrf2BMrTRTPhVGGuQNSul6pI37toQo8aPhQFnjL7KDLjb6XGbRBqUedHADX/U+br1yw==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/3] rpmsg: smd: Redeliver messages after probe
Date: Tue, 27 Mar 2018 14:06:40 -0700
Message-Id: <20180327210643.3436-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A race condition exists in SMD where incoming messages might be processed
before we've finished executing the rpmsg device's probe function. The driver's
callback function will in this case be unable to handle the incoming message
and might return an error.

Using the announce_create ops we can invoke the handler for incoming messages
once again after probe returns, solving this issue.

With SMD and QRTR this shows a high failure rate, but there are (at least
theoretical) similar issues in glink and virtio-rpmsg, so this needs to be
further investigated.

Bjorn Andersson (3):
  rpmsg: smd: Fix container_of macros
  rpmsg: Only invoke announce_create for rpdev with endpoints
  rpmsg: smd: Use announce_create to process any receive work

 drivers/rpmsg/qcom_smd.c   | 22 ++++++++++++++++++++--
 drivers/rpmsg/rpmsg_core.c |  2 +-
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.16.2
