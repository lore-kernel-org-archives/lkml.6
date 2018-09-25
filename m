Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F289EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75CB21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75CB21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeIYXfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:35:44 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:57386 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727677AbeIYXfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:35:42 -0400
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8PHRCU6000471
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:27:12 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8PHR7Op020953
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:27:12 -0400
Received: by mail-qk1-f198.google.com with SMTP id y130-v6so27149802qka.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=yg81aJkMGnQ60jgGx88gWp6r5X0TXT64YK91bLIVdzM=;
        b=twH4d8j9W3/0+/tAuo1vr0AmhI5H+7wHm4B6LPEVUyEp/cgqD5rNUb/Krx0owqHXmL
         3Xjj7P/m+ijFVAmWnJ0x3ArvTX0A7PJS5oxC6GSd3jQCKdpNfGmW3TUvx5xhIWFKEdyR
         E+qDQmylVFUWOB6DnE/qM7KK91lSwa1wXRetFwuvQOOKtAmEfxxdYI/z+81zBrU/czYO
         5YdTxiaeVx2bmNgNOA1A4LVMjcWjHtUsXBIIOuVZ2kzTHTN6GMBX/XYi26UoZYC4mGXY
         x+bXs+5s5cQXAnELYtiKOSXSQG9qiyIyULEotQ0smneuVCgcBu6yMb6cOMvu7ucaGboN
         8dgQ==
X-Gm-Message-State: ABuFfoiEKgeHyOxVOEUYQXPlWyUIBTnYzyVpuYfbbG1zy5JX/np5qT6+
        LdfNMIGJScwVWbnJ7DRIFmYGRQWCrE5dSF7K3L8MiSwVA4mx8f/VK6+x0G1S9xEaf+t4dlqUL8w
        M0r8JSpsrTE8uQOZoReUHk7ZcF48ulL37oyM=
X-Received: by 2002:ac8:266b:: with SMTP id v40-v6mr1629349qtv.104.1537896426939;
        Tue, 25 Sep 2018 10:27:06 -0700 (PDT)
X-Google-Smtp-Source: ACcGV621X6fBQSdILujirNC6zOGBck2gwdNAyjvt6v+c7cCRsUdwWesdRLMnQQ1bCU2GdGECyoXRVg==
X-Received: by 2002:ac8:266b:: with SMTP id v40-v6mr1629341qtv.104.1537896426799;
        Tue, 25 Sep 2018 10:27:06 -0700 (PDT)
Received: from [192.168.15.200] (linker.cs.vt.edu. [128.173.236.60])
        by smtp.gmail.com with ESMTPSA id k71-v6sm2140801qkh.30.2018.09.25.10.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:27:06 -0700 (PDT)
From:   Tong Zhang <ztong@vt.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: duplicate check for CAP_SYS_RAWIO
Message-Id: <9CFCBC36-B08F-4920-B144-F7EED5B9BC33@vt.edu>
Date:   Tue, 25 Sep 2018 13:27:05 -0400
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Wenbo Shen <shenwenbosmile@gmail.com>
To:     axboe@kernel.dk, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Version: 4.18.5

Problem Description:

We found a path where duplicate capability checks are observed,
the path is :

scsi_ioctl<- require CAP_SYS_ADMIN and CAP_SYS_RAWIO
     `->sg_scsi_ioctl() 
                `->blk_verify_command() <- require CAP_SYS_RAWIO

CAP_SYS_RAWIO is checked twice.

related file: 
  block/scsi_ioctl.c:215 
  block/scsi_ioctl.c:471
  drivers/scsi/scsi_ioctl.c:240
  drivers/scsi/scsi_ioctl.c:242

- Tong

