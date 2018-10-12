Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EF0C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9952098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ct1K6xzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9952098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeJLUN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:13:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41872 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbeJLUN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:13:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id 23-v6so7533266qkh.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fm8VFBXrZgUov3w870PrXIKWfhSzCmyP1hJHCNsaimY=;
        b=ct1K6xzkEw9fzMo/0yUMROOnia7T2fBr1KD/2oLZuSm/2s7n0hTN5QC6Nll1R13TcB
         e2Bv7Ik1FhLdJHW0gBP8OgfStajWtoWFBSGnADxIHnZECr5mIdgyrAOrxnlN+MCHydY6
         lNbLWHgu/PNAG8Zdi1rszmnCuDslYQNBF4tK/e7AqCi3DtqwGRTu9MSLXssnPqt5/+Di
         CWfJBbCbGLs38HFnBhd8V0gm7PtSRt5uYxfyyQwdVEO1aggBFn3kTc7nAOp/B1/8nHs+
         Jo/RujBcaluIgjCTajSR/vbCS5zuL3vNVF5yiD+QVA3M1fvdYddaSD3BfXZPOG/GOoHJ
         jwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fm8VFBXrZgUov3w870PrXIKWfhSzCmyP1hJHCNsaimY=;
        b=CsDY6GbIBwr2D4HfxGp/tWufkD10+Bx8fp3NexuNKFIPHItWsp/fv+wGzrIfVfv3dQ
         wmM0TIXhxldopkBJdfeCB8i1q+E9uJ4jgmBfnvqfb7VGVaPp3glk6ck51iZyBA2tu9GD
         WI71nfu4klWaAz7X+7w9D39BX3+0xqKmbUMc3KEiSOIxvlFfPVKR640qg8gySC9WVLRb
         9oczeETHFGBylOK1rktyB2eSP9mX67GaJ/qJLRe4U88MEH1erRqfer6Ng/AUi6CKwUM/
         RzHDI4MqfVot1WA0nL3Hv6i0l+ut/N9Bl35dMcV1D1vwu66nVc56/kc42IJCxyCvFr3c
         g2jA==
X-Gm-Message-State: ABuFfojOO5B3A5nm9sYglIC/dvbsLsgGtdA0oK/l9pWs6SVGJocI1Fqk
        uNJ4GMJNFkMAkMAW3bb0BVPyhf/BqxU=
X-Google-Smtp-Source: ACcGV618YJioMg6CjQrjbWw/6J6gRnYb1UwOYK9aB9lvXZZxbnT6CCNxHmqoI8Lm7eKbMZ4U6v1rHw==
X-Received: by 2002:a37:7f81:: with SMTP id a123-v6mr5498413qkd.37.1539348098814;
        Fri, 12 Oct 2018 05:41:38 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id f85-v6sm815673qkh.35.2018.10.12.05.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 05:41:37 -0700 (PDT)
Date:   Fri, 12 Oct 2018 08:41:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] memcg, oom: throttle dump_header for memcg ooms
 without eligible tasks
Message-ID: <20181012124137.GA29330@cmpxchg.org>
References: <000000000000dc48d40577d4a587@google.com>
 <20181010151135.25766-1-mhocko@kernel.org>
 <20181012112008.GA27955@cmpxchg.org>
 <20181012120858.GX5873@dhcp22.suse.cz>
 <9174f087-3f6f-f0ed-6009-509d4436a47a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9174f087-3f6f-f0ed-6009-509d4436a47a@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 09:10:40PM +0900, Tetsuo Handa wrote:
> On 2018/10/12 21:08, Michal Hocko wrote:
> >> So not more than 10 dumps in each 5s interval. That looks reasonable
> >> to me. By the time it starts dropping data you have more than enough
> >> information to go on already.
> > 
> > Yeah. Unless we have a storm coming from many different cgroups in
> > parallel. But even then we have the allocation context for each OOM so
> > we are not losing everything. Should we ever tune this, it can be done
> > later with some explicit examples.
> > 
> >> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > Thanks! I will post the patch to Andrew early next week.
> > 
> 
> How do you handle environments where one dump takes e.g. 3 seconds?
> Counting delay between first message in previous dump and first message
> in next dump is not safe. Unless we count delay between last message
> in previous dump and first message in next dump, we cannot guarantee
> that the system won't lockup due to printk() flooding.

How is that different from any other printk ratelimiting? If a dump
takes 3 seconds you need to fix your console. It doesn't make sense to
design KERN_INFO messages for the slowest serial consoles out there.

That's what we did, btw. We used to patch out the OOM header because
our serial console was so bad, but obviously that's not a generic
upstream solution. We've since changed the loglevel on the serial and
use netconsole[1] for the chattier loglevels.

[1] https://github.com/facebook/fbkutils/tree/master/netconsd
