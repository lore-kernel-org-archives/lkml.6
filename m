Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BABC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227F621480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227F621480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeIYXfl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:35:41 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41868 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727677AbeIYXfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:35:40 -0400
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w8PHRAm9026054
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:27:10 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w8PHR44g020903
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:27:10 -0400
Received: by mail-qk1-f197.google.com with SMTP id z17-v6so27169803qka.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=oEPox95A3KAcPRm+YVgLE+w2COnqQQTopS50DnFDT04=;
        b=Dh55qip8fp4oJR94W2mU2TP/DmHeGOlSe28ikWX0s27Z/16XGrMLkvHD464H2XSKUp
         zz/YNUOZs0cUnLLn6tj2xzndjiNl3VessaBeziWYwqH4pZjsLR2FbkpD9Uzy5TxZGTf9
         ZJB+mKzvjrArtHpN32AVyImIEnXcJwHyYf6dsUAvL+4+gR2nbB+3guNKzDYOwSIWy23C
         pz1qUPRAqwkryss1Qi0+7OYcaKSgBwPqJl3JFNBtvD1RjZ7+kW/VfKBiWXSjRoE8n04T
         5RbT38cCwYaOAPD21eLC/tRfZgZ6BkfJ16OGr2LNltOGtshRrfTW2LmSNnH/ifcmmW0c
         pRWw==
X-Gm-Message-State: ABuFfoiwNnA1Satdg67mjmVPCXYKZ53IzAVrNTFMDsCqTRnCQUFaUocC
        LeB2JGD/HQcoNWjDcWS80I1NudjJBMrRwOAUVT6gQX8QceHUeLD226CQYTQpsY0SLTirD9d1Tma
        tyIsHI94UOF4X2W/EJDe0wCTThpHM4c892AI=
X-Received: by 2002:aed:22cc:: with SMTP id q12-v6mr1564279qtc.145.1537896424842;
        Tue, 25 Sep 2018 10:27:04 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62k0F7ikJoIjVaW70HQN43tNWk2yMSs8kTcKRtZceruqqb8NUZWBKV/WOT6iLOA7NZ8veOwFw==
X-Received: by 2002:aed:22cc:: with SMTP id q12-v6mr1564270qtc.145.1537896424703;
        Tue, 25 Sep 2018 10:27:04 -0700 (PDT)
Received: from [192.168.15.200] (linker.cs.vt.edu. [128.173.236.60])
        by smtp.gmail.com with ESMTPSA id k71-v6sm2140801qkh.30.2018.09.25.10.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:27:04 -0700 (PDT)
From:   Tong Zhang <ztong@vt.edu>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Leaking path for search_binary_handler
Message-Id: <C2D9C687-4964-4DB3-AAF4-7C836324D6BE@vt.edu>
Date:   Tue, 25 Sep 2018 13:27:03 -0400
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, wenbo.s@samsung.com
To:     viro@zeniv.linux.org.uk
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Version: 4.18.5

Problem Description:

search_binary_handler() should be called after setting bprm using prepare_binprm(),
and in prepare_binprm(), there’s a LSM hook security_bprm_set_creds(), 
which can make a decision that binfmt cares.

We found a leaking path In fs/binfmt_misc.c:235, that don’t ask LSM’s decision.

- Tong
