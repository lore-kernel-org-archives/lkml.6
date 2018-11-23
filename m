Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293EAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3506A20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RHBwBLXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3506A20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405475AbeKWUfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:35:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38739 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387976AbeKWUfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:35:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so9776864ede.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 01:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B905NUlu7NO/lkKENI+4l+00+wjv/xrHDHnjASuen4U=;
        b=RHBwBLXdk16SM6wRpqu+HsKSUhbia94DKMlHmvAiopsC9UWoazgMBUwbsMhEZy9/Wu
         QDYFuMQCl9mUwSsfdtkWGvyKY8I55ggR+YXeoH11JpTlAdPhihCO+ISzKmPiDkQLWahN
         XlUOZc29xef58VEgPUH/XHknHcGSGvxeR2tDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B905NUlu7NO/lkKENI+4l+00+wjv/xrHDHnjASuen4U=;
        b=fSUDVAOnwh0bvD6VcqeDSht9F5RMcf4cmQpb636qCU/KOG0OuFbRIyQZ5h52/o6UZT
         nZpaX5bYKQhOBD38pPK4JqP6qEm7JYFTf6demHszg0YkUG2dTE/3Ug8GYAS5Ipnoy1YD
         8Cot83WFiSXA35CmjNAKvrETHh2wL4fpwH0+c5iIcLuPD8E7tDNKpn/PjUq4XMrEN2rt
         kclJwMTqjzxdRm3e6WvKFOyGn1UKinM1a4EBs+JrEYYXpenaRMDRUMZbb/xhDfbDaHGu
         RJnQoUOmXelY+bLOE0t0X9qp4+M6eu2HkQmxqPLMxD7EVLRZT6um2qVgEdsKfT+AtoTn
         47DQ==
X-Gm-Message-State: AA+aEWaaKteIZ0Wpn8c0mf0IIoiw7cgE36LnwrJur8MkEx5PECxWZ0pz
        VX9fFEkV5sfsWehurstP5PaPAQ==
X-Google-Smtp-Source: AFSGD/Xq4sF42sa7e5r13AbHnTDDzmibzCndnPZ7Bnr2O0+r4szYIDQiFzyz+KIdvyQFndvsTa2+BQ==
X-Received: by 2002:a05:6402:13d6:: with SMTP id a22mr12011207edx.39.1542966694718;
        Fri, 23 Nov 2018 01:51:34 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id b11-v6sm4015511ejd.16.2018.11.23.01.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 01:51:34 -0800 (PST)
Date:   Fri, 23 Nov 2018 10:51:28 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 05/10] staging: erofs: add a full barrier in
 erofs_workgroup_unfreeze
Message-ID: <20181123094739.GA3487@andrea>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-6-gaoxiang25@huawei.com>
 <20181122102230.GF3189@kroah.com>
 <1d1fd688-0cb5-cbac-9213-f56f7e356bca@huawei.com>
 <20181122185058.GA3466@andrea>
 <b2f367c5-a54c-9edf-42ad-d256bc725cf7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2f367c5-a54c-9edf-42ad-d256bc725cf7@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 10:51:33AM +0800, Gao Xiang wrote:
> Hi Andrea,
> 
> On 2018/11/23 2:50, Andrea Parri wrote:
> > On Thu, Nov 22, 2018 at 06:56:32PM +0800, Gao Xiang wrote:
> >> Hi Greg,
> >>
> >> On 2018/11/22 18:22, Greg Kroah-Hartman wrote:
> >>> Please document this memory barrier.  It does not make much sense to
> >>> me...
> >>
> >> Because we need to make the other observers noticing the latest values modified
> >> in this locking period before unfreezing the whole workgroup, one way is to use
> >> a memory barrier and the other way is to use ACQUIRE and RELEASE. we selected
> >> the first one.
> >>
> >> Hmmm...ok, I will add a simple message to explain this, but I think that is
> >> plain enough for a lock...
> > 
> > Sympathizing with Greg's request, let me add some specific suggestions:
> > 
> >   1. It wouldn't hurt to indicate a pair of memory accesses which are
> >      intended to be "ordered" by the memory barrier in question (yes,
> >      this pair might not be unique, but you should be able to provide
> >      an example).
> > 
> >   2. Memory barriers always come matched by other memory barriers, or
> >      dependencies (it really does not make sense to talk about a full
> >      barrier "in isolation"): please also indicate (an instance of) a
> >      matching barrier or the matching barriers.
> > 
> >   3. How do the hardware threads communicate?  In the acquire/release
> >      pattern you mentioned above, the load-acquire *reads from* a/the
> >      previous store-release, a memory access that follows the acquire
> >      somehow communicate with a memory access preceding the release...
> > 
> >   4. It is a good practice to include the above information within an
> >      (inline) comment accompanying the added memory barrier (in fact,
> >      IIRC, checkpatch.pl gives you a "memory barrier without comment"
> >      warning when you omit to do so); not just in the commit message.
> > 
> > Hope this helps.  Please let me know if something I wrote is unclear,
> 
> Thanks for taking time on the detailed explanation. I think it is helpful for me. :)
> And you are right, barriers should be in pairs, and I think I need to explain more:
> 
> 255 static inline bool erofs_workgroup_get(struct erofs_workgroup *grp, int *ocnt)
> 256 {
> 257         int o;
> 258
> 259 repeat:
> 260         o = erofs_wait_on_workgroup_freezed(grp);
> 261
> 262         if (unlikely(o <= 0))
> 263                 return -1;
> 264
> 265         if (unlikely(atomic_cmpxchg(&grp->refcount, o, o + 1) != o)) <- *
> 266                 goto repeat;
>             imply a memory barrier here
> 267
> 268         *ocnt = o;
> 269         return 0;
> 270 }
> 
> I think atomic_cmpxchg implies a memory barrier semantics when the value comparison (*) succeeds...

Correct.  This is informally documented in Documentation/atomic_t.txt
and formalized within tools/memory-model/.


> 
> I don't know whether my understanding is correct, If I am wrong..please correct me, or
> I need to add more detailed code comments to explain in the code?

Yes, please; please review the above points (including 1. and 3.) and
try to address them with inline comments.  Maybe (if that matches the
*behavior*/guarantee you have in mind...) something like:

[in erofs_workgroup_unfreeze()]

	/*
	 * Orders the store/load to/from [???] and the store to
	 * ->refcount performed by the atomic_set() below.
	 *
	 * Matches the atomic_cmpxchg() in erofs_workgroup_get().
	 *
	 * Guarantees that if a successful atomic_cmpxchg() reads
	 * the value stored by the atomic_set() then [???].
	 */
	smp_mb();
	atomic_set(&grp->refcount, v);


[in erofs_workgroup_get()]

	/*
	 * Orders the load from ->refcount performed by the
	 * atomic_cmpxchg() below and the store/load [???].
	 *
	 * See the comment for the smp_mb() in
	 * erofs_workgroup_unfreeze().
	 */
	if (unlikely(atomic_cmpxchg(&grp->refcount, o, o + 1) != o))
		goto repeat;

Thanks,
  Andrea


> 
> Thanks,
> Gao Xiang
> 
> 
> > 
> >   Andrea
> > 
> > 
> >>
> >> Thanks,
> >> Gao Xiang
> >>
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
