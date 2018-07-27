Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F88C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B0B20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B0B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388986AbeG1AIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:08:11 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43305 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388668AbeG1AIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:08:10 -0400
Received: by mail-qt0-f194.google.com with SMTP id f18-v6so6687549qtp.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 15:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yNUN47lKpvHq+FINBIiaH90BLsZAxxYvxgH2DYUpisM=;
        b=kCNUrdTOG4FC9Mh6jLWbfpYy28EIuAtfsS8dwPpo9nusmllbRrIg0TF9aE7hn7s1Oj
         uOUTP426WVNmLe1/HyI2xT13usxyQIwxmVWqZS+9/GdK5s3/mLSLRbNIl6tPjswYbu2C
         6oYQWJ/ZMhuW7puVfRdoDE45TNqjuJoxxgGzIY8WH403zLeiLIZ2xYqR/v4uVK+goYo0
         0or1oV+E3h2m7SuftH/ppG6oWPn4ICLthtx7edvkvGiwJYZBzqOCet5sTjtYoQAxqCAj
         CA2Z+IgC+h9QYi1wqgaPB4uUglKRFTtkSnW9ao/LIn/pcilnB6yjLn1KA7JUFjWUlX+m
         TnfA==
X-Gm-Message-State: AOUpUlHxcwZ7ojN8wrW1jKM3gg7BrX28udENZjYzl8RueJ8cpsGns/sK
        ILVbxwFU1tHzzzVsDgnKtqbdnA==
X-Google-Smtp-Source: AAOMgpdQgr5WeeUOAxwNIBiLfH2KZpm3rjU1LFppu6dgBHfHj2y4Gs+mdBfRBlogBulRu6VdSBm4rw==
X-Received: by 2002:aed:3d95:: with SMTP id i21-v6mr8120386qtf.232.1532731451043;
        Fri, 27 Jul 2018 15:44:11 -0700 (PDT)
Received: from builder.jcline.org.com ([2605:a601:80ce:4700:77a5:8983:ea8b:82ec])
        by smtp.gmail.com with ESMTPSA id g39-v6sm4145984qtb.47.2018.07.27.15.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 15:44:10 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH 0/2] net: socket: Fix potential spectre v1 gadgets
Date:   Fri, 27 Jul 2018 22:43:00 +0000
Message-Id: <20180727224302.5503-1-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This fixes a pair of potential spectre v1 gadgets.

Note that because the speculation window is large, the policy is to stop
the speculative out-of-bounds load and not worry if the attack can be
completed with a dependent load or store[0].

[0] https://marc.info/?l=linux-kernel&m=152449131114778

Jeremy Cline (2):
  net: socket: fix potential spectre v1 gadget in socketcall
  net: socket: Fix potential spectre v1 gadget in sock_is_registered

 net/socket.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.17.1

