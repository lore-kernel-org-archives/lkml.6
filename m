Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBFFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B6D21568
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B6D21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeHXAKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:10:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbeHXAKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:10:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08A7C804BAAC;
        Thu, 23 Aug 2018 20:39:26 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33CEC101041F;
        Thu, 23 Aug 2018 20:39:23 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w7NKdNkW007565;
        Thu, 23 Aug 2018 16:39:23 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w7NKdNQ5007561;
        Thu, 23 Aug 2018 16:39:23 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 23 Aug 2018 16:39:23 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
cc:     linux-crypto@vger.kernel.org, Mike Snitzer <msnitzer@redhat.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Deadlock when using crypto API for block devices
Message-ID: <alpine.LRH.2.02.1808231621220.8560@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 23 Aug 2018 20:39:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 23 Aug 2018 20:39:26 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

There's a deadlock reported here: 
https://bugzilla.kernel.org/show_bug.cgi?id=200835

* dm-crypt calls crypt_convert in xts mode
* init_crypt from xts.c calls kmalloc(GFP_KERNEL)
* kmalloc(GFP_KERNEL) recurses into the XFS filesystem, the filesystem 
	tries to submit some bios and wait for them, causing a deadlock

I was thinking how to fix it, there are several possibilities, but all 
have some caveats. So, I'd like to ask you as crypto code maintainers, 
what's the appropriate solution.


1. don't set CRYPTO_TFM_REQ_MAY_SLEEP in dm-crypt
=================================================
If we don't set it, dm-crypt will use GFP_ATOMIC and GFP_ATOMIC may fail. 
The function init_crypt in xts.c handles the failure gracefully - but the 
question is - does the whole crypto code handle allocation failures 
gracefully? If not and if it returns -ENOMEM somewhere, it would result in 
I/O errors and data corruption.

I'd like to ask if you as maintainers of the crypto API could say, whether 
the crypto code handles GFP_ATOMIC allocations failure gracefully or not.

Note that dm-crypt currently uses encryption, hashes and authernticated 
encryption, so if we go down this path, we must make sure that the code 
for these operations will never return -ENOMEM.

2. use memalloc_noio_save/memalloc_noio_restore in dm-crypt
===========================================================
This makes all allocations use GFP_NOIO implicitly, so it would fix the 
deadlock. But - the crypto API can offload encryption to the cryptd 
thread, and if the offload happens, the memalloc_noio_save flag is lost 
and the allocation can still be done with GFP_KERNEL and cause a deadlock.

3. introduce new flag CRYPTO_TFM_REQ_MAY_SLEEP_NOIO
===================================================
Would you like to introduce it?

4. make the whole crypto code use GFP_NOIO instead of GFP_KERNEL?
=================================================================


... any other suggestions?

Mikulas
