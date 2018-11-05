Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7CDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286AD20869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D90p0HLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286AD20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbeKET4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:56:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33155 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbeKET4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:56:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so5768808lfc.0;
        Mon, 05 Nov 2018 02:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m6TZp0efiFkYinWCKC0lU0px1N/yD39RLk6D3EMpJfw=;
        b=D90p0HLTmIlg3qiBF2Ynl2RUXIhckvhVT1hOH8qjXWH9t+JGNgmhS9hKmg2y+sVUWR
         hJH34GDUnKkMeIMcWuXE+VbfcP6TvRJz6FfwqaRimhVv326BJL3GglAMckhAk4miwX/D
         8AhAebqWy0O0s5VCj93FSh7nmUu+ZccfalQ3kH0JS3X8+Iq1UjjwhLWqMpu9o5AQv3gY
         JrrIHzowrRDHmHfn3qPvtX3QZezbYVkKwBKuZHW/L4quRx9cTHA207QWHajnKy/f1AOQ
         CIAKygk3Z94MCfrqA5fzYuO7J6OpQ2t8DAV1pRapIm5AhhRk5bu4xLU0eOvR68YVBHNf
         b9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m6TZp0efiFkYinWCKC0lU0px1N/yD39RLk6D3EMpJfw=;
        b=tMSU6sI5C3rJnSmz2ngWvkds1ztRdM+3PCA+KZ73/l83S/2bxPmV2MIS9DtvleqkjT
         ri43VsG1blkcYfMwhfl5VQ8C1pdFNJkXwMnJwchdBJgM5PhrDtt4pbuMZc8YinJM07m5
         jQKyyMVBA/bVqpfn5/PYSMnnqYS9KRS/J8m9cViBQ7oZP0K4UqGG6YdaCi97MWCaRM3K
         S0dxR8HYXk8LVoCwArqh0qOGhhGrmiWmF0ecg8athafc1nsrqIAEDp4yPHCZEggvkKc2
         VItuZ+tndEqCKQ7V9g6pGzRvD7cLq0vfFFmqLOgIsTJmQsO6NpPu4mo1oI4OwaCGYm5y
         J8cg==
X-Gm-Message-State: AGRZ1gJha6FCAZOM1XuijdlGL3Yehi4kgr4irEV1m2SwZu08lyKl6UsG
        vW/Osek8ZdDhkhzriCiTjQ==
X-Google-Smtp-Source: AJdET5d4JryNbbQiRSXHFTXhw2rmAEY5ApN6Jt0SzXSElIDjMB+VNV3pTzoZieJsENKewY+lmlLQ0g==
X-Received: by 2002:a19:ca51:: with SMTP id h17mr11616627lfj.126.1541414240357;
        Mon, 05 Nov 2018 02:37:20 -0800 (PST)
Received: from localhost.localdomain (89-64-7-227.dynamic.chello.pl. [89.64.7.227])
        by smtp.gmail.com with ESMTPSA id h140-v6sm5413605lfg.4.2018.11.05.02.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 02:37:19 -0800 (PST)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>
Subject: [PATCH v3 6/6] dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2
Date:   Mon,  5 Nov 2018 11:36:25 +0100
Message-Id: <20181105103625.9644-7-bugalski.piotr@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181105103625.9644-1-bugalski.piotr@gmail.com>
References: <20181105103625.9644-1-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atmel SAMA5D2 QuadSPI driver was moved from mtd to spi subsystem,
this change is just moving DT-binding documentation.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <bugalski.piotr@gmail.com>
---
 Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt (100%)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
rename to Documentation/devicetree/bindings/spi/atmel-quadspi.txt
-- 
2.11.0

