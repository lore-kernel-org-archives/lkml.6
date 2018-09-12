Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D5EC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A364020833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aXSu+hXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A364020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeILVBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:01:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53604 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeILVBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PxfS/9f6yTpE9ZgTQ8/cv2PwqzOJ4nIbA2ojseAd9Ko=; b=aXSu+hXd0Wz0PgWFph0vSpPFP
        lEspZmIVHEns4m5xBN5j3mzVBIpq7Ux0FOqt9ZYyKnheX2Ikdqme+nzdilNqksIvMN5bQlhX2avqn
        30q4wuR6ZmaqPJ7eQengDnum7CX1TJJ8X4qZM7D4Bdczmmz1nxtqHdJuqtDPWwertNsEg3D2+GChA
        Xxi7IEGEEGjB4K8RxDKfdVICGxQriAHNKm15GDKmVKsjeF8n2PC3H5ipNocpYCHoQB5VJuDtrnc4Z
        sidkE4o4dhB01SC3ehaDWKa/RG4txaEZDHB+Fstn2ccBsy7le0dlH0d/0Z5h5noyoDWtSspnsFGvK
        R0ih9M/KQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g07Uj-0000uy-Pv; Wed, 12 Sep 2018 15:55:57 +0000
Date:   Wed, 12 Sep 2018 08:55:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 4/4] fs/dcache: Eliminate branches in
 nr_dentry_negative accounting
Message-ID: <20180912155557.GA18304@bombadil.infradead.org>
References: <1536693506-11949-1-git-send-email-longman@redhat.com>
 <1536693506-11949-5-git-send-email-longman@redhat.com>
 <20180912023610.GB20056@bombadil.infradead.org>
 <bf7592c3-dc1d-635e-8bb0-717f6e8a54d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf7592c3-dc1d-635e-8bb0-717f6e8a54d9@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 11:49:22AM -0400, Waiman Long wrote:
> > unless our macrology has got too clever for the compilre to see through
> > it.  In which case, the right answer is to simplify the percpu code,
> > not to force the compiler to optimise the code in the way that makes
> > sense for your current microarchitecture.
> >
> I had actually looked at the x86 object file generated to verify that it
> did use cmove with the patch and use branch without. It is possible that
> there are other twists to make that happen with the above expression. I
> will need to run some experiments to figure it out. In the mean time, I
> am fine with dropping this patch as it is a micro-optimization that
> doesn't change the behavior at all.

I don't understand why you included it, to be honest.  But it did get
me looking at the percpu code to see if it was too clever.  And that
led to the resubmission of rth's patch from two years ago that I cc'd
you on earlier.

With that patch applied, gcc should be able to choose to use the
cmov if it feels that would be a better optimisation.  It already
makes one different decision in dcache.o, namely that it uses addq
$0x1,%gs:0x0(%rip) instead of incq %gs:0x0(%rip).  Apparently this
performs better on some CPUs.

So I wouldn't spend any more time on this patch.
