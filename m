Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ED3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439442075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439442075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeGRKbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:31:43 -0400
Received: from nautica.notk.org ([91.121.71.147]:47278 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbeGRKbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:31:42 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 93FFEC009; Wed, 18 Jul 2018 11:54:35 +0200 (CEST)
Date:   Wed, 18 Jul 2018 11:54:20 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] net/9p/trans_virtio.c: replace mutex_lock with spin_lock
 to protect 'virtio_chan_list'
Message-ID: <20180718095420.GA28377@nautica>
References: <5B4EF511.7090104@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B4EF511.7090104@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Wed, Jul 18, 2018:
> spin_lock is more effective for short time protection than mutex_lock, as
> mutex lock may cause process sleep and wake up which consume much cpu
> time.

That's not a fast path operation, I don't mind changing things but I'd
like to understand why - these functions are only ever called at unmount
time or when something happens on the virtio bus (probe will happen on
probing on the pci bus and I'm not too sure on remove but probably pci
removal i.e. basically never?)

I don't see why this wouldn't work, but I won't take this without a
(good?) reason.

-- 
Dominique Martinet
