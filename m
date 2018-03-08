Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbeCHXb2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:31:28 -0500
Received: from h2.hallyn.com ([78.46.35.8]:33132 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751137AbeCHXb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:31:26 -0500
Date: Thu, 8 Mar 2018 17:31:24 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>,
        ima-devel <linux-ima-devel@lists.sourceforge.net>,
        containers <containers@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Tycho Andersen <tycho@docker.com>,
        Yuqiong Sun <sunyuqiong1988@gmail.com>,
        David Safford <david.safford@ge.com>,
        Mehmet Kayaalp <mkayaalp@cs.binghamton.edu>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [RFC PATCH 1/5] ima: extend clone() with IMA namespace support
Message-ID: <20180308233124.GA12405@mail.hallyn.com>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
 <20170720225033.21298-2-mkayaalp@linux.vnet.ibm.com>
 <2fac8414-6957-1fce-6b40-ad4b687ca83c@linux.vnet.ibm.com>
 <20180308201931.GA6462@mail.hallyn.com>
 <a6ef5679-6aef-21de-7cdb-48e8af83f874@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6ef5679-6aef-21de-7cdb-48e8af83f874@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stefan Berger (stefanb@linux.vnet.ibm.com):
> On 03/08/2018 03:19 PM, Serge E. Hallyn wrote:
> >Quoting Stefan Berger (stefanb@linux.vnet.ibm.com):
> >>On 07/20/2017 06:50 PM, Mehmet Kayaalp wrote:
> >>>From: Yuqiong Sun<suny@us.ibm.com>
> >>>
> >>>Add new CONFIG_IMA_NS config option.  Let clone() create a new IMA
> >>>namespace upon CLONE_NEWNS flag. Add ima_ns data structure in nsproxy.
> >>>ima_ns is allocated and freed upon IMA namespace creation and exit.
> >>>Currently, the ima_ns contains no useful IMA data but only a dummy
> >>>interface. This patch creates the framework for namespacing the different
> >>>aspects of IMA (eg. IMA-audit, IMA-measurement, IMA-appraisal).
> >>>
> >>>Signed-off-by: Yuqiong Sun<suny@us.ibm.com>
> >>>
> >>>Changelog:
> >>>* Use CLONE_NEWNS instead of a new CLONE_NEWIMA flag
> >>>* Use existing ima.h headers
> >>>* Move the ima_namespace.c to security/integrity/ima/ima_ns.c
> >>>* Fix typo INFO->INO
> >>>* Each namespace free's itself, removed recursively free'ing
> >>>until init_ima_ns from free_ima_ns()
> >>With this patch we would use CLONE_NEWNS and create an IMA and mount
> >>namespace at the same time. However, the code below creates two
> >>inodes to handle the two namespaces separately via setns(). The
> >...  right.
> >
> >Either the ima and mounts namespaces are so closely tied that ima_ns
> >should be unshared on every CLONE_NEWNS, or not.  If they are, then
> >every setns(CLONE_NEWNS)  must also change the ima_ns.  That is not the
> >case here.  Every clone creates a new ima_ns, but we're not forcing
> >tasks to be in the ima_ns that is matched with its mntns, and
> >furthermore we have another object lifecycle to worry about.
> >
> >It still seems to me that the only sane way to do this is to have the
> >ima_ns be its own object;  have it be owned by a user_ns;  require
> >CAP_SYS_ADMIN (or better CAP_MAC_ADMIN) to your current userns to
> >clone a new one, maybe with no other tasks in userns yet, for good
> >measure.  And support hierarchical measuring (so parents can still
> >get information about a child's actions).
> 
> I think there is a real benefit to keeping the IMA namespace with
> the mount namespace since the mount namespace carries the signatures
> in the xattrs and IMA the (appraisal) policy. The user namespace has

But xattrs have to do with the files and filesystem.  Not with
mounts.

> the keys IMA needs for signature verification and if missing, the
> appraisal will fail (at least that is how it could work but Mimi
> tells me the pointer to the IMA keyring is cached). So there's an
> incentive to keep the otherwise 'loose' namespaces 'together.' If we
> were to associate the IMA namespace with the user namespace or be
> stand-alone, it is easier to just setns() the mount namespace and
> circumvent the IMA (appraisal) policy.

Sure but you won't have privilege over the previous namespace.
Now, you will over the uids you were delegated - almost seems like an
ima_ns should be assoicated with a segregated uid range.

> >If IMA is to be at all trustworthy for remote appraisal, then I do
> 
> remote appraisal ? remote attestation ?

right attestation

> >not see how you can let a privileged insecure container completely
> >bypass IMA.  The key difference between allowing new ima_ns with
> >mntns or only with userns is that after unsharing my user_ns, my
> >privilege with respect to the parent is lost.  A new mntns doesn't
> >change anything about how I can corrupt the parent.
> 
> Not quite following. After unsharing the user_ns IMA could be made
> to loose access to its keys from the previous user_ns and starting
> apps would fail appraisal then, unless the new user_ns IMA keyring
> has the same keys again.

It doesn't inherit the parent's to begin with?  I guess I don't
know enough about how the keyring is managed.
