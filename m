Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D59FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA2920855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA2920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeKZNXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 08:23:38 -0500
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:34630
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbeKZNXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 08:23:37 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id R6etgJAjIxtAIR6etgMtUQ; Sun, 25 Nov 2018 19:29:59 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gR6et-0002xJ-Av; Sun, 25 Nov 2018 19:29:59 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] Drivers: hv: vmbus: check the creation_status in vmbus_establish_gpadl()
Date:   Mon, 26 Nov 2018 02:29:56 +0000
Message-Id: <20181126022958.11320-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181126022821.11269-1-kys@linuxonhyperv.com>
References: <20181126022821.11269-1-kys@linuxonhyperv.com>
MIME-Version: 1.0
Reply-To: kys@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBZ1DY24yiQuWkTsaSplSw0cu1B4lwrsMf/pJGy8ot5Adi01iNSLM69WAPvYRQdv2DIuabFnQqwe+78PZZTnKzNTiH2DL9DDD4BeSC6I4huQGBdbZqjy
 +8sS4DOaZO+FcJ3AfhU6JO8fI3FW9DTOrxx4k6b2AQ+9KSaRswWvHS3v934cLtTdS+myZNOVyUictdn9K0LOKweL+5ALRvoXoSeGRLxM0hXOlJ/ifSIV8Q23
 7BqlLHcHKnLpm21bxo5XC1XaqW2ZnkIfjdck6ij5lQbI21r0tIJdfeEdGDgNE4qzN562+YXgYy7zKGyJcSb1Ld8LobjoVre3fof+IbC+qtd/9rrAKOTvzYAs
 yM8DjghXx1oiLvkvzM23xcNJuusT9mTLxaEgxi6A35Wc+Wl/CRzFEnlqjkWEW6gw3yLl4oA/ZLqYNGixJbAFZXXBJTtbViDR0F9LPEf7+oPRmMxii1Zhqa7D
 HZQ18DxDBQeLRrBo8Zc+wPJWyCvc27gbaZfaqGvoGblvkFEs8jV6mfyYXznlvlsHcUIOCUgsYfwUA0qxNXiP/kmlEAEce1E9EhK4EEuHcxOJyRFXPgBtS+fW
 RfHSnZ+bcBlbn006HzqU7uM2Vo+QxfSdzdem2VqKwwXTag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

This is a longstanding issue: if the vmbus upper-layer drivers try to
consume too many GPADLs, the host may return with an error
0xC0000044 (STATUS_QUOTA_EXCEEDED), but currently we forget to check
the creation_status, and hence we can pass an invalid GPADL handle
into the OPEN_CHANNEL message, and get an error code 0xc0000225 in
open_info->response.open_result.status, and finally we hang in
vmbus_open() -> "goto error_free_info" -> vmbus_teardown_gpadl().

With this patch, we can exit gracefully on STATUS_QUOTA_EXCEEDED.

Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/channel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index f96a77b18bb9..ce0ba2062723 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -516,6 +516,14 @@ int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 	}
 	wait_for_completion(&msginfo->waitevent);
 
+	if (msginfo->response.gpadl_created.creation_status != 0) {
+		pr_err("Failed to establish GPADL: err = 0x%x\n",
+		       msginfo->response.gpadl_created.creation_status);
+
+		ret = -EDQUOT;
+		goto cleanup;
+	}
+
 	if (channel->rescind) {
 		ret = -ENODEV;
 		goto cleanup;
-- 
2.19.1

