Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E55C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412CD21534
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412CD21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbeHMT7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:59:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729070AbeHMT7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:59:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A8A781663C4;
        Mon, 13 Aug 2018 17:16:44 +0000 (UTC)
Received: from treble (ovpn-124-166.rdu2.redhat.com [10.10.124.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45967202020C;
        Mon, 13 Aug 2018 17:16:44 +0000 (UTC)
Date:   Mon, 13 Aug 2018 12:16:42 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] net: socket: Fix potential spectre v1 gadget in
 sock_is_registered
Message-ID: <20180813171642.wlxmnzgsg2rkwe4o@treble>
References: <20180727224302.5503-1-jcline@redhat.com>
 <20180727224302.5503-3-jcline@redhat.com>
 <20180729135906.lgqo5ue6it3hl2da@treble>
 <914d34af-ba80-93b9-6f17-413eef8bf210@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <914d34af-ba80-93b9-6f17-413eef8bf210@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 13 Aug 2018 17:16:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 13 Aug 2018 17:16:44 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 11:59:36AM -0400, Jeremy Cline wrote:
> On 07/29/2018 09:59 AM, Josh Poimboeuf wrote:
> > On Fri, Jul 27, 2018 at 10:43:02PM +0000, Jeremy Cline wrote:
> >> 'family' can be a user-controlled value, so sanitize it after the bounds
> >> check to avoid speculative out-of-bounds access.
> >>
> >> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> >> ---
> >>  net/socket.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/socket.c b/net/socket.c
> >> index f15d5cbb3ba4..608e29ae6baf 100644
> >> --- a/net/socket.c
> >> +++ b/net/socket.c
> >> @@ -2672,7 +2672,8 @@ EXPORT_SYMBOL(sock_unregister);
> >>  
> >>  bool sock_is_registered(int family)
> >>  {
> >> -	return family < NPROTO && rcu_access_pointer(net_families[family]);
> >> +	return family < NPROTO &&
> >> +		rcu_access_pointer(net_families[array_index_nospec(family, NPROTO)]);
> >>  }
> >>  
> >>  static int __init sock_init(void)
> > 
> > This is another one where I think it would be better to do the nospec
> > clamp higher up the call chain.  The untrusted 'family' value comes from
> > __sock_diag_cmd():
> > 
> > __sock_diag_cmd
> >   sock_load_diag_module
> >     sock_is_registered
> > 
> > That function has a bounds check, and also uses the value in some other
> > array accesses:
> > 
> > 	if (req->sdiag_family >= AF_MAX)
> > 		return -EINVAL;
> > 
> > 	if (sock_diag_handlers[req->sdiag_family] == NULL)
> > 		sock_load_diag_module(req->sdiag_family, 0);
> > 
> > 	mutex_lock(&sock_diag_table_mutex);
> > 	hndl = sock_diag_handlers[req->sdiag_family];
> > 	...
> > 
> > So I think clamping 'req->sdiag_family' right after the bounds check
> > would be the way to go.
> > 
> 
> Indeed, the clamp there would cover this clamp. I had a scheme that I
> quickly fix all the gadgets in functions with local comparisons, but
> clearly that's going to result in call chains with multiple clamps.
> 
> I can fix this in a follow-up with a clamp here, or respin this patch
> set, whatever is easier for David.

Hi Jeremy,

Just checking up on this... since this patch was merged, will you be
doing a followup patch?

-- 
Josh
