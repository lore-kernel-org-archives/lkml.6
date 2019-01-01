Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E94C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3684218CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546351648;
	bh=9lxYifAmNQEa1Mq1jLXY82FGckJORo73xP2bBSv2NRg=;
	h=From:To:Subject:Date:List-ID:From;
	b=aINvFFFaFqGcfCfjVQ6PM16hoEA+UMX0d6AUuAiEPuarvvzrhctUSSjWplgAtIO2l
	 rA3jO7vbpjYjkKastLuDhp6dURmIWPipgkzAl9LCT62ATiMQdcon9Rex4Vme3/Rpxg
	 JuEYcj152AKVm+s/9lyyIEOmUs41DEVvSASJGsp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfAAOH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 09:07:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfAAOH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 09:07:27 -0500
Received: from localhost.localdomain (unknown [194.230.155.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0D2E218AE;
        Tue,  1 Jan 2019 14:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546351646;
        bh=9lxYifAmNQEa1Mq1jLXY82FGckJORo73xP2bBSv2NRg=;
        h=From:To:Subject:Date:From;
        b=QQRdXoBz1iJLlYn1pMrJQa2laBJ9GSOeIsPbxVOe+LgpiFjBTE39Y0WB0Tawcs/5a
         SwVTHVRAvTBtbx8tCg/Xv15DhT1pTFHiX9aD/gE8CiRZor0Qi0PCQAO6ouusoIHJvo
         T1vT22I+SPM4JDFU3phj68VHli9NAjwA28LrlbUk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 0/5] leds: trigger: Add pattern initialization from Device Tree
Date:   Tue,  1 Jan 2019 15:07:12 +0100
Message-Id: <20190101140717.13564-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v4:
1. Move helper to get default pattern from led-class.c to led-core.c and
   rename it (build issue pointed by kbuild robot).

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

 .../testing/sysfs-class-led-trigger-pattern   | 51 +---------
 .../devicetree/bindings/leds/common.txt       | 12 +++
 .../bindings/leds/leds-trigger-pattern.txt    | 49 +++++++++
 drivers/leds/led-core.c                       | 43 ++++++++
 drivers/leds/trigger/ledtrig-oneshot.c        | 38 ++++++-
 drivers/leds/trigger/ledtrig-pattern.c        | 99 +++++++++++++++----
 drivers/leds/trigger/ledtrig-timer.c          | 34 +++++++
 include/linux/leds.h                          |  3 +
 8 files changed, 260 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt

-- 
2.17.1

