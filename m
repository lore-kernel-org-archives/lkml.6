Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13E2C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E312083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0zNBjyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E312083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeLGKVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:21:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45689 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeLGKVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:21:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so1635978plm.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 02:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wkHt1TScDEEIbBuQ6HIBO2AZWICx0qSjTGpqbG9hKQI=;
        b=r0zNBjyNWTFlqlbxwG6bINZa/HT+5qS7m4u5v6sgQ/vMSuyS8pS4Hryv92cEXT1yxo
         JnGpVwNMezf/QfatDHGjt4R+1CyJC5f1wxOwp6wIi0I0UBFReqsdHsKgSn0fnfLxC1pl
         L58OxrGd3MFwgKxbX8t3r5MKoCpRVXLLJqwZ5pezR53jWvCPfcjHRE1P3HzTigNWHSvb
         +R+6gvWTxWkRj3Owfxyko+AI10MMI67jVc7vLgOraNTTfQZQJbiZ3ZTzcDfWmCxFZkZ3
         aP1ADB/KHH3zpZkxH6OiwoOzfvBZueOM7SZVSXp8jw4n6P8m4/xyEibvtzTFUROwMx1u
         Wl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wkHt1TScDEEIbBuQ6HIBO2AZWICx0qSjTGpqbG9hKQI=;
        b=LeLVhbc2ycdnmJvJr8Rpyjr0aTb1/R2IE7yk1J5PrnisxY/Cp54Kn6Qefwu2YEw+GK
         ioFlARtiVUMUH5CLm1wQEJf3rtwA15+3p4cDhnPEXfKrQu64lGHRIOaOJkyfKLTye0jw
         jKivzImZfUXwyS3a56LO4enjMsl4ffocLwthSEAoLrSiAUl/LQdhpwZGWVOEjbN2XsJt
         Ywgeak2QIFvhXJnamjZS9WnRcMs4/+hz1Aghx+3xonT7ykzfqXGIlj8UqlGDRmf8iqDL
         fmr75VN0AUF4n48F/Li3eqBi8cAy735pUMOHBbsFEG/iNucAC5iBiUjnlhlfZBGU0xzX
         Esvw==
X-Gm-Message-State: AA+aEWbyT3Gi00hfwfAst/H7L2jxF9/IKWYp/CJnaTia0N0R2SKiazmV
        37aj6FttpXiPT93g3UoQDhE=
X-Google-Smtp-Source: AFSGD/Xrc549Z/1JnhKwNKre6uaPo6/NzAWmMaCyTPDgWIPgyAcB6HSRRNnK2PienpYcvYuxhh2nnQ==
X-Received: by 2002:a17:902:930b:: with SMTP id bc11mr1631288plb.17.1544178069160;
        Fri, 07 Dec 2018 02:21:09 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id n186sm4164889pfn.137.2018.12.07.02.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 02:21:08 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, linux-kernel@vger.kernel.org,
        joe@perches.com, yuzibode@126.com
Subject: [PATCH v3 0/2] kobject: trival fix
Date:   Fri,  7 Dec 2018 05:20:52 -0500
Message-Id: <cover.1544175417.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is trival fix for lib/kobject_uevent.c file.

Bo YU (2):
  kobject: use pr_warn to replace printk
  kobject: drop newline from msg string

 lib/kobject_uevent.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--
2.11.0

