Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020CFC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E4B2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz2PCMXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E4B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbeJAUq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:46:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39277 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJAUq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:46:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id q5-v6so5177464qki.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rhpinfgPDPrM/hJtXqqn+RTC2XN6PrvNhdpNbV0vj0o=;
        b=Rz2PCMXG6AG/hvicUBI/9gWo2SaGow608skDEwiSXmKjPg0yPqd1vA2jMCobTkKUHq
         wJDvpNRM/VV+sgXGIs8oP5VJr8ZXWcTeYHognDmzEV3uiIo5zj1PKX3lFs7fZfPaOk1R
         3xoT0EK5ijkWUCTmj8UgJcuBgEgoq2JIy7LnL8BBPqwuMM/7Oxh9OxOhHyTEFJizVSRB
         Lp5mMHHnQ8hk9hB2xypoD3xb51perYkN4qwYPV5Eu3aEXAigxoQuRRLekrKPx9Sd+owF
         T8HcKrVbnHDHgVDtVK+uvdthfR2ilrhCbHusvjVrxGVcsaIjB57GeUZh7V1PmvZkuNAj
         3qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rhpinfgPDPrM/hJtXqqn+RTC2XN6PrvNhdpNbV0vj0o=;
        b=apsMK4IoafQ0yntGyvUBVevy7V4dbxmw1RkDKoLU14F9+yOO/r5mZcWFx3zCGMbO4Y
         lo9s0rMGOrk3ko5pNpp3X+KMw8yfLoSV+r+5rB0QFTMQb2r1SkvNgFuilj3KwtAgYNZ3
         YEtveL2aT8aMiHYE8qWJOcMzP4f4l+i05ubLhF6U8GHeCgw1prtEy/7cnn2j2XcPfVgk
         ZNPXqfI26UQD5j5ZM+b603C4J4xyj3NAnUF80xz315lq4/k+xROJqYs8YonPpHhh9upI
         emer8GKYt6yOh9KE2IAV+hE8DDtlvS5UUiEQaDKhqPcU91A1hNfyNtJG/rKFwmXATuk2
         HPFw==
X-Gm-Message-State: ABuFfohdIYp2fe2YuqxBCfdr67Biw9KD2LVER9lKyHutnipv1EcKhrR0
        Br4Fxmvx5P4LHeuKbKi8iw==
X-Google-Smtp-Source: ACcGV63Yrs2yMPltEtm6PfwvXo0dJNCEeUSZqzP5zkM/JFsJ0Za/xTbwpFBlUN9mF4nsZyNzZXimIQ==
X-Received: by 2002:a37:5e82:: with SMTP id s124-v6mr561014qkb.313.1538402939094;
        Mon, 01 Oct 2018 07:08:59 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j19-v6sm5714496qtr.6.2018.10.01.07.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 07:08:58 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Add a kernel parameter to change the padding size for KASLR
Date:   Mon,  1 Oct 2018 10:08:40 -0400
Message-Id: <20181001140843.26137-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series are adding an kernel parameter to change
the padding size used for KASLR. It is useful for memory hotplug
capable system. User can adjust the padding size to use it.

It is better if the padding size is calculated automatically,
however, ACPI SRAT is not available at the KASLR initialization
time. So, I add a message for user to tell the suitable padding
size. User can set it on next reboot.

This patch series don't change the current default padding size.

Change log from v4:
 - Fix the padding size check (2nd patch)
 - Add explanation for the parameter in the document. (3rd patch)

Change log from v3:
 - Add a warning message if the padding size for KASLR is not enough.
   And it says the suitable padding size to user.

Change log from v2:
 - Simplify the description. As Baoquan said, this is similar SGI UV issue,
   but a little different. Remove SGI UV description.

Masayoshi Mizuma (3):
  x86/mm: Add a kernel parameter to change the padding used for the physical
    memory mapping
  ACPI / NUMA: Add warning message if the padding size for KASLR is not
    enough
  docs: kernel-parameters.txt: document rand_mem_physical_padding

 .../admin-guide/kernel-parameters.txt          | 18 ++++++++++++++++++
 arch/x86/include/asm/setup.h                   |  2 ++
 arch/x86/mm/kaslr.c                            | 17 ++++++++++++++++-
 drivers/acpi/numa.c                            | 16 ++++++++++++++++
 4 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.18.0

