Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BDAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE7120883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phq6bLqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE7120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeGZMnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:43:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36475 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbeGZMnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:43:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so1656349wmc.1;
        Thu, 26 Jul 2018 04:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=bEy5Knd5juBkGI+Jfv7PwyBW3A5BAxYaPtHjxoOzIWk=;
        b=Phq6bLqD2vXOL/9QbVbhUC+uqX8iH0dPTjtkxMJ0gByxatB00LEqhSJitGp309sqYq
         WE6RcmwPxZSUnAKwXKp16jxPSjgtmidKBZBGDZCqQOtZiTCghvR5FzILOFHU6CV5/VmR
         CB7nByB3UvGUYCIZw512dCyO/8oJbwPAh4X68ISUXeuExrRReLTEoIjlbZH5VNc06k/s
         mpt8ize0+2KgNYhNSk1FNza4CrZTGl4ioq09/MVcin4wNrRZLt5dYNk5x28pbBN+RnGc
         qq517l5T4+6E32aTYkJcOTcdGVYkf0W7S9atQCuvPj7B0987uSRVLAl/Ofar2jlF0tNL
         Iohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=bEy5Knd5juBkGI+Jfv7PwyBW3A5BAxYaPtHjxoOzIWk=;
        b=WUIqqLAk7Z2W5Alp8/Tramut40HWWDlB/6z56R+Qo5+ePo9Szd1TQ4Z3bDaAMe5hFD
         hlpiFY6sukVPnvJEkbgJLMG+Ty36ulS+/q955JxMLwcsMZGf4Ab12X3sX1bFRSJPYtgB
         jdlttRLJ0qOROPORWXJ6GwwP/3PPO2zaNQdUMlujW7yIb//OZluxDe4lm5QIKd2/PqAF
         3rJdHdSitc3pheKaqA4FsxY3eiqdRynCPW3HJyMrvNuHBdTWxiF8ebzAiJxC6dlusm87
         CxworLD1F73QOMaVaaL03fqyZq2XTZXdSkgYIl6QUydOKH6pbrQBx5Niasmd2hH8TRz6
         54wA==
X-Gm-Message-State: AOUpUlGPp6Rb3cohlKZ/ZTcQxsezUrvzzhWaMTwFgoXVVWWpslPFFaqQ
        XaG3AMqD3PPbsiMsYq+Ou1wFmpwV
X-Google-Smtp-Source: AAOMgpd2ZV6nR9CIyyIlLtowdQaoEVPWb/lNCZBtc8F8xQEDPVSdUgFPl7fyUD47PZ5da4am192TdA==
X-Received: by 2002:a1c:78b:: with SMTP id 133-v6mr1366662wmh.59.1532604409914;
        Thu, 26 Jul 2018 04:26:49 -0700 (PDT)
Received: from donizetti.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id t70-v6sm1793683wmt.30.2018.07.26.04.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 04:26:49 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 0/3] kvm: selftests: initial version of state save/restore test
Date:   Thu, 26 Jul 2018 13:26:44 +0200
Message-Id: <20180726112647.6272-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be improved into a test for nested state save/restore

Paolo Bonzini (3):
  KVM: x86: ensures all MSRs can always be KVM_GET/SET_MSR'd
  kvm: selftests: ensure vcpu file is released
  kvm: selftests: add basic test for state save and restore

 arch/x86/kvm/hyperv.c                         |  27 +++-
 arch/x86/kvm/hyperv.h                         |   2 +-
 arch/x86/kvm/x86.c                            |  15 ++-
 tools/testing/selftests/kvm/Makefile          |   1 +
 tools/testing/selftests/kvm/include/x86.h     |   4 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  18 ++-
 .../selftests/kvm/lib/kvm_util_internal.h     |   1 +
 tools/testing/selftests/kvm/lib/x86.c         | 118 +++++++++++++++++
 tools/testing/selftests/kvm/state_test.c      | 123 ++++++++++++++++++
 9 files changed, 289 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/state_test.c

-- 
2.17.1

