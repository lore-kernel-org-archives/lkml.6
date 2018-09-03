Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6B7C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2643C204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2643C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeICTr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:47:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:55234 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbeICTr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:47:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 08:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,325,1531810800"; 
   d="scan'208";a="88605023"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga002.jf.intel.com with ESMTP; 03 Sep 2018 08:26:16 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 1277E301B65; Mon,  3 Sep 2018 08:26:16 -0700 (PDT)
Date:   Mon, 3 Sep 2018 08:26:16 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     jsteckli@amazon.de, David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        juerg.haefliger@hpe.com, deepa.srinivasan@oracle.com,
        Jim Mattson <jmattson@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        joao.m.martins@oracle.com, pradeep.vincent@oracle.com,
        Khalid Aziz <khalid.aziz@oracle.com>,
        kanth.ghatraju@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Kees Cook <keescook@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
Message-ID: <20180903152616.GE27886@tassilo.jf.intel.com>
References: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
 <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <CA+55aFzHj_GNZWG4K2oDu4DPP9sZdTZ9PY7sBxGB6WoN9g8d=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzHj_GNZWG4K2oDu4DPP9sZdTZ9PY7sBxGB6WoN9g8d=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 02:38:43PM -0700, Linus Torvalds wrote:
> On Fri, Aug 31, 2018 at 12:45 AM Julian Stecklina <jsteckli@amazon.de> wrote:
> >
> > I've been spending some cycles on the XPFO patch set this week. For the
> > patch set as it was posted for v4.13, the performance overhead of
> > compiling a Linux kernel is ~40% on x86_64[1]. The overhead comes almost
> > completely from TLB flushing. If we can live with stale TLB entries
> > allowing temporary access (which I think is reasonable), we can remove
> > all TLB flushing (on x86). This reduces the overhead to 2-3% for
> > kernel compile.
> 
> I have to say, even 2-3% for a kernel compile sounds absolutely horrendous.
> 
> Kernel bullds are 90% user space at least for me, so a 2-3% slowdown
> from a kernel is not some small unnoticeable thing.

Also the problem is that depending on the workload everything may fit
into the TLBs, so the temporary stale TLB entries may be around
for a long time. Modern CPUs have very large TLBs, and good
LRU policies. For the kernel entries with global bit set and
which are used for something there may be no reason ever to evict.

Julian, I think you would need at least some quantitative perfmon data about
TLB replacement rates in the kernel to show that it's "reasonable"
instead of hand waving.

Most likely I suspect you would need a low frequency regular TLB
flush for the global entries at least, which will increase
the overhead again.

-Andi

