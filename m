Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBBEC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB6220657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gz2DKQ3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB6220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeKCG71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:59:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34412 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeKCG70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:59:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id f12-v6so396635plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KtknSZMVwbqRe2epToELUMXm1/RPnXkthtqb+Nt1VuM=;
        b=gz2DKQ3JEX2TfV/zi9yIkS1EnWUS/o47uiUzui3bRLsekuzZyu6VkMlUC4uSyGoMcL
         b4uup+p7QcVh7uhTZYmGh8PkJsjtv8rQAZEfBeY6t4wgJRm1fYspCLmvq+bTznUjwLDs
         e5VojFkv44+zzMsLv9CSKu9dViEkOqHpSunJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KtknSZMVwbqRe2epToELUMXm1/RPnXkthtqb+Nt1VuM=;
        b=N2Tk00PU0keNzyUntWnpig7rDaHemuHrlpU+86Q9aPCU5xTePRG76QaNONDPSpw45K
         c4iJ8fkaN/8wYT9DCNAyg18Q1c10v0kbAdgTblE8m9XR7nQyW2Nj4nvLLoY/k9+6vQbZ
         ebyQeKSi+sWuJv+7e2bc7F5tVLwobyTtfYNSTqSewMo9+X26AGR5iEt0DnaiQOPySUXR
         dLtEuht0a/ZROBaYegTFCoWS+3Z6IRj6W++HtiL/nyyrNR6C/hQWc/ntM7C0lALLCW1d
         7LsRFTl3c/fg5mT+vPy1WDHqKUtaHw+C/+xFK6P7/7KrxpzV6OkUGUIuy1RdClr95s02
         apdQ==
X-Gm-Message-State: AGRZ1gIMwEpjPtwrwAwCJ1hT6exA8FXFkfa4AFiyz4i80/lc+mRuhoom
        9U929E8jB5WQjx5CzJDh+0XeNg==
X-Google-Smtp-Source: AJdET5cIU/3QXW48Cx9gj9a+m9nWmynVRCFLYcp0UjGrWBIFnnrvvmLaUsdA9SxnUGg/DdES/kK//g==
X-Received: by 2002:a17:902:7c87:: with SMTP id y7-v6mr13273468pll.232.1541195435762;
        Fri, 02 Nov 2018 14:50:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 126-v6sm40486891pff.105.2018.11.02.14.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 14:50:34 -0700 (PDT)
Date:   Fri, 2 Nov 2018 14:50:33 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 7/8] pstore: Remove needless lock during console writes
Message-ID: <20181102215033.GA99294@google.com>
References: <20181101235200.28584-1-keescook@chromium.org>
 <20181101235200.28584-8-keescook@chromium.org>
 <20181102183204.GC14942@google.com>
 <CAGXu5jKNjipB2yWf_7pE+m29Ma8KUOXotz2L=Pc7=wBZC3AGdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKNjipB2yWf_7pE+m29Ma8KUOXotz2L=Pc7=wBZC3AGdA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 01:40:06PM -0700, Kees Cook wrote:
> On Fri, Nov 2, 2018 at 11:32 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Thu, Nov 01, 2018 at 04:51:59PM -0700, Kees Cook wrote:
> >> Since commit 70ad35db3321 ("pstore: Convert console write to use
> >> ->write_buf"), the console writer does not use the preallocated crash
> >> dump buffer any more, so there is no reason to perform locking around it.
> >
> > Out of curiosity, what was the reason for having this preallocated crash
> > buffer in the first place? I thought the 'console' type only did regular
> > kernel console logging, not crash dumps.
> 
> The primary reason is that the dumper needs to write to somewhere and
> we don't know the state of the system (memory allocation may not work
> for example).
> 
> The other frontends tend to run at "sane" locations in the kernel. The
> dumper, however, is quite fragile.

Makes sense. thanks.

> > Also I wonder if Namhyung is still poking around that virtio pstore driver he
> > mentioned in the commit mentioned above. :)
> 
> Did that never land? I thought it mostly had to happen at the qemu end?
> 
> With nvdimm emulation, we can just use ramoops. :)
> 

Yes it seems like it never landed: https://lwn.net/Articles/694742/

One of the nice thing about his virtio set though, vs the nvdimm way is that
he actually gets a directory on the host instead of a backing memory file.
Then he can just list this directory and see all the pstore files as he shows
in his example.

I guess it should not be too hard to write a tool to post-process the nvdimm
images and convert it to files anyway :)

thanks,

 - Joel

