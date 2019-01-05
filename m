Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9D5C43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFA921872
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9tiLmeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfAEAtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:49:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45057 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAEAtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:49:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so18096257plm.12;
        Fri, 04 Jan 2019 16:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hQHCKM7ZhKGTJHdXyKG+gS12d7C0tK+PtMw4cMM9gh4=;
        b=i9tiLmeYyuZAc8YyIggrVs0OWm0oQRI2jklrXffBWVpgjRhoDBoQsd215WTTT7RLJG
         A5Lxppl1pP6QChpwYOG0gbnU1kP/BQh09iFKk83ihZi5rAZ9zoKK4mPaoO1+L8m27q8S
         QtqDIQtlbEw4hDLiWfPHpZxyyyII+Lhw6Rap8WqIAazO/N8GCyZsiOyXnWPAxPb6cFBX
         cn3nqlWGRriQ5uLbhpHzzEmqEu38G4+G4dwRSw2YnrChZw2rrT4vaq66FP8d9F2VuUkt
         T6TJfbRa3ZnNUMg94U6ob5uZPkvXr61R9tCX8qcegdnU6k5dTreCXaQOxZ5KNu3wWNe5
         ltzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hQHCKM7ZhKGTJHdXyKG+gS12d7C0tK+PtMw4cMM9gh4=;
        b=Ug5ApBr3pbZ6ptgx/U43ZXNpCqRugr+k2foUIpbJn8ohGM19kat8/aVOFMF0jC9FVK
         p/JTMhTA0yhIw+GBrdYHKCnFKauKCPI1yvyKYLuHWsn/lzEbk7tM0hwSgzEipJz8B6SC
         dX7uGwKuk0YHYeQNTV4OzK14y302L4t3mtO3yvXm2wr2GVprLA2+CqQwVoQY40HcL4li
         WPzHCcwCqMKHEmU46m5dO7yjyz26xuC+/0/4sYT3tSyPVgmb5elE9V1frX8hx11ym14f
         7DUC0zhjKd7vpXaLW7N1HgOWhSPi7es87OCVo7cWuNDeFTuyem/+VJWjQIjJVP99c+Tw
         jNIg==
X-Gm-Message-State: AJcUukfbi4fBYPAPSzdGwRrDg7BjRhoxhjiJ3lIAGVZS7zI4SIMhGHpL
        qoNOMjO6/A2X4HJqr5/15RWww80n
X-Google-Smtp-Source: ALg8bN4JyLSS7ihZOsIawZ7pfgmzyzpoUFN0urjvUasRHxbld8aa82NyKN3y3loQwgawl7zzjwQB5w==
X-Received: by 2002:a17:902:4225:: with SMTP id g34mr54008689pld.152.1546649374696;
        Fri, 04 Jan 2019 16:49:34 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n68sm101525495pfb.62.2019.01.04.16.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 16:49:34 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon (ina3221) Add single-shot mode support
Date:   Fri,  4 Jan 2019 16:49:02 -0800
Message-Id: <20190105004904.17947-1-nicoleotsuka@gmail.com>
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

Nicolin Chen (2):
  dt-bindings: hwmon: ina3221: Add ti,single-shot property
  hwmon: (ina3221) Implement ti,single-shot DT property

 .../devicetree/bindings/hwmon/ina3221.txt     | 10 +++++++
 drivers/hwmon/ina3221.c                       | 28 +++++++++++++++++++
 2 files changed, 38 insertions(+)

-- 
2.17.1

