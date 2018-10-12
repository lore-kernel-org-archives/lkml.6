Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F346DC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB3B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJu2CuO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB3B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbeJLXBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:01:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35338 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbeJLXBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:01:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id r191-v6so9629472lff.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=12uk6eX5VrJKHJeCHYQaElS3OIDvS7DlAyBo3dH7DQw=;
        b=OJu2CuO7V2ACkHblfz6imqThWl/akmz8DUKaKssZy6VyOrZ6aVJgbbwK/EuMm3+4Ds
         yj31eEbTV7+dEC4hlzJI5e2h3e8A8o2bpWsjBJgZHYfSA9beF/Y9yUsqHRbV86kobE50
         TXmIUQ78VIfPbDdNyepZzLr7bk8H8AlModFKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=12uk6eX5VrJKHJeCHYQaElS3OIDvS7DlAyBo3dH7DQw=;
        b=WjsEXjqH+mH31LJgDqNwc7IJVSApTtqN6uPvfvL3mfdPKRqO7Xhp82krpMN8AMXMHs
         XQSuTPPB/u02iW2Kz7c8vm4aiqBm//sdm4Gy6TZMJ/zIBhDKB+eM5G/naXZdBbvHl/iX
         hbg8UYdl7Tcg/AwtQZnHh1QzboRTJl9uo2FogKEUlrYmdf2Cle/cq9DfLH1GkMrCxGPF
         kwYWXn9qy3Q0s48yEfqAdnBY6cZ33EcZHO/hJwITRN2hm/7E5Y3JwePTcqsjfPdnBALu
         oAU+mItY5U3gskjRWpW8LlJmxmRt9UZ0mTifAexZpQoAZWfyPBNHJh8PMzftEQfZXHxp
         in/w==
X-Gm-Message-State: ABuFfojwyY0arn386t0DZXiO346XC4NNqZHzYz7wiFR9txfLDIwDbzUN
        kQbF/hUDaBP+iKYB1dxGNB62eg==
X-Google-Smtp-Source: ACcGV62PNMK6he9Kl1u5/8HpDh84dZXBmzOvake/NqfRuQoNbXU5sI9pTFaqspVrd+X0Eu647rjYGQ==
X-Received: by 2002:a19:ce01:: with SMTP id e1-v6mr4013396lfg.152.1539358099290;
        Fri, 12 Oct 2018 08:28:19 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id a63-v6sm325923ljf.54.2018.10.12.08.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 08:28:18 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 0/2] net: ethernet: ti: cpsw fix mcast packet lost
Date:   Fri, 12 Oct 2018 18:28:13 +0300
Message-Id: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset omits redundant refresh of mcast address table and
prevents mcast packet lost.

Based on net-next/master
tested on am572x evm

Ivan Khoronzhuk (2):
  net: ethernet: ti: cpsw_ale: use const for API having pointer on mac
    address
  net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode
    update

 drivers/net/ethernet/ti/cpsw.c     | 46 ++++++++++++++++++------------
 drivers/net/ethernet/ti/cpsw_ale.c | 12 ++++----
 drivers/net/ethernet/ti/cpsw_ale.h |  8 +++---
 3 files changed, 38 insertions(+), 28 deletions(-)

-- 
2.17.1

