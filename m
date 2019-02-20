Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50C0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6052083E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ARxKToOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfBTROo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:14:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44045 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBTROn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:14:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id a3so2390681pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 09:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0ogzB/eLPDhQ9ArE1Qt3owprzZeh0BVk1RVAdwYpGyc=;
        b=ARxKToOla+rCjQNxnSAo3ig/DK++KdZdZskaGrkLf6WRGwf6pCgx2tirh5b6ha0Zu3
         sNRw9DwdwBDz7/GkKLCAC09XSCOp+mNb3gj4hR/z4Zc4JCgwQNcLAPYXSjR8WRg+8TX6
         jjyyoil8oNYyigEnNEKcNzWT6u1DuYrbvIZm/7uLeL3q92E3XVaczYPo66/SmOMUn7Dt
         K4GD5N7325G4Bgg7LEkfjl+O7pvHSKbtKc9dpaJhH+rafAyVevSZAihhcNAHeovTA2Rl
         W7qgY/X3H7EmQiwkO4AZ2oIk4W7DvuaX+b+KCrsLL+eOR4Ne2Izyplx1S+hMG5xgBDWz
         oOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0ogzB/eLPDhQ9ArE1Qt3owprzZeh0BVk1RVAdwYpGyc=;
        b=RNmE4d2i4oxrldACQ6XkBUp3e+HBYfV9RKDysVry05GTZY8dH3LCkC6+j7DFwGrjp0
         L5N7Atm4PTOg9NJunAJXM7jgwM0Vtp3jRZk7So729LWYh2DP8WzrbI5h41g8OSkkCwB2
         QSUK15aOHaeT/25psTKoaKfRMQz2HqgTlyUt95jLRDCgN53GLZ5f8gJo1T1G+/L6qfY8
         99qn92MvA4noTB7ZmWf8PrS9iEr5cfPUXm772jR6pjyh9344pcJeU68GapWxQuFxZ/xW
         eiECYk7acP3qkHaB9QCy01NMOdlEr3klEZjD5D9PmTDA5RxuTZPRz6+c2TevmzRBQl2c
         +1fQ==
X-Gm-Message-State: AHQUAuYzFCM3ec/wIjx6DHnDsq4RMVJ5lhPsrtcZPdf4l3rqO4IEKlEc
        Mi7TwR+BlC3LD5ZcOETDwAjDWA==
X-Google-Smtp-Source: AHgI3IbG5wIt4/PIBta+oV+qSfQL/uGqrqbW8MmpjhF4GJD0aszlP8xC3t99RYxf1pdQh/iEmJgEGA==
X-Received: by 2002:a62:b40b:: with SMTP id h11mr17916493pfn.108.1550682882537;
        Wed, 20 Feb 2019 09:14:42 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id a1sm14481053pfn.26.2019.02.20.09.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 09:14:42 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gwVSD-0000t8-CI; Wed, 20 Feb 2019 10:14:41 -0700
Date:   Wed, 20 Feb 2019 10:14:41 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, jackm@dev.mellanox.co.il,
        majd@mellanox.com, OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: Spread completion vectors for proxy CQs
Message-ID: <20190220171441.GH8429@ziepe.ca>
References: <20190218183302.1242676-1-haakon.bugge@oracle.com>
 <38187795-4082-42C2-AF56-E6C89EE7DE39@oracle.com>
 <66C92ED1-EE5E-4136-A7D7-DBF8A0816800@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66C92ED1-EE5E-4136-A7D7-DBF8A0816800@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 06:32:50PM +0100, Håkon Bugge wrote:
>    Anyway, Jason mentioned in a private email that maybe we could use the
>    new completion API or something? I am not familiar with that one
>    (yet).

I was thinking of the stuff in core/cq.c - but it also doesn't have
automatic comp_vector balancing. It is the logical place to put
something like that though..

An API to manage a bundle of CPU affine CQ's is probably what most
ULPs really need.. (it makes little sense to create a unique CQ for
every QP)

alloc_bundle()
get_cqn_for_flow(bundle)
alloc_qp()
destroy_qp()
put_cqn_for_flow(bundle)
destroy_bundle();

Let the core code balance the cqn's and allocate (shared) CQ
resources.

Jason
