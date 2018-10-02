Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D1BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532A82082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532A82082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stwm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJCASb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:18:31 -0400
Received: from dresden.studentenwerk.mhn.de ([141.84.225.229]:38736 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbeJCASb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:18:31 -0400
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 42PmV03nqfzMkwT;
        Tue,  2 Oct 2018 19:34:00 +0200 (CEST)
From:   Wolfgang Walter <linux@stwm.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        christophe.gouault@6wind.com
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec tunnels
Date:   Tue, 02 Oct 2018 19:34 +0200
Message-ID: <4327972.7bla238zOs@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.14.61-debian64.all+1.1; KDE/4.14.13; x86_64; ; )
In-Reply-To: <20181002145616.pwdhbmafgsihbxvm@breakpoint.cc>
References: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc> <4708967.r5gU1pxIcW@stwm.de> <20181002145616.pwdhbmafgsihbxvm@breakpoint.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 2. Oktober 2018, 16:56:16 schrieb Florian Westphal:
> Wolfgang Walter <linux@stwm.de> wrote:
> > Since my last reply to this message I didn't get a reply: is there any
> > progress how to fix this performance regression I missed?
> 
> Did you test/experiment with hthresh config option?

I did. It did not improve the situation.

I suppose that is because our masks range from /16 to /30 and excpecially have 
for example /16 <=> /8 and vice versa.

When forwarding, every policy A => B also implies that you add a policy B => 
A.

I'm not familiar when the policy database is consulted, but I think it now has 
to for every not encrypted paket, and for those all rules have to be 
consulted. And unencrypted traffic is a large part of the traffic on that 
router.

That is: for unencrypted traffic neither the buckets of the hash nor the 
inexact list may be large.

> 
> > Or are we stuck here with longterm kernel 4.9 for a long time?
> 
> I'm experimenting with per-dst inexact lists in an rbtree but
> this will take time.

Hmm, I doubt that this is worth the effort. And certainly not that easy 
correctly done, as it still would have to obey the original order of the rules 
(their priority).

You may have a lot of rules of the form say

	10.0.0.0/16 <=> 10.1.0.0/29 encrypt ....
	10.0.0.0/16 <=> 10.1.0.8/29 encrypt ....
	....

And things like that.

Also, you get something like that

	10.0.1.0/24 <=> 10.0.2.0/29 allow
	10.0.0.0/16 <=> 10.0.2.0/24 encrypt
	0.0.0.0 <=> 10.0.2.0/16 block

And people may use source port and/or destination port or protocol 
(tcp/udp/imcp) to further tailor there ruleset.


Here is the approach HiPAC took for packet classification

https://pdfs.semanticscholar.org/a0bb/9d31e2499fb659c9e0d9544072d2f3c25079.pdf
https://pdfs.semanticscholar.org/0dea/8ee87f596f200de2722cbe9480610dd1a0db.pdf

Regards,
-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
