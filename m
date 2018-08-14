Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31661C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58462174B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 00:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEM+tzey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58462174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbeHNDRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 23:17:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37347 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHNDRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 23:17:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id a26-v6so8434491pfo.4;
        Mon, 13 Aug 2018 17:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nF9HR+nfiExx9g1zFaUlVs+wqK/5MFs1B4NZWz9b8o0=;
        b=eEM+tzey2Wlt0huSHzcnfxhvfKhaXOqz9U1TPJeME0oNmurDpWb/xsjg8IlaGFF0vO
         wCygMTgWnpU/Re5Ho+gHz21YoOCGeS1eY2AM2H3QuT2lJbLoZNjIjfATcJzmQyHIKRwJ
         BHbzkxO1yJl/o/vRKnXblXDln7SzgoRkAHPIqwBmUvN3y0kT1DrjJ7LeuEZxtXHuISrx
         k83z1DGbufv9T6QJBzEjcRBV19yew71/1+lT5SfrFbWjaqM3Dpc13IozxRXrviTsK+EO
         r2fea3hO2azVgMwKpm/Kr0ypOekm/z8x64r5/us0v5Y1Bjizv1rsAZun664LVTCP+pfB
         tEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nF9HR+nfiExx9g1zFaUlVs+wqK/5MFs1B4NZWz9b8o0=;
        b=hvYBfpmJZCktr51etOrJ5A0hPswvCwM+QwBJUVnU1XnrB0nwqVHrMoR26vx7VuCN4G
         /maNktMTznOPb0PJUp+Cxhw6cnc1sWLfmP9FFqxhK5qHPoHRq3JJuebp2SWDcdegYagJ
         82cbKg3VqGlBBwPaxkN4vNilFq8sNPrus8KhxdSTJcp0vkLAVciMWX53I7Mn+LYMmDVn
         98D/gP0KbgOtGyLGNPSzBJRdY+SwriY2ThhbpAgzwcamZsMhYO6OSz4xOBGVMf1CzrdY
         2N0hYj/iMAeBeJPM/luzurZ0Ike5LQ+JUznnrdIzfFKUWFlS9wSR59Q6LoSlMWjU3yKt
         t6fg==
X-Gm-Message-State: AOUpUlHJlsys4WdEP8ZNSejPlt1evD1D8qhqRc5+9jMqKp3pk5C3Bnrt
        ODnZvzWdoVTRsRttokROazxTYVwr
X-Google-Smtp-Source: AA+uWPy2DXeIu4Xas9Q4X+JMBEnybrELG5NdQzLgJiaQNrC/Fp+hU5+G0Pm93VvlrzPc5ghE0G7Gpg==
X-Received: by 2002:a62:843:: with SMTP id c64-v6mr21122546pfd.14.1534206777072;
        Mon, 13 Aug 2018 17:32:57 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::7:2bef])
        by smtp.gmail.com with ESMTPSA id h18-v6sm59917244pfa.173.2018.08.13.17.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 17:32:56 -0700 (PDT)
Date:   Mon, 13 Aug 2018 17:32:55 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jbrouer@redhat.com,
        mst@redhat.com
Subject: Re: [RFC PATCH net-next V2 0/6] XDP rx handler
Message-ID: <20180814003253.fkgl6lyklc7fclvq@ast-mbp>
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 11:17:24AM +0800, Jason Wang wrote:
> Hi:
> 
> This series tries to implement XDP support for rx hanlder. This would
> be useful for doing native XDP on stacked device like macvlan, bridge
> or even bond.
> 
> The idea is simple, let stacked device register a XDP rx handler. And
> when driver return XDP_PASS, it will call a new helper xdp_do_pass()
> which will try to pass XDP buff to XDP rx handler directly. XDP rx
> handler may then decide how to proceed, it could consume the buff, ask
> driver to drop the packet or ask the driver to fallback to normal skb
> path.
> 
> A sample XDP rx handler was implemented for macvlan. And virtio-net
> (mergeable buffer case) was converted to call xdp_do_pass() as an
> example. For ease comparision, generic XDP support for rx handler was
> also implemented.
> 
> Compared to skb mode XDP on macvlan, native XDP on macvlan (XDP_DROP)
> shows about 83% improvement.

I'm missing the motiviation for this.
It seems performance of such solution is ~1M packet per second.
What would be a real life use case for such feature ?

Another concern is that XDP users expect to get line rate performance
and native XDP delivers it. 'generic XDP' is a fallback only
mechanism to operate on NICs that don't have native XDP yet.
Toshiaki's veth XDP work fits XDP philosophy and allows
high speed networking to be done inside containers after veth.
It's trying to get to line rate inside container.
This XDP rx handler stuff is destined to stay at 1Mpps speeds forever
and the users will get confused with forever slow modes of XDP.

Please explain the problem you're trying to solve.
"look, here I can to XDP on top of macvlan" is not an explanation of the problem.

