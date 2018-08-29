Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DA8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3049520846
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCm+aKMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3049520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeH2FlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 01:41:20 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:40668 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeH2FlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 01:41:20 -0400
Received: by mail-pf1-f169.google.com with SMTP id s13-v6so1497087pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 18:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=zQ6oDkowHSdERMpJs42edCVGKDp7l9bR4B/JQogSUoQ=;
        b=GCm+aKMUWRZ95VfDfp4jbBvMr4bD89vCKG4CXIDVj5q/0Rb57T+nu/v+rHb7n3SLSu
         rb8SnezT7y31TrVCeyCa6nE6Fa4LNdVV7XmnInlFdpcFd0BCgNH1yjMzBUX10BXHEbUd
         cX63bLV75VpM6Tv5N6DCBY4YjuX2AJk8WYHcIwwgahrINLlOxarQaHmxu2/XQYQ0SdbV
         KOQ9g2xsIPAb4Ud+uF9+2AhNllorolX8TjhnPp+Rntsm36vg9VjRFrkewhjH6sVl3Xfi
         9hiPvpiEsL9747rmhXMYK4Ly/L7/mIEunRHfXzuGLXUYwCncimAMxDoBZDyJ+H4XdRR2
         scHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=zQ6oDkowHSdERMpJs42edCVGKDp7l9bR4B/JQogSUoQ=;
        b=jSi+W2hpwDe2KkWGceUPKxgbQ80ryh0JficuPNjjKnZGhStDOYEla1CoxJNbjRmpYv
         1YtO5E6NLlUYy/vU4S78o2r+SRT/rUkC6IqH7CBKtD33rnB9Y0txusY6S79CNfKAK7Z/
         CEiB841/42uCHwY25cRGPdtzc849D4H+9pqQNUyQT3W0PVot+9Nxm7+/xBzaDReduO7V
         74dftKqQYbx7zERASgzoe5ZXvh0Da/OF4SVXEyE7kqA24ArIPXP2qVPiCHruMxqjdJFE
         6HsF4U9jgIXucheS/eE9qegj0lVGHATuvMMvh1yntcme1aExC9CVOK/L3y9NzMNgDO1/
         VT8Q==
X-Gm-Message-State: APzg51BU0u3TqPyh4ztt9vcUCi9+h9uUPKNVd4AU6zk6SfVvSdZ/13PG
        V2YWFTBUgyjL9MJVRQHUj/o=
X-Google-Smtp-Source: ANB0VdZqKVKrAKwOVqNcmHpyxZgCIHWZ50IsQDqA5HaCZyZqn+nVs0tyLuXeASBcVe2FDN/LnyTl3w==
X-Received: by 2002:a63:1d22:: with SMTP id d34-v6mr3822059pgd.133.1535507215960;
        Tue, 28 Aug 2018 18:46:55 -0700 (PDT)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id h3-v6sm3854209pgn.26.2018.08.28.18.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 18:46:55 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Flushing user entries for kernel mappings in x86
Message-Id: <8F811430-A9D5-446C-9D6A-C4CA82555559@gmail.com>
Date:   Tue, 28 Aug 2018 18:46:52 -0700
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Is there a reason for __flush_tlb_one_kernel() to flush the PTE not only in
the kernel address space, but also in the user one (as part of
__flush_tlb_one_user)? [ I obviously regard the case when PTI is on ].

Thanks,
Nadav
