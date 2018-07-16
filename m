Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39FBECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6371F20850
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fKu1JI33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6371F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeGPUvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:51:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39477 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeGPUvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:51:06 -0400
Received: by mail-pf0-f193.google.com with SMTP id j8-v6so2198190pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3FbBCZAkwQ3N++5n7c5iTyDadyqyBKP40T5OviaDu64=;
        b=fKu1JI33SDlaCiJraKz+rkpxXVErlahOGvFWMikBz+E/mQZL862a3F1qC10G2qgLwQ
         qrhK+VNYZyPrUNE70rZ6vWilXkvW0SOMMjMb8jcm9Ws9ntRsCRygAMWMx+yXBzVWaCgY
         QRzo2FsuIcqx9ht8jPjkpXssHoETH7mYFBZWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3FbBCZAkwQ3N++5n7c5iTyDadyqyBKP40T5OviaDu64=;
        b=px0VmHXvDVQVGoNQ4/umu+cT2DurVrL7PhVK5SDzogjOP5V7lc1u8s+7+O4OklQPsd
         gNmkwkcQPIvOHATafewaXJ5wtSbNnHV0aknG3oYANVtwNnPXaXnK9+/gNNJlHp8U+sj7
         nij8u182RYF2Ec/lR6svy4TGmEb1B1eqmgj5qdwlMiUaH4KShldkaQARXVDOGzuYcsOV
         GkrCPKlU9UsEv1nsYwnUBD2ZApNOcOeBIPlz2vmMp4YiqEtBsOCz1fjoqS/PbVH4nzWs
         QXLMNsowX+DgP65GxvQVeiSfosnFvKkZX750zxxzXyuTgF5pCHnmG0EV1OZ97p7x4cuV
         JoDw==
X-Gm-Message-State: AOUpUlH+SiYnqaT4i1una1CN/6zNb6iehr8evDt3wCboLbrM6g3gvx2q
        xa8dP8LAPQlrXFWW45L/bOLSyIlJmAg=
X-Google-Smtp-Source: AAOMgpf5o15AU+ygdEP6DSAj2ByrNYbrsK08eCP+KIZSTkjH11+rjjqhgsPcMm+htW7JKgaRmFuUYQ==
X-Received: by 2002:aa7:88d3:: with SMTP id p19-v6mr19458623pfo.160.1531772525325;
        Mon, 16 Jul 2018 13:22:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id c7-v6sm15664497pfh.25.2018.07.16.13.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 13:22:04 -0700 (PDT)
Date:   Mon, 16 Jul 2018 13:22:04 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Todd Kjos <tkjos@android.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        Arve H <arve@android.com>, Martijn Coenen <maco@android.com>,
        Tobias Lindskog <tobias.lindskog@sonymobile.com>,
        kernel-team@android.com
Subject: Re: [PATCH] staging: android: ashmem: Shrink directly through
 shmem_fallocate
Message-ID: <20180716202204.GA160902@joelaf.mtv.corp.google.com>
References: <20180706214416.184691-1-joel@joelfernandes.org>
 <20180716094851.GA31480@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716094851.GA31480@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 11:48:51AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 06, 2018 at 02:44:16PM -0700, Joel Fernandes wrote:
> > From: Tobias Lindskog <tobias.lindskog@sonymobile.com>
> > 
> > When ashmem_shrink is called from direct reclaim on a user thread, a
> > call to do_fallocate will check for permissions against the security
> > policy of that user thread.  It can thus fail by chance if called on a
> > thread that isn't permitted to modify the relevant ashmem areas.
> > 
> > Because we know that we have a shmem file underneath, call the shmem
> > implementation of fallocate directly instead of going through the
> > user-space interface for fallocate.
> > 
> > Bug: 21951515
> 
> What does this "Bug:" line mean to any of us?  :)

Yeah I should have been more careful when sending Tobias's patch ;-)

> I'll go delete it, and I fixed up the subject to have 'staging: android'
> in it as well.  Please do that next time.

Sure will do, thanks for fixing it up this time. Sorry about that.

Regards,

-Joel

