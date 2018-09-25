Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB3CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BF721480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BF721480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeIYXft convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:35:49 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41922 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727677AbeIYXfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:35:48 -0400
Received: from mr1.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8PHRIQW026135
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:27:18 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8PHRChE008621
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:27:18 -0400
Received: by mail-qt1-f199.google.com with SMTP id c14-v6so9145929qtc.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=OIxYIjFmc4J+Sm2awJQcYqlr0Mhe7FwuigLWNOINNuE=;
        b=RJnMAS2ulmlLyu1IbbPXQbc4XAnb5RGofHt7I9/RuGlYKQ4CD4pitdtmJoHeTlcXSA
         jCLDXbMCPvAmhH2J/0mbi9R5u6WajGnwlRG+j0ICK5xeIwV8V6GaEC24F7kImpGUpWNZ
         aIkd00Ikl+owHhzEFmsGP3tnXYKPTXWLsF9uzF9JNlgfEukmp/lRgCsAbiUXGEvg7Rbx
         dGb0DbcthElYkHwI7quHCHBvWh4BS8X7XvC/CUQbvYd9kVshplXCEfkP0wlmjqTPSG8a
         tNAF3xLaI10gqkZ87noHsKiFtNkyNKSeMR1i6nyzNmaBuGQA/XvQCnbJDMGctQGhpDQV
         4wAg==
X-Gm-Message-State: ABuFfojymarcyieT0YxU4AGHQbf2SXfvum0Huv+q8T7z3C4bCCoN21kN
        15WozzUiRBIDuNYE3yC4k0s+ZwKNhnP/XmW0nTUJ2HXjD54JJ3HkYexyEIyxHmn8FitSGNEuuzh
        zccDck9QrijZhJHopw2cIvc3OLvqCNlJ3qxo=
X-Received: by 2002:a37:2a14:: with SMTP id q20-v6mr1488613qkh.248.1537896432580;
        Tue, 25 Sep 2018 10:27:12 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61sgwYQO5fOYOdOBySU/KV1RjK8VXMupFIatp/+MuZBp9MY+h9M1LqAI+DY1lHjvV46KbXJeQ==
X-Received: by 2002:a37:2a14:: with SMTP id q20-v6mr1488602qkh.248.1537896432430;
        Tue, 25 Sep 2018 10:27:12 -0700 (PDT)
Received: from [192.168.15.200] (linker.cs.vt.edu. [128.173.236.60])
        by smtp.gmail.com with ESMTPSA id k71-v6sm2140801qkh.30.2018.09.25.10.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:27:11 -0700 (PDT)
From:   Tong Zhang <ztong@vt.edu>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: leaking path in android binder: set_nice
Message-Id: <56B089F7-3656-4335-BBD2-D8B3CFD70996@vt.edu>
Date:   Tue, 25 Sep 2018 13:27:11 -0400
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Version: 4.18.5

Problem Description:

When setting nice value, it is checked by LSM function security_task_setnice().
see kernel/sched/core.c:3972 SYSCALL_DEFINE1(nice, int, increment)

We discovered a leaking path in android binder which allows using binder’s interface to change 
a process’s nice value. This path is leaked from being monitored by LSM.
see drivers/android/binder.c:1107 binder_set_nice.

- Tong

