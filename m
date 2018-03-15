Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932869AbeCOPy7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:54:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53468 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbeCOPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:54:57 -0400
X-Google-Smtp-Source: AG47ELshqieIyOYsqPLW1QPHnCiKu9W/qNN/J73ShkLwIs8g5NJ0krhVEbwVfHQQqOCHlVhhhdWRDA==
Date: Thu, 15 Mar 2018 17:54:44 +0200
From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Liran Alon <liran.alon@oracle.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        idan.brown@oracle.com, Yuval Shaia <yuval.shaia@oracle.com>
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
Message-ID: <20180315175444.02d70f23@halley>
In-Reply-To: <cd0b73e3-2cde-1442-4312-566c69571e8a@iogearbox.net>
References: <1520953642-8145-1-git-send-email-liran.alon@oracle.com>
        <20180315112150.58586758@halley>
        <a673c689-ec30-61f6-9238-6b1773788201@iogearbox.net>
        <20180315145038.16df4fea@halley>
        <cd0b73e3-2cde-1442-4312-566c69571e8a@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 16:13:39 +0100 Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 03/15/2018 01:50 PM, Shmulik Ladkani wrote:
> > 
> > It would be beneficial to have the mark preserved when skb is injected
> > to the slave device's rx path (especially when it's on the same netns).  
> 
> Right, I think also here the easiest would be to have a BPF_F_PRESERVE_MARK
> flag to opt-in in general case (xnet/non-xnet)

Sounds okay to me.

> But lets presume for a sec you would _not_ scrub it, then how are users
> supposed to make use of this? The feature/bug may not be critical enough
> (well, otherwise it wouldn't have been like this for long time) for stable,
> so to write an app relying on it the behavior will change from kernel A to
> kernel B, where you need to end up having a full blown veth run-time test
> in order to figure it out before you can use it, not really useful either.

Let's assume BPF_F_PRESERVE_MARK is a feature then, which is available only
in new kernels.
As said, this flag will not be honored by older kernels.

But your "run-time test" argument is true for every new flag-bit
introduced to bpf functions, for example:
 BPF_F_SEQ_NUMBER was added after other skb_set_tunnel_key flags,
 Same for BPF_F_INVALIDATE_HASH (skb_store_bytes), BPF_F_MARK_ENFORCE
 (l4_csum_replace) and others.

With every flag addition, the flag mask validation in the corresponding
bpf function has been relaxed to support it.

Why is BPF_F_PRESERVE_MARK any different from any previous flag addition?

Thanks,
Shmulik
