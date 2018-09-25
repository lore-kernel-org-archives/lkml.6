Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F23C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9583220842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9583220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeIYXfi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:35:38 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41846 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727677AbeIYXfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:35:37 -0400
Received: from mr1.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8PHR7Lc026023
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:27:07 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8PHR1av008334
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:27:07 -0400
Received: by mail-qk1-f197.google.com with SMTP id c22-v6so26577262qkb.18
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=7knTsdcOCmw5O92FJp/xx10ePeaFsJ6ZmlsaWAD7AKc=;
        b=S8Aolt8bAL8rtYPBWvT25ZjpmrOdxQphPuqxQ+cCYOZaDrxxzHGpNt5OX+89kFpcRO
         4GF/4gjuvXiqPTxgJc2XdQRHtfRqXSsdnvjXKw7158rRXqHCKeBCMgEQwF9BvhehNK3t
         2jbm7XjRwP6T/9NfkSQHA7Ys5cmu0OZ2kZpPR1fr3RVysZiDZ1CPSFfGFHtW0Zog9qXD
         UfVk3JfSsOf60KWRrQmdLuoWYz84T1LuVz6EJ2+5R0wS6PtIweehL+IUa+QZqAPLl0xT
         6m44ZcXDDVHXAKZjeUGj8bYZGJ+KG70vUbYgRc2uZ/5WgE/md9JcPaw1d419wbGKKsri
         zLAw==
X-Gm-Message-State: ABuFfohL7rJHwAZqvJBSO+0vHS/CIhgBFOHiVvc+ojjMAaibCan69ns6
        ofiY48kq2TksCYTzazqYdb7V7uTHr+obhbHCB3BU2SvqvW/OI4wFuVXeKwkIkcEUpraANbUU/WN
        kIuOfnoPytzbxGDMo36nrW/WIryT08qZV7dg=
X-Received: by 2002:aed:3903:: with SMTP id l3-v6mr1614344qte.315.1537896421782;
        Tue, 25 Sep 2018 10:27:01 -0700 (PDT)
X-Google-Smtp-Source: ACcGV624+pVVLbctz/UniXscvT7ubAMLLafrk4IyUV3MXE/CP3gKG9Cy8TtPDAkdW+G/vdAlTtN3MQ==
X-Received: by 2002:aed:3903:: with SMTP id l3-v6mr1614332qte.315.1537896421630;
        Tue, 25 Sep 2018 10:27:01 -0700 (PDT)
Received: from [192.168.15.200] (linker.cs.vt.edu. [128.173.236.60])
        by smtp.gmail.com with ESMTPSA id k71-v6sm2140801qkh.30.2018.09.25.10.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:27:01 -0700 (PDT)
From:   Tong Zhang <ztong@vt.edu>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Leaking path or inconsistency LSM checking observed in fs/net
Message-Id: <8004D467-2F24-4E9F-A429-AA4EE5D2E366@vt.edu>
Date:   Tue, 25 Sep 2018 13:27:00 -0400
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        cluster-devel@redhat.com, linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, keescook@chromium.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk, dvlasenk@redhat.com,
        ccaulfie@redhat.com, teigland@redhat.com
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Version: 4.18.5

Problem Description:

We found several leaking path or inconsistency LSM design issue in fs/net.

Currently we can only observe sock creation from kernel and all bind/listen/connect are not sent to LSM.
So, we think that those net/socket related stuff should all go through LSM check and being audited 
even it is not a user thread or process.


Here’s an example where we have a check: 
in fs/ocfs2/cluster/tcp.c:2035 o2net_open_listening_sock() a sock is created using sock_create(),
where a LSM check security_socket_create is called(net/socket.c:1242)


And where we don’t have a check

fs/ocfs2/cluster/tcp.c:2052 bind
fs/ocfs2/cluster/tcp.c:2059 listen

fs/dlm/lowcomms.c:1264 bind
fs/dlm/lowcomms.c:1278 listen
fs/dlm/lowcomms.c:1354 listen

several places that use kernel_bind/kernel_listen/kernel_connect

net/socket.c:3231 kernel_bind
net/socket.c:3237 kernel_listen
net/socket.c:3286 kernel_connect


- Tong

