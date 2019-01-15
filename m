Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C120AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5601520645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571138;
	bh=Bb+8WDEzBkRhBsTzSoBYAuA1Kaq9Oc8smB+qB0NmMYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VpbMTKMT74rY9Rn2KNDEsEc/y6aYD52nBg0T43u54d4NNC8XkWuDalYiCNwqOiHW4
	 Y4/h9ZU2w8JtYQx5QmXYQAQIHhlvVvS8gN7Qad5NNxafhO2HbogHmGLWCarO/IPKzF
	 bhzQW897C/jXU7aZn/6ivmmR7veSqSMC0UVWFbVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbfAOQom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728652AbfAOQoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D02D12054F;
        Tue, 15 Jan 2019 16:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570676;
        bh=Bb+8WDEzBkRhBsTzSoBYAuA1Kaq9Oc8smB+qB0NmMYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ajb3VhMjyRJD3SJXyLAjRSee15yAbWjR7z4F60Wo8OAbVP1FGJE/6TRQcvyLdgMY9
         jYWwMqBwkH5QWWpaw/Ec5pF6w4A6kHQcPbaF2DwJq6o7QI0rlm7gDEnHCQd3PmJTEy
         zuLIuhTSv+pb7iMBjtnGcRIda5wuqwXZnHRM3dI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
        Saranya Gopal <saranya.gopal@intel.com>
Subject: [PATCH 4.20 03/57] usbcore: Select only first configuration for non-UAC3 compliant devices
Date:   Tue, 15 Jan 2019 17:35:44 +0100
Message-Id: <20190115154910.910829923@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saranya Gopal <saranya.gopal@intel.com>

commit ff2a8c532c14fd22fb26a36574d9ff199afbbe54 upstream.

In most of the UAC1 and UAC2 audio devices, the first
configuration is most often the best configuration.
However, with recent patch to support UAC3 configuration,
second configuration was unintentionally chosen for
some of the UAC1/2 devices that had more than one
configuration. This was because of the existing check
after the audio config check which selected any config
which had a non-vendor class. This patch fixes this issue.

Fixes: f13912d3f014 ("usbcore: Select UAC3 configuration for audio if present")
Reported-by: Con Kolivas <kernel@kolivas.org>
Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>
Tested-by: Con Kolivas <kernel@kolivas.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/generic.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -143,9 +143,12 @@ int usb_choose_configuration(struct usb_
 			continue;
 		}
 
-		if (i > 0 && desc && is_audio(desc) && is_uac3_config(desc)) {
-			best = c;
-			break;
+		if (i > 0 && desc && is_audio(desc)) {
+			if (is_uac3_config(desc)) {
+				best = c;
+				break;
+			}
+			continue;
 		}
 
 		/* From the remaining configs, choose the first one whose


