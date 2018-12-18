Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A124BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71019214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QH4vgcsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeLRAI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:08:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42605 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeLRAI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:08:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so7168253pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G8WsvbXl+iLBLo+fDvmVSgQWNa3uWGPsiAkN1qPpBqE=;
        b=QH4vgcshZusAdSCW0F5FiOpo9B+4Yt5vdugPRb4BaCNecdKK8TLR1aatsZrJLbxGSV
         nhLHCsobHgZm/6oiagEYfWTEjTitZQ57FcglzGsIKs7eVfUSNXc5IV9IPo6hv7uFXEGa
         o0C0xPDF2Eo9SwWDdw4EK4VvHqGgXb2mHpexk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G8WsvbXl+iLBLo+fDvmVSgQWNa3uWGPsiAkN1qPpBqE=;
        b=k77CQTVsGkdqo9WoCwcXPOTlLx1qEkoA4vh7jJQyrOpszf7/EyCd7pCIVEhhSbOzUK
         bqXLgRJCiNZIMfSPNey515w+nVIIJf4UA+EPw39V3rdPS32Dqea3I0OfRMPXwMPdYtpS
         NuQYvvmQNhtx+YH92DsrxKiWqh505QlURuH2zU+7FEKvf2lCh3BjvdfTqaImw1BUqUJx
         P+8k9jR/x4k8kvchX7UUN7N4em70XXx5R2Lf2+WXQ9HmMZRz9Of7x+Wh7dIQy7TBRE+z
         Z3u1KPBjBYYD4RHcXI7Uy1XeTKBjazm9ukSkQkXRmkMEYKKJMgvohB20r30sFmdoHtQs
         0yxQ==
X-Gm-Message-State: AA+aEWafell59yWoG15zE8m/4wChiXKTkstFpGqWXduo1vh7882hqE8D
        +3EzBqC3ZNNAfxDvz3Z+WeqBTw==
X-Google-Smtp-Source: AFSGD/Vtp8QvZxyBxOKBPmf2IJVrVJpeHR6lM19Ck+5Seuw+JHouK2hO0rY4tnB7REsYvrQxhzU1Cw==
X-Received: by 2002:a63:3204:: with SMTP id y4mr13834880pgy.41.1545091738176;
        Mon, 17 Dec 2018 16:08:58 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id m65sm21734424pfg.180.2018.12.17.16.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 16:08:57 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Ben Chan <benchan@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] soc: qcom: rmtfs-mem: Support non-root rmtfs daemons
Date:   Mon, 17 Dec 2018 16:08:32 -0800
Message-Id: <20181218000834.201748-1-evgreen@chromium.org>
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


Evan Green (2):
  soc: qcom: rmtfs-mem: Add class to enable uevents
  soc: qcom: rmtfs-mem: Make sysfs attributes world-readable

 drivers/soc/qcom/rmtfs_mem.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

-- 
2.18.1

