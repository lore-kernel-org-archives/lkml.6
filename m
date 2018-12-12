Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C50FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F58F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJ/EZCOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F58F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeLLSaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:30:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36069 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbeLLSao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:30:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so14318247lfg.3;
        Wed, 12 Dec 2018 10:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DInuEKdbNHvaSBbjubOXmw0RPlkgMluOKS1WEsr6y5c=;
        b=qJ/EZCOs1b+EML34zHo9C+nR6UAZzo16PzwObmWr48LK1EtSXOupTjAqweEbPnHx/+
         b03fg/+YCYGMjHu1K34yfrcn2HWGSMXbp9MuwDwN1uHHRmKfJy+VuBr5it0s+dRpYcOk
         Xa9iIxJxHbyjq71xCqh+HB+cvu/ME6pAtGHG7RF6YQZo9WN62BnIfdcMyu3KZj6TXncy
         TkBSxaM5Xr9tdDSYKGhglxBViS5ltBxrjtVOBpaX5kAZ5tk2sqHRKd102T8AKlqQG3KD
         kOkp1qqhUggsZyn1yXoaqBiZelI19TwB4YQexz6sVPXI1d++8ry9V9uoyqC8IlmJ2S1O
         PHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DInuEKdbNHvaSBbjubOXmw0RPlkgMluOKS1WEsr6y5c=;
        b=aotxNdoq+dQM1s62PiZXNJ+ysYxhMEseaQS4JghvNyotyW1ORPL6G5/41B+Za2UhHJ
         KWj4OdxSzGal2882lifJJID5kpSyTiZm/joNfLMBQEBL0DHrGizgUHa6vBptzZ/4juJ4
         0OA9BqqHtq9jPDx/GGSE+RV7moYuoG0tAVPrhJPTrd5WM/k8JBf0Bzkm7/eRMFhSSxRJ
         5XUosLKpiGxeaxOMJod/uK8GXDlo7WOaoVKsuJAoyxKR15oD+LPQ/H7Mnr4owH+Lu8AT
         LMMmP8HBhZX41pDEmvuMBoVYb6Kk9AbfCOfImbL8O52tOGzAr43F32r6Bb5DdacPi1kZ
         j4xg==
X-Gm-Message-State: AA+aEWbiqzFBWOqgB0n6wLwvf7HLfRDuApy/wDKaZ+rKk08bZM778J6N
        43uNHv+J1M+0Lm7MfpcZ2rmQxa+TA8o=
X-Google-Smtp-Source: AFSGD/XcjTMDXqjBxyzJSYhKRmYMXAKBtlKH0JlsDPg2wT+SRZ2hc6HHDRYey8+PQ6/azofR4AHOew==
X-Received: by 2002:a19:8fce:: with SMTP id s75mr12059881lfk.151.1544639441229;
        Wed, 12 Dec 2018 10:30:41 -0800 (PST)
Received: from arch.domain.name (89-70-220-87.dynamic.chello.pl. [89.70.220.87])
        by smtp.gmail.com with ESMTPSA id b128sm3389852lfe.91.2018.12.12.10.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 10:30:40 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk,
        a.brauchli@elementarea.net, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v3 3/3] iio: chemical: sps30: add device tree support
Date:   Wed, 12 Dec 2018 19:30:11 +0100
Message-Id: <20181212183011.16567-4-tduszyns@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212183011.16567-1-tduszyns@gmail.com>
References: <20181212183011.16567-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for Sensirion SPS30 particulate
matter sensor.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../bindings/iio/chemical/sensirion,sps30.txt        | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
new file mode 100644
index 000000000000..6eee2709b5b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
@@ -0,0 +1,12 @@
+* Sensirion SPS30 particulate matter sensor
+
+Required properties:
+- compatible: must be "sensirion,sps30"
+- reg: the I2C address of the sensor
+
+Example:
+
+sps30@69 {
+	compatible = "sensirion,sps30";
+	reg = <0x69>;
+};
-- 
2.19.2

