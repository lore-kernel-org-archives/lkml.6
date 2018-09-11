Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DEFC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4383420883
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R+EJAt79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4383420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeILCSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:18:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeILCSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3rI4SIvhn4M4n/vLnkQxLt5iy3zT0pKD1CmqNvhzWTo=; b=R+EJAt792GU5fru6cwCn8G0Sf
        fwLkf0T5AECG9kTcWRxVzywT7s+ieQMyPPSi06zNLZT0PcbHkNizi2cfQnsCnhFMn8pYq+YNMGnRm
        tVgZZKYXQmlqJTJzLiP7j/wjcpKbD3piq6P1AvdGjGVlrE58txrGEaqah+sqzm7p6pcKlV6JGzHjA
        vLipZvTqsPU2CiXTqO28boWgtVPSHQJRfA9KXqtmQKD0BxsDULs1Xqi4y4MY9xLftgoyoygzQtK/6
        hphQXbJ7kP8c9ZQhQJWfXy/hklMLOm/ja+iP+IMjJTESu3Hu8Be9l6O2lhf5eJQvkEAld/Fpod3jq
        fqlZns/lA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzq1d-0006Jy-In; Tue, 11 Sep 2018 21:16:45 +0000
Date:   Tue, 11 Sep 2018 14:16:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, ldufour@linux.vnet.ibm.com, vbabka@suse.cz,
        akpm@linux-foundation.org, dave.hansen@intel.com, oleg@redhat.com,
        srikar@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v9 PATCH 2/4] mm: mmap: zap pages with read mmap_sem in
 munmap
Message-ID: <20180911211645.GA12159@bombadil.infradead.org>
References: <1536699493-69195-1-git-send-email-yang.shi@linux.alibaba.com>
 <1536699493-69195-3-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536699493-69195-3-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 04:58:11AM +0800, Yang Shi wrote:
>  mm/mmap.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--

I really think you're going about this the wrong way by duplicating
vm_munmap().
