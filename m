Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E54C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084ED20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084ED20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbeLGUqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:46:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLGUqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:46:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 832AEC04576C;
        Fri,  7 Dec 2018 20:46:30 +0000 (UTC)
Received: from ovpn-116-97.ams2.redhat.com (ovpn-116-97.ams2.redhat.com [10.36.116.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E683E1001F57;
        Fri,  7 Dec 2018 20:46:28 +0000 (UTC)
Message-ID: <f692efbbc9df09acb5f18ad16907e28cda520e4d.camel@redhat.com>
Subject: Re: [PATCH net-next v2 1/4] indirect call wrappers: helpers to
 speed-up indirect calls of builtin
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Woodhouse <dwmw2@infradead.org>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org
Date:   Fri, 07 Dec 2018 21:46:27 +0100
In-Reply-To: <b72eeb67a0c83d2b497ef5b2537a6211d18f847d.camel@infradead.org>
References: <cover.1544032300.git.pabeni@redhat.com>
         <07aaed31eb0b515c173138e1358c412157e58ec2.1544032300.git.pabeni@redhat.com>
         <b72eeb67a0c83d2b497ef5b2537a6211d18f847d.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 07 Dec 2018 20:46:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-07 at 09:46 +0000, David Woodhouse wrote:
> On Wed, 2018-12-05 at 19:13 +0100, Paolo Abeni wrote:
> > +/*
> > + * We can use INDIRECT_CALL_$NR for ipv6 related functions only if ipv6 is
> > + * builtin, this macro simplify dealing with indirect calls with only ipv4/ipv6
> > + * alternatives
> > + */
> > +#if IS_BUILTIN(CONFIG_IPV6)
> > +#define INDIRECT_CALL_INET(f, f2, f1, ...) \
> > +       INDIRECT_CALL_2(f, f2, f1, __VA_ARGS__)
> > +#elif IS_ENABLED(CONFIG_INET)
> > +#define INDIRECT_CALL_INET(f, f2, f1, ...) INDIRECT_CALL_1(f, f1, __VA_ARGS__)
> > +#else
> > +#define INDIRECT_CALL_INET(f, f2, f1, ...) f(__VA_ARGS__)
> > +#endif
> > +
> > +#endif
> 
> Thanks for working on this.
> 
> I'm not stunningly keen on the part cited above. And it doesn't seem to
> be working either, given Dave's later error and reversion.

My bad, I did not test vs a relevant cfg. Hopefully that can be fixed.

> I wonder if we can declare the common case functions as 'weak' so that
> the link failures don't happen when they're absent.

I experimented a previous version with alias. I avoided weak alias
usage, because I [mis?]understood not all compilers have a complete
support for them (e.g. clang).
Also, with weak ref, a coding error that is now discovered at build
time will result in worse performance at runtime, likely with some
uncommon configuration, possibly not as easily detected. I'm unsure
that would be better ?!?

> Once we extend this past the network code, especially to file systems'
> f_ops, I suspect we're going to want to use something like static keys
> to patch the common cases at runtime — perhaps changing the f_ops
> default according to what the root file system is, etc.

I'm sorry, I don't follow here. I think static keys can't be used for the reported network case: we have different list elements each contaning a different function pointer and we access/use
different ptr on a per packet basis.

> I'd quite like to see the API for this taking that into account even if
> it's left to be a future development.

Again, I'm lost here. Can you please give more hints?

Thanks,

Paolo

