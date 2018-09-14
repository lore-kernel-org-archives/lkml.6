Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E981C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF45120853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF45120853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeINKTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 06:19:40 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:45684 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbeINKTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 06:19:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id CD1C4201D5;
        Fri, 14 Sep 2018 09:06:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qIw_a_sAuVdG; Fri, 14 Sep 2018 09:06:34 +0200 (CEST)
Received: from mail-essen-02.secunet.de (mail-essen-02.secunet.de [10.53.40.205])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 9B9EB20097;
        Fri, 14 Sep 2018 09:06:34 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-02.secunet.de
 (10.53.40.205) with Microsoft SMTP Server id 14.3.408.0; Fri, 14 Sep 2018
 07:06:51 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 34F22318060A;
 Fri, 14 Sep 2018 07:06:51 +0200 (CEST)
Date:   Fri, 14 Sep 2018 07:06:51 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Florian Westphal <fw@strlen.de>
CC:     David Miller <davem@davemloft.net>, <linux@stwm.de>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <christophe.gouault@6wind.com>
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec
 tunnels
Message-ID: <20180914050651.GD23674@gauss3.secunet.de>
References: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc>
 <3448099.9yk84El3Sa@stwm.de>
 <20180913163848.ni5xc4gc4d6uusdn@breakpoint.cc>
 <20180913.102305.939671149040995911.davem@davemloft.net>
 <20180913210325.5usfj2rorvuvtyc7@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180913210325.5usfj2rorvuvtyc7@breakpoint.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: cbe3d3f7-b9e3-4256-b890-f24c4306a01c
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 5A3DAFA0-D46D-459B-ADC5-B24AE2ECD78E
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 11:03:25PM +0200, Florian Westphal wrote:
> David Miller <davem@davemloft.net> wrote:
> > From: Florian Westphal <fw@strlen.de>
> > Date: Thu, 13 Sep 2018 18:38:48 +0200
> > 
> > > Wolfgang Walter <linux@stwm.de> wrote:
> > >> What I can say is that it depends mainly on number of policy rules and SA.
> > > 
> > > Thats already a good hint, I guess we're hitting long hash chains in
> > > xfrm_policy_lookup_bytype().
> > 
> > I don't really see how recent changes can influence that.
> 
> I don't think there is a recent change that did this.
> 
> Walter says < 4.14 is ok, so this is likely related to flow cache removal.
> 
> F.e. it looks like all prefixed policies end up in a linked list
> (net->xfrm.policy_inexact) and are not even in a hash table.
> 
> I am staring at b58555f1767c9f4e330fcf168e4e753d2d9196e0
> but can't figure out how to configure that away from the
> 'no hashing for prefixed policies' default or why we even have
> policy_inexact in first place :/

The hash threshold can be configured like this:

ip x p set hthresh4 0 0

This sets the hash threshold to local /0 and remote /0 netmasks.
With this configuration, all policies should go to the hashtable.
This might help to balance the hash chains better.

Default hash thresholds are local /32 and remote /32 netmasks, so
all prefixed policies go to the inexact list.

To view the configuration:

ip -s -s x p count

