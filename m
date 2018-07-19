Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F868ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA65220673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA65220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbeGTANg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:13:36 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34403 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbeGTANf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:13:35 -0400
Received: by mail-qk0-f196.google.com with SMTP id b66-v6so5297694qkj.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 16:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=3Ta8HfVaVdUyz8rp0Om7TCjbPU+w+eHP2E4BeB+nmVI=;
        b=Uu3jViEBo//IqJchUIrOGIoG0aRgmDoQ3KvDtJ7eBxJ0wv3sdr5Z6+W3ckaHATNxoc
         PZACurdajguwj/u4ch0J90UiajUAm5vDE6qQMkcRVNLGNu0Fh38TwPlVvIoaF4jkbjhO
         06nfbf2ZDhZg6sKKDXU8d/82Dhv3Gd2dEnJ3xZKhPsxzBUTNzmJHF9yV3I0NSSoOeDL7
         rtvWnF8dEHjXHc2CPo7FjVJ6Y0EfdtyCXhx+rSAXd3GoAzlDAWtFcD71VAnpdTRvgRb/
         MqhTBPrC4C4KmlWlto++0Jl6rdYCHDvEgiOgzd8hxppNCmKCy2F7QHguTZ2Iq1k3gDUi
         xuBQ==
X-Gm-Message-State: AOUpUlH6pMGi9DMNVNX8W8E3t1sTC1jpBQvk++zQqGTjEbIvGaxf/6eO
        vl47XcpXevA7J0m83eIdv1+Lmw==
X-Google-Smtp-Source: AAOMgpeWD1c4O6Ci5BImtwQ0dTtBcc9kC84f7Amc3AWoq1d377ByryxYknNt399NGy0Q+nJw82jgbQ==
X-Received: by 2002:a37:b286:: with SMTP id b128-v6mr10961797qkf.158.1532042892953;
        Thu, 19 Jul 2018 16:28:12 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id f70-v6sm258205qke.77.2018.07.19.16.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 16:28:11 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCHv2 0/2] Stackleak for arm64
Date:   Thu, 19 Jul 2018 16:28:04 -0700
Message-Id: <20180719232806.3397-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1531341400-12077-1-git-send-email-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is hopefully the final version of the stackleak plugin for arm64.
Acks are appreciated!

Laura Abbott (2):
  arm64: Add stack information to on_accessible_stack
  arm64: Clear the stack

 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/processor.h    | 15 ++++++
 arch/arm64/include/asm/sdei.h         |  9 ++--
 arch/arm64/include/asm/stacktrace.h   | 73 ++++++++++++++++++++++-----
 arch/arm64/kernel/entry.S             |  7 +++
 arch/arm64/kernel/process.c           | 17 +++++++
 arch/arm64/kernel/ptrace.c            |  2 +-
 arch/arm64/kernel/sdei.c              | 51 ++++++++++++++++---
 arch/arm64/kernel/stacktrace.c        |  2 +-
 arch/arm64/kvm/hyp/Makefile           |  3 +-
 drivers/firmware/efi/libstub/Makefile |  3 +-
 11 files changed, 156 insertions(+), 27 deletions(-)

-- 
2.17.1

