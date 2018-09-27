Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B362C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A872170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SeW7QvDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A872170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeI1Esz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:48:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38530 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeI1Esy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:48:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so2870071pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f0ZdSQxirSoHLra8ampMfkHCK7RdatlNDW+DHll5IsE=;
        b=SeW7QvDaQ1KO4GL6DG/PJZIkd37D4HJwFg8Np+bfCwBuZ6upTX03Q8pjQ58W3+4zPy
         swl7vO+yUjmikNrOaNvG6iwfS52ybxoP27FpCDxsjeE8T6IUgtJvOOh+ZjuVl8kQYYrY
         ZTR56LMOic6VC7mkpUaS4ZoJ320VZzaxNc6K1dvg0TG/aBTMvp5oLt38fpXPi+GPsgnQ
         H27pPhfB1qeQaN7CE4nF5x4Hdy6fEwF3bzYqXbFedhbGzQjazqSmHq3xYh/hnysJCtGd
         Q9dJ3G+r7bKWKW8W+UggHGHMau9W5xS7tgirO7+ovAprcV7Ko/pnxcfm0ASsd4r2WsBP
         k2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f0ZdSQxirSoHLra8ampMfkHCK7RdatlNDW+DHll5IsE=;
        b=QQFaC53VYAuRtCkxXL9cj08wJqMILZRMxm2oSxqI5tpZ2fEeRAqM+q+ziUmk9CrDh8
         H4uvf37uacGUb7JBu360nGCtq8I3LVAQBS72T+sg5MEXGH9LFGGgH0oMgSfaywmybVMw
         J705M8S9tbd2vjBOGyr0vqDgBSU1mKQVFdzjJTqYAX7QmRw92nBKE7AXibkyYbteKuDY
         7EQsbY0N87F1I+evIU38CSs+p/EsF5hYIPz5GFV4lMjMifEPGbz1ggdNScXKze+xru2s
         4bcNUg7tSKZa/SlIlx0HZT/x23ZaZgYg0mgZDm9WpodrFk4EnztDDEs3akyFnAhzCS6n
         TMfA==
X-Gm-Message-State: ABuFfognrPxUJeaKQDHMTKB9UWgTNfAirGa9JWepbbYc3fHWNpIA4rqx
        eITusJK+gNoVB9ou0B7gcvzHYw==
X-Google-Smtp-Source: ACcGV632VXu6kc87JbLQgD5NBDA60V43nqTwmRGYoJ69OVTLL3BOZOd5P7zFCKWAWN81sOgAsSIqqw==
X-Received: by 2002:a62:8a91:: with SMTP id o17-v6mr1771610pfk.184.1538087303703;
        Thu, 27 Sep 2018 15:28:23 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id g6-v6sm4642203pfb.11.2018.09.27.15.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:28:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g5elh-0007iT-4v; Thu, 27 Sep 2018 16:28:21 -0600
Date:   Thu, 27 Sep 2018 16:28:21 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
Message-ID: <20180927222821.GC28301@ziepe.ca>
References: <20180924195716.30848-1-natechancellor@gmail.com>
 <CAKwvOdkr+ovYgmqWENHkCcAWMC+xC6NYne6SBycq_KXscpHxEQ@mail.gmail.com>
 <20180924222737.GA26973@flashbox>
 <CAKwvOdkZ-0k4BhXYz0wj3wXNyy95nKFe9aYXxXveLafuviGG2w@mail.gmail.com>
 <20180925023722.GA32600@ziepe.ca>
 <20180927010803.GA7640@flashbox>
 <20180927044826.GC24889@ziepe.ca>
 <CAKwvOdnmg2XY6K-8jTna3EKR1Nx04gOm6ZoywUwQO_CSANR_jg@mail.gmail.com>
 <20180927202849.GA11120@flashbox>
 <CAKwvOdnMOcdKPNHwKbcsg8rJX3_hDTgY752Nb4hgMC2D4p5aRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnMOcdKPNHwKbcsg8rJX3_hDTgY752Nb4hgMC2D4p5aRg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 01:34:16PM -0700, Nick Desaulniers wrote:

> > Neither ib_qp_create_flags nor mlx4_ib_qp_flags have negative values, is
> > signedness necessary?
>
> enums are by default restricted to the range of ints.  

That's not quite right, the compiler sizes the enum to be able to fit
the largest value contained within, today that is int, but if we added
1<<31, then it would become larger.

Values intended to hold bitfields should always be unsigned, so u32 is
an appropriate for flags where the flags are defined in an enum.

Jason
