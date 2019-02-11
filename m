Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB9AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EB8218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y3FsRwM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfBKNgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:36:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfBKNgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0RjqkG/Z5AYAcLHmSc7mP71T89y/DfZMMiXjibyrQmQ=; b=Y3FsRwM508xCp0G/iq7D7q6Q/
        +Vwi2bjqQKsAiiybpIONc9kDJSCDfA6pqDu8AnIz5sEaBbndwnVYbFDnFne3CHZi1WdV54Uvhpv0K
        jH4Etxr6yTNOEJukMJ/JItoRIKFmPzLXFJgroJmn8FrOTatK73R4HRUf3CzKowvoyRk5uwh6xk4PA
        NDNmTyXcCcCW0lxygBsuZo9fTYg62B0UyhyZW2okyzN6zxAInjMQQUaqGLlfbzWr30HWW3Bk9E8SF
        qoG1HgEhPJoH5IglNMpq4TBx3wmSatK07824fW3D7DUXCKqYSMHLKC070cqxT8SkwCSbWl5Eu/uNd
        HRoGlklLg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBkc-0008Ld-Db; Mon, 11 Feb 2019 13:35:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: dma_declare_coherent spring cleaning
Date:   Mon, 11 Feb 2019 14:35:42 +0100
Message-Id: <20190211133554.30055-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series removes various bits of dead code and refactors the
remaining functionality around dma_declare_coherent to be a somewhat
more coherent code base.
