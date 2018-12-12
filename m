Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1497AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAAD2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544613416;
	bh=K7F/UICVnj0FWkgxYBKLRYRA7wcKhytb1nf/zZi9KH4=;
	h=From:To:Subject:Date:List-ID:From;
	b=EoK1x3OKilrZiLQv8E9xFkug/aAcTjb1FDOFZavpeWmQUTP+ik1czMGuT1/0TOLal
	 TYnc/YNt/9zgq5It9qBRMFgf8weLh6+PJczbHUBYniNKH492Cb7TzMzzio3132e0/Y
	 6A4LXWSCd4CxBH7ApbrepOE1r5jbp0QQsJ4Ew6sk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAAD2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeLLLQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:16:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeLLLQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:16:55 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85C302084E;
        Wed, 12 Dec 2018 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544613414;
        bh=K7F/UICVnj0FWkgxYBKLRYRA7wcKhytb1nf/zZi9KH4=;
        h=From:To:Subject:Date:From;
        b=wJj9RoYLn8UQWfqD1GNEON3oSqlmlazIUhFOzcgA5MinSI4rdy9O5sHDu01r3xE/L
         4aRL1YAkhIBkbLBOln/7CWkwptheEpm4gw7QiJuhyvgVpQRQ29O/9amI9iUTNi8hti
         aABs0igt0pfREWXI5aH+ZVBWCEjHGMKXswmeqlYE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] leds: trigger: Add pattern initialization from Device Tree
Date:   Wed, 12 Dec 2018 12:16:41 +0100
Message-Id: <1544613406-27026-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

 Documentation/devicetree/bindings/leds/common.txt | 36 +++++++++++++++++++++++
 drivers/leds/led-class.c                          | 25 ++++++++++++++++
 drivers/leds/trigger/ledtrig-oneshot.c            | 31 +++++++++++++++++--
 drivers/leds/trigger/ledtrig-pattern.c            | 25 ++++++++++++++++
 drivers/leds/trigger/ledtrig-timer.c              | 28 ++++++++++++++++++
 include/linux/leds.h                              |  3 ++
 6 files changed, 146 insertions(+), 2 deletions(-)

-- 
2.7.4

