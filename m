Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B78C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6485B213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SGQ6leoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6485B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeJDFvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:51:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53213 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeJDFvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:51:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id 189-v6so7229579wmw.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D64BKrUDvTlVRvbo8SVJ9ZtVo81e+rMqar1KzbqDu9w=;
        b=SGQ6leoMyvlxlvyIfqM9wqfjoNZpwLQqCQ4I7t4zctJeK3d9PBhHcw82VR14n2GLlw
         yBtM80tKlXabpkDUjPmoLf56dH/oEzBUN8IYWWDA86zEDKJbEYzBj1FRq2IRudSZDbV5
         byHgDAmX8lEkOinYyQD9tleDtGnxGBZz2XbMQAfFqiBDF2lrXsRBgGZNchsBevywBJCU
         qePiX1zBrT+nvmg+tiRjmszgK693co4sDZu7Q0xCEYGV/PkdcvQkdGh3VIqj1uPfnyyo
         1CII+6Sl1pPmhsVKXKi378JZluBJ+6FzwfsPmb3+zOnPWXRj6Yu2HIpF3bdHqitFUYDf
         grUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D64BKrUDvTlVRvbo8SVJ9ZtVo81e+rMqar1KzbqDu9w=;
        b=oEmtU94uNaMwWpF4+Cr9DjWxH6+mIcdZak4tYzvD605FIbO1wnez95ceZb6ziaoyJ/
         vFaeHyFwpKq1Axwwcl6RJqwcDwiUgmNBdQUqSmme39T1cVj7gmRabbnHHDaoxsmb/uNS
         FahBz/a+VPNo9BVD4HMPN55icv22Dmf5B+wuZlLy56DCPbi17UMv8MSsQD5N7Hmt6RAq
         UD//3WRAq3En7cnsn8qvTejLNPJ+NNK7b/V3NZT8kKFCvj6yrmICg+noNrrwCMptRCcV
         QD4O0MoqdtSxb788pmblWLMuGtPOBYMdw33BdZwdcvlYZHC9OrpUBXk6E9ewLWd8HkTR
         Iafg==
X-Gm-Message-State: ABuFfojg4x14hHb/o+HetLz0oux00hb76HdyBFbDYGo49PmkDslLmRIa
        tsLOxXgehsivhkLPyEkUgWmaNg==
X-Google-Smtp-Source: ACcGV618/1xQGN6yePlU9fm6rh1NudnVq5gFMSnpRqFkAcbF2/nAMRim4/hgfTxOcamk9QgVuWg8BA==
X-Received: by 2002:a1c:f516:: with SMTP id t22-v6mr2735067wmh.103.1538607664963;
        Wed, 03 Oct 2018 16:01:04 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id q16-v6sm2594739wrn.41.2018.10.03.16.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 16:01:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g7q8b-0004TD-30; Wed, 03 Oct 2018 17:01:01 -0600
Date:   Wed, 3 Oct 2018 17:01:01 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
Message-ID: <20181003230101.GC3466@ziepe.ca>
References: <20180924195716.30848-1-natechancellor@gmail.com>
 <20181003223518.GA8700@ziepe.ca>
 <CAKwvOdnvXDtBAw_6_MSOEst3DBjbr8w6Pv6b4i=pC50s=gcq3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnvXDtBAw_6_MSOEst3DBjbr8w6Pv6b4i=pC50s=gcq3Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 03:53:58PM -0700, Nick Desaulniers wrote:
> On Wed, Oct 3, 2018 at 3:35 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Sep 24, 2018 at 12:57:16PM -0700, Nathan Chancellor wrote:
> > > Clang warns when one enumerated type is implicitly converted to another.
> > >
> > > drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
> > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
> > >                                                     ~ ^~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
> > > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> > >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
> > >                                                     ~ ^~~~~~~~~~~~~~~~~
> > >
> > > The type mlx4_ib_qp_flags explicitly provides supplemental values to the
> > > type ib_qp_create_flags. Make that clear to Clang by changing the
> > > create_flags type to u32.
> > >
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > >  include/rdma/ib_verbs.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Applied to for-next, thanks
> >
> > BTW, how are you compiling with clang?
> 
> https://github.com/ClangBuiltLinux/linux/wiki/Steps-for-compiling-the-kernel-with-Clang
> try it out, let us know bugs you find here:
> https://github.com/ClangBuiltLinux/linux/issues

Oh I see, you are doing ARM64!

> Still looking into the case you pointed out earlier.  I suspect the
> signedness of enums was undefined in c90, then defined as
> implementation specific in c99 (though I'm still researching that
> book report).  Thanks for your insights!

C enums details are a topic that seems more confusing every time it
gets brought up :(

Jason
