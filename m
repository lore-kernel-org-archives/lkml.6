Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D75C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1043B20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BcrTgjsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1043B20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeFUNDl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:03:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933169AbeFUNDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9IXDWkAXBmF71F26ka05Xhv15UCQmVpOrP73Kt2mfHk=; b=BcrTgjsfSzRN7ycJu/L75BmXq
        cjgMs4QrXp8ygBEr6TZ3AfU+71Q2+6hmZP6wjPLEGuuH601qRAw4sim51qnPAJMXgUfXD/cr97fQ0
        PX5TMaSXPHFbaC6S1f1QlBulVS4N57YL3hPYplDUVuU3lsrSN8wC5g+xiXVv+iuIVdmU/8Lx/7EXp
        AMmfSQT9EMRfQ62tTpJeTVx4nUspt2UI6rGWJUom0A0BXYZTEbX66CGtSJgaBPwzKAWexcDzT80dT
        bwhISU0jVI58EhdSdKhRR7o5FM25xb2pRz7Ile1mornUF3e3RA6Xrva10Q6P7zjq1JN7UQvXXkvFo
        w7wv3gitQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVzFH-00049A-R0; Thu, 21 Jun 2018 13:03:27 +0000
Date:   Thu, 21 Jun 2018 06:03:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        dgilbert@interlog.com, Al Viro <viro@zeniv.linux.org.uk>,
        fujita.tomonori@lab.ntt.co.jp, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org, Alexander Nezhinsky <alexandern@mellanox.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>, stgt@vger.kernel.org
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in
 release
Message-ID: <20180621130327.GB24925@infradead.org>
References: <20180615152335.208202-1-jannh@google.com>
 <20180615164009.GD30522@ZenIV.linux.org.uk>
 <90063ef3-68fa-e983-9b47-838e6076b0f4@interlog.com>
 <813e817b-bb2f-4a47-6225-9e39f19be278@kernel.dk>
 <20180621123431.GA558@infradead.org>
 <CAG48ez3BWeZkW5XG814K4o7p0KWXVm9Gpzh2rTthNei=4fhH-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3BWeZkW5XG814K4o7p0KWXVm9Gpzh2rTthNei=4fhH-A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 02:51:16PM +0200, Jann Horn wrote:
> In the package https://packages.debian.org/stretch/tgt:
>   https://sources.debian.org/src/tgt/1:1.0.73-1/usr/bs_sg.c/?hl=131#L131
>   https://sources.debian.org/src/tgt/1:1.0.73-1/usr/bs_sg.c/?hl=236#L236

This is for real, although it is an optional case in an optional plug
in, so I'm not sure if any one actually uses bsg read/write with it
for real.

The usual aspects added. (the question is if bsg read/write support
is actually used in real life or can be removed)

> In the package https://packages.debian.org/stretch/sg3-utils:
>   https://sources.debian.org/src/sg3-utils/1.42-2/examples/bsg_queue_tst.c/?hl=60#L60

This is just example code.
