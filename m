Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE4EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50632147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iffd9PWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50632147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeHPX3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:29:43 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38641 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeHPX3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:29:42 -0400
Received: by mail-pl0-f68.google.com with SMTP id u11-v6so2623303plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOFb+W4aN97wG4auHV8JFPffHbun2m7FWDAxUHXcIHw=;
        b=Iffd9PWl6aGcQTMimiwnu86TPNFZw/pJLjh3Sfxz0JSfgxZyHLOMs5M9PpO13BL60d
         EcU7dWn7X8Ef5zk3KxIVAFMBAV1n1njdwX6oQezGnmfEbr37MgNYzEenysaKRzgLkUKo
         Y20OkETjWE1iNQcURK8eA9dyS7xE9QqPD/VZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOFb+W4aN97wG4auHV8JFPffHbun2m7FWDAxUHXcIHw=;
        b=tLN1yBjQ4fJHuehUK1Z2LVd+a31rdw/odDKxuAmwMyRp4tFVN2b5vlskyqfNf3o+lM
         PfoogUDmDI7282I9MqkF4O9o70MNd0sfjZduqen9UGWukhgypDQJoSLJ1oF/Wcm25+/q
         9rpYwLrdnNRiOfzVEYcwA8migsUJ0u2bcYuf4+6IUGFSUNtm8JLqcV69W+okVm1Th70n
         ObW3AZDx9Z4Htxswrwrm9zhkZgreLfxWIeYtEyUY2YlF0BJyhx67AKpvUlGuYz6fFmC6
         HRzOtdCMLi5Ab3n8FgZ8wWki9o3JDS18dACgCeXQJ01YDSJ3pAYZHg10C+4uben+XF6Z
         uAiA==
X-Gm-Message-State: AOUpUlGE45AMUCpjlX1GOF77Ciw98Ysn/Ut4JeebPmrduUHFaEft+9+E
        iT6ATzE9kfFxefktOe9gLp7MFw==
X-Google-Smtp-Source: AA+uWPx92Ihntq/ruZVtfcLH/ZYZz9PZ4Q801G5evJ20Hq42vlauVh6DxTmlM/Yd0cSEb1VHCVoNnA==
X-Received: by 2002:a17:902:aa07:: with SMTP id be7-v6mr30020703plb.109.1534451333988;
        Thu, 16 Aug 2018 13:28:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id t76-v6sm209647pfe.109.2018.08.16.13.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 13:28:53 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        collinsd@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] regulator: core: Improve regulator_summary
Date:   Thu, 16 Aug 2018 13:28:00 -0700
Message-Id: <20180816202803.250079-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches in this series are useful for those who want to
see the load requested by regulator consumers and also what opmode
they're running in (these two concepts are sometimes linked).

The third patch adds some missing locking for regulator_summary.

All three patches could be applied separately but some rebasing would
be required since the patches touch much of the same code.

Changes in v2:
- No longer consider consumers that don't call regulator_set_load().

Douglas Anderson (3):
  regulator: core: Add the opmode to regulator_summary
  regulator: core: Add consumer-requested load in regulator_summary
  regulator: core: Add locking to debugfs regulator_summary

 drivers/regulator/core.c | 78 ++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 30 deletions(-)

-- 
2.18.0.865.gffc8e1a3cd6-goog

