Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8080DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33425216E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfsTkRSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33425216E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeHOI0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 04:26:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38766 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeHOI0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 04:26:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so86034pgq.5;
        Tue, 14 Aug 2018 22:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iayc9PU8uz1nzxw26VCJrklSbvE+GzIM4T/NEwyvLNQ=;
        b=AfsTkRSqkEa3J2zTSLjpuH7YUf/niXcwJsiga2bdABg2Emd21O2g/8Z63iqgohzY5s
         sgLR28/qls2NYURg9KjfUockvzMgMycUqkoUAE83DeIjjIl/PuJPLSQCg7mFmmvCs55e
         ON47q1A/5Egur4rxj6aGW+Wm3BRcXYRfkeL8hXi1n0/NrppYQfe7cZ2ykymWehllNcyV
         ow0KWV/7pF3N8gzHU370oA4hkKG0PG+tmP9065XHK6UMqHn8q8c80uUm+Mn4u8e3J4VL
         EgCq7lMn1JMXB0xKd1nANHVTd/7NLfXnRz5bXy2rz+crWOnIquQD1NDdoGvZgL2TFenH
         ulLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iayc9PU8uz1nzxw26VCJrklSbvE+GzIM4T/NEwyvLNQ=;
        b=fD6DWgDe1L0yJVFDqdiN5B9411GKuJzCh06p+gtCnCPiXQToPuVHLKkJ4a8HamIlpA
         g6kOzEND19JV07z/cxd3fvmKmy68XajD51W9HOlLkrGgGQxKnsh7eloo7RV0Mfke+oor
         Y4ANJVooIHdlqjEa0lRimIUUryL6txA+tGvCNYXFyFekKFCCDWSl/tfTXSwuJUGdqNoN
         UcielVfylYtghBEz5tRgCKPR7nqyTAuFxe2qmqEtLuEPjTspFoZf4U91kQIri4wH29Nf
         L5xaHeWGsX4qCPtkYX+o3COyTZxY8ecBmN694/aaXw9B7oAVQW5QGDR+GcXE+j0fjFWy
         tmVw==
X-Gm-Message-State: AOUpUlFnO4F67+9YtC92pjFTHUbamPux1+fwd/fi7xwOvt5qnrMNffyF
        8uDTBun0N9z/0wC4sQt2CQ4=
X-Google-Smtp-Source: AA+uWPynpTfJ1q5zdKMyh+RtgdtIF4IEAaRRpJ4wwK30vi2mTUgiu7evw1DjYuGZsKRl2lSFKD5vQg==
X-Received: by 2002:a62:198e:: with SMTP id 136-v6mr5152856pfz.103.1534311354574;
        Tue, 14 Aug 2018 22:35:54 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::1:cf3a])
        by smtp.gmail.com with ESMTPSA id f67-v6sm40462963pfe.75.2018.08.14.22.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 22:35:53 -0700 (PDT)
Date:   Tue, 14 Aug 2018 22:35:51 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     David Ahern <dsahern@gmail.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, mst@redhat.com
Subject: Re: [RFC PATCH net-next V2 0/6] XDP rx handler
Message-ID: <20180815053550.5g4f5qeb7r4wtgm5@ast-mbp>
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
 <20180814003253.fkgl6lyklc7fclvq@ast-mbp>
 <5de3d14f-f21a-c806-51f4-b5efd7d809b7@redhat.com>
 <20180814121734.105769fa@redhat.com>
 <03ab3b18-9b13-8169-7e68-ada307694bc1@redhat.com>
 <08bf7aec-078a-612d-833f-5b3d09a289d0@gmail.com>
 <aa9cf883-7822-70a7-5ab5-c873b69c2098@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa9cf883-7822-70a7-5ab5-c873b69c2098@redhat.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 08:29:45AM +0800, Jason Wang wrote:
> 
> Looks less flexible since the topology is hard coded in the XDP program
> itself and this requires all logic to be implemented in the program on the
> root netdev.
> 
> > 
> > I have L3 forwarding working for vlan devices and bonds. I had not
> > considered macvlans specifically yet, but it should be straightforward
> > to add.
> > 
> 
> Yes, and all these could be done through XDP rx handler as well, and it can
> do even more with rather simple logic:
> 
> 1 macvlan has its own namespace, and want its own bpf logic.
> 2 Ruse the exist topology information for dealing with more complex setup
> like macvlan on top of bond and team. There's no need to bpf program to care
> about topology. If you look at the code, there's even no need to attach XDP
> on each stacked device. The calling of xdp_do_pass() can try to pass XDP
> buff to upper device even if there's no XDP program attached to current
> layer.
> 3 Deliver XDP buff to userspace through macvtap.

I think I'm getting what you're trying to achieve.
You actually don't want any bpf programs in there at all.
You want macvlan builtin logic to act on raw packet frames.
It would have been less confusing if you said so from the beginning.
I think there is little value in such work, since something still
needs to process this raw frames eventually. If it's XDP with BPF progs
than they can maintain the speed, but in such case there is no need
for macvlan. The first layer can be normal xdp+bpf+xdp_redirect just fine.
In case where there is no xdp+bpf in final processing, the frames are
converted to skb and performance is lost, so in such cases there is no
need for builtin macvlan acting on raw xdp frames either. Just keep
existing macvlan acting on skbs.

