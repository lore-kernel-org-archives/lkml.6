Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F454C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E1E20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMURGGIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfBVIXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:23:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43763 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVIXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:23:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id l11so779522pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 00:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Rk8dPBdJ2C0H5pzuoEG59eKAB6fJapgFAjXCmyEI8XQ=;
        b=tMURGGIuTedkoj7NevuZpdaLPYCGuOMhgNgH1eBKJyEu82rRI5LZOJTyzyJDteFCat
         J3wjIlWtGA88j8X+VwjgMCQ/9UmnMPJZCYWccuHSW+rxj4Ah1f9DcDlinfrlEvU3fLRz
         WvjcqpDaXq7tNbD6tyUBIswM6YXBFmqNfRGqm9GVim32IOCNRXZ42ZlbBadB8ZLv+RvB
         gMjakxXOrPSnEjpRLHXw3IbfSKhnOvPr+YwDsfn9GkJg8Ewh3F+zGgHgmF2sCuLmg0UF
         i12tyxgDa1EGLGOtxlsV+FQ6jNUxwFWe8v1RiL9Sji/HTqC86qwKCkFB4XUQgtKe5tYE
         5guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rk8dPBdJ2C0H5pzuoEG59eKAB6fJapgFAjXCmyEI8XQ=;
        b=lu4kVg26CbSTmnaqBJtSXz3xYTXg117Ebl9Gj4kUfS+jjvbsO+AIJ8MJ2fYBsFNMoF
         vvq77/ipvHlcc1cmE1B6MJP6cosOVr8p/QPN5CeMwM1iufLbQqpiUffjmZfaMU6H4nXN
         hXZPQYUK8uyRc8RiWm2OnDQl0zwMsbTXSkyKQa+JpiFe3T21ddEv2r00/UGzTqZv5Ut9
         46yv7HNAxpn2qqI7NM0/adG4cIfyvkATvfxSFBFaucaT0EgzMMbupCkKpkIvuSL0005r
         tVoHI2bJvpVZu0p6ysDezdG1MxPsCmQ3WsNKyqwFBYGKUVoGxdfp4VwObdqiO/YEoVLF
         k95A==
X-Gm-Message-State: AHQUAuaTC4RJc3pf4+mOpVm2xQMr16r0dBVpEQ3Up9rMdCASVV9H4oOq
        R12BTkkFqTkAZ7I4WVWSyrmIxw==
X-Google-Smtp-Source: AHgI3IYXCPZwppu9S4z1lHFWmqopoN/SXnz6Ozl9hQF+Nh77shHtJUsFNsLoQQdoG+gjnVCaYCoHYQ==
X-Received: by 2002:a63:2ccd:: with SMTP id s196mr2848444pgs.194.1550823820858;
        Fri, 22 Feb 2019 00:23:40 -0800 (PST)
Received: from localhost.localdomain (li1195-158.members.linode.com. [45.79.96.158])
        by smtp.gmail.com with ESMTPSA id y22sm133821pfn.136.2019.02.22.00.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 00:23:39 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/4] ARM64/KVM: Minor cleanup and refactoring
Date:   Fri, 22 Feb 2019 16:23:22 +0800
Message-Id: <20190222082327.3312-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I read KVM/ARM64 related code I cannot find any issue or something
could be improved for performance; so this patch series is only for
minor cleaning up and refactoring code.

Hope this is helpful and can be picked up into mainline kernel,
otherwise it's also fine for me if the maintainer or main developers
could note these points and fix them in appropriate time.


Leo Yan (4):
  KVM: arm64: Use macro to replace hard number
  KVM: arm/arm64: vgic: Improve comment on kvm_vgic_inject_irq
  KVM: arm/arm64: Define TCR_EL2_T0SZ_MASK as TCR_T0SZ_MASK
  KVM: arm/arm64: Fix comment on create_hyp_mappings()

 arch/arm64/include/asm/kvm_arm.h | 2 +-
 arch/arm64/kernel/head.S         | 2 +-
 virt/kvm/arm/mmu.c               | 2 +-
 virt/kvm/arm/vgic/vgic.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1

