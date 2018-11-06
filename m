Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758F6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E65B20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 04:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Mx6zFfJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E65B20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeKFOFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:05:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45309 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbeKFOFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:05:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id p17-v6so5125229pfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 20:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q3R+B0JRUV6P8aofn5fxnlAD1Qv4joMYXhk3A++lgJI=;
        b=Mx6zFfJdkjSt3YfuIs3QmGn309FVWiyadvUnfdrDqM3I954bsrWZN73qqQ1HaSodXP
         oPXTqzJlIutFDZuFuD6DzO0NoFryV7MUMlqbtt3KrLW+1+3u/x/tF0VyA7CWr5xMnREF
         fPGeKQ68zJg34ni7NkQvN8sgKnzRZA0QSiLns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q3R+B0JRUV6P8aofn5fxnlAD1Qv4joMYXhk3A++lgJI=;
        b=Dp8PpRKDJmKpYabQPkP5g5Xr+45Dl3n6HAn8pXQOMEumlvbGVy1ut87I1+gPA5QoiB
         lOwbMUuzhHV6RAfjwD7Z4GXVqwUp7ri1bCkDgCREK+QpPbWnbIWlgd8Cfvk1ZQecl2JG
         I3rXneGlImS5J74Xa5DrnFsAmGXmKsIvUhYjXTXr4vl/FMypBEhacKB4ZRfUg66GSrrQ
         cFfpZrqUJrP27blLCJfqLR3OiUC1Jx8JasbT0ikLoORYy+Embc0C/Czw0G6cj++cVwqu
         DJzJigleCR+A9d2M50xvn5DQOJCH9xG8/qKwv7jsWgxvPDCx3xg41DIzQ8LOBKlyAawp
         NeZg==
X-Gm-Message-State: AGRZ1gL/559Jg9yMlVk4wvVX61QlF6xZMU81ZHi4lWed1Znma/7NwwSp
        O50rtEHymiRoGVuHw+CLmisAIQ==
X-Google-Smtp-Source: AJdET5esrjKnhSMMosjTOjd19edUnr2HXvTnQmkEOXnnY3KcDM5h9CLov/5rUGo0q18xj3qXRez+HQ==
X-Received: by 2002:a65:6249:: with SMTP id q9-v6mr22542845pgv.392.1541479325412;
        Mon, 05 Nov 2018 20:42:05 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id g17-v6sm64241209pfe.37.2018.11.05.20.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 20:42:04 -0800 (PST)
Date:   Mon, 5 Nov 2018 20:42:03 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 8/8] pstore/ram: Correctly calculate usable PRZ bytes
Message-ID: <20181106044203.GD139199@google.com>
References: <20181101235200.28584-1-keescook@chromium.org>
 <20181101235200.28584-9-keescook@chromium.org>
 <20181102180111.GA14942@google.com>
 <CAGXu5jLcawCKQL9i6poyJu3v3Ru6VcAXqwa5dxKWQL1Bp+Ai_w@mail.gmail.com>
 <20181105044217.GB56850@google.com>
 <CAGXu5jJzszbMOZAj_K0tfBV-3Rs67_gedHd+RwSXvzY38Fu3dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJzszbMOZAj_K0tfBV-3Rs67_gedHd+RwSXvzY38Fu3dA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 09:04:13AM -0800, Kees Cook wrote:
> On Sun, Nov 4, 2018 at 8:42 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > Dumping the magic bytes of the non decompressable .enc.z files, I get this
> > which shows a valid zlib compressed header:
> >
> > Something like:
> > 48 89 85 54 4d 6f 1a 31
> >
> > The 0b1000 in the first byte means it is "deflate". The file tool indeed
> > successfully shows "zlib compressed data" and I did the math for the header
> > and it is indeed valid. So I don't think the data is insane. The buffer has
> > enough room because even the very small dumps are not decompressable.
> 
> Interesting. So the kernel wouldn't decompress it even though it's the
> right algo and untruncated? That seems worth fixing.

I just can't reproduce the issue though :) I am wondering if it was something
to do with compression being done by an older version of the algorithm or a
buggy algorithm, and the decompressor is newer. Or something.

Not sure if its worth spending more time on, I'll park it for now unless you
want me to dig deeper into it.

- Joel

