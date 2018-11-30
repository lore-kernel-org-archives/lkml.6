Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E54C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373FB20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPPwxdEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373FB20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeLAFPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:15:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34509 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeLAFPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:15:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so4763324lfc.1;
        Fri, 30 Nov 2018 10:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ORrA66Jnsk2VmedMEWnNRYYi8IYilYtn+Su4c6IixN8=;
        b=nPPwxdEyQj9sT80fPOn1XnDy5MqcfYBpqUJtSnxw6qdjPA4FuoKb6khtnFcvGL9yNa
         fdVgdo9DErlTwps69SF5LsXM8X4dOlCizYSqDJoWgig4YXBEBGcLLgaND7haU1WIpw5U
         new5dGxAOtgOEoW66tBtzzfu/Ft4ZNKSvKmoOh72DaL9h2Gchhz36b+GCeCIMjGj0ihd
         6XeozdlpyaxO30Q+zRLFkQG5xT4GFuU00/xM5GwORovr3l/AxgIsq25xihjYoREIQQ00
         mEXAbWpx/gYsBrHw8TATZRR7gxwew2U4eQaM3MKcBuM/Vso4szC+isavFPv26as/gbK8
         /HzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ORrA66Jnsk2VmedMEWnNRYYi8IYilYtn+Su4c6IixN8=;
        b=e04ZuE0rUwdcejMKpKM2furcvrhBUgmoTRVXlAdnOQvjf9xplNJaTHn8E8JB6mTcsZ
         VJyhmOotkC/o8mwENCO4P550QsrMTF+ItflOSwbnNneahAVDkGX8bNJToG+uvCBXPGsU
         RdphlqJ3ihcMl4hXQv3LKz00iNuso+aYt4ZGrRzWDF0pUr7ORKmbCBe0xmODYNgxE/LM
         um66inD0O6R1RK1DNd3n0Kn/WsP2GwyTop1+Ysqi0IhH8JYHj4X1sjVfI/VsyhkDm41M
         eWJB8W04gjSx7Gt00sJ/+/0jEvshVB5wAtucNzoLZPC+lCAFZZOytmhxQqMHLrvInd2s
         F9Ow==
X-Gm-Message-State: AA+aEWY4ntxz26SxY9F7k3Byu3m6h8HfqoWWiEQghk2zYbY2eA7rDHUR
        doh6LDtXIgyfVsnmziUJiJw=
X-Google-Smtp-Source: AFSGD/VnLu/Gc48tTZjyAcqkqZJHYLTSydEi5RyJxIX3CKuyV6rPMYw0AR9uz1fkoMIKxYFhN0cfEw==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr4332600lfb.72.1543601105901;
        Fri, 30 Nov 2018 10:05:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:dd88:5bb0:9191:dab2])
        by smtp.googlemail.com with ESMTPSA id q6sm922199lfh.52.2018.11.30.10.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 10:05:05 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH] ARM: dts: s5pv210: Add s5p-jpeg codec node.
Date:   Fri, 30 Nov 2018 19:04:23 +0100
Message-Id: <20181130180423.9421-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds node for s5p-jpeg codec,
which is present in S5PV210 SOC.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 75f454a210d6..12eac8930eac 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -627,6 +627,15 @@
 				samsung,lcd-wb;
 			};
 		};
+
+		jpeg_codec: jpeg-codec@fb600000 {
+			compatible = "samsung,s5pv210-jpeg";
+			reg = <0xfb600000 0x1000>;
+			interrupt-parent = <&vic2>;
+			interrupts = <8>;
+			clocks = <&clocks CLK_JPEG>;
+			clock-names = "jpeg";
+		};
 	};
 };
 
-- 
2.17.1

