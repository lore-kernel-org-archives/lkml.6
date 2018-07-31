Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07D3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A081C20840
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A081C20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbeGaDP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:15:27 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33841 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeGaDP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:15:27 -0400
Received: by mail-yw0-f193.google.com with SMTP id j68-v6so5157355ywg.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 18:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1zSy6rN01vLWst7hzSsQZDmaeeU7ekWlXFMRZKI0qBw=;
        b=TiY9NLM4CfukMJLaUB+NUGGmkmy2RnaQekX8vuZMjvBXKOewkurBdndHLHu5qezy4s
         OvqFKKhs43G1WIBvvZ3irWuHu4GeG3Modh5zrR0aG7w53zXgVl3+Z09GA2ka5BLmhHR8
         A69N9CtycQCYezKwv2YslFu6eumGTqtO2bmN4KRNvwJnaV3MP5qh9hDS1XJXWN6PFcyN
         mBMqO5Eu/6uoIJwcMS3utL4BeS/CeyaUmQ5CRDVpnwuB3I9sZY3hOSTl8B7bqS62pDOT
         czh/904kDp/4bJ8iIh1rWo1iPiX81nMBm6ZwDpqODm4CoCOwkopmBrqBw4qz1tkF9RW4
         61jA==
X-Gm-Message-State: AOUpUlHFVOg9zjN1a+jBfqhOE9j5EQh87AxI/KUGc2O8SMsKY/KsPC+I
        KA6lALJw3VjHVxIeyv/KcN+S+g==
X-Google-Smtp-Source: AAOMgpdF/DnMEp2TLdm4poEwkEyXA39y8Jk2HUhuS6SfMzI3GWScq5wSrfDUwgwiICga73lZiA/e4A==
X-Received: by 2002:a0d:c744:: with SMTP id j65-v6mr10005168ywd.484.1533001061481;
        Mon, 30 Jul 2018 18:37:41 -0700 (PDT)
Received: from builder.jcline.org ([2605:a601:80ce:4700:77a5:8983:ea8b:82ec])
        by smtp.gmail.com with ESMTPSA id y133-v6sm13800287ywy.31.2018.07.30.18.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 18:37:41 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH 0/2] fs/quota: Fix potential spectre v1 gadgets
Date:   Tue, 31 Jul 2018 01:37:29 +0000
Message-Id: <20180731013731.1987-1-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This series unifies XQM_MAXQUOTAS with MAXQUOTAS, which were both being
used to perform bounds checks on arrays, and then sanitizes 'type' so it
can't be used in speculative out-of-bounds array access.

Jeremy Cline (2):
  fs/quota: Replace XQM_MAXQUOTAS usage with MAXQUOTAS
  fs/quota: Fix spectre gadget in do_quotactl

 fs/quota/quota.c               | 14 +++++++-------
 include/linux/quota.h          |  8 +-------
 include/uapi/linux/dqblk_xfs.h |  5 -----
 3 files changed, 8 insertions(+), 19 deletions(-)

-- 
2.17.1

