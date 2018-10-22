Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4517FECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F6B20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F6B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeJVKMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 06:12:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:19932 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeJVKMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 06:12:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2018 18:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,410,1534834800"; 
   d="scan'208";a="83314595"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.104])
  by orsmga008.jf.intel.com with ESMTP; 21 Oct 2018 18:56:25 -0700
Date:   Mon, 22 Oct 2018 09:53:42 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
Message-ID: <20181022015342.GK11769@yi.y.sun>
References: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
 <1539954835-34035-3-git-send-email-yi.y.sun@linux.intel.com>
 <bab010e9-a122-95f1-d8cc-790e56c72716@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bab010e9-a122-95f1-d8cc-790e56c72716@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-19 16:20:52, Juergen Gross wrote:
> On 19/10/2018 15:13, Yi Sun wrote:

[...]

> > diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> > index 0130e48..9e88c7e 100644
> > --- a/kernel/locking/qspinlock_paravirt.h
> > +++ b/kernel/locking/qspinlock_paravirt.h
> > @@ -7,6 +7,8 @@
> >  #include <linux/bootmem.h>
> >  #include <linux/debug_locks.h>
> >  
> > +#include <asm/mshyperv.h>
> > +
> >  /*
> >   * Implement paravirt qspinlocks; the general idea is to halt the vcpus instead
> >   * of spinning them.
> > @@ -305,6 +307,10 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
> >  				wait_early = true;
> >  				break;
> >  			}
> > +#if defined(CONFIG_X86_64) && defined(CONFIG_PARAVIRT_SPINLOCKS) && IS_ENABLED(CONFIG_HYPERV)
> > +			if (!hv_notify_long_spin_wait(SPIN_THRESHOLD - loop))
> > +				break;
> > +#endif
> 
> I don't like that. Why should a KVM or Xen guest call into a hyperv
> specific function?
> 
> Can't you move this to existing hyperv specific paravirt hooks?
> 
hv_notify_long_spin_wait() must be called in this loop but it seems
there is no appropriate existing paravirt hook here. So, can I add
one more hook in pv_lock_ops to do this notification?

> 
> Juergen
