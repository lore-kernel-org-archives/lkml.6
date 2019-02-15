Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E772CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0E221934
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfBOBAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:00:48 -0500
Received: from nautica.notk.org ([91.121.71.147]:58980 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbfBOBAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:00:47 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 90B5BC009; Fri, 15 Feb 2019 02:00:44 +0100 (CET)
Date:   Fri, 15 Feb 2019 02:00:29 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Miller <davem@davemloft.net>
Cc:     doronrk@fb.com, tom@quantonium.net, davejwatson@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
Message-ID: <20190215010029.GA10899@nautica>
References: <1536657703-27577-1-git-send-email-asmadeus@codewreck.org>
 <20180912053642.GA2912@nautica>
 <20180917.184502.447385458615284933.davem@davemloft.net>
 <20180918015723.GA26300@nautica>
 <20181031025657.GA17861@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181031025657.GA17861@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Wed, Oct 31, 2018:
> Anyway, that probably explains I have no problem with bigger VM
> (uselessly more memory available) or without KASAN (I guess there's
> overhead?), but I'm sending at most 300k of data and the VM has a 1.5GB
> of ram, so if there's an allocation failure there I think there's a
> problem ! . . .
> 
> So, well, I'm not sure on the way forward. Adding a bpf helper and
> document that kcm users should mind the offset?

bump on this - I had mostly forgotten about it but the nfs-ganesha
community that could make use of KCM reminded me of my patch that's
waiting for this.

Summary for people coming back after four months:
 - kcm is great, but the bpf function that's supposed to be called for
each packet does not automatically adjust the offset so that it can
assume the skb starts with the packet it needs to look at

 - there is some workaround code that is far from obvious and
undocumented, see the original thread[1]:
[1] http://lkml.kernel.org/r/20180822183852.jnwlxnz54gbbf6po@davejwatson-mba.dhcp.thefacebook.com

 - my patch here tried to automatically pull the corresponding packet to
the front, but apparently with KASAN can trigger out of memory
behaviours on "small" VMs, so even if it doesn't seem to impact
performance much without KASAN I don't think it's really ok to
potentially hang the connection due to oom under severe conditions.


The best alternative I see is adding a proper helper to get
"kcm_rx_msg(skb)->offset" from bpf and document it so users aren't as
lost as I have been; I'm not quite sure how/where to add such a helper
though as I've barely looked at the bpf code until now, but should we go
for that?


(it really feels wrong to me that some random person who just started by
trying to use kcm has to put this much effort to keep the ball rolling,
if nobody cares about kcm I'm also open to have it removed completely
despite the obvious performance gain I benchmarked for ganesha[2] ;
barely maintained feature is worse than no feature)

[2] https://review.gerrithub.io/c/ffilz/nfs-ganesha/+/421314

Thanks,
-- 
Dominique
