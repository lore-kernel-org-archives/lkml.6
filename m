Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FE720841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="n2pgJTWp";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="n2pgJTWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FE720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbeGaSYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:24:53 -0400
Received: from node.akkea.ca ([192.155.83.177]:53286 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729622AbeGaSYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:24:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id B54ED54204E;
        Tue, 31 Jul 2018 16:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1533055425; bh=TbqlNEu3WJWfDY6ovENrWtfIa1RN9DRRy0dbUJpWNRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=n2pgJTWpTBZKLESnlxY73/1bwos4QemqZ5+Alhw/A35SoqYAPzfFUw8dw/NJ5bds6
         7Lp6V0z6Reoa/+67zOfddzW61DaNeIkT7azW/fXjUcJCogBnSeOuJNpm+2FJbUby2I
         oULrYavZlz+egdiyN0ezm9oqEtOVk+H4DDhgIfnE=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gnZYSkWCPwan; Tue, 31 Jul 2018 16:43:45 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.cg.shawcable.net [68.144.56.170])
        by node.akkea.ca (Postfix) with ESMTPSA id 0472954204A;
        Tue, 31 Jul 2018 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1533055425; bh=TbqlNEu3WJWfDY6ovENrWtfIa1RN9DRRy0dbUJpWNRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=n2pgJTWpTBZKLESnlxY73/1bwos4QemqZ5+Alhw/A35SoqYAPzfFUw8dw/NJ5bds6
         7Lp6V0z6Reoa/+67zOfddzW61DaNeIkT7azW/fXjUcJCogBnSeOuJNpm+2FJbUby2I
         oULrYavZlz+egdiyN0ezm9oqEtOVk+H4DDhgIfnE=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v3 0/4] Add the BQ25896 charger IC
Date:   Tue, 31 Jul 2018 10:43:12 -0600
Message-Id: <20180731164316.32696-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:

Remove additional un-used table entries.
Use the exsisting compitble string for the new part.
Voltage now doesn't depend on state "online".

Angus Ainslie (Purism) (4):
  power: bq25890_charger.c: Add debugging output of failed
    initialization
  power: bq25890_charger.c: Remove unused table entries
  power: bq25890_charger.c: Add the BQ25896 part
  power: bq25890_charger.c: Read back the current battery voltage

 .../bindings/power/supply/bq25890.txt         |  3 +
 drivers/power/supply/bq25890_charger.c        | 62 ++++++++++++++-----
 2 files changed, 50 insertions(+), 15 deletions(-)

-- 
2.17.1

