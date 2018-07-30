Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4450BC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF77F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p96gK10S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF77F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeG3JP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:15:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeG3JP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y4X/O3jQkmVrHMreA4iqrexBlVGtDOMFJb7lFQaK/rA=; b=p96gK10SrqfWxpgP45AXZCVXa
        d6ONftGD2+xBT+rXug+M7SndrYGc1FrUlMBjb51EolmFBDmG89Szx6EYe26t6lM8rarvjrP8gCQRc
        lMEUaAh9OzuVAafuAEvtw5fmpjX3ObG/pBkw+cSIrHzpmrv4Dgm8YeYwpZeZCPL8kxc8tLtRGG1DK
        qRUwLRaLMrXhEjoaiRza0jbirN9oCWDp0tjDMu5cITqpI5tuxpc5RibtleUH9X984+QN98tIDA1X7
        NHZyRfi64yZZnp4V8wSZFlp/UnsoMrWsUheI9fPxiD7KSSo9sAaSAGEZw5T+qI3pVTjih9fbI1/ti
        QrN7PsB4Q==;
Received: from 089144213232.atnat0022.highway.a1.net ([89.144.213.232] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk2or-0002J8-Rv; Mon, 30 Jul 2018 07:42:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: socket poll related cleanups v2
Date:   Mon, 30 Jul 2018 09:42:09 +0200
Message-Id: <20180730074213.16832-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of cleanups I stumbled upon when studying the networking
poll code.

Changes since v1:
 - drop a dispute patch from this series (to be sent separately)
