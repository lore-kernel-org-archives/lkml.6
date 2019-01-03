Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD40C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2766120856
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IOCjtxOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfACAC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 19:02:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34655 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfACAC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 19:02:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so15232275pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 16:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XegKRqQNwELnHOVCfSkZODWxzEPM42Lqqg4XgBJw9IM=;
        b=IOCjtxOpeyUXTnR49867Q0wNXdVYqfK/qnMpT9rsXIx+oKbQe67XlpdHG8QYwL1l5T
         MKyJuyE9hEtZhbjbp8gb3NRir70pHA1JtEVCLn0yB8hm+w0tkfWAJvL9o7j7s0m95cg3
         wdCa+r/tDzSbZXJ01/f0JaGnOGlbI06xxYwUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XegKRqQNwELnHOVCfSkZODWxzEPM42Lqqg4XgBJw9IM=;
        b=LRESRYMktBKZPdShb5vBITZwN1YtkhapZNLId2pWSco3RK6MdG2jovD0LWOIv634HH
         Xft4YXSdCK06HfcotKh2i0HO1Vmhgl4z6gBbZnp2k3K468rurNumCdE2tgxgvKtlaOoU
         4lYkFnJoKgHn7WULF62w9BRdCV91IDIteOvy3bTPGH82SAGlF1rTTJxaQmZo8pmFijOn
         No8aEQSC+eIk3Uln55xu799ejSlNd4L4qcbKH3xhyBs27RvgYBwHTyMB57DIOm45SevT
         Eytn9PWj70crBo8CfLyUnihjs+kiLeOLrlUhGdyQpAukJCJayC5X+iRqxu0lIdT701MT
         Lzcg==
X-Gm-Message-State: AJcUukfh5DRSxJA6zG2i+bPmuznBYrJ3PyJd32zwpAnPEoZBwrekUWDR
        NBwi3WJMUNZ9gN5tOr5RtThMeg==
X-Google-Smtp-Source: ALg8bN7Qy7Int0Wh0u5MAq9VM1IwQjO52o+Xo7I3h0ywe9OYVZskiOfvR8zWKxCHfVYPA+qbdHLV/Q==
X-Received: by 2002:a63:4665:: with SMTP id v37mr15454615pgk.425.1546473746517;
        Wed, 02 Jan 2019 16:02:26 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id u6sm60291199pgr.79.2019.01.02.16.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 16:02:25 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Ben Chan <benchan@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] soc: qcom: rmtfs-mem: Support non-root rmtfs daemons
Date:   Wed,  2 Jan 2019 16:02:11 -0800
Message-Id: <20190103000213.230652-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains minor fixes needed to better support running an
rmtfs daemon from an unprivileged process:
 - Enable uevents on the child character device by adding a struct
class to the parent. I needed these so that I could change the
ownership of /dev/qcom_rmtfs_mem1, and drove myself crazy trying to
understand why my udev rules never fired.
 - Enable access to phys_addr and size sysfs attributes. The daemon
needs to read these, and they don't really contain anything sensitive,
so expose them.

I still need CAP_NET_ADMIN to be able to bind to the right qrtr port,
but at least with these changes I can run as a different user, and drop
all other privileges.

Changes in v3:
- Removed spurious whitespace changes (Brian, Bjorn)

Changes in v2:
- Moved class registration/deregistration into init/exit routines (Brian)

Evan Green (2):
  soc: qcom: rmtfs-mem: Add class to enable uevents
  soc: qcom: rmtfs-mem: Make sysfs attributes world-readable

 drivers/soc/qcom/rmtfs_mem.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

-- 
2.18.1

