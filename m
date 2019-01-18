Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E267C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DAB20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ih8IquNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfARLwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:52:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55307 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfARLwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:52:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so4202046wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 03:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeMLuAiaL8DBaAYq8DMslzU3bn8IjC2Xka68ZCyd56E=;
        b=ih8IquNqAfrk14DWOz2OiY2RQ6AwwLSixsLYzimOXxuUU0W1g7BSZ46Fm0txNIdtjv
         tANtbBOF892wJwzfxNpkYPVQXKD1aRpsf16PMIWI7iCm8+8AsPDf5+Nd8SxkWb0HPDop
         5niSZjviopzAJBGLVaYbMi4L43WNaHnrIIinM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeMLuAiaL8DBaAYq8DMslzU3bn8IjC2Xka68ZCyd56E=;
        b=B26zw4jT06sneulZTLMnisVGGUAgb/WV6kNIEvbRBAzULWGc2S70ybKT2iXc0KMHiv
         ArkAxqskZxqek8n+o3dyM71LINemcxVafe459Vxod2K6A/TAvXdRDFWjHEhmX4AZvaeX
         G0EM3gZrcZIaSZk0L2nBz2MAO9r5JnknlJ7Faeo4Y6Yamx1cDwN4wx/EozdzjqGi9hHi
         x9uYrvOM/7181S1k1F16HhsVPPHtgi5fP1MOZhDIJN0KJnFJSV4haJ7Pkv+LpPZoE1LC
         KlYf1UD+DpWK5FjGBs7kAxwCJjbPqO89l4xIUexAeZAWUUPfj/jXNiX2AlXx4y6qfssr
         8oMA==
X-Gm-Message-State: AJcUukerrAqUETVty1lX92KLspiH6jFszovZlwiN4AvL5lmBXnRYMqVW
        R8guHH+zSMoKRsTlZr+tERDO/g==
X-Google-Smtp-Source: ALg8bN4QXTXgkTNHhewR2dQ7pT3mDoCnbhE6GERX8Li8/bnAjRgsXP1UY614jH+cpTPnWoJ1MCyoNg==
X-Received: by 2002:a1c:7616:: with SMTP id r22mr15426157wmc.35.1547812353086;
        Fri, 18 Jan 2019 03:52:33 -0800 (PST)
Received: from localhost.localdomain (146-241-71-93.dyn.eolo.it. [146.241.71.93])
        by smtp.gmail.com with ESMTPSA id i13sm75183049wrw.32.2019.01.18.03.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 03:52:32 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, hurikhan77+bko@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX RFC 0/2] reverting two commits causing freezes
Date:   Fri, 18 Jan 2019 12:52:17 +0100
Message-Id: <20190118115219.63576-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
a user reported a warning, followed by freezes, in case he increases
nr_requests to more than 64 [1]. After reproducing the issues, I
reverted the commit f0635b8a416e ("bfq: calculate shallow depths at
init time"), plus the related commit bd7d4ef6a4c9 ("bfq-iosched:
remove unused variable"). The problem went away.

Maybe the assumption in commit f0635b8a416e ("bfq: calculate shallow
depths at init time") does not hold true?

Thanks,
Paolo

[1] https://bugzilla.kernel.org/show_bug.cgi?id=200813

Paolo Valente (2):
  Revert "bfq-iosched: remove unused variable"
  Revert "bfq: calculate shallow depths at init time"

 block/bfq-iosched.c | 116 ++++++++++++++++++++++----------------------
 block/bfq-iosched.h |   6 +++
 2 files changed, 63 insertions(+), 59 deletions(-)

--
2.20.1
