Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F212C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3BE20868
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 21:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJXNz5mB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3BE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeKXIhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 03:37:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50898 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeKXIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 03:37:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id 125so13079447wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 13:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xa3llWsINPMWmZPjSBZM+i1g7fwU0sDBnCMvkdgOpm8=;
        b=FJXNz5mBewTdRIrySfs34g0zlFArZSvCXd0v4wAjwn8FBRT1QNX0DBtfnVA/cBvqUY
         dmdezHDyl0IAqF/rUYwGVdo+MLQms6efHDQK7vVrBekIfqJn3ReI+yEbFlMY/ltXul+5
         /lqIay2Es2H1kH8qU5vZRLAauV3NECJF8mIwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xa3llWsINPMWmZPjSBZM+i1g7fwU0sDBnCMvkdgOpm8=;
        b=fwPwsN/jymXCsm4K3KWj17ZFZgPLg9C7mEw+eUOaE2WLN6VCWBO08S20ZSfPAhhJnB
         inBI/7zKvgq6UK3QBsUR2cSzgCextyYTq9McICz+Plv2DeT7VxlvrbUe+aq2ea7v9F7B
         HCNzXa1/MMe8GASp9KaiuOeydyojEz/PC+jkbSJKvzZNtVhxFPH4xGzqPCpXBuFFRics
         nKlKWeeo4vedbI1HRgyY9Q7uNqjAIK2VJYo2u7sTAZGxTMYRfoI7lL0Lwi77Wcn35d2S
         xkx/BykE7Tr0GUyZup+wYsaItOlxzHP3txhvNW1fduTckq4Dk8vlXHUzXl7YDtBl3Ozo
         h+Sg==
X-Gm-Message-State: AA+aEWZKXiuEemITeKggm3UvblZi9+FmPzBfXTPINxJBA0jJ/+rHsMzt
        olzpw+s42BtHhNTh5rOvsbSzsAIuwjU=
X-Google-Smtp-Source: AFSGD/X4EId608zzg73liANfRFKjKTvlIbJ+Y3WV5YrbQbw+CAY8uibl+aL3Fb748bwInu/5pGTd2Q==
X-Received: by 2002:a1c:e0d:: with SMTP id 13mr15597277wmo.52.1543009913242;
        Fri, 23 Nov 2018 13:51:53 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:6913:f64b:5e59:5ba5])
        by smtp.gmail.com with ESMTPSA id z12sm14529178wrh.35.2018.11.23.13.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 13:51:51 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>,
        John Garry <john.garry@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [GIT PULL 0/1] EFI fix for v4.20
Date:   Fri, 23 Nov 2018 22:51:31 +0100
Message-Id: <20181123215132.7951-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 63eb322d89c8505af9b4a3d703e85e42281ebaa0:

  efi: Permit calling efi_mem_reserve_persistent() from atomic context (2018-11-15 10:04:47 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 57e56580724370056aadd0e4e331ec5445ebf9e1:

  efi: prevent GICv3 WARN() by mapping memreserve table before first use (2018-11-23 20:21:12 +0100)

----------------------------------------------------------------
Apply a fix on top of the efi_mem_reserve_persistent() fix that was
merged last week to allow the function to be called earlier.

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: prevent GICv3 WARN() by mapping memreserve table before first use

 drivers/firmware/efi/efi.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)
