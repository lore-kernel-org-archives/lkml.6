Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC50C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39BB223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDFftD9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39BB223F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeHJPRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:17:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44814 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJPRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:17:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so7043001ljq.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=htSpdVGJsmH7KfuS7fkJXAaW0H62C2tNvDGdP1fNSQc=;
        b=FDFftD9pojWlAiCHVQ4E8Z38b8oCa0BuFQJ79WGlLC1+0bK2pgx/oL4ArwSMqIs+Rh
         HCfo/QWTE4ZR6K4oZxJwExhUY8CfGtMdu8GqibY/fGo7J36W0wZOVg/NdQP525WXFuEs
         0lZTI22InnE3NqMxIUIYYL9Y4XqWXQjYUu7/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=htSpdVGJsmH7KfuS7fkJXAaW0H62C2tNvDGdP1fNSQc=;
        b=IOoqJEUs1ASKpgmMQT+IB3lQkoCcf0WKDfjR89+KDJuey/F6rZeniNkvs6X/2zux+L
         vO9XdHt/aXM4RytiCJhOEA4l4vJOxY0iO7UGMiJ3oz0+jz4JlLEc4ASilf7JXwSzEgc8
         +grDSEwVFq8fTLyhhn6DJtuzY95JcmwLncuyDMA8GTBLj1EGK9GGc4zMMqnm13j7ay7P
         Xf89uYtgmdSz8cNKAqjDjr6+PRj4209ZKEWy/7XADSc3dp93wC/hwEWVWKqP6MqTpuVS
         n5c0tqGXF8Jim7VPIb003blHwTkhiO2vslKGgTDrc877/m/nvDJgQuGsXG1LNec+R3M/
         YChw==
X-Gm-Message-State: AOUpUlEbVK9FWTL0S0RPZdXsyzPzbP36uYstnXS7kVZv0XL9MttVvtzz
        X1FoODsZtCdhzY4YrGBCuCXx+A==
X-Google-Smtp-Source: AA+uWPzXX5xuIbugbo888VRvl5lGuDxNy4iP38i4SIePd4TaIFOP6tMpDduG5SafACuh91BMeZV2kw==
X-Received: by 2002:a2e:4186:: with SMTP id d6-v6mr4554617ljf.36.1533905240101;
        Fri, 10 Aug 2018 05:47:20 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 84-v6sm1626382lje.48.2018.08.10.05.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 05:47:19 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 0/2] net: ethernet: ti: cpsw: fix runtime pm while add/del reserved vid
Date:   Fri, 10 Aug 2018 15:47:07 +0300
Message-Id: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here 2 not critical fixes for:
- vlan ale table leak while error if deleting vlan (simplifies next fix)
- runtime pm while try to set reserved vlan

Based on net/master

Ivan Khoronzhuk (2):
  net: ethernet: ti: cpsw: clear all entries when delete vid
  net: ethernet: ti: cpsw: fix runtime_pm while add/kill vlan

 drivers/net/ethernet/ti/cpsw.c     | 25 +++++++++++--------------
 drivers/net/ethernet/ti/cpsw_ale.c |  2 +-
 2 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.17.1

