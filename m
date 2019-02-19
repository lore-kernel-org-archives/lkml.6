Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C441AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE6A2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MAT7kc0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfBSE1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:27:22 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14030 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfBSE1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:27:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6b85a80000>; Mon, 18 Feb 2019 20:27:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 20:27:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Feb 2019 20:27:20 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 04:27:20 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 04:27:20 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 04:27:20 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6b85a60000>; Mon, 18 Feb 2019 20:27:20 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>,
        <linux-tegra@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <rui.zhang@intel.com>,
        <srikars@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wei Ni <wni@nvidia.com>
Subject: [PATCH v8 0/3] Fixes for Tegra soctherm
Date:   Tue, 19 Feb 2019 12:27:01 +0800
Message-ID: <1550550424-7979-1-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550550440; bh=Hdjh0o5VcGnB0trntnbaLoH/zT8zMYEwuDxRXLqats8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=MAT7kc0uiV9b+pBKDbcRN3Tp46RQiw+ZGHhZHpgPkgdDmyhOXUqk4Ye10sWks5W7m
         BVL9+F4oy1+r3fzMaRwoPSabRXq743Y/hcxO/mO06aS4pUklOwgHFa1N0tlaKbJwAk
         upj9vaz0pqXBevOGq+cA3Z6RgPgWv4qqXDH/dRPFe8gj/ICl0g3pIClU5GZTdqi9du
         n0NgkEyuJfTR9H5a4jr9oxxPp5G61/EqXUnQ3piLb2m+CYIi7JvKvKdu8cjl1h8jxW
         YEgf1p+Y0NPr4r9losYIY8MVqPArqijHe2KvbfK6rdeqO7dU9tb7EJrlst1orTBuzI
         HVpf6JIgQAu0w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixed some issues for Tegra soctherm,
and add get_trend().

Main changes from v7:
1. use READ_ONCE to get temperature in get_trend()

Main changes from v6:
1. Per Eduardo's comment, we can remove the change:
"thermal: tegra: parse sensor id before sensor register"

Main changes from v5:
1. Move the get_trend() patch https://lkml.org/lkml/2018/11/20/643
into this serial.

Main changes from v4:
1. fixed for the parsing sensor id.
2. keep warning for missing critical trips.

Main changes from v3:
1. updated codes for parsing sensor id, per Thierry's comments

Main changes from v2:
1. add codes to parse sensor id to avoid registration
failure.

Main changes from v1:
1. Acked by Thierry Reding <treding@nvidia.com> for the patch
"thermal: tegra: fix memory allocation".
2. Print out the sensor name when register failed.
2. Remove patch "thermal: tegra: fix coverity defect"


*** BLURB HERE ***

Wei Ni (3):
  thermal: tegra: remove unnecessary warnings
  thermal: tegra: fix memory allocation
  thermal: tegra: add get_trend ops

 drivers/thermal/tegra/soctherm.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

-- 
2.7.4

