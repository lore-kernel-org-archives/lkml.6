Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C183AECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7601E2150C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="TxdGirE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7601E2150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeIQP1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:27:55 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:30564 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeIQP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1537178474; x=1568714474;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=HKWCHGOwghN2+Pdpfl4D607WZ8TaQXZtauUiLvgErAg=;
  b=TxdGirE7y9KERxPBszVgIbhKp/2eozP8wBNz7U1AKoqvCC7ajsHUp8Wc
   u2ep8reQf54epAIzdRvz598uDvTLinQi0FqkIDJwRv16fSy7Tm4SuaxJ3
   zYEFKWSxRb39jfK7OIuSxn6d9z2kTFHIXW29lODtGoYO5UOatSBDssnWC
   g=;
X-IronPort-AV: E=Sophos;i="5.53,384,1531785600"; 
   d="scan'208";a="630977129"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-cd289015.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Sep 2018 10:01:09 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-cd289015.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w8HA15a7066176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 17 Sep 2018 10:01:06 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8HA13BY023478;
        Mon, 17 Sep 2018 12:01:03 +0200
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id w8HA12mZ023475;
        Mon, 17 Sep 2018 12:01:02 +0200
X-Authentication-Warning: u54ee758033e858cfa736.ant.amazon.com: jsteckli set sender to jsteckli@amazon.de using -f
From:   Julian Stecklina <jsteckli@amazon.de>
To:     Juerg Haefliger <juergh@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        deepa.srinivasan@oracle.com, Jim Mattson <jmattson@google.com>,
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
        <ciirm8efdy916l.fsf@u54ee758033e858cfa736.ant.amazon.com>
        <CADLDEKsxx=MSFu=4_4JLX1afUMr3GVjNxSQ-726NrbLn8KQaQg@mail.gmail.com>
Date:   Mon, 17 Sep 2018 12:01:02 +0200
In-Reply-To: <CADLDEKsxx=MSFu=4_4JLX1afUMr3GVjNxSQ-726NrbLn8KQaQg@mail.gmail.com>
        (Juerg Haefliger's message of "Thu, 13 Sep 2018 08:11:49 +0200")
Message-ID: <ciirm8r2hs30kh.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Juerg Haefliger <juergh@gmail.com> writes:

>> I've updated my XPFO branch[1] to make some of the debugging optional
>> and also integrated the XPFO bookkeeping with struct page, instead of
>> requiring CONFIG_PAGE_EXTENSION, which removes some checks in the hot
>> path.
>
> FWIW, that was my original design but there was some resistance to
> adding more to the page struct and page extension was suggested
> instead.

From looking at both versions, I have to say that having the metadata in
struct page makes the code easier to understand and removes some special
cases and bookkeeping.

> I'm wondering how much performance we're loosing by having to split
> hugepages. Any chance this can be quantified somehow? Maybe we can
> have a pool of some sorts reserved for userpages and group allocations
> so that we can track the XPFO state at the hugepage level instead of
> at the 4k level to prevent/reduce page splitting. Not sure if that
> causes issues or has any unwanted side effects though...

Optimizing the allocation/deallocation path might be worthwhile, because
that's where most of the overhead goes. I haven't looked into how to do
this yet. I'd appreciate if someone has pointers to code that tries to
achieve similar functionality to get me started.

That being said, I'm wondering whether we have unrealistic expectations
about the overhead here and whether it's worth turning this patch into
something far more complicated. Opinions?

Julian
--
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

