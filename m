Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CEBC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7960D2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSpGVm6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfBDQZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:25:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36236 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbfBDQZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:25:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so503351wrv.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gj4CO8cKmeYrRRbK9pmA1l2CtkIGPY5k/yuxkvfaR0I=;
        b=iSpGVm6bk6aqVVi6UgCSx6Ltk72BPZUwH9m/dakwPfH66odYZZnNC6MuA7N3jYacPj
         hgi+vjkJTXK0Lyhy+xFs9YpnJg8zyIp/WFMTP8YfHMiZwDwEJcMSXD/ktxxYRtqSXYB4
         3+floKLMmdYOzoFyGWxLCzafuY4mOBR7mIxXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gj4CO8cKmeYrRRbK9pmA1l2CtkIGPY5k/yuxkvfaR0I=;
        b=TWtpkJlOsI/Ai2No8H4Lqf1MvQ+8hf1l7gf3/X1FMylmu60Sn1NT9xnAUm/AUmn/JA
         JtdCvwMn8NMEZ8FT99QpM1Cwxeg5UADAKuJKFCAXKGpf9veJY83OFvt9bZhYkn81TsMX
         Dp4OSuj+y4BybG3gKxn2/wME1v/S5zsX4pe9D41cpgkOwsG9zl5grr9zCPIA3yQdGAz0
         VJp7bfojV6Q2ZcTHyqARxPJb25cPoTlLP/sdq12zJiGRc2CuK4lDPgc0efZYVlurVV9G
         ZO6pyoXF0OmuSR20wvCyFFqBXiT5FPP70raUldTbcRliYkFWJYKhd/8gcAKJfBtRXFFF
         f+GA==
X-Gm-Message-State: AHQUAublRwCW7GSDiVym4BPkaY8LYFBANMtK4mTYEWDzvsp1B62JV4co
        Ra4upe2wR+049otqfwRzxiVwgQ==
X-Google-Smtp-Source: AHgI3IYguOK+dM/9om6QfOgjjrMG44+JJ3V9kjMBviVQPvGe1GyoA3P+vG/ut4gB+CnLAU/37KPzsg==
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr114174wru.291.1549297557099;
        Mon, 04 Feb 2019 08:25:57 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:70b6:b9c6:89e2:36a])
        by smtp.gmail.com with ESMTPSA id a4sm1251992wrt.37.2019.02.04.08.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 08:25:56 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, ulf.hansson@linaro.org, biju.das@bp.renesas.com
Cc:     linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org,
        thara.gopinath@linaro.org, linux-renesas-soc@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/2] PM-runtime: fix and clean up of time accounting
Date:   Mon,  4 Feb 2019 17:25:51 +0100
Message-Id: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix time accounting which has the same lock contraint as for using hrtimer
and update accounting_timestamp only when useful.

Vincent Guittot (2):
  PM-runtime: move runtime accounting on ktime_get_mono_fast_ns()
  PM-runtime: update time accounting only when enabled

 drivers/base/power/runtime.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

-- 
2.7.4

