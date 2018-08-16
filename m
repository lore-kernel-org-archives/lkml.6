Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB06AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862C72148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="CN8sbb0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862C72148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391245AbeHPOca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 10:32:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41030 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391216AbeHPOca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 10:32:30 -0400
Received: by mail-pl0-f68.google.com with SMTP id w19-v6so1961752ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 04:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Subax9Rmkay8BJ9objlFfmUWJgRdRhAIQcj91vI4W/c=;
        b=CN8sbb0/daU5vY0+CmBCEWBN4st0EIst8kpnn5C4KVRGTWWYil4MEBTnIhjCT2T2Ib
         KtzjOLZjJAsvRdi7bpCaHkwTmnRxBt4IgOwgYCyo3TK25/iBvr+rsuFLHIiRhs0WL921
         muk4Sr0x1ASJz17jtmEO1kK3sF6ANE0NL/1TlMogXS/OisYCF1NpXJuQyb9JDwOz3Jw7
         2g6WgaqQ7AzbzrnMigK28tKIYGrUIibKXgSPLCYZu0kCz3GX7rGVsQY9aYYD3aYFRpxZ
         Eft2ar0qsV8FxqUM8GBqfoKDKu5Wds/Sgq+U3tAhOibIs8QrpuJudXt/LVm+JsSa+s71
         BNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Subax9Rmkay8BJ9objlFfmUWJgRdRhAIQcj91vI4W/c=;
        b=WDoraDV2lmvpFwnqUmFYmDNh5eXVgkZPUNFampD+3t0cL+jsoNZUuMbDPmu5LsAoVq
         sOlrcn2S5SOSzID/016+1qSiCeLe9G+uYWwKR2aJjvUMgNiBvmJkYHNPEMt2Zs6cYINA
         vuXFyFMolupgohxJAKcsfwGHIG8zefRdU5LcrjRwO6eBPOTFf6+N4QpoS0Ku92JZoy/w
         cxLPIJLsqwC5vyWCm46hgEn/a51BwIAbYlBAU0Hi+OhiS7vmdZ08bweXB7lnPFi6XnmM
         53cg0lB0JrrMRblNqDmY0fwvNw0JfWkaQTcmaMSSFTRB+aJeMCy0Ww1JGMR1d1jbCY1C
         LElw==
X-Gm-Message-State: AOUpUlE5ubWlBfrieG6c1tvXPQfqrlLI5fonZqS3fqszcVXSNhGkihgV
        lNfrZOhMY/h85JE+QsXOImuf6w==
X-Google-Smtp-Source: AA+uWPz3x3q3NJZDjqJFDMQL0SqQ2s3UrQrdGVuUK9j/3Y7elAOgthbtRmlwm32es8nCIhyGgC43Cw==
X-Received: by 2002:a17:902:3e3:: with SMTP id d90-v6mr28577027pld.12.1534419271803;
        Thu, 16 Aug 2018 04:34:31 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id d12-v6sm30022530pfn.118.2018.08.16.04.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 04:34:30 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state logic to core
Date:   Thu, 16 Aug 2018 13:34:16 +0200
Message-Id: <20180816113417.3641-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
core.

Hi Javier, I did not end up using your patch. I had misunderstood what
was implemented. Instead I implemented the detection of the each chunk by
first sensing the first page, then the last page, and if the chunk
is sensed as open, a per page scan will be executed to update the write
pointer appropriately.

Note that one needs a real drive to test the implementation. The 1.2
qemu implementation is lacking. I did update it a bit, such that
it defaults to all blocks being free. It can be picked up in the ocssd
qemu repository.

Changes since v1:

  - Add sensing of chunks wrt to free/open/closed
  - Add update of write pointer if chunk state is open

Matias Bjørling (1):
  lightnvm: move bad block and chunk state logic to core

 drivers/lightnvm/core.c      | 310 +++++++++++++++++++++++++++++++++++--------
 drivers/lightnvm/pblk-core.c |   6 +-
 drivers/lightnvm/pblk-init.c | 116 +---------------
 drivers/lightnvm/pblk.h      |   2 +-
 drivers/nvme/host/lightnvm.c |   4 +-
 include/linux/lightnvm.h     |  15 +--
 6 files changed, 266 insertions(+), 187 deletions(-)

-- 
2.11.0

