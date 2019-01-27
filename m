Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9BFC282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3224A21855
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 15:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="dJ6h03zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfA0Pw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 10:52:29 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25384 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfA0Pw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 10:52:28 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548604326; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Bw2vY8Qo2PSHrMq+89zY4HaheCH1n4l6QHqD2AveUosrwEjHv2L9hPypgDmJ1dThfaISOeLVHFOOJIHJFGow9U6WXYbxM1uOD7GDjj1iOfzPaBpO/heXUEGnkBytSLsTLd6yITSgxNOYK7Qzf0pcdYmm/qLVMsdjCnnvToRcZZw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548604326; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Pb71XkIXmGtx2Ee1Zcw86ygWZcbXxNlClEgFJekHJOQ=; 
        b=kpjiHg5nSlf9cf9WZLq0IIkEhdQr4ZjJ2UycNUBdjkAihDzSiZcVHg3QbzgG2azeALm8lkaDJkoF2SzkvNoSe5D4Dqjg2t4Lsoc/BkKTVqUbZDQim5BOyGoVstFihyWO5ITkInlJWYfMVD5qlTmYbFU9cz12ZDsYTeH8k9tC1ws=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=b98VDjPPXcGfu0k4SzYcYq5NDdFvl0lLqpi4NEiJEerQb9bW+RlU8b8daq6N9YNYXOH6h1r2Eqa4
    tyODUsJbbJg7XkPb5zri2byMSqMR6AIX/R2LLQbifoOyQXzKZr+P  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548604326;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=79;
        bh=Pb71XkIXmGtx2Ee1Zcw86ygWZcbXxNlClEgFJekHJOQ=;
        b=dJ6h03zp9b+jNWGI7UEEDpVNNjo2tjF/GX4Aa9rSSMnCa8cZOt1g4zDtcf6NEc1c
        10QXUZ0IPZLuij08drNRSSve3krM6XJPrMkrtFJSbnOYF7VJd0WID+EmfTzQ6lArtDY
        TSNmIpj4HQHJe/7M5/rfaqSk+/4G8cPzEhkAnth8=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548604325047153.90201650864924; Sun, 27 Jan 2019 07:52:05 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de,
        syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: Add Ingenic X1000 irqchip support v2.
Date:   Sun, 27 Jan 2019 23:50:28 +0800
Message-Id: <1548604232-19159-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548517123-60058-2-git-send-email-zhouyanjie@zoho.com>
References: <1548517123-60058-2-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vi->v2: Replace "__fls(pending)" with "bit" in function "generic_handle_irq".


