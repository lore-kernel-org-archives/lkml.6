Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EDFECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CB921536
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi0KJ2Wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CB921536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbeIUFyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:54:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39639 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeIUFyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:54:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so5114373pff.6;
        Thu, 20 Sep 2018 17:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qpTLYIb500e/4dIUmIsS8OV6z2xLinRtj9YbH5EapOY=;
        b=Yi0KJ2Wtr11IKGnqbZ7uvMr4Fwlv8ArTcKz7WTsq29G+WYw17WB5r05hgARM0Um4N+
         isnCTbqEqzf3khsZR2OxQkjgvD3dwD6SqFXyk3vWYzjU8ksk0FYCr7LwT4mxUr99fsz1
         +Pdu2LhRDfZZS82YRFuiw2CBULLCND9gkKsM7K4UREZJ2teLJihrTt9X3mKD2uTrZcPJ
         cL6YIBdgHh+WrFwsoIBP+PKOjX2rI/T0V12za6ibXWyHy9fVCkLyfWP9vZ8RoucdAL/x
         TE4ojY9PdsNlgpblW/KzPjqj3+4qdFZGNT5Q1/8heT/CEMvEhTfRb3R1spmTYwgBzHtf
         vmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qpTLYIb500e/4dIUmIsS8OV6z2xLinRtj9YbH5EapOY=;
        b=OFFiYLXRTqR/iOOBeFXJQPzlXrVeOt8sJ3vyvCoyg1chb5gKz3kog+46XG8MebpEzL
         9MnHxZPu3hDhnmJZKKjxCCkL/fdL3nBv1kqp81ucqEnXCBNEJ6n/WmiIaK07SeuPai4L
         DaG++r/xfpIbQc7LMnl2GhDxMbOzUFAwIB20jCHYIK/mSfeE3bUn39s1HY5OGp9gZmaN
         wHNYOY1un/nv/b2HdYdLO/muiJSJb5s/+jCVzgSTzUsdHJGwr0N4k6H5UiEHXKA7K1MJ
         Q8WnGZVMGRVA1HhV6t/vGUq/caw50LHEDM+zXGPajJ2mfHUkRi+TRV2AeziGy8aFC3M0
         sbiQ==
X-Gm-Message-State: APzg51C+t3r7y2LQOq3OqLvQmsUNxwMv/lWnLEhRDupY0FdhoMtHU8/0
        Y2ZfGz7u7+xGXrXqfvdKFOw=
X-Google-Smtp-Source: ANB0VdY2RQ4jN4StmyHdIX3zMD91kebhwYV1PHsqOMJ6y93jtE90uk/LzgMr1WKjjZLVYYDp4U8zRQ==
X-Received: by 2002:a62:9683:: with SMTP id s3-v6mr43657916pfk.191.1537488493878;
        Thu, 20 Sep 2018 17:08:13 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q26-v6sm43355083pfj.127.2018.09.20.17.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:08:13 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add an initial DT binding doc for ina3221
Date:   Thu, 20 Sep 2018 17:07:51 -0700
Message-Id: <20180921000753.21846-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a initial DT binding doc for ina3221. It adds
channel names (which should be according to board schematics)
and implements the corresponding actions (disabling channels)
in the driver.

Nicolin Chen (2):
  dt-bindings: hwmon: Add ina3221 documentation
  hwmon: ina3221: Get channel names from DT node

 .../devicetree/bindings/hwmon/ina3221.txt     | 23 +++++
 drivers/hwmon/ina3221.c                       | 88 +++++++++++++++++--
 2 files changed, 103 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

-- 
2.17.1

