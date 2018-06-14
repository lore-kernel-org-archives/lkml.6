Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A777CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481F9208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHy5ohzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481F9208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965078AbeFNWwK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 18:52:10 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34840 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964995AbeFNWwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 18:52:09 -0400
Received: by mail-ot0-f195.google.com with SMTP id q17-v6so8999400otg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWtsj9ozwRRuUjeEPl7/TBe9eDUFRixECnKeRkHSD3U=;
        b=MHy5ohzQYXR6tDlatYNjVtLu+k4SiSxhm3szHYX5W22GT5EXX71ct4Vt+KRBjAYbY7
         cOSg0na0hW/GFvWEGt/akR0hCB8O6RMvQCnUJwVwkYZ8GGA/et+COxRutruBVLUn4Le7
         8UTiJKbOrfe9adrb2cZDcwS3ND/1mSxsoLaGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWtsj9ozwRRuUjeEPl7/TBe9eDUFRixECnKeRkHSD3U=;
        b=ADihheeQaU4/LEjztiB14h/4BR6Sy2orfc0oeltNV1NhqxaVkKtxoAy/2VeW9nvzXm
         ZBmvOUSKgZ1yuvGE8UjX0MHrGE3/AYBDc7fso7podXTLwcKFrSDoALZJ7KuQl0ACG/JC
         SJTWv4xQlphW7Gw95FxDdDnnMNv8kmw3k9xVKxNZ3DeB9ZG7jmqsHW/bKyvXrEdyfvF0
         UPaIh/Cpa9bzaXfHSBZNm/BjxED9bId/QZMUEQFGMyPC3dwSmDR+DAXH0ey8GPUg2LVB
         Q1YQO47v8cBhxpdFAAdEDt+jM5zkqrwjkchVRLrhgzCk7sPHyZTMc78HwhXhCDrHlbNc
         jodQ==
X-Gm-Message-State: APt69E2eXlQ3z7LqxsJ2Us3v7odiFKB6cYAXSuP9VYwZhGlHp4bYOFE5
        VhuHE7/KWzMUZH8qkXJQHmANEg==
X-Google-Smtp-Source: ADUXVKJ8T0MCVpcJmZH4eXsyDNpGZKPBCT8XgsaM4LaWjEvXBl5+xwHvrRSM/szHfO8P4BXnB1SwpQ==
X-Received: by 2002:a9d:725e:: with SMTP id a30-v6mr2679692otk.303.1529016729177;
        Thu, 14 Jun 2018 15:52:09 -0700 (PDT)
Received: from aura.cortijodelrio.net (CableLink-187-161-191-185.PCs.InterCable.net. [187.161.191.185])
        by smtp.googlemail.com with ESMTPSA id w5-v6sm2778982otg.5.2018.06.14.15.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 15:52:07 -0700 (PDT)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     x86@kernel.org
Cc:     anders.roxell@linaro.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH 1/2] x86: x86_64_defconfig: Enable KSM.
Date:   Thu, 14 Jun 2018 17:50:26 -0500
Message-Id: <1529016629-2948-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the documentation, Kernel Samepage Merging (available
since 2.6.32) is a memory-saving de-duplication feature,
enabled by CONFIG_KSM=y and activated via sysfs. More
information can be found here:
  https://www.kernel.org/doc/Documentation/vm/ksm.txt

When enabled in the kernel, the default is to not do anything
at all, until it is activated at run-time with:
  echo 1 > /sys/kernel/mm/ksm/run

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 arch/x86/configs/x86_64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index e32fc1f..8fd7396 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -48,6 +48,7 @@ CONFIG_MICROCODE_AMD=y
 CONFIG_X86_MSR=y
 CONFIG_X86_CPUID=y
 CONFIG_NUMA=y
+CONFIG_KSM=y
 CONFIG_X86_CHECK_BIOS_CORRUPTION=y
 # CONFIG_MTRR_SANITIZER is not set
 CONFIG_EFI=y
-- 
2.7.4

