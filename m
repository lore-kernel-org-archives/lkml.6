Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F4CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418D421757
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418D421757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeI1GEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 02:04:30 -0400
Received: from namei.org ([65.99.196.166]:33528 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeI1GEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 02:04:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w8RNhNEX013743;
        Thu, 27 Sep 2018 23:43:23 GMT
Date:   Fri, 28 Sep 2018 09:43:23 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     "Schaufler, Casey" <casey.schaufler@intel.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>
Subject: RE: [PATCH v5 5/5] sidechannel: Linux Security Module for
 sidechannel
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC67321463CE3@ORSMSX107.amr.corp.intel.com>
Message-ID: <alpine.LRH.2.21.1809280936290.13517@namei.org>
References: <20180926203446.2004-1-casey.schaufler@intel.com> <20180926203446.2004-6-casey.schaufler@intel.com> <alpine.LRH.2.21.1809280744560.8410@namei.org> <025d4742-5947-545e-f603-502a0c5ee03f@schaufler-ca.com> <alpine.LRH.2.21.1809280846280.8410@namei.org>
 <99FC4B6EFCEFD44486C35F4C281DC67321463CE3@ORSMSX107.amr.corp.intel.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018, Schaufler, Casey wrote:

> > > On 9/27/2018 2:45 PM, James Morris wrote:
> > > > On Wed, 26 Sep 2018, Casey Schaufler wrote:
> > > >
> > > >> +	/*
> > > >> +	 * Namespace checks. Considered safe if:
> > > >> +	 *	cgroup namespace is the same
> > > >> +	 *	User namespace is the same
> > > >> +	 *	PID namespace is the same
> > > >> +	 */
> > > >> +	if (current->nsproxy)
> > > >> +		ccgn = current->nsproxy->cgroup_ns;
> > > >> +	if (p->nsproxy)
> > > >> +		pcgn = p->nsproxy->cgroup_ns;
> > > >> +	if (ccgn != pcgn)
> > > >> +		return -EACCES;
> > > >> +	if (current->cred->user_ns != p->cred->user_ns)
> > > >> +		return -EACCES;
> > > >> +	if (task_active_pid_ns(current) != task_active_pid_ns(p))
> > > >> +		return -EACCES;
> > > >> +	return 0;
> > > > I really don't like the idea of hard-coding namespace security semantics
> > > > in an LSM.  Also, I'm not sure if these semantics make any sense.
> > >
> > > Checks on namespaces where explicitly requested.
> > 
> > By whom and what is the rationale?
> 
> The rationale is to protect containers. Since those closest thing
> there is to a definition of containers is "uses namespaces" that
> becomes the focus. Separating them out does not make too much
> sense as I would expect someone concerned with one to be concerned
> with all.

A lot of people will not be using user namespaces due to security 
concerns, so with this hard-coded logic, you are saying this case is 
'safe' in a sidechannel context.

Which hints at the deeper issue that containers are a userland 
abstraction.  Protection of containers needs to be defined by userland 
policy.



-- 
James Morris
<jmorris@namei.org>

