Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCDBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D33821480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I17wE5rJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D33821480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbeHPG5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 02:57:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38820 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeHPG5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 02:57:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so1398680pfh.5;
        Wed, 15 Aug 2018 21:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xc6yhhUfXTvJs3e1KNnqtBfZ+6DQtygjHrIODwlucIw=;
        b=I17wE5rJvFqsKi2l/kYTTAWRVQ5sDD1raY17KlK/Miq0n3EbHZ+VmZZpO0IAWHkyCt
         8D0NV5r8d+eVfkQ3D9ETc20wSRLIO6ynIxxG2/PBxP+5FNl6RuKjqI/zTOMrKy/13Fri
         d7WoTmDFf0SuyYAVJ5gg7wNvQBvDnN3d8dUD5uiZsza5BKEH1+C1TCArOEFrm+QWJZ8D
         BJPmt8JxaqcOKqXz7LHtBfhSA65KYBCqKD1gcMa1ibaKRthr/L7pz2Av801MywYplCwj
         Wpn0rcei9Tt6LXPD6RyjH0kxzfcGdZTsTL/7zsZytxPZda/mC/d4jFtiU/KUsaeLct8J
         WhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xc6yhhUfXTvJs3e1KNnqtBfZ+6DQtygjHrIODwlucIw=;
        b=ZD/wIMjmskJh36oCj4aagHZq2zKZiR8yXByHvwj815b6UFZPOy755xWbKUrqNUh8L7
         if83ocxcGiK5r2HMVp914H7rMRSRexSXCATc9Vls15fGqQ/SS9qlAAi6aVGeYZ3j19xU
         Jp+v30sUCCOdyM2EAxBJ5KzSNhqIuQIC/Pl/vXil4mwehN0TfJIeGpejJmIeLWjZhy7U
         u+pAbmnokC44Pdwo9T6ZjiWa8INAnxrwUoeUMCXiRTZSEzZQPpN3tsFxVBh/m3Mqz5pr
         Ocxk65wMkElH3BavrZfv4MNdurfxz0oY2YHycguvFOgRSFCMJkKzubToMYvQsvDQdtfa
         /W9g==
X-Gm-Message-State: AOUpUlEeYJAcVnLlXFuZWLBCMWRFQu/noBwztskqM/X2v7PGu+I03wZD
        zEx0VZVA1zpHlSbh1SniE/edtsaH
X-Google-Smtp-Source: AA+uWPyZzA8dL7XyctHegTbbtJCO7svAJyGCERxk0ze0Q4euxKB1cNv+0ObsL5ZqAdShD7n93KSe+g==
X-Received: by 2002:a62:3545:: with SMTP id c66-v6mr30488327pfa.63.1534392109824;
        Wed, 15 Aug 2018 21:01:49 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:97de])
        by smtp.gmail.com with ESMTPSA id r23-v6sm73398938pfd.144.2018.08.15.21.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 21:01:48 -0700 (PDT)
Date:   Wed, 15 Aug 2018 21:01:47 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>
Subject: Re: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2)
 command
Message-ID: <20180816040145.gqzqicab4s6kcbye@ast-mbp.dhcp.thefacebook.com>
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
 <20180729205835.34850-1-dancol@google.com>
 <e8f6e709-e694-ddad-b61e-d2ce1598dff3@iogearbox.net>
 <CAKOZuesH_LRdt15aXaRQRPSNzN-URTQWgSgr0zLsv8ZKFU9=9Q@mail.gmail.com>
 <20180730172641.7d516231@cakuba.netronome.com>
 <CAKOZuesNnY8oKimMk+gnUppMgZt92F+razSZCSfHu=xfq+snGg@mail.gmail.com>
 <67423232-be56-fd47-06e6-394812c2b918@iogearbox.net>
 <CAKOZueu5VdzCEkEv_nR4D0CtYi5r9XOdKOfpKvYWDGPnQGqMHQ@mail.gmail.com>
 <20180810225246.3d3pa5qvbtoh42bt@ast-mbp.dhcp.thefacebook.com>
 <CAKOZueuACjK0W4byW7omPvEJ-H-8MK1OU3ORrAfNtsEi8NxoPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZueuACjK0W4byW7omPvEJ-H-8MK1OU3ORrAfNtsEi8NxoPQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 01:37:12PM -0700, Daniel Colascione wrote:
> 
> > If we agree on that, should bpf_map_update handle it then?
> > Wouldn't it be much easier to understand and use from user pov?
> > No new commands to learn. map_update syscall replaced the map
> > and old map is no longer accessed by the program via this given map-in-map.
> 
> Maybe with a new BPF_SYNCHRONIZE flag for BPF_MAP_UPDATE_ELEM and
> BPF_MAP_DELETE_ELEM. Otherwise, it seems wrong to make every user of
> these commands pay for synchronization that only a few will need.

I don't think extra flag is needed. Extra sync_rcu() for map-in-map
is useful for all users. I would consider it a bugfix,
since users that examine deleted map have this race today
and removing the race is always a good thing especially since the cost
is small.

