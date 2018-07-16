Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B086ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB436208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOQzkGag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB436208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeGPMDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:03:44 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:41028 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbeGPMDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:03:44 -0400
Received: by mail-lj1-f174.google.com with SMTP id y17-v6so24847197ljy.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6mCqnG+fzDj0mwIyLMWAy4x6iRCWw0glqjO4/159do0=;
        b=LOQzkGag3QaNhoCMfntUyI+Qb/KsTfHN9pCqLDxJR+Oy9jAoLwK6nlslB8o4zY7N8F
         m5VMJAcWyT3K2hcdcvlrmDqeQDt+gOYCxrlZ/j4mVU7nw8gS2URkpx0Hx7iq+zIr8rqx
         w9Cha1ICCF0ZrkeaZqiUUyg3fqvaP2U9ZvOUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6mCqnG+fzDj0mwIyLMWAy4x6iRCWw0glqjO4/159do0=;
        b=GI+q+W2TTF5yjz/3Q8SYJ/5zpQVRh+I0HZfmt2YA++hdxMerqjD8BldA+MhDHzC7Th
         L1xuOs3BDInUqjMdlWXOP/HXGKds6XAY9WH6cBfitLuZv74P9g84AJ2/WgKNfydLrUts
         K+whHO/6eSxgFWSZ15WTPURS7oHeZKOPFfUW41P/24ztSaxORA1NZA8P37yWlp6TpSh/
         s6L+DdFNKc/lShyQ8sonuZ3MNwEYuM3Z1QawVU+P/d331gSDWjKQdwRWlep1no16aq1u
         xIYhilLZw93B7iA7e8n2cfqTNlPwdvXhh/4huWyE2ng+dxC56QMaWYsz4YP5sl4W0imR
         3p5A==
X-Gm-Message-State: AOUpUlHdDo1Ptkr/FhQZDT9iasyuLzuXGW3GCX66aQ1hZ7j0vcTVmN1x
        xQyAiXlWNmVki5GYl6oJ20P/NA==
X-Google-Smtp-Source: AAOMgpfrO7vw/i/o5SeCic4M8cMKWZ67fsUpHTFa7X3lPwmE2WskdsfKjhhsG6Az8PG4pTwAU3oR6g==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26-v6mr10388537lja.149.1531741001799;
        Mon, 16 Jul 2018 04:36:41 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id v136-v6sm8104913lfa.10.2018.07.16.04.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 04:36:41 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH 0/4] regulator: qcom_spmi: fix Bad of_node_put() splat
Date:   Mon, 16 Jul 2018 13:35:21 +0200
Message-Id: <20180716113525.9335-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Bad_of_node_put() splat, and some minor checkpatch issues.

Niklas Cassel (4):
  regulator: qcom_spmi: Fix warning Bad of_node_put()
  regulator: qcom_spmi: Use correct regmap when checking for error
  regulator: qcom_spmi: Do not initialise static to NULL
  regulator: qcom_spmi: Indent with tabs instead of spaces

 drivers/regulator/qcom_spmi-regulator.c | 48 +++++++++++++++++--------
 1 file changed, 33 insertions(+), 15 deletions(-)

-- 
2.17.1

