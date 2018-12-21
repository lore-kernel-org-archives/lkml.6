Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69906C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E948121928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="di3eqWtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390427AbeLUUKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:10:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41504 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeLUUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:10:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so3062576pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 12:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EQAIQUQsGcLI8rqNjfwTQN3sEVOL/4WZkv+xAEAj404=;
        b=di3eqWtmE28dmOERpS2sBG/HSbxaz/0CaTaVYP15xuUJP/6Es5dTB5Jxd8AzvW43Ov
         UQc5WHE+XLNRFgFt0hhmAbPLBUhsiUlBSiWS2WdAG5T8e3gBKCNoFlwOnjoQYwNrmvfx
         3mm7hp3djO57PV8/svRtL2qfznzMC2YfZOmTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EQAIQUQsGcLI8rqNjfwTQN3sEVOL/4WZkv+xAEAj404=;
        b=EJyFJXC8G55FFqRkHLi+Cxek+EZ+Jwju2E5hrY4a8xWkDiOu+dqgRat6T/qQd+ZSH5
         gaxobcLrBCKVGb/93gqOANYnpDcAGYucunM7BR7sr3luY2iLkZ4XG0XHSKiLyzcTCN0G
         xSeTcI1fyPyFYNIe90aSBsXXKEDpxq9RIaq0vr+3NzpUWkznwa7bKwHrfQ6y1Cy2VK2l
         il9SoBYtdNefAKHPvFeayo//54dam1KRfEWe/vlrwjdXaVzRRazDamL2TChBb3zLH/Vq
         H2/51mUhmsyurS3ODqZ+dFiyRIRDfoTCN/qKEMhaLn7cLVjBMaZHAHgmEp/aMuUXS8Ux
         LFsw==
X-Gm-Message-State: AJcUukdRBw3uxEeh+uRwl3kHBQhfqYQktmnkTJav3UMqea7L1jS9s4VA
        SL5rXaVq2RMYTd44Cg6EcNRrBw==
X-Google-Smtp-Source: ALg8bN4MaYkHKLb3gsXffS7gr8jUws92VRLpo2aDZxWHnj/3DbQkCjZ75FX7uGRWMiG6nViOZuPvYA==
X-Received: by 2002:a63:6cc:: with SMTP id 195mr3725360pgg.401.1545423010054;
        Fri, 21 Dec 2018 12:10:10 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id o1sm35300406pgn.63.2018.12.21.12.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Dec 2018 12:10:09 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Ben Chan <benchan@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] soc: qcom: rmtfs-mem: Support non-root rmtfs daemons
Date:   Fri, 21 Dec 2018 12:09:59 -0800
Message-Id: <20181221201001.160613-1-evgreen@chromium.org>
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

Changes in v2:
- Moved class registration/deregistration into init/exit routines (Brian)

Evan Green (2):
  soc: qcom: rmtfs-mem: Add class to enable uevents
  soc: qcom: rmtfs-mem: Make sysfs attributes world-readable

 drivers/soc/qcom/rmtfs_mem.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

-- 
2.18.1

