Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D89C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5B22084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5B22084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeLKW2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:28:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeLKW2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:28:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED8353082139;
        Tue, 11 Dec 2018 22:28:35 +0000 (UTC)
Received: from ovpn-116-73.ams2.redhat.com (ovpn-116-73.ams2.redhat.com [10.36.116.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29B675D736;
        Tue, 11 Dec 2018 22:28:33 +0000 (UTC)
Message-ID: <0ffb8bc11613ea082179142f7c90830d4e419491.camel@redhat.com>
Subject: Re: [PATCH net-next v2 1/4] indirect call wrappers: helpers to
 speed-up indirect calls of builtin
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Woodhouse <dwmw2@infradead.org>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org
Date:   Tue, 11 Dec 2018 23:28:32 +0100
In-Reply-To: <2c80b9d34540dad337ed2fce6f9d16233105a2c2.camel@infradead.org>
References: <cover.1544032300.git.pabeni@redhat.com>
         <07aaed31eb0b515c173138e1358c412157e58ec2.1544032300.git.pabeni@redhat.com>
         <b72eeb67a0c83d2b497ef5b2537a6211d18f847d.camel@infradead.org>
         <f692efbbc9df09acb5f18ad16907e28cda520e4d.camel@redhat.com>
         <2c80b9d34540dad337ed2fce6f9d16233105a2c2.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 11 Dec 2018 22:28:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sorry for the long delay, I was (and still I am) diverted by some
other duty.

On Fri, 2018-12-07 at 21:46 +0000, David Woodhouse wrote:
> On Fri, 2018-12-07 at 21:46 +0100, Paolo Abeni wrote:
> > > I wonder if we can declare the common case functions as 'weak' so that
> > > the link failures don't happen when they're absent.
> > 
> > I experimented a previous version with alias. I avoided weak alias
> > usage, because I [mis?]understood not all compilers have a complete
> > support for them (e.g. clang).
> > Also, with weak ref, a coding error that is now discovered at build
> > time will result in worse performance at runtime, likely with some
> > uncommon configuration, possibly not as easily detected. I'm unsure
> > that would be better ?!?
> 
> I think everything supports weak linkage; we've been using it for
> years.

Ok, I likely was confused by some old, non first-hand info.

Anyway weak alias will turn a compile time issue in a possible run-time 
(small) regression. I think the first option would be preferable.

> > I'm sorry, I don't follow here. I think static keys can't be used for
> > the reported network case: we have different list elements each
> > contaning a different function pointer and we access/use
> > different ptr on a per packet basis.
> 
> Yes, the alternatives would be used to change the "likely" case.
> 
> We still do the "if (fn == default_fn) default_fn(); else (*fn)();"
> part; or even the variant with two (or more) common cases. 
> 
> It's just that the value of 'default_fn' can be changed at runtime
> (with patching like alternatives/static keys, since of course it has to
> be a direct call).

Thanks for clarifying. If I understood correctly, you would like some
helper for:

if (static_branch_likely(&use_default_fn_a))
    INDIRECT_CALL_1(f, default_fn_a, <args>)
else if (static_branch_likely(&use_default_fn_b))
    INDIRECT_CALL_1(f, default_fn_b, <args>)
// ...

if so, I think we can eventually add support for this kind of stuff on
top of the proposed macros. WDYT?

Thanks,

Paolo


