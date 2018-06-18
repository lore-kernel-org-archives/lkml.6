Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974C5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521A220852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fqqatgK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521A220852
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967387AbeFRJF0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:05:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55713 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967228AbeFRIcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:32:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so12566589wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Vu42YNoT23i0YJrN/U8w469DZxlxnxuOvK7FSSJOxDk=;
        b=fqqatgK/JSuPM99QVb8uae/i4fry0gWGNWGtOAIxTQtfbCBHv8uOk5ckBgnqcsyfXV
         9Aio3++xolC8VXN6OA3D5B7KuYO5+peO4sjzmCmTIi4OWafc8pbJKZwVJGALqc512y1m
         AejO6UIJkXTl1kuqBgKIQEkc/NKx6CU9VHQbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vu42YNoT23i0YJrN/U8w469DZxlxnxuOvK7FSSJOxDk=;
        b=H+w/rBLsYp0FutqzEBF17Mqah1h6bhx4so0sbLJ76ZDwp0LLs0D9EUXDwVd9CBFDpR
         UfghwCGgH9rDP72+f6fOmmWINH9JLtcmomiNfxSjyZP/HtDmKQ0BImf8+YVkUtY4zefG
         DLwGOOstqtPUsEiHtTlo6Z6+LmVMGgesqMvVZCt30cx9NwTACgtUj8GkEozHBqtZn8JZ
         ruGasBGEhLv+6rZbK65quaHZzfj4Ztj60slB6CKHqni06et22sXJHE37WUm9Zjma48Sm
         UlqC5gCbxtqgobWZTEktu+btydD38NPiCdQH7iiXgxhxLGgC/P0Nx9uXCxDqg5/bpTIE
         QSpA==
X-Gm-Message-State: APt69E0vv9TiX24UX/s1bdMCwZO5nhP2hUYYEspM5RJoyrW5Lx+SLh6g
        armUmjS7FjpYH7Zx50pWs3TQlw==
X-Google-Smtp-Source: ADUXVKIiL7wkOKekTIUb1f2p4z93LF437589ke8gjcoBkJJg1icozT/I9Mx2BmsXdUTDhVjvsHw64Q==
X-Received: by 2002:a50:ccc8:: with SMTP id b8-v6mr10400627edj.98.1529310722311;
        Mon, 18 Jun 2018 01:32:02 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r10-v6sm6261992edo.77.2018.06.18.01.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 01:32:01 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 0/3] Stingray thermal driver support
Date:   Mon, 18 Jun 2018 14:01:16 +0530
Message-Id: <1529310679-13482-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches adds the stingray thermal driver and its
corresponding DT nodes with documentation.

Pramod Kumar (3):
  dt-bindings: thermal: Add binding document for SR thermal
  arm64: dts: stingray: Add Stingray Thermal DT support.
  thermal: broadcom: Add Stingray thermal driver

 .../bindings/thermal/brcm,sr-thermal.txt           |  45 ++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  37 +++++
 drivers/thermal/Kconfig                            |   3 +-
 drivers/thermal/broadcom/Kconfig                   |   9 ++
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/sr-thermal.c              | 151 +++++++++++++++++++++
 6 files changed, 245 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
 create mode 100644 drivers/thermal/broadcom/sr-thermal.c

-- 
2.7.4

