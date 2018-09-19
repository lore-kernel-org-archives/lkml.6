Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3E5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32572083A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBQDu9ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32572083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbeITEal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:30:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36854 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeITEal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:30:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id j192-v6so8758465wmj.1;
        Wed, 19 Sep 2018 15:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=whkDutS3F2DQl4qkMuAGH7T1sbauHEXoAEgLmTSdGRE=;
        b=gBQDu9tyfmbu4p/voVm+u9ELsdwpwUgvDuMsn1/ylgi/C5Oz9Z8eP0h5yMqbe6LXoJ
         GLGSD5P5FnoaXfBMy7TDGRem8mqbSNw5jY3rmdHfvSfFeyfPMGiMdm/Ia5zX3KE5FNsX
         cV00pRDr90u257F5fDDDLEESUVkbR6ICO2KzbumLEYTYh5x5SX4Cr5KDWzPXJdvuIlIb
         JNxnBUD4sx9ok5fMffiL10jsQkFmAjMwKbEepB2oHYh0dUwZNHMPeqNiCGotM+wth3Wx
         ygV72PaxqPrSpolfihzA/iRf8k3s9ShcmnyppH7tlosBFDffGSjfPp2n0JPIMVWhoWFt
         BO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=whkDutS3F2DQl4qkMuAGH7T1sbauHEXoAEgLmTSdGRE=;
        b=GgMI1s2AlmzMLzJL8dWLYKAr/IUoqDmuKK0b3uOg6H/g/IgI+wIJfzwiXrjzsQvIU0
         8ET0swXiP21cWEwIdFcuyv4nn/UAhY8ugHPt3QVej70cfwFUovDVLmpNaTZJta1sTR4n
         HcwIsntJzhgGxsdFwXvVeUqCAeg2wCWhOzbOuYQlLEQNaWntl82DPvudRYn023aBqQR2
         XYS9xSZ/15jPR7l3oJeIwouW5dIOazKWLWrcb5uNtUoZ5TaV5a4iPw81G3SAZH5II0kW
         RdsmcnEoNoBQLIUIv2BC0Cb5num8niXPAbBxljYOhcw+WbMXSCO7eardlxxq5y7Eh9iJ
         2Wng==
X-Gm-Message-State: ABuFfojR1bgcJGlR5qYScOmHVcz6iyWrcmSF/JnumL3BH0b4bhXwDHxU
        hp44nc5ycXbcpVDO4dmjqpe6BotJ
X-Google-Smtp-Source: ANB0VdY1txpGmp3jzQJZ7tDMzVSwkdXswWd0h8MFFQdIKFRWo58rSyxAwcsat4xfBbuYy3GlRtCo3g==
X-Received: by 2002:a1c:e00a:: with SMTP id x10-v6mr80083wmg.58.1537397431595;
        Wed, 19 Sep 2018 15:50:31 -0700 (PDT)
Received: from 640k.lan (94-36-187-248.adsl-ull.clienti.tiscali.it. [94.36.187.248])
        by smtp.gmail.com with ESMTPSA id l10-v6sm46721117wre.0.2018.09.19.15.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 15:50:30 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v2 0/3] KVM: VMX: handle preemption timer value of zero
Date:   Thu, 20 Sep 2018 00:50:26 +0200
Message-Id: <1537397429-38588-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



A VMX preemption timer value of '0' at the time of VMEnter is
architecturally guaranteed to cause a VMExit prior to the CPU
executing any instructions in the guest.  KVM serendipitously
emulates this behavior when running as L0, but doesn't ensure
correct emulation when running at L1 or higher.  Explicitly
emulate the architectural behavior of a timer value of '0'.

v1->v2:
- move flag to vmx->loaded_vmcs
- extract arming the timer to a separate function instead of using a boolean
- clean up SVM

Sean Christopherson (3):
  KVM: VMX: immediately mark preemption timer expired only for zero
    value
  KVM: VMX: modify preemption timer bit only when arming timer
  KVM: VMX: use preemption timer to force immediate VMExit

 arch/x86/include/asm/kvm_host.h |  2 +
 arch/x86/kvm/svm.c              |  2 +
 arch/x86/kvm/vmx.c              | 94 ++++++++++++++++++++++++++---------------
 arch/x86/kvm/x86.c              |  8 +++-
 4 files changed, 70 insertions(+), 36 deletions(-)

-- 
1.8.3.1

