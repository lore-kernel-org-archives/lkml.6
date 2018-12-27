Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A332C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B2B20873
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6pA93fP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeL0TBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 14:01:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37459 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeL0TBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 14:01:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so15946032edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 11:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YeLTEE1Dx6n4L7qt3HAfaNdbaisfIf0DmmbR0jyozfU=;
        b=M6pA93fPInmaZvTvAdoyA+R0K4MZ2cILF/roEYUEy7vyeNTrZDMfYfIeVKnN2ksomo
         wb3ZllCfoj5ItsSgLGgnrocXifUUI2ioVQooSUejSHaW6aHN6Nzita6CUVXZVlIoYbxX
         dxDbNZF2aXgPMcYNiWs9XEXUr2shErRoTsdqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YeLTEE1Dx6n4L7qt3HAfaNdbaisfIf0DmmbR0jyozfU=;
        b=n4sL1OjxDaS6fD+cTMkauc8LoBPKvln+MuMlYoD3j//NAi6fXAb32RiOcTXE0FWCsF
         KYt5XW4xcVj+xrKUIGSq+9g/fjXteFXFU45QLk7k0Ft5NtlNjN0AyPM5fplJHM8oavgD
         a7y2cOGqzUfKm1D6l13smg9e35hbUunFOsShccWrVkC1uI68O+8f+1a1TPwxDF1xlqbD
         GeLIK069O/n2Jo6qNrzgv3g+ZsuOLuGAOlzy1GkiD3HHK081SRiLDu99UpS6bF+wMl1K
         AEl4TwYPKUg0kI0TasjDBjj1d5r1a4LudqJf1Y7EYLYOuYZzw1cplZj9CJZWjBkVyCdj
         spDQ==
X-Gm-Message-State: AA+aEWYO9LkS6f+ehBGAgb9x61xibwMH7perLpbatSfHnGm+w+KhQ5cX
        veDAHWcgpausU8C+zQxMkJZWoPNQwYKNmg==
X-Google-Smtp-Source: AFSGD/Xs9PQK5EMlwpd67QKcl1duFASXaWlzlSe73PPzPufYI5vRG92Fw31Jvjn+zhu4ihJM42WcWA==
X-Received: by 2002:a17:906:4e82:: with SMTP id v2-v6mr16349209eju.149.1545937292430;
        Thu, 27 Dec 2018 11:01:32 -0800 (PST)
Received: from chuckie.home ([2a01:cb1d:112:6f00:6488:e12:eb9c:4813])
        by smtp.gmail.com with ESMTPSA id v14sm11224376edq.74.2018.12.27.11.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 11:01:31 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>
Subject: [RFC PATCH 0/2] allow optee to be exposed on ACPI systems
Date:   Thu, 27 Dec 2018 20:01:20 +0100
Message-Id: <20181227190122.23149-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to how OP-TEE is exposed as a pseudo device under /firmware/optee
on DT systems, permit OP-TEE presence to be exposed via a device object
in the ACPI namespace. This makes it possible to model the OP-TEE interface
as a platform device gets instantiated automatically both on DT and ACPI
systems, and implement the driver as a platform driver that is able to
use the generic device properties API to access the 'method' attribute
as well as potential future extensions to the binding that introduce
new attributes.

What remains to be discussed is how to expose OP-TEE pseudo devices,
e.g., Sumit's RNG implementation on SynQuacer which we would like to
bind a Linux driver to.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>

Ard Biesheuvel (2):
  optee: model OP-TEE as a platform device/driver
  optee: add ACPI support

 drivers/tee/optee/core.c | 94 +++++++++-----------
 1 file changed, 41 insertions(+), 53 deletions(-)

-- 
2.19.2

