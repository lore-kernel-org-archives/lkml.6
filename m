Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7238C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A826E20837
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A826E20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeKHFWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:22:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41351 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeKHFVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:21:14 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so22539282qkj.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 11:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OomASdO+kpEr0msYFMfrGVRhsBEh4KrHwg5PWeSlNUs=;
        b=U0HHG+nFDSWwiQ6ClPN2Z5E1EkaR8gUPdrsz2OUOTRdCNWxTZboVIvWgWHushLfeLg
         23mBW4wcgdxQL/0KAu6377ihs4CWkykYYRGfz1fpSg0Rf0P+f349riNAxuxhCCNMupd2
         uI07dA40priNrX7ZPDRr65yCKwy3IW9W0S4MLK1gNovi6deMNK8wIxyW+QhItFRyieB4
         HtuAEF7WCui1HYWlpPaiO9jm4AwSVQSFUiBn4X6ikgZXPJ6sjZP+IrCHj2YOTR9/c0DO
         obY38JixRiaLtgdQ5g1ivGkF87urD6dKGWs5Ko4yvMOPs/yh0e/Yf+wROdSue6qAmJZj
         8XSw==
X-Gm-Message-State: AGRZ1gKmtrUcJk6YWebQNATK63YrWvDXFedHV3aHVTuLMW4vQyCI8EqP
        hgBeNBv3fDcxbW8hg18s9dCbsA==
X-Google-Smtp-Source: AJdET5d8N8Dv8PBlhBMCRpvMVGNL4qbWpwpqoZfJ1GAgNPmmx0AFLAAcp+i0B4rpjxJ2ogFpbS4Jaw==
X-Received: by 2002:aed:36a9:: with SMTP id f38mr1651880qtb.367.1541620164356;
        Wed, 07 Nov 2018 11:49:24 -0800 (PST)
Received: from dhcp-12-212-173.gsslab.rdu.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id i26sm1289863qtc.13.2018.11.07.11.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 11:49:23 -0800 (PST)
Message-ID: <1541620162.4051.5.camel@redhat.com>
Subject: Re: [Qestion] Lots of memory leaks when mounting and unmounting nfs
 client to server continuously.
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     zhong jiang <zhongjiang@huawei.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        herbert@gondor.apana.org.au, trond.myklebust@hammerspace.com,
        bfields@redhat.com
Cc:     linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org
Date:   Wed, 07 Nov 2018 14:49:22 -0500
In-Reply-To: <5BD86392.7070200@huawei.com>
References: <5BD85266.6000301@huawei.com>
         <1DEE371C-69EB-4D92-8F78-535AA5203007@redhat.com>
         <5BD86392.7070200@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-14.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-30 at 21:58 +0800, zhong jiang wrote:
> On 2018/10/30 21:06, Benjamin Coddington wrote:
> > Hi zhong jiang,
> > 
> > Try asking in linux-nfs.. but I'll also note that 3.10-stable may
> > be missing a number of fixes to leaks in the NFS GSS code.
> > 
> > I can see a more than a few fixes to memory leaks with:
> > git log --grep=leak --oneline net/sunrpc/auth_gss/
> > 
> 
> Thanks for your reply.  I has tested some of them in the upsteam as
> you have said.  but It fails to solve the issue completely.
> hence, I turn to the relevant experts whether they have happened to
> the issue or  can give some suggestion or not.
> 
> Thanks,
> zhong jiang
> > Ben
> > 
> > On 30 Oct 2018, at 8:45, zhong jiang wrote:
> > 
> > > Hi,   Herbert
> > > 
> > > Recently,  I  hit  a memory leak issue when  mounting and
> > > unmounting nfs with  the way of  krb5.
> > > The issue happens to the linux-3.10-stable.
> > > 
> > > I find that slab-1024 and slab-512 will take up most of the
> > > memory.  And it can not be freed.
> > > Meanwhile, it result in rpcsec_gss_krb5 can be unregistered as
> > > well.
> > > 
> > > 

Are you running the latest 3.10-stable?

This sounds very familiar to something I encountered a while ago and it
was a sunrpc cache related problem.  The patch that fixed it for me is
in 3.10.106 though.

Can you check if this cache is growing indefinitely?
/proc/net/rpc/auth.rpcsec.context

If it is large, try to flush explicitly with:
date +%s  > /proc/net/rpc/auth.rpcsec.context/flush

If all that checks out, you may need the below upstream fix, but it
went into v3.10.106 as
6a4a5fd svcrpc: don't leak contexts on PROC_DESTROY

commit 6a4a5fd4c7bc6a06ca26ad7327d046d8d3c0932a
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Mon Jan 9 17:15:18 2017 -0500

    svcrpc: don't leak contexts on PROC_DESTROY
    
    commit 78794d1890708cf94e3961261e52dcec2cc34722 upstream.
    
    Context expiry times are in units of seconds since boot, not unix time.
    
    The use of get_seconds() here therefore sets the expiry time decades in
    the future.  This prevents timely freeing of contexts destroyed by
    client RPC_GSS_PROC_DESTROY requests.  We'd still free them eventually
    (when the module is unloaded or the container shut down), but a lot of
    contexts could pile up before then.
    
    Fixes: c5b29f885afe "sunrpc: use seconds since boot in expiry cache"
    Reported-by: Andy Adamson <andros@netapp.com>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>
    Signed-off-by: Willy Tarreau <w@1wt.eu>

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 62663a0..e625efe 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1518,7 +1518,7 @@ static void destroy_use_gss_proxy_proc_entry(struct net *net) {}
        case RPC_GSS_PROC_DESTROY:
                if (gss_write_verf(rqstp, rsci->mechctx, gc->gc_seq))
                        goto auth_err;
-               rsci->h.expiry_time = get_seconds();
+               rsci->h.expiry_time = seconds_since_boot();
                set_bit(CACHE_NEGATIVE, &rsci->h.flags);
                if (resv->iov_len + 4 > PAGE_SIZE)
                        goto drop;
