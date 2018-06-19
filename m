Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60ECC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8452075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RKscPO6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8452075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966649AbeFSPMS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:12:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39470 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966469AbeFSPMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:12:16 -0400
Received: by mail-wr0-f195.google.com with SMTP id w7-v6so34894wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lTBkWHTS6vALX+fw08C0UwyCjXznkRYAqMEwBTFo6Nc=;
        b=RKscPO6+/E6taW/9zKqB+/4D3Q8YI2tWiWEAcZW5M0rD0zxzawOh5mPrlmcuJ/WZ9s
         HJavFPm0ys2I+v0rkSrKC73ETJIbVgGnWSrsr4Ze6JqwPfQMBEVRLyUdgX0PYGXqHSl1
         yWZc358lL5WOtpga1N/9ol8ryGnK/gxpcdLXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lTBkWHTS6vALX+fw08C0UwyCjXznkRYAqMEwBTFo6Nc=;
        b=jifuXXpgCRGMvSRI0UJ/lhycSbKSsPZMVN4ajAR/y8XhGcqgrQhx3I6Fv2AYhZyzZW
         kIzcTzkzkUUC5nIFPFHUzYfRtWlDusuG2a5ZEXb2QpQtXiTBB0TxsLtgYIiDGyjKCPiY
         KdX2QVYaawgBX62XZMjFHXjEmg1Kigb7c+E6hdClCwigIYTfI+iXrwBjLjTkXGr3ZzIA
         E4e44erbTps4mcxNJN0KyOfFNDHpUt7SxPb6N+SQNL5QBonmJ0yqhom+zzQZtGwXCWlP
         Z08aySEkKrf1PFRdaQ5rGLpXHsGUjlPqV1MCnZzGjacjGpOZrHHBOth/tXVBc4VC+yCy
         38bA==
X-Gm-Message-State: APt69E3kjnw6VskpgmAmvi0yxeI6Q4y9Ns4XsEKaPXgW8hp1XkuHb37p
        U1eRrzJZE1l6a41fLdpIbs/1Qg==
X-Google-Smtp-Source: ADUXVKIuQSZ1+AAMNBv5nhnZ/bDCS/BTSe9tM6Rzbd4OEfHCDn6Tr9RS8g3Ab9lZKtXaBOlo8AMNFw==
X-Received: by 2002:adf:a801:: with SMTP id l1-v6mr13762116wrc.201.1529421135515;
        Tue, 19 Jun 2018 08:12:15 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id f81-v6sm473599wmh.32.2018.06.19.08.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 08:12:14 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] slimbus: fixes for v4.18
Date:   Tue, 19 Jun 2018 16:12:01 +0100
Message-Id: <20180619151205.11300-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are few trivial slimbus fixes, 
Could you please take them for next possible rc.

Thanks,
srini

Srinivas Kandagatla (4):
  slimbus: messaging: pass correct wbuf
  slimbus: messaging: remove multiple calls to pm_runtime_mark_last_busy
  slimbus: messaging: initialize completion correctly
  slimbus: qcom: remove redundant depends in Kconfig

 drivers/slimbus/Kconfig     | 1 -
 drivers/slimbus/messaging.c | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.16.2

