Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584A5ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095E0214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="RZwUqtHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095E0214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJJCGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:06:34 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:38758 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJJCGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:06:34 -0400
Received: by mail-yw1-f48.google.com with SMTP id d126-v6so1104147ywa.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AY6e9eD2812QMScDAUBqi112m7w08un1ckTcrUeZNk4=;
        b=RZwUqtHNSdWVkvw07m0ummQd/VY5ciTHuMW+O97KWjgKf5MDQ1iMnNQZ7xd+RWC5v9
         LEvsAPq0IUxH+3PNEWDKskXP0xvcnwfFlibBSFK+RJ4uT4hfZ2Ng3UIojNxMo/DodUAc
         8SyxF0tB93d+8tKbKd+G+waxvxv6PTOh5urShJVGEqYshnhooBCEKUXpuQstxFs2MwR0
         iIFlfcZ4pbDCnlp9+l3LRRAtFcZd9UgdtBG238ubbCdwj+mABLrqvC3iSzFEpHn1djoE
         kzlP7L7rUvyuRCe2d5WanqNca88VvT87zPx80s88cfbJuGoMn+3+MMbgcBEwR6O+1bqI
         zjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AY6e9eD2812QMScDAUBqi112m7w08un1ckTcrUeZNk4=;
        b=kbQcyJiYksgIAmkWI6FbSpK1ScRzqgdeIjUtwkkjtoTGxSuvqCeEThoF/bAtL10Kin
         l/KcEGZxj4W9C+dx6qv3HAf/I2/RKVMeuJIk8/QlxDBAmhLrO+vjxHfaVxyKcQB6NPgO
         GGJ/wrKHaagO5pzCF3pw0in74LWmgoYGKeLD9objWo6NOSFfbabc4qH1y5ok+5Prv7uD
         71xl9ZxhGphKVkXOsMR+39dVe+iTPoC54rML3r54T1IDfp+7g30FPJVAucu1OmeljOLL
         NHf9l4SZMPsVDeZvPs/zIuMIDCC/D5So4VsCJ7rpm5T+VNLUpLyD0d8OiXxq050e9V08
         49fQ==
X-Gm-Message-State: ABuFfojDPwJpfvZnVpNij7GBkA12kCL9FSgePM2RVrnt3FMcMJHu+59Y
        4lUC/WUrz8oTl3CQXFp8Oqaj7Q==
X-Google-Smtp-Source: ACcGV61CXoBpMGFlzLiTLNAaKzmZeZzcxQSUr+gzv69PFxjQJnWPtZiw0GwVosUjEVk3bKFGhpwV2g==
X-Received: by 2002:a81:618b:: with SMTP id v133-v6mr10741898ywb.13.1539110893136;
        Tue, 09 Oct 2018 11:48:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:14c5])
        by smtp.gmail.com with ESMTPSA id c10-v6sm8031837ywh.27.2018.10.09.11.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 11:48:11 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/4] mm: workingset & shrinker fixes
Date:   Tue,  9 Oct 2018 14:47:29 -0400
Message-Id: <20181009184732.762-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

these patches address problems we've had in our fleet with excessive
shadow radix tree nodes and proc inodes.

Patch #1 is a fix for the same-named patch already queued up in the
-mm tree. The other three patches are stand-alone.


