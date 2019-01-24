Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD068C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9CC218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqihlWKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfAXOx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:53:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38249 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfAXOx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:53:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so3372741wml.3;
        Thu, 24 Jan 2019 06:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=A3SN7QUqp5qHg4oNm84SJ/vICsa9CU0oqMXYe7YOBRA=;
        b=RqihlWKVZUdLnJV7dMLj4lQrVenP34YaZbaBOC8ox1JB+XWoGi2oAkORw0AY203Jr1
         c3NJIJMWAG+g2D9tLpAsKTUG1ZvGocYZ56cOxCSZ2+3O5qokm8rJ61Blc3kCwenYrzK4
         c6jFOZatSrAIdTlKDFUuZLOJmmQHNRHvGqNK7t0bYqQqqwOqdSGIhX/uKoXKRo/+esCY
         PBDXslx7C3vY7OLwHjlntc1HsX7osW1883Zc+jfBDxixvWZ0zNTJS4HTOqahXBbOCEkB
         tms+04YWl4ZN3Zp77INn2uyDy3SWO2lT1A85x7lpN30UxZLFHqZzWSNL3+kBCvxH1TPR
         4kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=A3SN7QUqp5qHg4oNm84SJ/vICsa9CU0oqMXYe7YOBRA=;
        b=FOGT2V8gmJ3UFUVkwR7pXk/XF2QKeo806qga9GGsy6ok15NajtfC/fzFVofrYBni88
         IX5fTyhH07rPs1ptb8mxxFtblv6dzKP3WzhdI5Y3kYykcH6a1ZOUz7TyUOblSfBGeWqa
         hfeI34VBgQRYPg+7vdYMSoBSW94Eiap0WqbNc9eVCv8XcFzjYev2238HjF7N2YT9cTcU
         U+/Xysj6r3/OS7fYxu0qgekWPXRBgdJke1+Um3P5Ng8YHyk7ORfi4vyt8jf/t//AgUDk
         NQt4xdEwfYT+4kk5BeQhpliCYT2oi9cuL/ZzPPElQXi/L4ToE+n729Ilj54M5GH2LdHK
         ydzQ==
X-Gm-Message-State: AJcUuketXuTXft7Mv7qS6iXOlPSu+W4cvIA18gnRoD8LQmELTP3w3vZx
        pNQ48anmMO9TMnVrcn03xnw=
X-Google-Smtp-Source: ALg8bN6OphMgt2UYZg7oRmVsCccsXMMRyxs5Eo9mcdTweHVWVa9ztTeBA2XSsPwlphS1ZMJCD9VVgw==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr2905450wmj.127.1548341634624;
        Thu, 24 Jan 2019 06:53:54 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id t63sm53611538wmt.8.2019.01.24.06.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 06:53:53 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>
Subject: [PATCH v3 lora-next 0/4] net: lora: Add documentation for SX130x and SX125x parts
Date:   Thu, 24 Jan 2019 14:53:05 +0000
Message-Id: <20190124145309.21698-1-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds documentation for the SX130x and SX125x chips.
We are using the yaml binding format and this series builds with
'make dt_binding_check'.

This series is split such that the basic documentation can be taken
without clock components, as there is an ongoing problem running clk
over spi backed regmaps on certain spi controller drivers [1]

Thanks,
Ben Whitten

v2 -> v3
* Added the clock input and output names
* Limited the radio-spi node children names to radio@
* Fixed fallback compatible for SX1308 -> SX1301
v1 -> v2
* Dropped reset-gpios, radio-spi from required.
* Dropped spi-max-frequency from binding.
* Changed compatible to allow fallback from SX1308 to SX1301.
* Wording changes in commit and descriptions.
* Dual licence
* Incorperate Robs comments on child node and spi wrapper

[1] http://lists.infradead.org/pipermail/linux-lpwan/2018-December/000063.html


Ben Whitten (4):
  dt-bindings: lora: sx130x: add basic documentation
  dt-bindings: lora: sx125x: add basic documentation
  dt-bindings: lora: sx125x: add clock bindings
  dt-bindings: lora: sx130x: add clock bindings

 .../bindings/net/lora/semtech,sx125x.yaml     |  77 +++++++++
 .../bindings/net/lora/semtech,sx130x.yaml     | 151 ++++++++++++++++++
 2 files changed, 228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx125x.yaml
 create mode 100644 Documentation/devicetree/bindings/net/lora/semtech,sx130x.yaml

-- 
2.17.1

