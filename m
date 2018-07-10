Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3303C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4888820B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TRlfus5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4888820B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbeGJV0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:26:42 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41714 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbeGJV0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:26:41 -0400
Received: by mail-qk0-f193.google.com with SMTP id d22-v6so12389212qkc.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ze0Y/6Fsw6U1u46NA46V42vwgb3Cn6gZP85XLIBbti0=;
        b=TRlfus5flCmQQvKQPX98zyARAPUMTvDXBF4JZGcVkvCqFYBMpVX1kSMtwap4G466dO
         XBxCjdoGYZqCR3gxsqIpqTU2duc9WhdUSLQ6TCQjZTegq2k3ItpOJHsOiamG2YtyHXSg
         o724cuW1NiTRZVMoXZjYpjzdlDa/WtKeWEJ1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ze0Y/6Fsw6U1u46NA46V42vwgb3Cn6gZP85XLIBbti0=;
        b=JpBEq6I+wJn5gJIcB/6JVnz5g06o4ZUzw+FthoMabMKPpVFVonEFHzwfbGLoYqpYQi
         78ioRtbRS2K/p8V+iOfUAzvg2rIjK7FHsClCEiSNrEqVfNatWEVHEAojSqMzRinuQwNB
         PAqIx7cRkkyHqLB2v28seCJuSLZKAb/fBsG4V4NdFGi668b+vJVlTL0iC15SpwSPcAwE
         M1EvptCipKpXsJwsHoC5SvyBXzRRfhyRNVfMEqOM6cM7RFUz8VJyj82PJU+WbQ+TcIWd
         /5w37P+nb5FeKw4PYM15NNaWstgC6DunjxHiZzqEIhEeH8AypCHSuKbbYev5+VTlIjgO
         i8ZA==
X-Gm-Message-State: APt69E1F2rj2dnFScDgd90A9jwRU9th9D891U0wvLseQC4d7rrd23Ryy
        EcfqzKHSgg9Wqph7t5dyfiMGkg==
X-Google-Smtp-Source: AAOMgpdszkBcoslGQkTUhbwCvIV5Uu4oHgKbBGBM30q4eLu34PKyBDoqRaBN021H3KRqwbgUHzERvQ==
X-Received: by 2002:ae9:ed82:: with SMTP id c124-v6mr23835340qkg.303.1531257944029;
        Tue, 10 Jul 2018 14:25:44 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b21-v6sm6638912qtp.26.2018.07.10.14.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 14:25:43 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 0/2] Stingray Smart NIC DT support
Date:   Tue, 10 Jul 2018 14:25:29 -0700
Message-Id: <1531257931-11591-1-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds DT support for Stingray smart NIC boards

This patch series is based off v4.18-rc3 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-smartnic-dt-v1

Ray Jui (1):
  arm64: dts: stingray: add PAXC support

Vladimir Olovyannikov (1):
  arm64: dts: stingray: add bcm958802a802x dts

 arch/arm64/boot/dts/broadcom/stingray/Makefile     |  2 +
 .../boot/dts/broadcom/stingray/bcm958802a802x.dts  | 26 +++++++++++
 .../boot/dts/broadcom/stingray/stingray-pcie.dtsi  | 54 ++++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 11 +++++
 4 files changed, 93 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi

-- 
2.1.4

