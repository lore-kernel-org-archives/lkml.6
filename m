Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861DFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCAB2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZ1knbXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCAB2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966880AbeFSQVG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:21:06 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36665 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966646AbeFSQVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:21:03 -0400
Received: by mail-ot0-f194.google.com with SMTP id c15-v6so329661otl.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=463XK7obqJajXpDjRAT+4RJ2/Hoph3sdhEwkyHLEYFw=;
        b=gZ1knbXHj7kYOYchTbnMCwVRwZyTVKqCjqutCNPfoLV+L7GELwe5N3+yRO3+P5LMv3
         R/DduV8hIXbNS5ZxjvIK6cbbLwg1RWlD1fVJU6Ms3YRkCfZhcJ2SRyMoF42sd0ZUrFNY
         GIdfE5W9Jg3QOZSonmpxT4juGf/d4ecHMV/RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=463XK7obqJajXpDjRAT+4RJ2/Hoph3sdhEwkyHLEYFw=;
        b=MnNbBb4tlZb67+gX3Rv8zuIFUz2JVSvDrC4FN67SIjmoHklJo7rJu9Luo9zrkSilEQ
         gC7RqmWw+HBswbeGUR2gfvEIs0yzodD/Nspem45LrUD/Ksy9Eyoo2tBdP162kVukAHvE
         F++ipRvw3R82e3jjvq671YWlfFwmfBnLdS6urOh+BYHuT3CVbEs7mopC3J0N/UrRFEEn
         v86PEWftgx4fUOL89l+DmfMJDLst3KbRmUxBuUAWLbCkB4kRJrnl4KYtKGVLOT70L24r
         B58nFiqqU7nir3Rt82htjsn59MH/nyGGE3Rvp0ExsiKV+QL7xX5fExsVFNyX5P/lDHks
         DLYg==
X-Gm-Message-State: APt69E1eUaqijlTnoV1dDg5jTTAl4zgsMvmy7nQm1KVv/dMEbV4lwROu
        lprusj9Qdfsivbd2VJtOIdUIGQ==
X-Google-Smtp-Source: ADUXVKLzJgu0Ma54PwEuNDCMFZH0J82ZIgUE/qyV+5ESA91EKbmJLbA/JuIjZfzLmKbncl8GQnSc7A==
X-Received: by 2002:a9d:25cf:: with SMTP id q73-v6mr10043793ota.207.1529425263147;
        Tue, 19 Jun 2018 09:21:03 -0700 (PDT)
Received: from aura.cortijodelrio.net (CableLink-187-161-191-185.PCs.InterCable.net. [187.161.191.185])
        by smtp.googlemail.com with ESMTPSA id t7-v6sm56234oth.12.2018.06.19.09.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 09:21:01 -0700 (PDT)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc:     =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/net: Fix permissions for fib_tests.sh
Date:   Tue, 19 Jun 2018 11:20:31 -0500
Message-Id: <1529425232-25242-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fib_tests.sh became non-executable at some point. This is
what happens:
  selftests: net: fib_tests.sh: Warning: file fib_tests.sh is
  not executable, correct this.
  not ok 1..11 selftests: net: fib_tests.sh [FAIL]

Fixes: d69faad76584 ("selftests: fib_tests: Add prefix route tests with metric")

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/net/fib_tests.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/net/fib_tests.sh

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
old mode 100644
new mode 100755
-- 
2.7.4

