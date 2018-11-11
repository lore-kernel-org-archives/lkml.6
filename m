Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0B9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75BA20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSeRtW6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75BA20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388788AbeKLJVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:44684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388585AbeKLIUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:19 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C43322353;
        Sun, 11 Nov 2018 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975423;
        bh=LvW/ZQC0QU58LSSLNhsqKcZNV/bIJbOSL71yR3qXHP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSeRtW6PMhOVCyuEqSIw6LUkoqL3koSsB7+fn2lzGMom6vsTOOkBqGgY1w0hNAAof
         OALZVxNaYH5WxMggvWC0IIuhgVSOH8BaqmJ5/ql7RE5LMFH6NORS3i6AJumAi5HfO9
         uoRP8DoX068bGyt5yc+KcRw5ZDYBSXwdSmZHh/hY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 152/350] usb: typec: tcpm: Report back negotiated PPS voltage and current
Date:   Sun, 11 Nov 2018 14:20:16 -0800
Message-Id: <20181111221714.416683336@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

[ Upstream commit 554fab6dbf20ee7298ed2d4e8398b85e6058abb7 ]

Currently when requesting a specific voltage or current through
the psy interface, for PPS, when reading back from that interface
the values will always be the same as previously given, if the
request was successful. However PPS only allows for 20mV voltage
steps and 50mA current steps, and the psy class expects microvolt
and micro amp requests, so inbetween values can be provided through
this interface. Really when reading back the true values negotiated
should be given, and not the ones originally asked for.

To report the actual values negotiated with the Source, the values
stored are now rounded down to the relevant step units prior to
building the PPS request, so that those values are later correctly
reported through the psy interface. In addition this improves the
adjustments made to meet the operating power requirements of the
platform, which previously could have been slightly out due to not
using valid PPS units of voltage and current.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -4018,6 +4018,9 @@ static int tcpm_pps_set_op_curr(struct t
 		goto port_unlock;
 	}
 
+	/* Round down operating current to align with PPS valid steps */
+	op_curr = op_curr - (op_curr % RDO_PROG_CURR_MA_STEP);
+
 	reinit_completion(&port->pps_complete);
 	port->pps_data.op_curr = op_curr;
 	port->pps_status = 0;
@@ -4071,6 +4074,9 @@ static int tcpm_pps_set_out_volt(struct
 		goto port_unlock;
 	}
 
+	/* Round down output voltage to align with PPS valid steps */
+	out_volt = out_volt - (out_volt % RDO_PROG_VOLT_MV_STEP);
+
 	reinit_completion(&port->pps_complete);
 	port->pps_data.out_volt = out_volt;
 	port->pps_status = 0;


