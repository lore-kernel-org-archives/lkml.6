Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19966C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04F920840
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04F920840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbeGaDN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:13:58 -0400
Received: from nautica.notk.org ([91.121.71.147]:54752 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbeGaDN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:13:57 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 9473EC009; Tue, 31 Jul 2018 03:36:11 +0200 (CEST)
Date:   Tue, 31 Jul 2018 03:35:56 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Greg Kurz <groug@kaod.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH 2/2] net/9p: add a per-client fcall
 kmem_cache
Message-ID: <20180731013556.GA1530@nautica>
References: <20180730093101.GA7894@nautica>
 <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
 <1532943263-24378-2-git-send-email-asmadeus@codewreck.org>
 <5B5FB8F0.6020908@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B5FB8F0.6020908@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Tue, Jul 31, 2018:
> Could you help paste some test result before-and-after the patch applied?

The only performance tests I did were sent to the list a couple of mails
earlier, you can find it here:
http://lkml.kernel.org/r/20180730093101.GA7894@nautica

In particular, the results for benchmark on small writes just before and
after this patch, without KASAN (these are the same numbers as in the
link, hardware/setup is described there):
 - no alloc (4.18-rc7 request cache): 65.4k req/s
 - non-power of two alloc, no patch: 61.6k req/s
 - power of two alloc, no patch: 62.2k req/s
 - non-power of two alloc, with patch: 64.7k req/s
 - power of two alloc, with patch: 65.1k req/s

I'm rather happy with the result, I didn't expect using a dedicated
cache would bring this much back but it's certainly worth it.

> > @@ -1011,6 +1034,7 @@ void p9_client_destroy(struct p9_client *clnt)
> >  
> >  	p9_tag_cleanup(clnt);
> >  
> > +	kmem_cache_destroy(clnt->fcall_cache);
> 
> We could set NULL for fcall_cache in case of use-after-free.
> 
> >  	kfree(clnt);

Hmm, I understand where this comes from, but I'm not sure I agree.
If someone tries to access the client while/after it is freed things are
going to break anyway, I'd rather let things break as obviously as
possible than try to cover it up.

-- 
Dominique
