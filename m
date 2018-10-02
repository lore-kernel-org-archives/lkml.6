Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3C0C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770E72083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knWbFzSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770E72083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeJBVWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:22:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:47056 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:22:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id q12-v6so1237470qkl.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T6s9k4agoeLcHtSfEWyrLKGme4RCBk09rBKbno5wQSA=;
        b=knWbFzSyc7AJ/dB/Sn688cl7nmgMJopQDJnwVYPjDfXCcvHS7wXr2wGHIxCVBwSFyi
         zGJxc79oSQAx/A8FgeyA2l7qNe/dI3wdM7SnvTo/ebdhy/ZWXM+gSk2e+btxrFmBPwSG
         iW7A7FlEF+WPSulNcqKJLCIM0+6Yqe80V1KW66MOhw9eDbCbE+eh7jp2FCBm4kG8Afa2
         HwuevXEF1dxWlrXW86zecwahMDB865lcnoZMosOhvorDpIow3ghAk2QSYB8hoGo8/C3z
         viEi2vjYiDrjEMFdd1K7q9Y/c2cn9uT5FPF0uED9C7BsEIszBIXtB9k/SmK6Nf6AsPm+
         WdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T6s9k4agoeLcHtSfEWyrLKGme4RCBk09rBKbno5wQSA=;
        b=WXY+AZPnNlK3GRyvuhmHSJHoPRbJA6zCoqX0r2RFKUq7dtDtgDKxVLoVfnYUvRYdai
         xEk03bX7WMVKCf00xqR0gqG14LeyALDcX73KW2IF2LKrLzIwjB4+mP3OOh1rtRmHEK8g
         TptUuJfZxkuRkFaV9DAZSf+Xk8zmp2MwrYVpacDD77BboO1oORysDRtfmIYJUmrxWCZp
         Yl89iGmvQi5CCmvi97ja6fssB9cr9GMCjfY0/2jXb1DQAEpjPNQX9LVgBFuuhN/0Qe4c
         gc/+FhOT56c2J9RyDBj5X5A2/IFBI/u94nb0p85EAyZ5ISc115khcPAFwoOaASugoQ96
         1h0A==
X-Gm-Message-State: ABuFfoivVCBEor2zMrA+CaFriRBgHmvVNVXI2Upd6WPSBdjdn4/UkHx1
        c1T7nlIGaRxDIv5V4WcdFQ==
X-Google-Smtp-Source: ACcGV60mq8jMHBSw/7PfeYmiFD10N4KkK2xIR9ViSIQTI7UiqMw5+jdc7s02kJR4+V3Vny2C0RGmUQ==
X-Received: by 2002:a37:c603:: with SMTP id b3-v6mr12245932qkj.176.1538491109265;
        Tue, 02 Oct 2018 07:38:29 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y20-v6sm5257538qkb.46.2018.10.02.07.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 07:38:28 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 0/3] mm: Fix for movable_node boot option
Date:   Tue,  2 Oct 2018 10:38:18 -0400
Message-Id: <20181002143821.5112-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series are the fix for movable_node boot option
issue which was introduced by commit 124049decbb1 ("x86/e820:
put !E820_TYPE_RAM regions into memblock.reserved").

The commit breaks the option because it changed the memory
gap range to reserved memblock. So, the node is marked as
Normal zone even if the SRAT has Hot pluggable affinity.

First and second patch fix the original issue which the commit
tried to fix, then revert the commit.

Changelog from v2:
 - Change the patch order. The revert patch is moved to the last.

Masayoshi Mizuma (1):
  Revert "x86/e820: put !E820_TYPE_RAM regions into memblock.reserved"

Naoya Horiguchi (1):
  mm: zero remaining unavailable struct pages

Pavel Tatashin (1):
  mm: return zero_resv_unavail optimization

 arch/x86/kernel/e820.c   | 15 +++--------
 include/linux/memblock.h | 15 -----------
 mm/page_alloc.c          | 54 +++++++++++++++++++++++++++-------------
 3 files changed, 40 insertions(+), 44 deletions(-)

-- 
2.18.0

