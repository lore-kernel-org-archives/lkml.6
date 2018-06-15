Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 72841C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2905E208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2905E208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936158AbeFOC0u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:26:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:55112 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936111AbeFOC0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:26:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 19:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="232741764"
Received: from voyager.sc.intel.com (HELO voyager) ([10.3.52.149])
  by orsmga005.jf.intel.com with ESMTP; 14 Jun 2018 19:26:47 -0700
Date:   Thu, 14 Jun 2018 19:23:09 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 14/23] watchdog/hardlockup: Decouple the hardlockup
 detector from perf
Message-ID: <20180615022309.GF11625@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-15-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613084324.GU12258@hirez.programming.kicks-ass.net>
 <20180614011901.GA22652@voyager>
 <20180614114144.05891a04@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614114144.05891a04@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 11:41:44AM +1000, Nicholas Piggin wrote:
> On Wed, 13 Jun 2018 18:19:01 -0700
> Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> 
> > On Wed, Jun 13, 2018 at 10:43:24AM +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 12, 2018 at 05:57:34PM -0700, Ricardo Neri wrote:  
> > > > The current default implementation of the hardlockup detector assumes that
> > > > it is implemented using perf events.  
> > > 
> > > The sparc and powerpc things are very much not using perf.  
> > 
> > Isn't it true that the current hardlockup detector
> > (under kernel/watchdog_hld.c) is based on perf?
> 
> arch/powerpc/kernel/watchdog.c is a powerpc implementation that uses
> the kernel/watchdog_hld.c framework.
> 
> > As far as I understand,
> > this hardlockup detector is constructed using perf events for architectures
> > that don't provide an NMI watchdog. Perhaps I can be more specific and say
> > that this synthetized detector is based on perf.
> 
> The perf detector is like that, but we want NMI watchdogs to share
> the watchdog_hld code as much as possible even for arch specific NMI
> watchdogs, so that kernel and user interfaces and behaviour are
> consistent.
> 
> Other arch watchdogs like sparc are a little older so they are not
> using HLD. You don't have to change those for your series, but it
> would be good to bring them into the fold if possible at some time.
> IIRC sparc was slightly non-trivial because it has some differences
> in sysctl or cmdline APIs that we don't want to break.
> 
> But powerpc at least needs to be updated if you change hld apis.

I will look into updating at least the powerpc implementation as part
of these changes.

Thanks and BR,
Ricardo
