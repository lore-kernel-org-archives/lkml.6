Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8075C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662CE2609E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYhVklP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662CE2609E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965038AbeFYTzw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:55:52 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43646 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964869AbeFYTzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:55:50 -0400
Received: by mail-wr0-f193.google.com with SMTP id c5-v6so3704662wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8JsplwdCGInDqyNOJNSReCPhLS4ecB0lWAL0Ojz4pi4=;
        b=JYhVklP7EAzrkDQemMxG0gXS97KTOMHqYUaY5kXWTO1MjUshOamsuhGbJn50wtITyZ
         kzsqSpNJFZsx5Ld1g8ley7HSC5e4QpR3Cat05YAEHmYPP8oACF/stpw7GCB6DIHazVn+
         fbMdW8x5uWNo5sUxO9qNFIvhPnQrbB9l0X1r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8JsplwdCGInDqyNOJNSReCPhLS4ecB0lWAL0Ojz4pi4=;
        b=SFB5WAa41LFv0X8lNvwaX7DNJ+02MxSybpkrAHv4xud8zRtPkQezoMt/PNH0FeYgtO
         5V7alKqCgiKrYBteW/Mzw+wnM0jngMvcFb4PUSSlD0VOemULFXJBKK0tZTx15T0rfsJB
         ywYhTlrbm0chvnTM8q+reQkJL9GTaJm54Xhioe+yoZY85GSxgI9dDbSfFXLezYOVisio
         +OwyFuV7T9hHAHkXTT4y54u/uSWtR+a/IettvXl0izTF5azLXroic1ZHrcYWzE9SEJBp
         5QiA34uIhPZjY3uUCuqP2DCt9ORRI5wOZy+tu4YKv8CH2+LTvaOu831vI6noBChF+3em
         2QMA==
X-Gm-Message-State: APt69E3eLu+FcG/X6+Ka5ulccu9/nA0gyk85m8UJX/0EzEMcwXGq7Fu2
        5jB7S9Wo2aZ8SbdpcMSkDr+1c1E+EhM=
X-Google-Smtp-Source: AAOMgpdkkPVb1w0yeDdiSUC/X0TmkdCOZOaYL9vP2WiDOxBCEIVNRNOyeo29FKLVnGywtkxEIjzRoA==
X-Received: by 2002:a5d:4049:: with SMTP id w9-v6mr11475753wrp.96.1529956549549;
        Mon, 25 Jun 2018 12:55:49 -0700 (PDT)
Received: from localhost.localdomain (146-241-36-97.dyn.eolo.it. [146.241.36.97])
        by smtp.gmail.com with ESMTPSA id n18-v6sm29072897wrj.58.2018.06.25.12.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:55:48 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX RESEND 0/4] bfq: fix bugs breaking bandwidth guarantees occasionally
Date:   Mon, 25 Jun 2018 21:55:33 +0200
Message-Id: <20180625195537.7769-1-paolo.valente@linaro.org>
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
  block, bfq: give a better name to bfq_bfqq_may_idle

 block/bfq-iosched.c | 131 +++++++++++++++++++++++++++++++++++++++++++---------
 block/bfq-iosched.h |   7 ++-
 block/bfq-wf2q.c    |  30 ++++++------
 3 files changed, 128 insertions(+), 40 deletions(-)

--
2.16.1
