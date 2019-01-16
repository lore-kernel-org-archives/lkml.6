Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47F5C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824F120657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="B0mp1JeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393770AbfAPPAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:00:00 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:26902 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbfAPPAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1547650799; x=1579186799;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=RaiNxQUKMt3ENI0wPF/bEAsbn6PzyzrB2L8Q11F+LsQ=;
  b=B0mp1JeW0Irq10CKbd5zRgNoRO8cJxLlVppKUJP9MQFagYlZVphTifeE
   XUFxUsDRm0MZoharn4IgmB3Bec/zgEYlKOK2D4B1dYxZE2CYiD+SygAD4
   c6TqapEHoIRFUyOlu20OmxSIW2aScCKHnE8d1sK/L2ZLXdH4JoIH/4lEG
   I=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="653786779"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Jan 2019 14:57:10 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x0GEujFk043915
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Wed, 16 Jan 2019 14:56:47 GMT
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
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v7 00/16] Add support for eXclusive Page Frame Ownership
References: <cover.1547153058.git.khalid.aziz@oracle.com>
Date:   Wed, 16 Jan 2019 15:56:44 +0100
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com> (Khalid Aziz's
        message of "Thu, 10 Jan 2019 14:09:32 -0700")
Message-ID: <ciirm8o98gzm4z.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khalid Aziz <khalid.aziz@oracle.com> writes:

> I am continuing to build on the work Juerg, Tycho and Julian have done
> on XPFO.

Awesome!

> A rogue process can launch a ret2dir attack only from a CPU that has
> dual mapping for its pages in physmap in its TLB. We can hence defer
> TLB flush on a CPU until a process that would have caused a TLB flush
> is scheduled on that CPU.

Assuming the attacker already has the ability to execute arbitrary code
in userspace, they can just create a second process and thus avoid the
TLB flush. Am I getting this wrong?

Julian
