Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E7AC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7D721976
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdgLIZhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7D721976
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389988AbeHGSLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:11:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35226 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHGSLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:11:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id g1-v6so12777908wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 08:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2TFYbOxEyTGP3emB8vz1gsYGmJp+Lil1MzQeCdvXZgo=;
        b=jdgLIZhpn6PCRyXo5wGT0hK3D6GBowR8gRbXJkXoQOoV8pQeWyfmqLVI/HNAqrZZjw
         QWIuTmPjokzuuaqWWSjeeR6AiUNFqNqHMWMqbQadLp7M5GUU7t8gUXmTg4u4tPrTezRG
         krRZB1X+BSAomnEboW1kOuhpS6hg5g2s2nbWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2TFYbOxEyTGP3emB8vz1gsYGmJp+Lil1MzQeCdvXZgo=;
        b=jB4D3TJX9UICjEDug+wM7rLgDRxHJ3O6fen+/8Ss8CrR2o3lz6a3OtH4jClZsJ5FXw
         Ifhq3oaBMMLvEfMZ2gGPa+Zioe82tuo4gvQuy2dH0zPGGBJNKag2ZbR3z9zV95sRLqaB
         zrH5Lic6nhWwPhh9EOP6RwkL/iNGk1OmUM9BM4sS7KK1stD32e8iq3OlL7m5CAUOb2g+
         A/knifPbD3CasoDeXAn7+MRgKhsaUBqVg0zXoyEuiNF0S71d7L2rpLmmez0hKxymH4hg
         Bxb2NpMragB+Sx4jiTqakmz2gEJ448nUh50B5ziQUpfbiu/1GLuZTwzdS+qE+Jvjt7H8
         V99Q==
X-Gm-Message-State: AOUpUlG0HKQcbRXpCO1IQ6ICyU+wrK9h6i4xE3BMCZNImjVAO3MguQGT
        t1pmaff78Uu1MGA6SwYP8rE/SA==
X-Google-Smtp-Source: AAOMgpdltDixPLc5yDBufl0Xw8QRIiHLYDKmWQlGOH6zgp9+eB5jNpP7nSVXtl2xty3yddE4+ypz1A==
X-Received: by 2002:adf:e287:: with SMTP id v7-v6mr13861639wri.139.1533657393526;
        Tue, 07 Aug 2018 08:56:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:41ad:95bb:4cb8:621f])
        by smtp.gmail.com with ESMTPSA id y203-v6sm2903644wmd.1.2018.08.07.08.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 08:56:32 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/3] sched/fair: some fixes for asym_packing
Date:   Tue,  7 Aug 2018 17:56:24 +0200
Message-Id: <1533657387-29039-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the review of misfit task patchset, Morten and Valentin raised some
problems with the use of SD_ASYM_PACKING flag on asymetric system like
hikey960 arm64 big/LITTLE platform. The study of the use cases has shown
some problems that can happen for every systems that use the flag.

The 3 patches fixes the problems raised for lmbench and the rt-app UC that
creates 2 tasks that start as small tasks and then become suddenly always
running tasks. (I can provide the rt-app json isf needed)

Vincent Guittot (3):
  sched/fair: fix rounding issue for asym packing
  sched/fair: trigger asym_packing during idle load balance
  sched/fair: fix unnecessary increase of balance interval

 kernel/sched/fair.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

-- 
2.7.4

