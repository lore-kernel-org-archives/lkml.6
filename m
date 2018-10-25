Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60D1C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE9F20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE9F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeJZFNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:13:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44563 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeJZFNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:13:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2-v6so1573065pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59fJwxGkJCfDnuB2vQZBu74z4pwjA+yCejf1qSEfCX8=;
        b=m0pLWxByfAj3LcW4Vm54o0dEcgIlHcjHdf7ON7dWDe9l1bcRFoin7dhoCYacTE3q8l
         byDAXGeo01v/eKzRlJ9cyrem5ceQvtZbxfu9mgJYH3XsNuOTa4/8DowfBOaKDtnMlrHU
         ESx82EKOTi8E8gGRM7Ig3kh5pjIAPZsRW3CLj5SEEQ2mBtDh+qBgq9QfXB2RJPr39aUO
         ip95eDwjT8NaUOWJFsUkPXTvgI3GYUDoPMENo97fYvVzNxgmQcVc5TDvbXXCSFMQabl/
         8osmcBLDEmZFkMvspcYIAUU6Dvsi3zCzUhR23eKDNjo5w69RmOOKXOIsfr8LHPK4toMb
         tsfw==
X-Gm-Message-State: AGRZ1gIb9fT/d2aXtAxt1CT0LPChnLdQqDtZ5gg+8gteOAJxKPv905U8
        mxc3y0jjrH3MpQAUb6wH9ro=
X-Google-Smtp-Source: AJdET5e8a9vNknPGP4KDUfLKXY+lGDaQ9UU6JD3FlB3VZrNh6Okvmxhm+c2h4+NoDn8fduATvLmw7Q==
X-Received: by 2002:a62:7701:: with SMTP id s1-v6mr690562pfc.159.1540499973416;
        Thu, 25 Oct 2018 13:39:33 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id i4-v6sm10576651pgt.4.2018.10.25.13.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 13:39:32 -0700 (PDT)
Message-ID: <1540499971.66186.51.camel@acm.org>
Subject: Re: [PATCH 3/3] kernel/workqueue: Suppress a false positive lockdep
 complaint
From:   Bart Van Assche <bvanassche@acm.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "tytso@mit.edu" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 13:39:31 -0700
In-Reply-To: <11db45f85e2f763c23ae32834dcd016adfce8ad6.camel@sipsolutions.net>
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-4-bvanassche@acm.org>
         <2cebeb88640433ce473bc40f9a5c7e06d0661e4d.camel@sipsolutions.net>
         <1540487511.66186.31.camel@acm.org>
         (sfid-20181025_191156_926182_FF0802A9) <11db45f85e2f763c23ae32834dcd016adfce8ad6.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 21:51 +-0200, Johannes Berg wrote:
+AD4 +AFs ... +AF0
+AD4 diff --git a/fs/direct-io.c b/fs/direct-io.c
+AD4 index 093fb54cd316..9ef33d6cba56 100644
+AD4 --- a/fs/direct-io.c
+AD4 +-+-+- b/fs/direct-io.c
+AD4 +AEAAQA -629,9 +-629,16 +AEAAQA int sb+AF8-init+AF8-dio+AF8-done+AF8-wq(struct super+AF8-block +ACo-sb)
+AD4  	 +ACo This has to be atomic as more DIOs can race to create the workqueue
+AD4  	 +ACo-/
+AD4  	old +AD0 cmpxchg(+ACY-sb-+AD4-s+AF8-dio+AF8-done+AF8-wq, NULL, wq)+ADs
+AD4 -	/+ACo Someone created workqueue before us? Free ours... +ACo-/
+AD4 +-	/+ACo
+AD4 +-	 +ACo Someone created workqueue before us? Free ours...
+AD4 +-	 +ACo Note the +AF8-nested(), that pushes down to the (in this case actually
+AD4 +-	 +ACo pointless) flush+AF8-workqueue() happening inside, since this function
+AD4 +-	 +ACo might be called in contexts that hold the same locks that an fs may
+AD4 +-	 +ACo take while being called from dio+AF8-aio+AF8-complete+AF8-work() from another
+AD4 +-	 +ACo instance of the workqueue we allocate here.
+AD4 +-	 +ACo-/
+AD4  	if (old)
+AD4 -		destroy+AF8-workqueue(wq)+ADs
+AD4 +-		destroy+AF8-workqueue+AF8-nested(wq, SINGLE+AF8-DEPTH+AF8-NESTING)+ADs
+AD4  	return 0+ADs
+AD4  +AH0
+AD4 +AFs ... +AF0
+AD4  /+ACoAKg
+AD4 - +ACo flush+AF8-workqueue - ensure that any scheduled work has run to completion.
+AD4 +- +ACo flush+AF8-workqueue+AF8-nested - ensure that any scheduled work has run to completion.
+AD4   +ACo +AEA-wq: workqueue to flush
+AD4 +- +ACo +AEA-subclass: subclass for lockdep
+AD4   +ACo
+AD4   +ACo This function sleeps until all work items which were queued on entry
+AD4   +ACo have finished execution, but it is not livelocked by new incoming ones.
+AD4   +ACo-/
+AD4 -void flush+AF8-workqueue(struct workqueue+AF8-struct +ACo-wq)
+AD4 +-void flush+AF8-workqueue+AF8-nested(struct workqueue+AF8-struct +ACo-wq, int subclass)
+AD4  +AHs
+AD4  	struct wq+AF8-flusher this+AF8-flusher +AD0 +AHs
+AD4  		.list +AD0 LIST+AF8-HEAD+AF8-INIT(this+AF8-flusher.list),
+AD4 +AEAAQA -2652,7 +-2653,7 +AEAAQA void flush+AF8-workqueue(struct workqueue+AF8-struct +ACo-wq)
+AD4  	if (WARN+AF8-ON(+ACE-wq+AF8-online))
+AD4  		return+ADs
+AD4  
+AD4 -	lock+AF8-map+AF8-acquire(+ACY-wq-+AD4-lockdep+AF8-map)+ADs
+AD4 +-	lock+AF8-acquire+AF8-exclusive(+ACY-wq-+AD4-lockdep+AF8-map, subclass, 0, NULL, +AF8-THIS+AF8-IP+AF8)+ADs
+AD4  	lock+AF8-map+AF8-release(+ACY-wq-+AD4-lockdep+AF8-map)+ADs
+AD4  
+AD4  	mutex+AF8-lock(+ACY-wq-+AD4-mutex)+ADs
+AD4 +AFs ... +AF0

I don't like this approach because it doesn't match how other kernel code uses
lockdep annotations. All other kernel code I know of only annotates lock depmaps
as nested if the same kernel thread calls lock+AF8-acquire() twice for the same depmap
without intervening lock+AF8-release(). My understanding is that with your patch
applied flush+AF8-workqueue+AF8-nested(wq, 1) calls lock+AF8-acquire() only once and with the
subclass argument set to one. I think this will confuse other people who will read
the workqueue implementation and who have not followed this conversation.

I like Tejuns proposal much better than the above proposal.

Bart.

