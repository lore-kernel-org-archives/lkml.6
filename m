Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC17BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8402081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZWZsE5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8402081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeK1QK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:10:27 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:45139 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeK1QK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:10:26 -0500
Received: by mail-pf1-f177.google.com with SMTP id g62so9562029pfd.12;
        Tue, 27 Nov 2018 21:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LCddcK4tw6CGnCM2cDc7YvELzgqnmsQ+NTYYZUUQpII=;
        b=AZWZsE5IsJmq4IuVBgmccuvhhnN2/17LRTw50IGNfh11b8MIuBYnz+l5U263jqwMMQ
         J8g7jnldWkElD125P5KalWwMy/rfMDO+1u7wi7vA+ZvJc+xWb0HpIwnNcfNtiUI4HIzE
         QsvAfLhmI1D2nAY0FaUXqJqv07U29DS3QRjnYmujnB4P084SVZg+oXHe3+p7xA8E9R+O
         KUblWpc+ybcOreqamjpaWBrKqoj5rWm9ea5/dCltRXYv+v7nSnXdLkzyoUTW7SUkhD0d
         uh3StPfeYLclCqouhc4k0FxvMdE3NLCpspj6Xar9fMfRIR7p5n5qMRmgoAap0oB846gU
         5FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LCddcK4tw6CGnCM2cDc7YvELzgqnmsQ+NTYYZUUQpII=;
        b=o1f6KMpraGoIfLbo4Tuo2d3/Pmu550uoDkWp7LOajTw5LI8TgQFvzwiTYYOkSwQIff
         9+TlQ4TNcq0uB4DXRWnGA2u7u3AcxNTkao+Tz4FKmxdSRBb/hUlsWTC7+lMDsM3AtuS3
         oM5fXC0VZomg8OJweOxJ+gB29HMylpyzlAxepsUNO+G7wXdsv3hYjzdJ2/EuZb/NHUmX
         LABTKR+/ShBRyMSs1oxIswMxLDb+FLn7LsB8Ip5swx1DbY07CiKNVMECaZD6frS+bBvu
         KAn1zMNUUeIpqJF+pWvGf0Q5pDQ3IakDxwteI+rrsw9Dz3VsSeC+n2LKJAJjtcqImnvm
         a3Mw==
X-Gm-Message-State: AA+aEWb0eJ5drHgFHVwCmUETk5mkWBwrLjzLXU3/eo01VOPwGy8/IA5Z
        BstMeutW7OmQY4nkFRwZYTY=
X-Google-Smtp-Source: AFSGD/Xuo5zAChDK1Ygi0nUPkiw/MRPpO9KqGyXVtKrLXEKVC5D3uLLqc9Upo+yql5TELygPacMOvg==
X-Received: by 2002:a63:82c6:: with SMTP id w189mr32207356pgd.344.1543381806259;
        Tue, 27 Nov 2018 21:10:06 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:15df])
        by smtp.gmail.com with ESMTPSA id l19sm10597187pfi.71.2018.11.27.21.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 21:10:05 -0800 (PST)
Date:   Tue, 27 Nov 2018 21:10:03 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Aaron Conole <aconole@bytheb.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Brouer <brouer@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        Rony Efraim <ronye@mellanox.com>,
        Simon Horman <horms@verge.net.au>,
        Marcelo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [RFC -next v0 1/3] bpf: modular maps
Message-ID: <20181128051001.wcsgqx3d6c2aszp6@ast-mbp.dhcp.thefacebook.com>
References: <20181125180919.13996-1-aconole@bytheb.org>
 <20181125180919.13996-2-aconole@bytheb.org>
 <20181127020608.4vucwmhrtu2cxrwu@ast-mbp.dhcp.thefacebook.com>
 <f7tftvmd2ey.fsf@dhcp-25.97.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7tftvmd2ey.fsf@dhcp-25.97.bos.redhat.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:24:05AM -0500, Aaron Conole wrote:
> 
>   1. Introduce flowmap again, this time, basically having it close to a
>      copy of the hashmap.  Introduce a few function calls that allow an
>      external module to easily manipulate all maps of that type to insert
>      / remove / update entries.  This makes it similar to, for example,
>      devmap.

what is a flowmap?
How is this flowmap different from existing hash, lpm and lru maps?
'close to a copy of hashmap'... why hashmap is not enough for your purpose?

