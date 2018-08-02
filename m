Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931F9C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E4B2156B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMUpLbGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E4B2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeHBVid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:38:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44000 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeHBVid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:38:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id b20-v6so1330405edt.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 12:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=56FAvYozzzawTLAmWNQaS/ylLi9OPb10xlYe9IJORGQ=;
        b=NMUpLbGuZO9ciKXGRtV/IILRRYmqvkoV69G/wAYjeq2aXQvIK5SBMUVZFH5310ZUd4
         guWk9/fIxSNZqqx/FBLr7zPXKB3YZr2jR09dgGGokAFeuRQg4ZbQYnYqQK1hZRVH/fh9
         LPuiTjOUX+fDujoIGc/KIXG6+aEc9SiZdGXIQzdKsyEE9TC/FbUP/BN1ogEBPYN7xjE+
         IAaiGvMZ3ri5WcaTKo2r+XMJYkX2EdnqdUX4xE7BbC92K6qZp/hptjjksDrLr3HQgk6D
         p73aG07baBYD9PgOcMct19abuSyJuNTxh2Z/41Ap1VnzlHyvlLyCu4eLIUrmOPYkbql2
         zd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=56FAvYozzzawTLAmWNQaS/ylLi9OPb10xlYe9IJORGQ=;
        b=W8C7TGryMKRITOaxAwuP37wjcdtaeXeONVvdLELwztI6oMVJFOlU0IZfVv5uECWZVz
         uWvTTgi41RtGdxmIplu2iIBH5Et2mgNbA31walm+cJH8ZF1+y7v4juNswf/jHSp3a2gd
         7sS4GYGBSMY/eRZNr6VJ3WlYs713UOPjAEfFkq1D9YZ+nFKM1sxVzD/9b199fjSi1drF
         N6zEDmMAYTXoRNyaHkBA1Rru7r0qS4MWZ47xkYGaiAHzmEaUjTK7KDxBlZAZ4ti1oLSg
         mrMycIlRZ5hh3HsD67ul4+fMBG2om5Ia55DU8VHpP3RZyWFdcl+VTQWH4te0faK7YGNR
         5PMQ==
X-Gm-Message-State: AOUpUlFg8QdnUtxwczzhCVCvVWoEY/Oc/vDvmu2xV4rNwmU1O6wRWVEh
        C9a2penuGEwHtlDoVzaAegY=
X-Google-Smtp-Source: AAOMgpfdcUOrCHwoD+q2bpSKPs7uFMDY2/LZ8lRq7YeHagqIElc+eilSsvEcwekbZxH+6kC17q9bJA==
X-Received: by 2002:a50:ec0b:: with SMTP id g11-v6mr4662180edr.38.1533239157284;
        Thu, 02 Aug 2018 12:45:57 -0700 (PDT)
Received: from jupiter.lan (126.158-248-196.customer.lyse.net. [158.248.196.126])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1219655edn.28.2018.08.02.12.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 12:45:56 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Noralf T <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 4/5] dt-bindings: add winstar,wg160160 display bindings
Date:   Thu,  2 Aug 2018 21:45:35 +0200
Message-Id: <20180802194536.10820-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180802193909.GA11443@ravnborg.org>
References: <20180802193909.GA11443@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The winstar display uses the pardata binding.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../bindings/display/winstar,wg160160.txt          | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/winstar,wg160160.txt

diff --git a/Documentation/devicetree/bindings/display/winstar,wg160160.txt b/Documentation/devicetree/bindings/display/winstar,wg160160.txt
new file mode 100644
index 000000000000..893065d558c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/winstar,wg160160.txt
@@ -0,0 +1,53 @@
+DT binding for Winstar WG160160
+
+This binding is for the Winstar WG160160 display using a RA8822 controller
+
+Required properties:
+- compatible: "winstar,wg160160"
+- reg: numeric identifier for the display
+
+The node for this driver must be a child node of a parallel-data-bus, hence
+all mandatory properties described in ../pardata/parallel-data-bus.txt
+must be specified.
+
+Optional properties:
+- chipselect-gpios: GPIO used for chipselect of the display
+- reset-gpios: GPIO that can be used to do a hardware reset of the display
+- backlight: phandle of the backlight device attached to the panel
+- regulator: phandle of the regulator that provides the supply voltage
+
+Example:
+
+	backlight: backlight {
+		compatible = "gpio-backlight";
+	}
+
+	power: regulator@0 {
+	}
+
+	pardatabus {
+		compatible = "parallel-data-bus";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pardata>;
+		data-gpios = <&pioe 0 GPIO_ACTIVE_HIGH
+			      &pioe 1 GPIO_ACTIVE_HIGH
+			      &pioe 2 GPIO_ACTIVE_HIGH
+			      &pioe 3 GPIO_ACTIVE_HIGH
+			      &pioe 4 GPIO_ACTIVE_HIGH
+			      &pioe 5 GPIO_ACTIVE_HIGH
+			      &pioe 6 GPIO_ACTIVE_HIGH
+			      &pioe 7 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&pioe 8 GPIO_ACTIVE_HIGH>;
+		rs-gpios = <&pioe 12 GPIO_ACTIVE_HIGH>;
+		readdwrite-gpios = <&pioe 11 GPIO_ACTIVE_HIGH>;
+
+		wg160160@0 {
+			compatible = "winstar,wg160160";
+			reg = <1>;
+			reset-gpios = <&pioe 13 GPIO_ACTIVE_LOW>;
+			chipselect-gpios = <&pioe 9 GPIO_ACTIVE_LOW>;
+			backlight = &backlight;
+			power = &power;
+		}
+	}
+
-- 
2.12.0

