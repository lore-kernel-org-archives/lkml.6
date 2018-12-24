Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5287C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EC72171F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="If4Fki+f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XaxtLHME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbeLXJC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:02:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55190 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbeLXJC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:02:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 82504608CB; Mon, 24 Dec 2018 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545642147;
        bh=ARkw0UyVva+HQF45urB7dPlLF1OqEeTe9mZXYxZFc/s=;
        h=From:To:Cc:Subject:Date:From;
        b=If4Fki+fk7I0Ca4u9xxgrwwMAo9oKH18Um1C0cvgZcR41eRguq5NLF5b19zhdMlew
         bH8kcQCQyo2IDFkgGqGzXHYTd1ooQAuOWGnj49jfXubxyLqwok9HL18vlQG79DGUQy
         1a8GjRKkGmlAUHJXN1e8ZSuiJb4tMaDlzRcB+oY0=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37894602CB;
        Mon, 24 Dec 2018 09:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545642146;
        bh=ARkw0UyVva+HQF45urB7dPlLF1OqEeTe9mZXYxZFc/s=;
        h=From:To:Cc:Subject:Date:From;
        b=XaxtLHME6Ls6tj/f0R3xO6L8w3UAjt9gCmtQp8FmEzvSxBaVxwWvIp5WfO3g97bup
         3B3/jlLgIB3MqJT04ui2R9GPyvR3jj1kL5ydhxXvDtvA2Y6zhLI5imH2oxazCnbppY
         LiPykUhP8fzjnUBivPp10r6FXwYA4LdkGaZ54sog=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37894602CB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org,
        asishb@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 0/2] ASoC: soc-core: add snd_soc_of_lookup_component()
Date:   Mon, 24 Dec 2018 14:32:11 +0530
Message-Id: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform DAI component probe is not called if it is not
present in component list during sound card registration.
Add snd_soc_of_lookup_component() to get component info from
device_node. This can be used by machine driver to make sure that
card components are registered before calling snd_soc_register_card().


Ajit Pandey (2):
  ASoC: soc-core: add snd_soc_of_lookup_component()
  ASoC: qcom: defer probe if platform dai is not registered

 include/sound/soc.h     |  1 +
 sound/soc/qcom/common.c |  9 +++++++++
 sound/soc/soc-core.c    | 28 ++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

