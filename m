Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD11C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9AE20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="jtQREaOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9AE20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeHaLv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:51:57 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:43003 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbeHaLv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1535701547; x=1567237547;
  h=from:to:cc:subject:in-reply-to:date:message-id:
   mime-version;
  bh=mN+wg8uInvKKGfWyGW6sYogkjdr0gjUfR1UBpphlFvg=;
  b=jtQREaOFbl/87mCDpK180krLRQ8OcwQ1UnKKfapj/nolVPFlrtxSd8xn
   Q1YLSHm9nJiZJWgO9kYm7OL3uV3rZzRcCnRpK8iThMODUTR1KunzSivpj
   nOWn0pBhfXtIdtbV3D2drG6bMhgE2J5ZtsqwL4qbD6bajI7ceCAFtZ5DQ
   c=;
X-IronPort-AV: E=Sophos;i="5.53,309,1531785600"; 
   d="scan'208";a="360047298"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Aug 2018 07:45:43 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w7V7jaLG115839
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 31 Aug 2018 07:45:38 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w7UG0uiX009177;
        Thu, 30 Aug 2018 18:00:56 +0200
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id w7UG0qZM009176;
        Thu, 30 Aug 2018 18:00:52 +0200
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
In-Reply-To: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
Date:   Thu, 30 Aug 2018 18:00:51 +0200
Message-ID: <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

On Mon, 20 Aug 2018 15:27 Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, Aug 20, 2018 at 3:02 PM Woodhouse, David <dwmw@amazon.co.uk> wrote:
>>
>> It's the *kernel* we don't want being able to access those pages,
>> because of the multitude of unfixable cache load gadgets.
>
> Ahh.
> 
> I guess the proof is in the pudding. Did somebody try to forward-port
> that patch set and see what the performance is like?

I've been spending some cycles on the XPFO patch set this week. For the
patch set as it was posted for v4.13, the performance overhead of
compiling a Linux kernel is ~40% on x86_64[1]. The overhead comes almost
completely from TLB flushing. If we can live with stale TLB entries
allowing temporary access (which I think is reasonable), we can remove
all TLB flushing (on x86). This reduces the overhead to 2-3% for
kernel compile.

There were no problems in forward-porting the patch set to master.
You can find the result here, including a patch makes the TLB flushing
configurable:
http://git.infradead.org/users/jsteckli/linux-xpfo.git/shortlog/refs/heads/xpfo-master

It survived some casual stress-ng runs. I can rerun the benchmarks on
this version, but I doubt there is any change.

> It used to be just 500 LOC. Was that because they took horrible
> shortcuts?

The patch is still fairly small. As for the horrible shortcuts, I let
others comment on that.

HTH,
Julian

[1] Measured on my quad-core (8 hyperthreads) Kaby Lake desktop building
Linux 4.18 with the Phoronix Test Suite.

--
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

