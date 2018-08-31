Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA4AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09CD2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="qzDiXdcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09CD2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeHaMuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:50:20 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39650 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727263AbeHaMuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:50:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 081D18EE1F4;
        Fri, 31 Aug 2018 01:43:56 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I7aNlxD4mMhQ; Fri, 31 Aug 2018 01:43:55 -0700 (PDT)
Received: from jarvis.home (unknown [81.145.101.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 46EA68EE101;
        Fri, 31 Aug 2018 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1535705035;
        bh=Ajnnt3X7ChJnYfHHLUrrPQ7QHlFZHmrVsnci/KqWD1o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qzDiXdcWv3F5lB0oysbVVZ7p/jszVT/lz1vdAstkmAPMomAU39baWqnLlsXY+RjPf
         ijC50n9UUSYGZwoABC1s2CPb95tF/9frNRaUuPeF6AHO64urgajkNx50eW3LVOclbd
         XUsarWLZ7XCra1TOKmVdw0DvtTS4m7xcamYiHDI4=
Message-ID: <1535705027.3085.5.camel@HansenPartnership.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated
 CPUs in mind (for KVM to isolate its guests per CPU)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Woodhouse, David" <dwmw@amazon.co.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Cc:     "juerg.haefliger@hpe.com" <juerg.haefliger@hpe.com>,
        "deepa.srinivasan@oracle.com" <deepa.srinivasan@oracle.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "pradeep.vincent@oracle.com" <pradeep.vincent@oracle.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
        "liran.alon@oracle.com" <liran.alon@oracle.com>,
        "keescook@google.com" <keescook@google.com>,
        "jsteckli@os.inf.tu-dresden.de" <jsteckli@os.inf.tu-dresden.de>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "tyhicks@canonical.com" <tyhicks@canonical.com>,
        "john.haxby@oracle.com" <john.haxby@oracle.com>,
        "jcm@redhat.com" <jcm@redhat.com>
Date:   Fri, 31 Aug 2018 09:43:47 +0100
In-Reply-To: <1534801939.10027.24.camel@amazon.co.uk>
References: <20180820212556.GC2230@char.us.oracle.com>
         <CA+55aFxZCyVZc4ZpRyZ3uDyakRSOG_=2XvnwMo4oejpsieF9=A@mail.gmail.com>
         <1534801939.10027.24.camel@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-20 at 21:52 +0000, Woodhouse, David wrote:
> On Mon, 2018-08-20 at 14:48 -0700, Linus Torvalds wrote:
> > 
> > Of course, after the long (and entirely unrelated) discussion about
> > the TLB flushing bug we had, I'm starting to worry about my own
> > competence, and maybe I'm missing something really fundamental, and
> > the XPFO patches do something else than what I think they do, or my
> > "hey, let's use our Meltdown code" idea has some fundamental
> > weakness
> > that I'm missing.
> 
> The interesting part is taking the user (and other) pages out of the
> kernel's 1:1 physmap.
> 
> It's the *kernel* we don't want being able to access those pages,
> because of the multitude of unfixable cache load gadgets.

A long time ago, I gave a talk about precisely this at OLS (2005 I
think).  On PA-RISC we have a problem with inequivalent aliasing in the
 page cache (same physical page with two different virtual addresses
modulo 4MB) which causes a machine check if it occurs. 
Architecturally, PA can move into the cache any page for which it has a
mapping and the kernel offset map of every page causes an inequivalency
if the same page is in use in user space.  Of course, practically the
caching machinery is too busy moving in and out pages we reference to
have an interest in speculating on other pages it has a mapping for, so
it almost never (the almost being a set of machine checks we see very
occasionally in the latest and most aggressively cached and speculating
CPUs).  If this were implemented, we'd be interested in using it.

James

