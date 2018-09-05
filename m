Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9C0C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A399206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1vMJlmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A399206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeIEXGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:06:50 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:33876 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIEXGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:06:50 -0400
Received: by mail-lj1-f178.google.com with SMTP id f8-v6so7139844ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/iS8/L/JbSX8PHzS8SJY+SYdehyHPUPHCbJXt98GSCc=;
        b=R1vMJlmEJqI5EFdp/wJ9fHfzQ1yaF77K+iliXmqepfzgPFREtMF1G5fyEVMTLWomsD
         d/5IZEVAEx76s4yeoLB+/omCc7E5WSZ/Fd2yTZFWXjBbr0CxiFVJf36F8k5ZmotQn3RZ
         fwWiVH8Yv3W4AkbYfPEiQ2etN4v8029mJjEhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/iS8/L/JbSX8PHzS8SJY+SYdehyHPUPHCbJXt98GSCc=;
        b=LaTR+gyVlS5VkgjPclqjgt7JeQTr6c83amK3Z9N/bBSbs6V8a7u/5HW2Y2FbSFcPq1
         cDqfr8884Mu0LVC6r4dailcBwUqzouGEwMKLiCFaM3cTIPTp5Vnu15B05JhmDARPmKH+
         ZiiD5iAzssFICoDlS0MI2Gj+Ve+Vhxo5wSmSYl1XkguP/WRUFit7CQu/CPR/L1H4uw0I
         2hxFltFsG/jIjft7JWpRuLsg8jCkOOCupWz2wrcgfzkFOgWDLPOV4o6tMjSi4Ig5fF3B
         ukby0eGRx2yNvDXBq1nyJI20bF6xPCSyZdXODKMXUgle7OHGW5x+N8TQaenvv+lHqmSF
         F9gQ==
X-Gm-Message-State: APzg51CA90PkNhW4Mjr0CG8hvWve6PE2PTdUm5KHgoB9TYgXKcVXI1qE
        wTQsHurNTvLT+LONBwbp+7XJ+w==
X-Google-Smtp-Source: ANB0VdbgEHC5LeWYF0hkr+EfR8uBzYYy73A7D/tyUXPRccm6jS0Z4J/UlKc3I1MpqSHOcyoF07YDFg==
X-Received: by 2002:a2e:21d5:: with SMTP id h82-v6mr24264847lji.46.1536172525156;
        Wed, 05 Sep 2018 11:35:25 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id r1-v6sm433169ljr.81.2018.09.05.11.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 11:35:24 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm msm compatible+model cleanup
Date:   Wed,  5 Sep 2018 20:35:14 +0200
Message-Id: <20180905183517.9390-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor arm msm compatible+model cleanup


Changes since v1:
Instead of adding compatible to msm8996.dtsi,
drop both compatible and model from msm8996.dtsi
and msm8916.dtsi, since all DTS board files that
includes these already specifies both model and
compatible themselves.

Niklas Cassel (3):
  arm64: dts: db820c: Add qcom,apq8096 to compatible string
  arm64: dts: msm8916: Drop model and compatible
  arm64: dts: msm8996: Drop model

 arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi       | 3 ---
 arch/arm64/boot/dts/qcom/msm8996.dtsi       | 2 --
 3 files changed, 1 insertion(+), 6 deletions(-)

-- 
2.17.1

