Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B98C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACEB206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Ng/bw8ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393869AbfAPPFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:05:54 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:25655 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387554AbfAPPFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1547651152; x=1579187152;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=/0UUjJhn0QsMWnnFtSYwiBRNb0hAx07KGH409bDln60=;
  b=Ng/bw8ZZbtpMn+aCyapqSFhlYkZiqoVKt5DIJ/AkLXcb4W0ZivwTxqra
   0UUrS9a3T/zBMi/nYgayrusQf+7WFoqQtfkzeH6dkx+GdvgM9t/CD1gV3
   L04fjUUP9RbeAt4TvhtqVM8prskYi0JEMMtuCriUtlwnhNjQi0FGOGwgQ
   w=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="754293829"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Jan 2019 15:05:50 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x0GF16BJ055549
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Wed, 16 Jan 2019 15:01:08 GMT
From:   Julian Stecklina <jsteckli@amazon.de>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     juergh@gmail.com, tycho@tycho.ws, ak@linux.intel.com,
        torvalds@linux-foundation.org, liran.alon@oracle.com,
        keescook@google.com, konrad.wilk@oracle.com,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        "Vasileios P . Kemerlis" <vpk@cs.columbia.edu>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Tycho Andersen <tycho@docker.com>,
        Marco Benatto <marco.antonio.780@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC PATCH v7 12/16] xpfo, mm: remove dependency on CONFIG_PAGE_EXTENSION
References: <cover.1547153058.git.khalid.aziz@oracle.com>
        <a9436d3bc7943123bdbaac3f3e2b6bec3153ee05.1547153058.git.khalid.aziz@oracle.com>
Date:   Wed, 16 Jan 2019 16:01:05 +0100
In-Reply-To: <a9436d3bc7943123bdbaac3f3e2b6bec3153ee05.1547153058.git.khalid.aziz@oracle.com>
        (Khalid Aziz's message of "Thu, 10 Jan 2019 14:09:44 -0700")
Message-ID: <ciirm8k1j4zlxq.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz <khalid.aziz@oracle.com> writes:

> From: Julian Stecklina <jsteckli@amazon.de>
>
> Instead of using the page extension debug feature, encode all
> information, we need for XPFO in struct page. This allows to get rid of
> some checks in the hot paths and there are also no pages anymore that
> are allocated before XPFO is enabled.

I have another patch lying around that turns the XPFO per-page locks
into bit spinlocks and thus get the size of struct page to <= 64 byte
again. In case someone's interested, ping me.

Julian
