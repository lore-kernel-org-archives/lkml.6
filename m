Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6556C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998962190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D6lBcZ90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391054AbfBMRql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:46:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfBMRqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3tZ3NHZ1d3bA/70lj6RR5Q5NCXupe66P+A7rmOeDnE8=; b=D6lBcZ90Hp+lGIn/L8UmQVvqF
        Jtw0mI7xsCH9CY0gYLt7fRtXn1XpjpOX3wRshZaCsV1zKN7m+pW+MMKFreQjHyMJBSJU5S6VqlV9X
        suMmeTm/FjafmxU47yuz5E3noPkNFDuGnvwvxJNbIPEfNEe8Aq81S/0JqUbM6BElLZFeq3TMH/eOj
        NraTaSD140I96d3Hqm0q6HSDqDQBKRm312wPUUxtVfUWzFaVeyZPWdEw33FJsCyAGKA+mjgOr5RGb
        lXUWaXTiQ0Ot/I7ElFcJhjMh9GQ5huxp2ri0Xu3OoctbasoJ4RWYnsH+GDPv8zFipw+oUZI7z+Py+
        hzFnNGBvg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtyc1-0006Xf-HW; Wed, 13 Feb 2019 17:46:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: initramfs tidyups
Date:   Wed, 13 Feb 2019 18:46:13 +0100
Message-Id: <20190213174621.29297-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've spent some time chasing down behavior in initramfs and found
plenty of opportunity to improve the code.  A first stab on that is
contained in this series.
