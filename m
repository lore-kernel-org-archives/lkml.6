Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6930AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2118C205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="lh2GfvMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2118C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeIDODO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:03:14 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:46796 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbeIDODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536053934; x=1567589934;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=C2Hf41+IEZMk5xpKFP+uDreWWT+A7kXsuHfwxjzf0Cg=;
  b=lh2GfvMidmkFRXgSAqNoNzvm8YDoROxuqFjDd9ol+J2XxQTbRPaIsvMi
   ikfTGzcPOdwOGNjy7JjsQiQmQPfcBQTRTdtDvprxtKqmU7qMttREXP0zw
   15WKVBuk56gCGiYBvhvdiDH+gji7YznhgBRhi3PQd9odi+paWhNCR7DW2
   4=;
X-IronPort-AV: E=Sophos;i="5.53,328,1531785600"; 
   d="scan'208";a="360497512"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Sep 2018 09:38:50 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w849bVrO039982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 4 Sep 2018 09:37:34 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w849bSVP025410;
        Tue, 4 Sep 2018 11:37:29 +0200
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id w849bPfQ025409;
        Tue, 4 Sep 2018 11:37:25 +0200
X-Authentication-Warning: u54ee758033e858cfa736.ant.amazon.com: jsteckli set sender to jsteckli@amazon.de using -f
From:   Julian Stecklina <jsteckli@amazon.de>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        <deepa.srinivasan@oracle.com>, Jim Mattson <jmattson@google.com>,
        "Andrew Cooper" <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <joao.m.martins@oracle.com>, <pradeep.vincent@oracle.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        <kanth.ghatraju@oracle.com>, Liran Alon <liran.alon@oracle.com>,
        Kees Cook <keescook@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        <chris.hyser@oracle.com>, Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs in mind (for KVM to isolate its guests per CPU)
References: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
        <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
        <CA+55aFzHj_GNZWG4K2oDu4DPP9sZdTZ9PY7sBxGB6WoN9g8d=A@mail.gmail.com>
        <20180903152616.GE27886@tassilo.jf.intel.com>
Date:   Tue, 04 Sep 2018 11:37:25 +0200
In-Reply-To: <20180903152616.GE27886@tassilo.jf.intel.com> (Andi Kleen's
        message of "Mon, 3 Sep 2018 08:26:16 -0700")
Message-ID: <ciirm88t4hhacq.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@linux.intel.com> writes:

> On Sat, Sep 01, 2018 at 02:38:43PM -0700, Linus Torvalds wrote:
>> On Fri, Aug 31, 2018 at 12:45 AM Julian Stecklina <jsteckli@amazon.de> wrote:
>> >
>> > I've been spending some cycles on the XPFO patch set this week. For the
>> > patch set as it was posted for v4.13, the performance overhead of
>> > compiling a Linux kernel is ~40% on x86_64[1]. The overhead comes almost
>> > completely from TLB flushing. If we can live with stale TLB entries
>> > allowing temporary access (which I think is reasonable), we can remove
>> > all TLB flushing (on x86). This reduces the overhead to 2-3% for
>> > kernel compile.
>> 
>> I have to say, even 2-3% for a kernel compile sounds absolutely horrendous.
>> 
>> Kernel bullds are 90% user space at least for me, so a 2-3% slowdown
>> from a kernel is not some small unnoticeable thing.
>
> Also the problem is that depending on the workload everything may fit
> into the TLBs, so the temporary stale TLB entries may be around
> for a long time. Modern CPUs have very large TLBs, and good
> LRU policies. For the kernel entries with global bit set and
> which are used for something there may be no reason ever to evict.
>
> Julian, I think you would need at least some quantitative perfmon data about
> TLB replacement rates in the kernel to show that it's "reasonable"
> instead of hand waving.

That's a fair point. It definitely depends on the workload. My idle
laptop gnome GUI session still causes ~40k dtlb-load-misses per second
per core. My idle server (some shells, IRC client) still has ~8k dTLB
load misses per second per core. Compiling something pushes this to
millions of misses per second.

For comparison according to https://www.7-cpu.com/cpu/Skylake_X.html SKX
can fit 1536 entries into its L2 dTLB.

> Most likely I suspect you would need a low frequency regular TLB
> flush for the global entries at least, which will increase
> the overhead again.

Given the tiny experiment above, I don't think this is necessary except
for highly special usecases. If stale TLB entries are a concern, the
better intermediate step is to do INVLPG on the core that modified the
page table.

And even with these shortcomings, XPFO severely limits the data an
attacker can leak from the kernel.

Julian
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

