Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7A0C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2C22064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2C22064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stwm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeJYSKS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:10:18 -0400
Received: from dresden.studentenwerk.mhn.de ([141.84.225.229]:35704 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbeJYSKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:10:17 -0400
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 42ghrW6RFMzMkwB;
        Thu, 25 Oct 2018 11:38:19 +0200 (CEST)
From:   Wolfgang Walter <linux@stwm.de>
To:     netdev@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        christophe.gouault@6wind.com, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec tunnels
Date:   Thu, 25 Oct 2018 11:38:19 +0200
Message-ID: <2766296.15tpkxTHJV@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.18.12-041812-generic; KDE/4.14.13; x86_64; ; )
In-Reply-To: <1729915.dWWxddREcQ@stwm.de>
References: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc> <20181002213536.sgjansduqenps2md@breakpoint.cc> <1729915.dWWxddREcQ@stwm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

there is now a new 4.19 which still has the big performance regression when 
many ipsec tunnels are configured (throughput and latency get worse by 10 to 
50 times) which makes any kernel > 4.9 unusable for our routers.

I still don't understand why a revert of the flow cache removal at least for 
the longterm kernels is that a bad option (maybe as a compile time option), 
especially as there is no workaround available.

We use linux in that scenario since more than 10 years so I'm really rather 
unhappy if not to say despaired that we will be stucked with 4.9 for an 
unforeseeable future.

We would have detected and reported that performance regression much earlier 
if not another bug in ipsec had prevented us from running 4.14 and later until 
end of august 2018 (See kernels > v4.12 oops/crash with ipsec-traffic: 
bisected to b838d5e1c5b6e57b10ec8af2268824041e3ea911: ipv4: mark DST_NOGC and 
remove the operation of dst_free()).

Am Donnerstag, 4. Oktober 2018, 15:57:52 schrieb Wolfgang Walter:
> Am Dienstag, 2. Oktober 2018, 23:35:36 schrieb Florian Westphal:

[snip]

> > Well, I'm not going to send a revert of the flowcache removal.
> >
> > 
> > I'm willing to experiment with alternatives to a full iteration of the
> > inexact list but thats it.
> 
> If this brings performance back to pre-removal, I'm fine with that. I'm even
> fine if it is slower by a factor of 2.
> 
> I think it is a serious regression, and there is no workaround, and therefor
> it cannot stay like that.
> 
> So I still hope that reverting is an option if no acceptable solution can be
> found.
> 
> > > correctly done, as it still would have to obey the original order of the
> > > rules (their priority).
> > 
> > Except that neither the priority or the order in which it was added
> > matters in case the selector doesn't match.
> 
> To match a packet one has to find all matching rules and chose that one with
> the lowest priority.
> 
> "indexing" by dst will not help much if you have a ruleset where a lot of
> rules sharing a dst. You also have to replicate rules with dsts that have a
> prefix oft another dst as they may habe a higher priority even if they are
> less specific.
> 
> Every such entry may again have such an "indexing" by dst. Only then this
> would be efficient.
>

[snip]
 
> 
> I wonder why there is no such thing for netfilter or the rules list in
> routing. nf does not have such a thing, either. This is the reason why I
> think that this is not that easy and for longterm kernel 4.14 the best
> solution will be a revert anyway.
> 
> Regards,

Regards,
-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
