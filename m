Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36014C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77D421A57
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="DneLgrnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77D421A57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kepstin.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeHQTjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:39:03 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45016 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeHQTjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:39:03 -0400
Received: by mail-io0-f194.google.com with SMTP id q19-v6so7368802ioh.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=U1kQXAo4f9cVT9z5IiXtIdmmGGul8C5A8nbD933USbI=;
        b=DneLgrnFQGy20CUNNlnTUkmCxQXZSZ/Xhk9d8ibYLdGMXoeq/47phS+O68hbLiwtsP
         P2D8q8Ayc33qa68yJJHyHcmOkk9LBvGfDFdzPj0o1qycCiJZd5oWm87hL5iCPbStDLZJ
         khljRjb93Mx5x1KIQ1D3/P1gsXUlqtYMGDpds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U1kQXAo4f9cVT9z5IiXtIdmmGGul8C5A8nbD933USbI=;
        b=IeikbeDICQY2SRWNI9egF6UndyupsTJLRad+7+oHwYBBs6uYvBiqnk0ZI4jZjZwUAQ
         BMgIETRazTZlRd8RsNO57XGGeeBy8hR85/mWlYz2pgagUyxTzKJZlDSa0cuscUMc2JTF
         UnXqPVLXLEnAh1ibDT+W1gCHroMA3yGHNUm4MrIxU4Namuqac1hc2BjfEUpFW0lIXv9Q
         BcKU687j9tZ+VCgVY7b91et0Qv3JbjdZz+h3YEqUL5y4qV/H2cURF6b0KbWrxsF/4o5P
         enu4JsPRwysCj2Hz63hPnaao8ChHgSy5479fkq2npOKSNIgAXDaRrX350LphOLtQW4J2
         dF0A==
X-Gm-Message-State: AOUpUlET5Sw5VQylEVEK+6Qut3UtFyZyjI+KAR2mNb2YceTzJE9B9Wae
        t9N4L/h5zRL+7QUK4ZdAFAibbw==
X-Google-Smtp-Source: AA+uWPz79wv6Jaa5lW/UqJuwkEI98kVMvpLZYCEfTWx6B+eW+ppRLQWh+I4X8F108f6X1JTDh1XNKg==
X-Received: by 2002:a6b:bf04:: with SMTP id p4-v6mr30106838iof.15.1534523700802;
        Fri, 17 Aug 2018 09:35:00 -0700 (PDT)
Received: from fuko.kepstin.ca ([2001:470:b3f4::561])
        by smtp.gmail.com with ESMTPSA id e140-v6sm1947974itc.24.2018.08.17.09.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 09:34:59 -0700 (PDT)
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH v3 0/2] tools/power turbostat: Add support for AMD Fam 17h (Zen) RAPL
Date:   Fri, 17 Aug 2018 12:34:40 -0400
Message-Id: <20180817163442.10065-1-calvin.walton@kepstin.ca>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated version of my RAPL patchset for Zen CPUs, rebased on
top of the current state of kernel/git/lenb/linux.get turbostat branch.
(In particular, this fixes conflicts with the AMD APIC-id patch)

I've split it into two patches now. The first patch only adds Cores
power reporting, since I'm fairly confident that this'll work on all of
the Zen chips. I think this part is ready to apply now.

The second part is still a work in progress until I'm able to (or I'm
able to find someone else to) test the package power reporting on a
multi-die Zen chip.

Calvin Walton (2):
  tools/power turbostat: Add support for AMD Fam 17h (Zen) RAPL
  [WIP] tools/power turbostat: Also read package power on AMD F17h (Zen)

 tools/power/x86/turbostat/turbostat.c | 167 +++++++++++++++++++++-----
 1 file changed, 138 insertions(+), 29 deletions(-)

-- 
2.18.0

