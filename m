Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11916ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E9720825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3iW9GOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E9720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeKICi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:38:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34887 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKICi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:38:27 -0500
Received: by mail-qk1-f194.google.com with SMTP id w204so2710216qka.2;
        Thu, 08 Nov 2018 09:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fyqKoBlC5KloHDPLPAXPXw2hUMPNCFEdFIhxzsljqCY=;
        b=T3iW9GOzEAUCqAzsC8Ltqtnepthi9TR8DTocif9tC1AB5SMnGSVVPRmYR/JUlww3u9
         2s3jiCrAfWVn8ZjbXcqBxRnHcDkN+qno0BkkIOILJknCuEYPvBIkXiXXIQSDlfGEFxXJ
         7IvsJuqxyfdzIHbv6xbi0nGEaAadZPpv+mjDKq+Q8kBxn36MhYsEmwhdOpT/Y4geVWTc
         LzytumPkuBvSEljgYzHuINWQexqSEqzyKftkJcMNBvonld+3M6E9glk+US/tsTpgE1Ac
         aFz9DQ2rKRY+8sdlyCLjURJ/iNktWD0h7WAmUJp3DahbRVK4FGwxB+XvJLnM4G0ZbVee
         ig/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fyqKoBlC5KloHDPLPAXPXw2hUMPNCFEdFIhxzsljqCY=;
        b=h6Cj38apYOiqaKv+cXvN4o+KUmFM+xP9ghIVKbA3lFNxx82xVSsYYXoewc++FH/yTs
         zJYyTCXk2eggDEzFv6+c4o4HaiQJL2g8v8GhzrTxz5AKenKyzKY7uZ+Y4yZlkSwBmQGi
         wa64BtrSkWuJAw5blGLECOgNtOTuJEYmijZ+HpvOc4rKVVFW0H9uyLIfhNgG8AEdWZ9i
         11oZqmmJHcGYJcr6yATDk93vxBrBMA5PFpjiX2aw3KVeBiSVmrDEb3o5TucdxpwpAtoq
         cGoC3oFZ+erWIu7pKRwmhwLi5aUBHYDFoy7rr9rEiwCE6a5EHZVXi7s3i+KAEjcqaghD
         DRjQ==
X-Gm-Message-State: AGRZ1gK6vkJErbxhcOXEuhIglZTmHW75nAIwcWaHwesnq4uRs9bMc8tw
        grhBJt0ddgSzf+w+fzer23M=
X-Google-Smtp-Source: AJdET5cq+Q5F6agGjpJjBlxeF258S7mhQOcNRJW6yok1N0noIrPqed8Cyo3RMdlCwmdjbpSrG+guBQ==
X-Received: by 2002:ac8:1a77:: with SMTP id q52mr4979903qtk.329.1541696522914;
        Thu, 08 Nov 2018 09:02:02 -0800 (PST)
Received: from localhost.localdomain ([50.224.228.202])
        by smtp.gmail.com with ESMTPSA id 53-v6sm3172243qtw.52.2018.11.08.09.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 09:02:02 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 0/3] ARM64: dts: meson-gxl: Add dts and bindings for Smartlabs SML-5442TW
Date:   Thu,  8 Nov 2018 21:01:06 +0400
Message-Id: <1541696475-27454-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new bindings and a device-tree file for the Smartlabs
SML-5442TW set-top box.

v2 - removed audio nodes
   - changes soundcard name to "meson-gx-audio"
   - added missing uart-has-rtscts;

Christian Hewitt (3):
  dt-bindings: Add vendor prefix for Smartlabs
  dt-bindings: arm: amlogic: Add support for the Smartlabs SML-5442TW
  ARM64: dts: meson-gxl: Add support for the Smartlabs SML-5442TW

 Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts | 316 +++++++++++++++++++++
 4 files changed, 319 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts

-- 
2.7.4

