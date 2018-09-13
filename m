Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1E4C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E597820652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E597820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbeIMTNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:13:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35330 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbeIMTNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:13:24 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3536CD32;
        Thu, 13 Sep 2018 14:03:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikita Lipski <mikita.lipski@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.18 166/197] drm/amd/display: update clk for various HDMI color depths
Date:   Thu, 13 Sep 2018 15:31:55 +0200
Message-Id: <20180913131848.199588449@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikita Lipski <mikita.lipski@amd.com>

commit 81aca8e75c1b046865fb2badef95a0dcff6f73de upstream.

[why]
When programming tonga's connector's backend we didn't take
in account that HDMI's colour depth might be more than 8bpc
therefore we need to add a switch statement that would adjust
the pixel clock accordingly.

[how]
Add a switch statement updating clock by its appropriate
coefficient.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/bios/command_table.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -808,6 +808,24 @@ static enum bp_result transmitter_contro
 	 * (=1: 8bpp, =1.25: 10bpp, =1.5:12bpp, =2: 16bpp)
 	 * LVDS mode: usPixelClock = pixel clock
 	 */
+	if  (cntl->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+		switch (cntl->color_depth) {
+		case COLOR_DEPTH_101010:
+			params.usSymClock =
+				cpu_to_le16((le16_to_cpu(params.usSymClock) * 30) / 24);
+			break;
+		case COLOR_DEPTH_121212:
+			params.usSymClock =
+				cpu_to_le16((le16_to_cpu(params.usSymClock) * 36) / 24);
+			break;
+		case COLOR_DEPTH_161616:
+			params.usSymClock =
+				cpu_to_le16((le16_to_cpu(params.usSymClock) * 48) / 24);
+			break;
+		default:
+			break;
+		}
+	}
 
 	if (EXEC_BIOS_CMD_TABLE(UNIPHYTransmitterControl, params))
 		result = BP_RESULT_OK;


