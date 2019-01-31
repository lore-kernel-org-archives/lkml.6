Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F8EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C1521900
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548936488;
	bh=8xiqhQL74NPCiIrNIibRzSqNG12ZScZrkr4RT+/ftLI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=HsucUCCmeTrI4Twb5v9tBqd7mw060jUgCGmO2/6zsHhaj5AFmOZMs4kii+ngI3Lh1
	 ONqBqQuE1QfDWc1Zl4EnUzgbttJp04kOtXfo4wgiiqMUZmsbAxlx/3eAZ1t5XfMKn8
	 sEDTuMyxdRH7KM/FAZV2eypSWGc801GAEMV6oYgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbfAaMIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:08:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbfAaMIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:08:06 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 823272086C;
        Thu, 31 Jan 2019 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548936485;
        bh=8xiqhQL74NPCiIrNIibRzSqNG12ZScZrkr4RT+/ftLI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HGbUe8Q1y9wvs/YPD5E+gnIYoMx6uM84L7B+qKScVKjTy3XS9bKf3oqMNjO4lIWaJ
         mtmeCQSycFybNyNiIhRtBCY8yioMvLQ8WsXzv2sI+VsohOMh7wvEnIrEkcA7TZbDp8
         5qkehS+eB/MhingrKgW+FQP5eleT04QyLDTmX4xg=
Date:   Thu, 31 Jan 2019 13:08:00 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Daniel Gruss <daniel@gruss.cc>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 2/3] mm/filemap: initiate readahead even if IOCB_NOWAIT
 is set for the I/O
In-Reply-To: <aea9a09a-9d01-fd08-d210-96b94162aba6@gruss.cc>
Message-ID: <nycvar.YFH.7.76.1901311306570.3281@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-3-vbabka@suse.cz> <aea9a09a-9d01-fd08-d210-96b94162aba6@gruss.cc>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019, Daniel Gruss wrote:

> If I understood it correctly, this patch just removes the advantages of 
> preadv2 over mmmap+access for the attacker.

Which is the desired effect. We are not trying to solve the timing aspect, 
as I don't think there is a reasonable way to do it, is there?

-- 
Jiri Kosina
SUSE Labs

