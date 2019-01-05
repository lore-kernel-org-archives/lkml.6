Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237AEC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E038E217F5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcpmj/yl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfAEDGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 22:06:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38238 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfAEDGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 22:06:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so18246544pgc.5;
        Fri, 04 Jan 2019 19:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fiIhb4dSkhsN9FzjQC5lutfHVy6pJ2r+9lVnkOLs+AY=;
        b=Tcpmj/ylLzkNCT7S56HhT5WMmavbwQuUZn/HTpmOhAiGh8GdIwlNDCxd+Xz0Hf6EZw
         vOdqGiAX4lEyCOdZqtddL4bWjSBmuPBY40N+aeZAFwNy2blIDhREjn667O44w/rq5MNL
         oRZ2LIDPyfWQ8kPmoND1qWn/O0B/eY4/BS7I2UmF7Ai7LBs0giOiB2jk+l0fiyKmaVSW
         v6WZwc3ecxl9Ai6j1W7v+QiIl7UHGoRqt8cO7zZbYv/VCPYXK9dAxpvCacVnmgy13AfZ
         +OhWqiEkDW0X/FDPl/LGfEo7sT4dh69ZGrX+JK9Us7gHpOJ0vogKs46gGx6RYNcQmFJw
         A6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fiIhb4dSkhsN9FzjQC5lutfHVy6pJ2r+9lVnkOLs+AY=;
        b=PxtVZLhZwmYBrFGorALErtO58LEdLX1EtPxr410/IPU8eHp65gTOGe52hpQW2W7fDA
         ywlTg43QJJaxY96TE7bwu5LyPtk43s5u1G1H+bVjuzdLczu7eHUusVRN6v+WmwLSoYs+
         fhMrYxpgLNzROd9sO5IYnBzsIb2Ln5Jp86xhSUyyj2fC8crv8XC3gjPqxSsF6MwpXsl0
         MUtGme6hlhQyq5D1/HspJfNqxD1kcAUBXnZHaeKP36lxofypzf9tMsjTNndxjJdT3IFm
         1zGFV6iern8SESVMmumObBluIs3YTVy2S7bBR2gQxJ1bZ017J/tXUiFpBjGeOu/GrkFQ
         42fw==
X-Gm-Message-State: AJcUukcd4v76LGr0Rf8qq3sufogF+yvF+SCfyOmqWVwCp+VRO9peBHRY
        VXv9+KRoxBnb25ARwoJ28g4=
X-Google-Smtp-Source: ALg8bN5wJ3RppDAHp+rEuN77jy8GNnxMW8O02G6znGQ1YmOrzhvOHPnQT4uDkvSR1hj0tz27uAxVHQ==
X-Received: by 2002:a62:c583:: with SMTP id j125mr55200656pfg.37.1546657601698;
        Fri, 04 Jan 2019 19:06:41 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id h82sm102885099pfa.105.2019.01.04.19.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 19:06:41 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] hwmon (ina3221) Add single-shot mode support
Date:   Fri,  4 Jan 2019 19:06:34 -0800
Message-Id: <20190105030636.533-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, ina3221, as a hardware monitor, continuously measures
the inputs and generates corresponding data. However, for battery
powered devices, this mode might be power consuming.

This series of patches add a feature of changing default operating
mode to its single-shot mode via DT.

Changelog
v1->v2:
 * Cleaned-up PATCH-2

Nicolin Chen (2):
  dt-bindings: hwmon: ina3221: Add ti,single-shot property
  hwmon: (ina3221) Implement ti,single-shot DT property

 .../devicetree/bindings/hwmon/ina3221.txt     | 10 ++++++++++
 drivers/hwmon/ina3221.c                       | 20 +++++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.17.1

