Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeCOMuy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:50:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51476 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeCOMuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:50:52 -0400
X-Google-Smtp-Source: AG47ELtDQ6wjlaKF0Yrr5QfZEpmr5HTD88vdgKyMBme5/RouXievR3qakVzUksKhx4+hU0CmEZmXIw==
Date: Thu, 15 Mar 2018 14:50:38 +0200
From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Liran Alon <liran.alon@oracle.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        idan.brown@oracle.com, Yuval Shaia <yuval.shaia@oracle.com>
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
Message-ID: <20180315145038.16df4fea@halley>
In-Reply-To: <a673c689-ec30-61f6-9238-6b1773788201@iogearbox.net>
References: <1520953642-8145-1-git-send-email-liran.alon@oracle.com>
        <20180315112150.58586758@halley>
        <a673c689-ec30-61f6-9238-6b1773788201@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Mar 2018 12:56:13 +0100 Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 03/15/2018 10:21 AM, Shmulik Ladkani wrote:
> > 
> > Regarding veth xmit, it does makes sense to preserve the fields if not
> > crossing netns. This is also the case when one uses tc mirred.
> > 
> > Regarding bpf redirect, well, it depends on the expectations of each bpf
> > program.
> > I'd argue that preserving the fields (at least the mark field) in the
> > *non* xnet makes sense and provides more information and therefore more
> > capabilities; Alas this might change behavior already being relied on.
> > 
> > Maybe Daniel can comment on the matter.  
> 
> Overall I think it might be nice to not need scrubbing skb in such cases,
> although my concern would be that this has potential to break existing
> setups when they would expect mark being zero on other veth peer in any
> case since it's the behavior for a long time already. The safer option
> would be to have some sort of explicit opt-in e.g. on link creation to let
> the skb->mark pass through unscrubbed. This would definitely be a useful
> option e.g. when mark is set in the netns facing veth via clsact/egress
> on xmit and when the container is unprivileged anyway.

For the veth xmit case, an opt-in flag which disables mark scrubbing in
the *non* xnet veth-pair seems reasonable.

But what about bpf_redirect BPF_F_INGRESS, in setups not invovling
containers?
Currently bpf_redirect is implemented using dev_forward_skb which
*fully* scrubs the skb, even if the target device is on same netns as
skb->dev is.

One might use ebpf programs that perform BPF_F_INGRESS bpf_redirect, for
example for demuxing skbs arriving on some "master" device into various
"slave" devices using specialized critiria.

It would be beneficial to have the mark preserved when skb is injected
to the slave device's rx path (especially when it's on the same netns).

Liran's patch fixes this - but at the cost of changing existing behavior
for BPF_F_INGRESS users (formerly: fully scrubbed; post patch: scrubbed
only if xnet).

I wonder, do you know of implementations that actually RELY on the fact
that BPF_F_INGRESS actually clears the mark, in the *non* xnet case?

Regards,
Shmulik
