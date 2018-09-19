Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E574C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3325C2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lgy6BU9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3325C2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeITCQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:16:22 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37342 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeITCQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:16:22 -0400
Received: by mail-yb1-f193.google.com with SMTP id b3-v6so1918816yba.4;
        Wed, 19 Sep 2018 13:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SFS8Lh1KZvhT9uv45CxE2V/El8vzUnhToBMg2e/2ESE=;
        b=Lgy6BU9rbAz9B+9j2q8Ne37Ui5kxxvBdv/zM6a+UifvpGYN+vOH5MpnifYw/VCZEzY
         Vnlcm7UIThuRvQaHx2if+i6+zPRFhnpM+kxV1Eb/y7qAMq+UxqlAW7ZD9AOAn/uoO0Io
         z+Nq/G0b2CWotNNpUK50afvc8vM5FSh5J5KzybOZasURj9a4WJAoLZG+agATxBDjFDp8
         QC/U3dR1rEwHsbNt0I0AVLJyv21ykeRxpciaQD/KORhD/1E+f1ZA/AfKBNdZtfvpqT+P
         dC6+n1RY/33SohaCb/GFPUNXh7bG7ApGxsHvosVcSzMpl0oLheKS5rFooPnUu6aWKj4l
         bu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SFS8Lh1KZvhT9uv45CxE2V/El8vzUnhToBMg2e/2ESE=;
        b=i1vO6FiYkRj/xLao5BWaJ55YOVfqqbNA9h9N/4rqm7F4mIx/Br2iS0MffWOhwclXUe
         smlDym6eCEsG0ZLLvUcSaVy5N5Y8P4IZ08kW5x/VH7pmkY9jxbh+V5DRj7zr4TEQD8Pu
         HWrCFr8UTwxYff9FDl3l0XDivT+oJcLMM+bHNY3gt9ycI1LfQ7biH9Ns9Ia8yX6uEyXK
         dihSs1uAlG3XkS95hudFr5T66AHKeqjYRZ1QCOPrutYwf0qQdWEz6P10cOZat+hy4ffJ
         W7oOyCZR3/gSkOy+Z6G7O97y/EJdYfvIvgZmSqEESthdpz9814gcqqLQyacFLWynFP8+
         ksbA==
X-Gm-Message-State: APzg51Ae2yfrGEct0xAQKF+LQF1mUPU8Tdui7Lit4vcxym8okT8+n/05
        76svTitIKFJq88hc/bGdbQk=
X-Google-Smtp-Source: ANB0VdY/f/qclueqZfDDl9qhUGJg+KiLZOxi56lO6pgbVKHf/ZDdI6uzUvKBx321XlOwtBY63RZDrQ==
X-Received: by 2002:a25:104:: with SMTP id 4-v6mr16121980ybb.220.1537389405385;
        Wed, 19 Sep 2018 13:36:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:cfe3])
        by smtp.gmail.com with ESMTPSA id n187-v6sm7811071ywn.76.2018.09.19.13.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 13:36:44 -0700 (PDT)
Date:   Wed, 19 Sep 2018 13:36:41 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180919203641.GD902964@devbig004.ftw2.facebook.com>
References: <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
 <20180911160532.GB10082@ming.t460p>
 <20180911163032.GA2966370@devbig004.ftw2.facebook.com>
 <20180911163443.GD10082@ming.t460p>
 <20180911163856.GB2966370@devbig004.ftw2.facebook.com>
 <20180912015247.GA12475@ming.t460p>
 <20180912155321.GE2966370@devbig004.ftw2.facebook.com>
 <20180912221139.GB15810@ming.t460p>
 <20180918124909.GA902964@devbig004.ftw2.facebook.com>
 <20180919025148.GB20560@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919025148.GB20560@ming.t460p>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ming.

On Wed, Sep 19, 2018 at 10:51:49AM +0800, Ming Lei wrote:
> > That doesn't make sense to me.  How is synchronize_rcu() gonna change
> > anything there?
> 
> As you saw in the new post, synchronize_rcu() isn't used for avoiding
> the race. Instead, it is done by grabbing one extra ref on atomic part.

This is layering violation.  It just isn't a good idea to depend on
percpu_ref internal implementation details like this.

> > 1. Callers of percpu_ref must not depend on what internal
> >    synchronization construct percpu_ref uses.  Again, percpu_ref
> >    doesn't even use regular RCU.
> > 
> > 2. If there is already an outer RCU protection around ref operation,
> >    that RCU critical section can and should be used for
> >    synchronization, not percpu_ref.
> 
> I guess the above doesn't apply any more because there isn't new 
> synchronize_rcu() introduced in my new post.

It still does.  The problem is that what you're doing creates
dependencies on percpu_ref's implementation details - how it
guarantees the mode transition visibility using what sort of
synchronization construct.

> > Right?  There isn't much wheel to reinvent here and using percpu_ref
> > for the above is likely already incorrect due to the different RCU
> > type being used.
> 
> No RCU story any more, :-)
> 
> It might work, but still a reinvented wheel since perpcu-refcount does
> provide same function. Not mention the inter-action between the two
> mechanism may have to be considered.

Why would the two independent mechanisms interact with each other?
What's problematic is entangling two mechanisms in an implementation
dependent way.

> Also there is still cost introduced in WRITER side, and the
> synchronize_rcu() often takes a bit long, especially there might be lots
> of namespaces, each need to run one synchronize_rcu(). We have learned
> lessons in converting to blk-mq for scsi, in which synchronize_rcu()
> introduces long delay in booting.

You're already paying that latency.  It's not like percpu_ref can make
it happen magically without paying the same cost.  You also can easily
overlay the two grace periods as the percpu_ref part can be
asynchronous (if you still care about it).  But, from what I've read
till now, it doesn't even look like you'd need to do anything with
percpu_ref if you all you need to do is shutting down issue of new
commands.

Thanks.

-- 
tejun
