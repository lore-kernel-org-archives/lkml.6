Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0850C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E6022504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xatzw4t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E6022504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeKLXx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:53:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46778 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbeKLXx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:53:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id f23so6224174lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 06:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1xK1GmOnAf3rs8BoOhn2FjWZpcvEXMQAIIlYTRqRQaY=;
        b=Xatzw4t/ymITEICMbKpU37Mr8TmEmZkA6AKHq/21c86XlQsSl4zv+xG7IfOrlLvnhS
         FVrwZK5/qgbkNokEEiQEFe6C4NVgjWI7urV/Uo3/eLSvWfXP4LM0HcaUWA4KasK6t14O
         /1FFPBtpRjC16it0jK/Ytsmd7jX1DL0G7kPFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1xK1GmOnAf3rs8BoOhn2FjWZpcvEXMQAIIlYTRqRQaY=;
        b=Fa7OgUOBWXs2Kce9sPgvy0DKEywyD5fuRBoLDJ3vJjKoXlSFlNcMpZQ/5iUAKcPnk1
         XHj1R/SPyLYZ/FBIfQGCdGF0liWpz+dVqGNdylgXw/AF/Gvus8iJ1ZZZosbD5ZEckRP5
         OWJXPdeO23NN87woN+Z1X1MEXz16gHZ1fl0J/i+6pTtgC3E5+pkOVXkULFtNAXVDbRSd
         XZuC3w7dTLQreouLuIa3Y2TM7oE4bVadeD2WHfDbZdQVezCdYiSR2pOwtc+A6oydM5Zh
         jecL/cBvAkmeugghxQZTLV0umi8XIK+VM7p2lTmeVoRxXuowOYcZ41soIWQcq/RHkyDE
         1T0g==
X-Gm-Message-State: AGRZ1gJfIPUMzrZcXL48pQ6palUcnugDQ5h3v35flmypnt4s5tndMG4D
        bC+e6I0ZeaTgWpb9WdPYuljfNw==
X-Google-Smtp-Source: AJdET5eOHhagunoNnlLku4ku4ogwBzPVus1n/lM+0EJTwdLWnHk6ymWBMcKKba4n0C6Lj0SpysebTA==
X-Received: by 2002:a19:2c92:: with SMTP id s140mr689473lfs.42.1542031230854;
        Mon, 12 Nov 2018 06:00:30 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 26-v6sm3546387lje.18.2018.11.12.06.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 06:00:30 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 0/4] net: ethernet: ti: cpsw: allow vlan h/w timestamping
Date:   Mon, 12 Nov 2018 16:00:19 +0200
Message-Id: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds several improvements and allows vlan h/w ts.

Based on net-next/master

Ivan Khoronzhuk (4):
  net: ethernet: ti: cpts: correct debug for expired txq skb
  net: ethernet: ti: cpts: purge staled skbs from txq
  net: ethernet: ti: cpts: move enable/disable flags outside of cpts
    module
  net: ethernet: ti: cpsw: allow vlan tagged packets to be timestamped

 drivers/net/ethernet/ti/cpsw.c        | 51 ++++++++++++++-------------
 drivers/net/ethernet/ti/cpts.c        | 32 +++++++++++++----
 drivers/net/ethernet/ti/cpts.h        | 38 --------------------
 drivers/net/ethernet/ti/netcp_ethss.c | 32 +++++++++--------
 4 files changed, 69 insertions(+), 84 deletions(-)

-- 
2.17.1

