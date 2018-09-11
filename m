Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B247DC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A51320645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ODv27x2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A51320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeIKLbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:31:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeIKLbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7A8dWqZJ1JVbq+EWXqvi0esbNRltwavXgahwOc+/Lnk=; b=ODv27x2sCP/xvtDR0X1lwjzrW
        foTUtHbk2BmyeVRjSWev4Rb78ia0/U7ouEDaO2suZTVfjv7xMkln3Dg3/OOllonzyg3KQ7GjMq00W
        Oejg5070PcMgZtCEaknarqlnrXvp2IokjbRxeTCxLH7EeE51fiXe5vumGimabkJBMzDUwv03LLa8H
        y2Z7Cyz9bQyA2Plk4cz//kZajnu8MoD00Ab9S7cxf4uaAnJL6c10+wTdGt2nR1GwFQf6w5EobePcB
        yZW5sTNk8utliqNPdc3XPrl8bycSP51+RUQCXMrLzvtE5ceSeapPC65xT2is1yP2nhYzdYnRpj2tK
        El/13zfng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzcEy-0002Ut-3m; Tue, 11 Sep 2018 06:33:36 +0000
Date:   Mon, 10 Sep 2018 23:33:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        syzbot <syzbot+5b1df0420c523b45a953@syzkaller.appspotmail.com>,
        bcrl <bcrl@kvack.org>, linux-aio <linux-aio@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: possible deadlock in aio_poll
Message-ID: <20180911063335.GA3315@infradead.org>
References: <000000000000cbb35d05757f7a3a@google.com>
 <20180910165317.GA3237@infradead.org>
 <CAJfpeguWqJgU8EfjvOtsBYRbbY2J7Ck2oNUcLNS8my9g2eNZfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguWqJgU8EfjvOtsBYRbbY2J7Ck2oNUcLNS8my9g2eNZfA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 08:14:20PM +0200, Miklos Szeredi wrote:
> Why do pollable waitqueues need to disable interrupts generally?

Any waitqueue needs to disable interrupts for consistency.  We
always use spin_lock_irqsave in __wake_up_common_lock() for example.
