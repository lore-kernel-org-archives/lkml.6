Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD98C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77BC23C4E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="sScaeOIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77BC23C4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934054AbeGFRjR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:39:17 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33875 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933633AbeGFRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:39:14 -0400
Received: by mail-lf0-f67.google.com with SMTP id n96-v6so10420094lfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=egIXuSyMiSPHd52WqMBdDPzbgD3tvwvzpF1A+Hn9ZG8=;
        b=sScaeOIWG9g5o3kSxodDom2hhJvfmmx6KDCAcfY/zxS6zOdKXcJPztp2cbUwA7605j
         RXTkjEQ+EAMTyStJhxOhoPmlz8FonGVl/1kkWINj19bRLWYQP1k5Mg7FpaAZONwWom0e
         9tbAro1vKlNFLAjpfGCCgOgybup9zPwu2QAckxELpvKOuBBTfKXnI9r+u8CwWOkRCr4u
         KfJsbBeLJYBwc5Xmbipsv6xZMw2ihsMsosiCIdDKomfJHKOdIWix4U/pdXcWlsuMHjsC
         cEaaQrEP4TaGGcVKFvmO+lEb8FK+jXiHWDEqf9O1zcqskp91YMGCcp2XjSGNNwWV3B0l
         SP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=egIXuSyMiSPHd52WqMBdDPzbgD3tvwvzpF1A+Hn9ZG8=;
        b=RyTPehVZyViEvwdcqtM3JhfyG8BXpq5hjcqo/VScNJ7FT224bqdP7wkRM9OZkymO4R
         uzlkBfOZSWX8qKDd/1gr8EAZN2bqfnCAinlpPWlgOAjlQdYLKtsLflT/cGkOMNTeeAiJ
         9LDREVzdadQomgvJzh9JtbOXRnLJv4CxjuCYjBs6RKVxE6epTS7RxYheHsdqXWtE46U8
         L9sKlzA5VS745SCVardQ+zH2Scxxdk1ScGJPtjqpUjzxtq8n1DzoeQsxIlRvT327RVSO
         aSB8FiU3FV9cSL+n2K7cuIT3ay+GYMJT4pdEEqQ9cI+nZzUGeQn/BxyXcGcc+wrKrLgT
         tw1g==
X-Gm-Message-State: APt69E1VYgvXltXctXU345r4cFof28oNSwbJEhep1F0W427ctMz9KbXo
        rhsNsXbri2LhyZ7BIzwQYF3vdQ==
X-Google-Smtp-Source: AAOMgpclUKJ/LyhWc+ONNmr4S6P1xHwEcMNsIp+9O9OludQCqLOqWn9KwXM2jm1IaLGOxVCHrZavFw==
X-Received: by 2002:a19:4c57:: with SMTP id z84-v6mr7853430lfa.67.1530898753284;
        Fri, 06 Jul 2018 10:39:13 -0700 (PDT)
Received: from Macroninja.cnexlabs.com (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id i69-v6sm2301662lfa.50.2018.07.06.10.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 10:39:11 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, damien.lemoal@wdc.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH 0/2] null_blk: zone support
Date:   Fri,  6 Jul 2018 19:38:37 +0200
Message-Id: <20180706173839.28355-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for exposing a zone block device using the
null_blk device driver.

The first patch moves core null_blk data structures to a shared header
file. The second implements the actual zone support. The patchset adds
two new options. One to enable the zone interface, and another to
define the size of the zones to expose.

Thanks,
Matias

Matias Bjørling (2):
  null_blk: move shared definitions to header file
  null_blk: add zone support

 Documentation/block/null_blk.txt |   7 ++
 drivers/block/Makefile           |   5 +-
 drivers/block/null_blk.c         | 124 ++++++++++++--------------------
 drivers/block/null_blk.h         | 108 ++++++++++++++++++++++++++++
 drivers/block/null_blk_zoned.c   | 149 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 315 insertions(+), 78 deletions(-)
 create mode 100644 drivers/block/null_blk.h
 create mode 100644 drivers/block/null_blk_zoned.c

-- 
2.11.0

