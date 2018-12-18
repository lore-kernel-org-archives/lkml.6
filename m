Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D340CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7D9218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545146861;
	bh=GIPmiDMxAfWFegTfVFlBOREnRLIv2Oab4u3bzF54KFA=;
	h=From:To:Subject:Date:List-ID:From;
	b=MLD7QUsubkToOjtBic4OKKeOq//Eox/SulXvGPonyCqinlZdblSYnvQUExKsrBSl6
	 Ka7kSZmvh+5ykNKBV1NYnJBw8LqlRZ/htM/NRnaz8Fcg577J79efHZmEBnFksaKot2
	 oerqMgetXqIqs24r99c58zqT5iU3H5kKTOEQe1/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeLRP1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:27:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:51096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbeLRP1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:27:40 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94A3220815;
        Tue, 18 Dec 2018 15:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545146859;
        bh=GIPmiDMxAfWFegTfVFlBOREnRLIv2Oab4u3bzF54KFA=;
        h=From:To:Subject:Date:From;
        b=K/Es2xV/KqumZH6kHYTiBGKOpd2ImxpZR+cEcHMB60obaEmmjBrXxS2sZfFP4dK6W
         ePlpJUwrEuurzrMaGWqqS8LMuSfsgrUu990SPwvGd8vJuAYX3ii2+JBAXCoCt7KrLk
         ZBvwb1+s3rwsYeeE70HU0wkvrkjPIEKbDa+ksvPI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 0/5] leds: trigger: Add pattern initialization from Device Tree
Date:   Tue, 18 Dec 2018 16:27:27 +0100
Message-Id: <1545146852-32207-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v3:
1. Add missing EXPORT_SYMBOL_GPL.
2. Put pattern trigger format into common file - shared between
   dt-bindings and sysfs.
3. Use array of integers as led-pattern property (since it is bigger change
   I did not add Pavel's ack to patch 2/5).
4. Mention ms units for led-pattern bindings.

Changes since v2:
1. Drop Jacek's patches and my "led: triggers: Initialize
   LED_INIT_DEFAULT_TRIGGER if trigger is brought after class".
2. Follow Rob's advices about bindings - use "led-pattern" property
   and generalize usage of it into to three triggers.
3. New patches (2/5, 4/5 and 5/5).

Changes since v1:
1. Rebase on Jacek's patches.
2. Add patch 3/5 for fixup of Jacek's solution.
3. Drop first two patches from the series (applied).
4. Patch 5/5: Use LED_INIT_DEFAULT_TRIGGER (suggested by Jacek Anaszewski).
5. Patch 5/5: Return-on-error and log warning (suggested by Pavel Machek).


Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  dt-bindings: leds: Add pattern initialization from Device Tree
  leds: Add helper for getting default pattern from Device Tree
  leds: trigger: pattern: Add pattern initialization from Device Tree
  leds: trigger: oneshot: Add initialization from Device Tree
  leds: trigger: timer: Add initialization from Device Tree

 .../ABI/testing/sysfs-class-led-trigger-pattern    | 51 +----------
 Documentation/devicetree/bindings/leds/common.txt  | 11 +++
 .../bindings/leds/leds-trigger-pattern.txt         | 48 +++++++++++
 drivers/leds/led-class.c                           | 42 +++++++++
 drivers/leds/trigger/ledtrig-oneshot.c             | 38 ++++++++-
 drivers/leds/trigger/ledtrig-pattern.c             | 99 +++++++++++++++++-----
 drivers/leds/trigger/ledtrig-timer.c               | 34 ++++++++
 include/linux/leds.h                               |  3 +
 8 files changed, 257 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt

-- 
2.7.4

