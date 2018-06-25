Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF4EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E46926089
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWJdEMlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E46926089
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755677AbeFYTsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:48:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33320 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755600AbeFYTsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:48:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id l23-v6so3483556edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gjlQ8+456ljOWKGroBtAa5LO0SGekXvVSi81l9uCRmc=;
        b=PWJdEMlxf8dwDoF3pxCQbJ2CCLR9PGLJXykJ8SGV2sTzDdKDwy53hfK0zdAsAndtnF
         qBvcW76tt75p7LAJ9RC/aTQ10d2e3snVhJnpTZ6Awxr0qxaj9UM/LUWV/W2mODWjyA5j
         hmpNIN4c7sZg+CN4fCMeFGNsGzWtu3Wn+iL0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gjlQ8+456ljOWKGroBtAa5LO0SGekXvVSi81l9uCRmc=;
        b=otL4YZO7qWt32DSaMl91FNeR0SvOrH3ufpcY9LtEdor5Ie6Uv1ugMPDY3HNN6yq5SZ
         i3BfQaJFCqJQVGgrbu/D0O9u3SK/DHEUr7ixeqSKJcLymJjEpCc+7+gxvzSULNGHduqR
         2ei3LP9ZiZX29GEKCreVzZncDJQTToij0mTwTH2pv8wYFdMJx95jR7TsHOfctiExZClM
         72xmS5gCv7V9WZAet2rj4ga4Ast0vMfH84w1nzagHR9PwZ4Qp3EBY5bfCWSFFflOO/oG
         wKHsinrfEPiBIbbrTzrp2xyE5M1gLabVe/mhoCaHFwG7m1oFF/DXdFbFGNv9jYzpCtfV
         OfLg==
X-Gm-Message-State: APt69E3S0bkxspXz9RqNMcc1FnUsxIiQnPilBUriPwlhRoH3j0GsH1Ur
        sk9rAW+xohjYEPWvMvodRbuqvQ==
X-Google-Smtp-Source: ADUXVKIVnYIj0/g4Pwghw/lQPnS6LKItxDpL7UXU0sLOrL2IR8uPg9vdfGXwfxnXDP+ER6c4d1mvsA==
X-Received: by 2002:a50:9286:: with SMTP id k6-v6mr5813882eda.66.1529956099749;
        Mon, 25 Jun 2018 12:48:19 -0700 (PDT)
Received: from localhost.localdomain (146-241-36-97.dyn.eolo.it. [146.241.36.97])
        by smtp.gmail.com with ESMTPSA id d11-v6sm17553edh.61.2018.06.25.12.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:48:18 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/4] bfq: fix bugs breaking bandwidth guarantees occasionally
Date:   Mon, 25 Jun 2018 21:48:02 +0200
Message-Id: <20180625194806.7619-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
during some bandwidth tests, I found some occasional but severe
malfunctions (losses of bandwidth control). The first three patches in
this series fix the bugs that caused these malfunctions. The last
patch is a fix/improvement of the name of one of the functions
involved with these bugs.

I guess these patches are appropriate for next kernel release.

Thanks,
Paolo

Paolo Valente (4):
  block, bfq: add/remove entity weights correctly
  block, bfq: do not expire a queue that will deserve dispatch plugging
  block, bfq: fix service being wrongly set to zero in case of
    preemption
  block, bfq: fix service being wrongly set to zero in case of
    preemption

 block/bfq-iosched.c | 131 +++++++++++++++++++++++++++++++++++++++++++---------
 block/bfq-iosched.h |   7 ++-
 block/bfq-wf2q.c    |  30 ++++++------
 3 files changed, 128 insertions(+), 40 deletions(-)

--
2.16.1
