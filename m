Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13307C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EB420895
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="sQzjOm0c";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="SE70skzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EB420895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbeGYVAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:00:06 -0400
Received: from node.akkea.ca ([192.155.83.177]:60902 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbeGYVAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:00:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 4D3DA54204E;
        Wed, 25 Jul 2018 19:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1532548018; bh=GE9rqRy1ux4BfjkLCjcHo5gobLNjE/s+4eFMfSqJeqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=sQzjOm0cf6T/yXwGE727I4uQLn62IIdLu4GtU+2CK+ghhsRMPCSo47vQBr48HbMrr
         i1YOfM1B6bNHidqv+ezBjzwIdTq7ScSU6x4a4RaaxT5tySEDA/WrP3GWEtLr5fIAu8
         BPDNoMVrSLt8j5AlQ8nLyDlGAM1LYmqnBD72pn5Y=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id btsJnV3-36LC; Wed, 25 Jul 2018 19:46:58 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.cg.shawcable.net [68.144.56.170])
        by node.akkea.ca (Postfix) with ESMTPSA id 82DF254204A;
        Wed, 25 Jul 2018 19:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1532548017; bh=GE9rqRy1ux4BfjkLCjcHo5gobLNjE/s+4eFMfSqJeqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SE70skzXXSAwQpu2z9zNOW15WjoxLERMDC2jF0yVjuEDTWpeIdXW74Pq8s5B2Joo1
         P4fcxowCP5u4OMWxJVGBgD1wFG45al3l1+PlAROXUAhBp6BC3owmW2wAY11zqCipy9
         EOvQ8/uZvezIZaIc5n+6LrDOo33d+OJlP5/5rqlw=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 0/4] Add the BQ25896 charger IC
Date:   Wed, 25 Jul 2018 13:46:26 -0600
Message-Id: <20180725194630.10414-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revised patch set based on review comments

Angus Ainslie (Purism) (4):
  power: bq25890_charger.c: Add debugging output of failed
    initialization
  power: bq25890_charger.c: Remove unused table
  power: bq25890_charger.c: Add the BQ25896 part
  power: bq25890_charger.c: Read back the current battery voltage

 .../bindings/power/supply/bq25890.txt         |  1 +
 drivers/power/supply/bq25890_charger.c        | 65 +++++++++++++++----
 2 files changed, 54 insertions(+), 12 deletions(-)

-- 
2.17.1

