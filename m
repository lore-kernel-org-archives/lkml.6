Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFA6C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A13D205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A13D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbeG0Rrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:47:45 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34835 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730771AbeG0Rrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:47:45 -0400
Received: by mail-qt0-f195.google.com with SMTP id a5-v6so5623091qtp.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 09:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e3ebDUbeMV/L8Kj2OXFdbYyc+uWSGH8FYi4GQaMyx1s=;
        b=ecPQf9OuUuoa5owjuZrykv9A7JU3lWGGYNVqaByKPQApWYOuL4a7A/iCHbLflXVYZr
         /SDvFZYqzIPeeVo0Oe+K7rir9XCNppb6/ja/Ee4qxSzlLkLmojNsfRKp1fskCGSm014w
         BWPaGepnFP53+18wn/eg0LtxgUYy7KLj0iXZf9O9lJVZnkSLpEks0gK7NdgCLjd6TkZx
         RYkU9UU7+arqLcL6BTtL15ZaRtY1kDuKqjlpCERa100F355cICk/sOb0rkkinx/W2/UM
         6ypOrpZvZ9L35X0etx6dNOClVXasqcnWqTx2nA4aEwupw32EjgrqctEvUmpbt2de9/W0
         NEpw==
X-Gm-Message-State: AOUpUlEVm5oCmDqHd2SfSGTEpr9G2E2ueA9tIDIr7kl/rD5gTTND7a2q
        NBCjTCOaRQHUrvVBRRuuIGG9o53JVyU=
X-Google-Smtp-Source: AAOMgpcoJ+cEkS7AS2tMA8sG/6MV/lSLWKs0jBRFHTR58dWe7hZYilrbc1cnbh0aogo8SRDnODqEqg==
X-Received: by 2002:ac8:13c3:: with SMTP id i3-v6mr6836650qtj.54.1532708707422;
        Fri, 27 Jul 2018 09:25:07 -0700 (PDT)
Received: from builder.jcline.org.com ([2605:a601:80ce:4700:77a5:8983:ea8b:82ec])
        by smtp.gmail.com with ESMTPSA id s73-v6sm3137342qkl.65.2018.07.27.09.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 09:25:06 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>
Subject: [PATCH 0/3] ext4: fix spectre v1 gadgets
Date:   Fri, 27 Jul 2018 16:23:54 +0000
Message-Id: <20180727162357.30801-1-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This patch set fixes a few Spectre v1 gadgets in ext4 detected with the
help of Smatch.

Note that because the speculation window is large, the policy is to stop
the speculative out-of-bounds load and not worry if the attack can be
completed with a dependent load or store[0].

[0] https://marc.info/?l=linux-kernel&m=152449131114778

Jeremy Cline (3):
  ext4: super: Fix spectre gadget in ext4_quota_on
  ext4: super: Fix spectre gadgets in ext4_quota_{read,write,off}
  ext4: mballoc: Fix spectre gadget in ext4_mb_simple_scan_group

 fs/ext4/mballoc.c |  2 ++
 fs/ext4/super.c   | 20 ++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.17.1

