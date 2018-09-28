Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974DBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB9E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB9E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeI1W6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:58:31 -0400
Received: from namei.org ([65.99.196.166]:34010 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbeI1W6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:58:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w8SGXKjQ016354;
        Fri, 28 Sep 2018 16:33:20 GMT
Date:   Sat, 29 Sep 2018 02:33:20 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jann Horn <jannh@google.com>
cc:     Casey Schaufler <casey.schaufler@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        kristen@linux.intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        deneen.t.dock@intel.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH v5 5/5] sidechannel: Linux Security Module for
 sidechannel
In-Reply-To: <CAG48ez3Jnao-5z3O8s=RdoAx8=b68C_1pfKNKJSm+6R_HyU_fg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1809290233130.15725@namei.org>
References: <20180926203446.2004-1-casey.schaufler@intel.com> <20180926203446.2004-6-casey.schaufler@intel.com> <alpine.LRH.2.21.1809280744560.8410@namei.org> <025d4742-5947-545e-f603-502a0c5ee03f@schaufler-ca.com> <alpine.LRH.2.21.1809280846280.8410@namei.org>
 <99FC4B6EFCEFD44486C35F4C281DC67321463CE3@ORSMSX107.amr.corp.intel.com> <alpine.LRH.2.21.1809280936290.13517@namei.org> <CAG48ez3Jnao-5z3O8s=RdoAx8=b68C_1pfKNKJSm+6R_HyU_fg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018, Jann Horn wrote:

> > so with this hard-coded logic, you are saying this case is
> > 'safe' in a sidechannel context.
> >
> > Which hints at the deeper issue that containers are a userland
> > abstraction.  Protection of containers needs to be defined by userland
> > policy.
> 
> Or just compare mount namespaces additionally/instead. I think that
> containers will always use those, because AFAIK nobody uses chroot()
> for containers, given that the kernel makes absolutely no security
> guarantees about chroot().

We can't define this in the kernel. It has no concept of containers.

People utilize some combination of namespaces and cgroups and call them 
containers, but we can't make assumptions from the kernel on what any of 
this means from a security point of view, and hard-code kernel policy 
based on those assumptions.

This is violating the principal of separating mechanism and policy, and 
also imposing semantics across the kernel/user boundary. The latter 
creates an ABI which we can then never break.


-- 
James Morris
<jmorris@namei.org>

