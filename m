Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD76EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926FA21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926FA21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeIYXfq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:35:46 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:57414 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727677AbeIYXfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:35:45 -0400
Received: from mr2.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8PHRFTr000499
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:27:15 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8PHRAJC008696
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:27:15 -0400
Received: by mail-qt1-f197.google.com with SMTP id d1-v6so9233342qth.21
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=DhBVNj10Sbxs1XKQgkvxIWncxg6P5KZrFHtrnc5vvgo=;
        b=G5LXJwoYbxVqMDjJqZg44Fl3SONK7cgFFEFllhlGQP/9p9GFqNA8RtH0HpklhFVFfm
         cvo7OA1RckiQtKebwXxLdnxn7xs/dGGRLS5H07JyaGGcxya9N5nR+M9PNxxfx0YToRwL
         nHLpUkmPynD6n+jEXSnlB/CE8l7XRr/ILBe6wPTKq/JdzYx0YlZtM6fVuvyfg2orI35j
         7x8YKy9JZPrHkf4Nw581pdSuyAR0zQiVkdMuUs/7LnHNr4JPxX6y1ON+H35w+BPZy7OZ
         PxdtgFTnt6dTNjfxeEuXv08e2qOmZNflEnY3AREnKZtnIk8a2HNwz95HLFn8MkcVIhCG
         UA8Q==
X-Gm-Message-State: ABuFfojjiJSGCM8uCwUXrEOrch+Mrpq4tHEnz858so2H/2GDU4PaKP+F
        TYFtQXFETbIVRfG+IzCjZYfFgtSMyRBsAEX3dJEY2icQQXyRbX0mtZdkPYRD4wG5jZow8AJGe7Y
        hISRuRQAlWY5GaVJHJTuz6Z/iXLSpoJahesA=
X-Received: by 2002:aed:3903:: with SMTP id l3-v6mr1614805qte.315.1537896430032;
        Tue, 25 Sep 2018 10:27:10 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60on3Fl4jyKkB1lWtutpqlEt/VpQdREWkSTJ8PjzwLvS8YHV7rDZgo3g3Mp9wJesF3DjCwKyA==
X-Received: by 2002:aed:3903:: with SMTP id l3-v6mr1614795qte.315.1537896429895;
        Tue, 25 Sep 2018 10:27:09 -0700 (PDT)
Received: from [192.168.15.200] (linker.cs.vt.edu. [128.173.236.60])
        by smtp.gmail.com with ESMTPSA id k71-v6sm2140801qkh.30.2018.09.25.10.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:27:09 -0700 (PDT)
From:   Tong Zhang <ztong@vt.edu>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Leaking path for set_task_comm
Message-Id: <F7DFF547-5267-4EF3-8BF3-70DAF6C2A53A@vt.edu>
Date:   Tue, 25 Sep 2018 13:27:08 -0400
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, wenbo.s@samsung.com
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, gorcunov@openvz.org
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Version: 4.18.5

Problem Description:

When using prctl(PR_SET_NAME) to set the thread name, it is checked by security_task_prctl.

We discovered a leaking path that can also use method implemented in 
fs/proc/base.c:1526 comm_write(), to do similar thing without asking LSM’s decision.

- Tong

