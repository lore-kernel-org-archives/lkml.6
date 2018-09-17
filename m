Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8122DECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DED214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="iaUB5np2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DED214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeIQPS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:18:29 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:12550 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeIQPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1537177910; x=1568713910;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=gI5xpfu/M4Z3NU3FfOGhaGnYOeIRNAeRd1+IUFhLM5I=;
  b=iaUB5np2hbr0VgqspxwsmohTbI2mw6tMQ8fv7uHQDwpWIsCa20cEsY//
   G86+P6UR2NWgLYZPhtjpB116XzBDmrbe6OPb0Qx1VORk3Cw8apm7I0Jte
   Xm1rrqTuw6CkxzcRlzSxA/+8qQgNbxqcQT5/WP1zYb125nkF6LAaGqv43
   o=;
X-IronPort-AV: E=Sophos;i="5.53,384,1531785600"; 
   d="scan'208";a="758625088"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Sep 2018 09:51:47 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w8H9pg4e130822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 17 Sep 2018 09:51:43 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8H9pegM022715;
        Mon, 17 Sep 2018 11:51:41 +0200
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id w8H9pcxD022714;
        Mon, 17 Sep 2018 11:51:38 +0200
X-Authentication-Warning: u54ee758033e858cfa736.ant.amazon.com: jsteckli set sender to jsteckli@amazon.de using -f
From:   Julian Stecklina <jsteckli@amazon.de>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        juerg.haefliger@hpe.com, deepa.srinivasan@oracle.com,
        Jim Mattson <jmattson@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        joao.m.martins@oracle.com, pradeep.vincent@oracle.com,
        Andi Kleen <ak@linux.intel.com>, kanth.ghatraju@oracle.com,
        Liran Alon <liran.alon@oracle.com>,
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
        <5efc291c-b0ed-577e-02d1-285d080c293d@oracle.com>
Date:   Mon, 17 Sep 2018 11:51:38 +0200
In-Reply-To: <5efc291c-b0ed-577e-02d1-285d080c293d@oracle.com> (Khalid Aziz's
        message of "Fri, 14 Sep 2018 11:06:53 -0600")
Message-ID: <ciirm8va743105.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz <khalid.aziz@oracle.com> writes:

> I ran tests with your updated code and gathered lock statistics. Change in
> system time for "make -j60" was in the noise margin (It actually went up by
> about 2%). There is some contention on xpfo_lock. Average wait time does not
> look high compared to other locks. Max hold time looks a little long. From
> /proc/lock_stat:
>
>               &(&page->xpfo_lock)->rlock:         29698          29897           0.06         134.39       15345.58           0.51      422474670      960222532           0.05       30362.05   195807002.62           0.20
>
> Nevertheless even a smaller average wait time can add up.

Thanks for doing this!

I've spent some time optimizing spinlock usage in the code. See the two
last commits in my xpfo-master branch[1]. The optimization in
xpfo_kunmap is pretty safe. The last commit that optimizes locking in
xpfo_kmap is tricky, though, and I'm not sure this is the right
approach. FWIW, I've modeled this locking strategy in Spin and it
doesn't find any problems with it.

I've tested the result on a box with 72 hardware threads and I didn't
see a meaningful difference in kernel compile performance. It's still
hovering around 2%. So the question is, whether it's actually useful to
do these optimizations.

Khalid, you mentioned 5% overhead. Can you give the new code a spin and
see whether anything changes?

Julian

[1] http://git.infradead.org/users/jsteckli/linux-xpfo.git/shortlog/refs/heads/xpfo-master

--
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

