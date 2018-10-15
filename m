Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD37C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B0020652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOAFMJvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B0020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeJOMna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:43:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42181 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJOMn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:43:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so8552576pgq.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 21:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Buny1gAW+O5WKIrF3yuE/KrqBggfVPH1nvuy0QICbRE=;
        b=IOAFMJvKipE87YR17y/83Z6bOvlmqc9PhyFcSIWCMaoiBBgX1kaa5S10ld4uBXRbTG
         AfUb4vYnm6l4sDp60q0ncKjsR1xN7HImM1ofTWJVM0qXpOMkOo1DRhwU5V/8YyjekXHH
         jdG9Crw2Lt2rdOhh7WaqwTE/K8vuvfY4l2oEsBWjtVOxusJhFc1jwwEkKUsX+aUGxvUE
         yewjrf3tKFDntL5ZLBIV+U1ocQePc+Rqj3LW/i4tRtaeLnu7ZssZU1//SgEKLvw5Y1an
         66s5wcsp1QSX+DwMsvRoXqv26bDAAywp/Xadf3bWXM0A85TfhNfvbglwNnCg0/0hJxxD
         Iksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Buny1gAW+O5WKIrF3yuE/KrqBggfVPH1nvuy0QICbRE=;
        b=KzTiwnPUe90VIQP3ul326v5Qe0a7OyY+Hpo0YrkjR08KK/+QO4iU0wElIT8K0mEh5D
         lB07K8JeyQt7qHY3lXyqs/FTx3K3C+9SAtpkMNXbQ1hanWex2GK5Vk//W9O6gVd/7xgs
         ZD/Gl9MpBQie8lDeXpJGYk2YAbSmAwoZ2JwRt1Zx4cnDoCJ2X77aqpPDz56Cd75NCx2l
         kamxNYoftrYqQM4gRU3JfCxL6tbbwgvVmAcVBn7nOGrBg9uIIj+omG5Tc1FCi98Ul9wh
         UcTMFQPnEHNZ5P/R/farhjir1WE0Zx3aessETd8Nqk6TLxviUNrzq6+L2e4Ilk4SJrZL
         rrGw==
X-Gm-Message-State: ABuFfoiXrAJeXbzjHEbavHdTOd9ALYEESGZvmUIy1haQ3Z/UrqQuEIJj
        9huTfDseoJjso4dP7WG3dDk=
X-Google-Smtp-Source: ACcGV61c1depBN9OAcGAPGMpNyucXDlDPr4pfSVzS9TEMxxVMlq4nomZpx4FK+5cBAc1L7YvSIJSRA==
X-Received: by 2002:a63:6342:: with SMTP id x63-v6mr13816764pgb.83.1539579596143;
        Sun, 14 Oct 2018 21:59:56 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p62-v6sm12244698pfp.111.2018.10.14.21.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 21:59:55 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 00/11] staging: gasket: fixes
Date:   Sun, 14 Oct 2018 21:59:16 -0700
Message-Id: <20181015045927.156790-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Various fixes for gasket/apex drivers.

Nick Ewalt (8):
  staging: gasket: page_table: remove unnecessary PTE status set to free
  staging: gasket: page_table: rearrange gasket_page_table_entry
  staging: gasket: page table: fixup error path allocating coherent mem
  staging: gasket: page_table: fix comment in components_to_dev_address
  staging: gasket: page_table: simplify gasket_components_to_dev_address
  staging: gasket: apex: fix sysfs_show
  staging: gasket: sysfs: fix attribute release comment
  staging: gasket: Update device virtual address comment

Todd Poynor (3):
  staging: gasket: core: debug log updates
  staging: gasket: page table: return valid error code on map fail
  staging: gasket: page table: remove dead code in coherent mem alloc

 drivers/staging/gasket/apex_driver.c       |  2 +-
 drivers/staging/gasket/gasket_core.c       |  9 +--
 drivers/staging/gasket/gasket_page_table.c | 65 +++++++++-------------
 drivers/staging/gasket/gasket_sysfs.h      |  4 +-
 4 files changed, 33 insertions(+), 47 deletions(-)

-- 
2.19.0.605.g01d371f741-goog

