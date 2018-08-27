Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF43BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640D8208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640D8208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH1C3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:29:32 -0400
Received: from nautica.notk.org ([91.121.71.147]:51442 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbeH1C3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:29:31 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 808B7C009; Tue, 28 Aug 2018 00:40:52 +0200 (CEST)
Date:   Tue, 28 Aug 2018 00:40:37 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+d4252148d198410b864f@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: KASAN: invalid-free in p9stat_free
Message-ID: <20180827224037.GA18923@nautica>
References: <000000000000af648b057456e234@google.com>
 <20180827052412.GA26294@nautica>
 <CACT4Y+b1B5_Eg+j91GxaVbPk5sb8+SVOU_z5k9HYb4R716X9kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+b1B5_Eg+j91GxaVbPk5sb8+SVOU_z5k9HYb4R716X9kQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Mon, Aug 27, 2018:
> kfree and then null pointer is pretty common, try to run:
> 
> find -name "*.c" -exec grep -A 1 "kfree(" {} \; | grep -B 1 " = NULL;"

Hmm, right, it looks like somewhere between 5 and 10% of the kfree()
calls are followed by NULL assignment, that's "common enough" - not
generalized but not rare either.

> Leaving dangling pointers behind is not the best idea.
> And from what I remember a bunch of similar double frees were fixed by
> nulling the pointer after the first kfree.

In this case it really is an error to call p9stat_free again, so let's
just do both.
Will send the patches shortly.


Thanks,
-- 
Dominique
