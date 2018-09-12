Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC8AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532DE20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="pft6uJHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532DE20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeILUnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:43:02 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:4324 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeILUnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536766679; x=1568302679;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=MGE2jG+SWSZNqpEp28E7CyH1XABB1gKLFcOI3ByH3wE=;
  b=pft6uJHqVa1PlRpULOsQ7qUnT5oamLfAf03krZrah0qHdHoL/Srm7hNf
   JH75AIaLfkTzbk2FP+PtrxrU6kt7jpespH8bD+AMBkcJKbOx0sdjYEll3
   nAKAg4tHp0xHsDL05oktNifo7JKE9yA0HWpqiBcdqrhVgwA0LuUvnuLZQ
   U=;
X-IronPort-AV: E=Sophos;i="5.53,365,1531785600"; 
   d="scan'208";a="697319287"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Sep 2018 15:37:55 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w8CFbhM8018732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 12 Sep 2018 15:37:46 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8CFbgsx003922;
        Wed, 12 Sep 2018 17:37:42 +0200
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id w8CFbdOh003914;
        Wed, 12 Sep 2018 17:37:39 +0200
X-Authentication-Warning: u54ee758033e858cfa736.ant.amazon.com: jsteckli set sender to jsteckli@amazon.de using -f
From:   Julian Stecklina <jsteckli@amazon.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        juerg.haefliger@hpe.com, deepa.srinivasan@oracle.com,
        Jim Mattson <jmattson@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        joao.m.martins@oracle.com, pradeep.vincent@oracle.com,
        Andi Kleen <ak@linux.intel.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        kanth.ghatraju@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Kees Cook <keescook@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs in mind (for KVM to isolate its guests per CPU)
References: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
        <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
        <CA+55aFzHj_GNZWG4K2oDu4DPP9sZdTZ9PY7sBxGB6WoN9g8d=A@mail.gmail.com>
        <ciirm8zhwyiqh4.fsf@u54ee758033e858cfa736.ant.amazon.com>
Date:   Wed, 12 Sep 2018 17:37:38 +0200
In-Reply-To: <ciirm8zhwyiqh4.fsf@u54ee758033e858cfa736.ant.amazon.com> (Julian
        Stecklina's message of "Mon, 03 Sep 2018 16:51:35 +0200")
Message-ID: <ciirm8efdy916l.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julian Stecklina <jsteckli@amazon.de> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Fri, Aug 31, 2018 at 12:45 AM Julian Stecklina <jsteckli@amazon.de> wrote:
>>>
>>> I've been spending some cycles on the XPFO patch set this week. For the
>>> patch set as it was posted for v4.13, the performance overhead of
>>> compiling a Linux kernel is ~40% on x86_64[1]. The overhead comes almost
>>> completely from TLB flushing. If we can live with stale TLB entries
>>> allowing temporary access (which I think is reasonable), we can remove
>>> all TLB flushing (on x86). This reduces the overhead to 2-3% for
>>> kernel compile.
>>
>> I have to say, even 2-3% for a kernel compile sounds absolutely horrendous.
>
> Well, it's at least in a range where it doesn't look hopeless.
>
>> Kernel bullds are 90% user space at least for me, so a 2-3% slowdown
>> from a kernel is not some small unnoticeable thing.
>
> The overhead seems to come from the hooks that XPFO adds to
> alloc/free_pages. These hooks add a couple of atomic operations per
> allocated (4K) page for book keeping. Some of these atomic ops are only
> for debugging and could be removed. There is also some opportunity to
> streamline the per-page space overhead of XPFO.

I've updated my XPFO branch[1] to make some of the debugging optional
and also integrated the XPFO bookkeeping with struct page, instead of
requiring CONFIG_PAGE_EXTENSION, which removes some checks in the hot
path. These changes push the overhead down to somewhere between 1.5 and
2% for my quad core box in kernel compile. This is close to the
measurement noise, so I take suggestions for a better benchmark here.

Of course, if you hit contention on the xpfo spinlock then performance
will suffer. I guess this is what happened on Khalid's large box.

I'll try to remove the spinlocks and add fixup code to the pagefault
handler to see whether this improves the situation on large boxes. This
might turn out to be ugly, though.

Julian

[1] http://git.infradead.org/users/jsteckli/linux-xpfo.git/shortlog/refs/heads/xpfo-master
--
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

