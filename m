Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5577C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CBC213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="GvDQD7Pr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CBC213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeJFIlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 04:41:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36966 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeJFIlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 04:41:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id c22-v6so13125321edc.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 18:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yI7XQyg/f4gf3BQBzbr8fAnSSZ5R3RfZyAjZBppbxUs=;
        b=GvDQD7PryO0QH/Kd01NmYyscWGF79P91k74YZwvuTGBz0LdD/TuFxjLoyF4QdEuw14
         L3Fq/JyV42C+DEYXMe/2WBsZ0CwuHk2/+SSV0XUJOpli0MbWu8PTSntu5FurcDbZB9x1
         OYzaxVY/GJH5XY32lpSU0cM8dlWaAHhb7XdJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yI7XQyg/f4gf3BQBzbr8fAnSSZ5R3RfZyAjZBppbxUs=;
        b=GEOGJ3iPMNkljFI+tBUmaw9VjI3s5aXA5paYq+q1hOERdAHYtsv1FAbuLY6Q5o1Dyk
         xxacut/ctdOhmN7Hm0ReAl8V76Im8ELQhlP6IiTlMKU4sEdV3/srXlOaGnn+GLG0/PBB
         kdFEAgXBJ+1VxlY+VADCRaT7HUHnzuXA0eo9yMbmG4opDBzF1/MO4g8POUorAC1H/Y6H
         QKr3yDfaWP2nAtRgBIiEHG5l3jmLM63EeywzBbnfweQxu8k9edw7Ir8OVbFVf3oKzOhD
         U8KlWPo9y1ojkDnVllg98Ghc6lOeo5qNaenxqcpA+cnrTjh/We0Rm2GZbOAqN5XC/bAi
         f5PA==
X-Gm-Message-State: ABuFfohgEe6oH96Y9m2Gy2s22hIejSkO98NGupzXHadgTBUtoultN6I9
        RyoE/MfeIfHSG3+8CMKLP8AMqg==
X-Google-Smtp-Source: ACcGV61QKX1eomDUWB8pRJR6h1iYVxTdpJty1A2HMsvi3gLzugBSFIjIJKq//ozsw8jTgjJy2I3uDA==
X-Received: by 2002:a50:b941:: with SMTP id m59-v6mr17246313ede.20.1538790027610;
        Fri, 05 Oct 2018 18:40:27 -0700 (PDT)
Received: from [192.168.0.189] (dhcp-5-186-116-96.cgn.ip.fibianet.dk. [5.186.116.96])
        by smtp.gmail.com with ESMTPSA id n41-v6sm3033811edd.7.2018.10.05.18.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 18:40:26 -0700 (PDT)
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com> <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
 <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
 <36D6F606-6922-4057-B1F8-2B30993962AE@zytor.com>
 <20181004091651.GB21151@gmail.com>
 <df1bddc1-e71b-dbd8-a24f-01a46d462a79@zytor.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <85bef695-f7af-0e77-9790-6a6965b9d02b@rasmusvillemoes.dk>
Date:   Sat, 6 Oct 2018 03:40:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <df1bddc1-e71b-dbd8-a24f-01a46d462a79@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-04 21:33, H. Peter Anvin wrote:

> Here is the horrible code I mentioned yesterday.  This is about
> implementing the immediate-patching framework that Linus and others have
> discussed (it helps both performance and kernel hardening):

Heh, I did a POC in userspace some years ago for loading an "eventually
constant" value into a register - the idea being to avoid a load in
cases like kmemcache_alloc(foo_cachep) or kmemcache_free(foo_cachep, p),
and I assume this is something along the same lines? I didn't do
anything with it since I had no idea if the performance gain would be
worth it, and at the time (before __ro_after_init) there was no good way
to know that the values would really be constant eventually. Also, I had
hoped to come up with a way to avoid having to annotate the loads.

I just tried expanding this to deal with some of the hash tables sized
at init time which I can see was also mentioned on LKML some time ago.
I'm probably missing something fundamental, but there's some sorta
working code at https://github.com/villemoes/rai which is not too
horrible (IMO). Attaching gcc at various times and doing disassembly
shows that the patching does take place. Can I get you to take a look at
raimacros.S and tell me why that won't work?

Thanks,
Rasmus
