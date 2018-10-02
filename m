Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CA5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212B82082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212B82082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stwm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeJBV3n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:29:43 -0400
Received: from mailin.studentenwerk.mhn.de ([141.84.225.229]:35576 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726787AbeJBV3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:29:43 -0400
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 42Phm50RVyzMl0T;
        Tue,  2 Oct 2018 16:45:57 +0200 (CEST)
From:   Wolfgang Walter <linux@stwm.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        christophe.gouault@6wind.com
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec tunnels
Date:   Tue, 02 Oct 2018 16:45:56 +0200
Message-ID: <4708967.r5gU1pxIcW@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.14.61-debian64.all+1.1; KDE/4.14.13; x86_64; ; )
In-Reply-To: <20180914055437.77pffp2jrbfnykbp@breakpoint.cc>
References: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc> <20180914050651.GD23674@gauss3.secunet.de> <20180914055437.77pffp2jrbfnykbp@breakpoint.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am Freitag, 14. September 2018, 07:54:37 schrieb Florian Westphal:
> Steffen Klassert <steffen.klassert@secunet.com> wrote:
> > On Thu, Sep 13, 2018 at 11:03:25PM +0200, Florian Westphal wrote:
> > > David Miller <davem@davemloft.net> wrote:
> > > > From: Florian Westphal <fw@strlen.de>
> > > > Date: Thu, 13 Sep 2018 18:38:48 +0200
> > > > 
> > > > > Wolfgang Walter <linux@stwm.de> wrote:
> > > > >> What I can say is that it depends mainly on number of policy rules
> > > > >> and SA.
> > > > > 
> > > > > Thats already a good hint, I guess we're hitting long hash chains in
> > > > > xfrm_policy_lookup_bytype().
> > > > 
> > > > I don't really see how recent changes can influence that.
> > > 
> > > I don't think there is a recent change that did this.
> > > 
> > > Walter says < 4.14 is ok, so this is likely related to flow cache
> > > removal.
> > > 
> > > F.e. it looks like all prefixed policies end up in a linked list
> > > (net->xfrm.policy_inexact) and are not even in a hash table.
> > > 
> > > I am staring at b58555f1767c9f4e330fcf168e4e753d2d9196e0
> > > but can't figure out how to configure that away from the
> > > 'no hashing for prefixed policies' default or why we even have
> > > policy_inexact in first place :/
> > 
> > The hash threshold can be configured like this:
> > 
> > ip x p set hthresh4 0 0
> > 
> > This sets the hash threshold to local /0 and remote /0 netmasks.
> > With this configuration, all policies should go to the hashtable.
> 
> Yes, but won't they all be hashed to same bucket?
> 
> [ jhash(addr & 0, addr & 0) ] ?
> 
> > Default hash thresholds are local /32 and remote /32 netmasks, so
> > all prefixed policies go to the inexact list.
> 
> Yes.
> 
> Wolfgang, before having to work on getting perf into your router image
> can you perhaps share a bit of info about the policies you're using?
> 
> How many are there?  Are they prefixed or not ("10.1.2.1")?

Since my last reply to this message I didn't get a reply: is there any 
progress how to fix this performance regression I missed?

Or are we stuck here with longterm kernel 4.9 for a long time?


Regards,
-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
