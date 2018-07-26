Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DF7C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD2E20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD2E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeGZDBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:01:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38288 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbeGZDBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:01:10 -0400
Received: from mail-qk0-f198.google.com ([209.85.220.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <mfo@canonical.com>)
        id 1fiVMa-0005eb-SJ
        for linux-kernel@vger.kernel.org; Thu, 26 Jul 2018 01:46:44 +0000
Received: by mail-qk0-f198.google.com with SMTP id 123-v6so108341qkg.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 18:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PNY0B9IyhhiL28HuhMKOb8iglpjyDho04O5nul2q/+4=;
        b=jo14kiWy3brSlUlo6U92tmbI/OxFYAt4jJjbZv/Gyk2k0X9jMOYN9f9DZne5lXMvhy
         3Vf06xhvGfhV5fm+nB/xMC0iarAAN5hh+2L+Nl0N0mJRlyNUrhPj4Gro7f9i65SBXUsu
         e+3fsWKNOjPPLmCXMz0/PDunAK1l8PzQOXthIQtmVO8Je/rG/AxJ+b+B7ESC6SYSKUbo
         hfP3B4vIXDuvEAbCIOltAE3GEF5MS2ngshqVrlMzvyK1t89MsPl1ifmUpOAd/2YNznug
         DJGvih8zU/kW22aToLAMmctT8IKjF60Mte2tEBPlogjQOq472OGaF4WTxnkx/Oh0KqCv
         wCyw==
X-Gm-Message-State: AOUpUlG6GNWWx6NavNClOJE9bL7btdXojGylKewOUZ9dLvWRXuXKnLq4
        uhicTIHrJQeGwvLmhoZof2awUyW4S1cSstfX4tHpv9wlvmwkc5RuWXdncMVE19zcV5GFRpK9RjA
        eAAEL4QAUphgSEDrtGpiWiTExtaN2OWSNopt+9SAlAw==
X-Received: by 2002:ac8:42b:: with SMTP id v43-v6mr21938751qtg.319.1532569604107;
        Wed, 25 Jul 2018 18:46:44 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpc+XRIc8ESPZ386qmgfKcub2hymdgewhx9NAc973CK9XTDReXz4vJf+Swv4YpeCGgBM1Gvyjw==
X-Received: by 2002:ac8:42b:: with SMTP id v43-v6mr21938747qtg.319.1532569603976;
        Wed, 25 Jul 2018 18:46:43 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:77dd:8111:28ad:fd9c:9a4d])
        by smtp.gmail.com with ESMTPSA id r4-v6sm19619qtm.10.2018.07.25.18.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 18:46:43 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     axboe@kernel.dk
Cc:     phdm@macqel.be, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.axtens@canonical.com
Subject: [PATCH 0/2] partitions/aix: fix problems due to disk corruption
Date:   Wed, 25 Jul 2018 22:46:27 -0300
Message-Id: <20180726014629.30411-1-mfo@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've recently received a disk image from an AIX LUN that when
attached on Linux displayed errors on console, then eventually
hung the system.

Apparently the LUN was originally installed with AIX and later
exercised with some I/O stress/overwrites which caused certain
bits to be wrong in just the right way for Linux to get a NULL
pointer and invalid data.

This is the test-case used ('--partscan' is the important bit).
  $ sudo losetup --show --find --partscan aix-lun.img

Patch 1 resolves the particular problem the disk image has.
Patch 2 improves the code a bit further (tested synthetically).

Mauricio Faria de Oliveira (2):
  partitions/aix: fix usage of uninitialized lv_info and lvname
    structures
  partitions/aix: append null character to print data from disk

 block/partitions/aix.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.17.1

