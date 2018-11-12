Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166DDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6242243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WNDXj5dB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6242243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbeKMIG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:06:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38419 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbeKMIG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:06:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so4668800pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 14:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJ5qY9PDhNvQvRrFMXl2pc8K9tKhezALSPu3zjgvVVI=;
        b=WNDXj5dBhYZ8UxJ2c1aM8MQm9nn8Twf6IAIXjFeQh0bvCaay5n6DtxQ2hEdenprohZ
         ThVMdSWV5APtLy4NI7GMc0fe+l7has9pwOGJNgWJ2EA1vU9qzfH/x4zkLWQRUWbiuuZ5
         kYcsVw1O/7vK7lviX7Sazp0NyM7pZi540TQRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJ5qY9PDhNvQvRrFMXl2pc8K9tKhezALSPu3zjgvVVI=;
        b=o9T+q+Bz8UCed4++dd5NCZRnlUVS8D3J1uTxa8xZ0lXZlU6zZ5o8Ejuoe13XNAgolB
         H6F6VznEOBQByexhBzpfOyuqw8xPgco+gfWE8l7SSYqHgzgOnXd3YywsZKd+b3Le/8sR
         1M++dujBbHGbMKsrMp4w6lXfKGvzKfP66SV3fmV19E/yD33gojTQQhJxhedBQxvatvX6
         g3TUU7Rla2xK9ONELVwYKJzJqlDiPXjNHODZso+1Ngo6MPUeOomd2Rq4OKObcde7H6VG
         ZPTaumSl6AgyjkyqtA2EMkqsP4/Ekgca6ljVRzUf6svyCIidEP6YeEhQJzdmiaD54XHm
         F1Mw==
X-Gm-Message-State: AGRZ1gJxQAqkdr0dKOCu6/+BYtMxNnTCuVmZFisKipaSdrX6fQRJJP/k
        FIrIRqa7JI0Vdd50G/KbdFp4SQ==
X-Google-Smtp-Source: AJdET5fmbVxWA2tBLZcenqdrOyqWUjqeZU8M9WPHGl/wN3MiMHo58BVFqNyDeXmNx3939gi2/DkQig==
X-Received: by 2002:a62:5904:: with SMTP id n4mr2561467pfb.120.1542060711047;
        Mon, 12 Nov 2018 14:11:51 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z2sm16166706pgu.4.2018.11.12.14.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 14:11:50 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 0/2] arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
Date:   Mon, 12 Nov 2018 14:11:24 -0800
Message-Id: <20181112221126.27142-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a channel for the die temperature to the QCOM SPMI
PMIC5 ADC. It also fixes an example in the DT documentation.

Matthias Kaehlcke (2):
  dt-bindings: iio: vadc: Add unit address to ADC channel node in
    example
  arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC

 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt          | 6 +++++-
 arch/arm64/boot/dts/qcom/pm8998.dtsi                        | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.19.1.930.g4563a0d9d0-goog

