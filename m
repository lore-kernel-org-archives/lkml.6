Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD1FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE502064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="uVmsetXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE502064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJIBdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:33:02 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:59370 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbeJIBdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:33:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 011832092C;
        Mon,  8 Oct 2018 20:20:01 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1539022800; x=
        1541614801; bh=7GDl1ndnwqGbv+2YOjStm1fcMbJsyDoNyj9lXt0BCQs=; b=u
        VmsetXPlK4oeLH+1nV5R/cFsFnZThA9yFl4Z1kHnnip3BI91L/gbIZrEvR9nbxSD
        2OmhQSYOylui8e3BhjE8AITcyODijxp6LXv5XXSsgTwS/SLBVlCq2+vHh8IqN+VB
        T/tzNWTifhQkLOGRdVifrZWmAJR0f8iyD0vJM+k7eRpSOzX0rShrZD0bNhRVtwr8
        qAgQU4mgpEUPXf3sZ1RRjLLrGNOtBiPl88P8/88qtN+czEwegb0tuG8PHg9rZurL
        hlFBpfu3p9YUEbZs30DpScur17rdjHAh6IApatR2q2tJtzG7u8VYnyCzPqOaFwIB
        ZSMaoV1tUj2OBIlZFu5BA2npt9RSYsDRJNOE/pjkaLS/a3EqzWz4OrFRqJznIPRD
        xDNtRpj8+2YyZlX7tJk8lHs8bttlqXEYQ0ycwunaGzKa8XSek/ZDM0AWig2FzLrw
        gCKgYkgY5hZBU1yUB8UBdwAetxaSNtG88LxHnN5lTOjycvjg3alHxbQj5/cIXgjw
        SOrQcL/7c8qDk+I+DmlqvE73Af9yxZs/8QHWPvo4iA71g6voh8dO+qLkMtFnx9x+
        /ITJ+ow8rPYJaG0hGhhn58XDIUnq1VFwv28oXbr2Wa77mODNTzUf4EIYhcAZsJz4
        NFMSZopFYgFpg5LZAujPEBMnPf4U/l8vlkCcYIMK/Y=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 0pncrSTZGO9n; Mon,  8 Oct 2018 20:20:00 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id A9ECC1F984;
        Mon,  8 Oct 2018 20:19:59 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/7] dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
Date:   Mon,  8 Oct 2018 21:19:02 +0300
Message-Id: <20181008181908.9456-2-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008181908.9456-1-oskari@lemmela.net>
References: <20181008181908.9456-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP803/AXP813 AC power supply can limit input current and voltage.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 .../devicetree/bindings/power/supply/axp20x_ac_power.txt       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
index 826e8a879121..7a1fb532abe5 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
@@ -4,6 +4,7 @@ Required Properties:
  - compatible: One of:
 			"x-powers,axp202-ac-power-supply"
 			"x-powers,axp221-ac-power-supply"
+			"x-powers,axp813-ac-power-supply"
 
 This node is a subnode of the axp20x PMIC.
 
@@ -13,6 +14,8 @@ reading ADC channels from the AXP20X ADC.
 The AXP22X is only able to tell if an AC power supply is present and
 usable.
 
+AXP813/AXP803 are able to limit current and supply voltage
+
 Example:
 
 &axp209 {
-- 
2.17.1

