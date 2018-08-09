Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317B9C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E825D21C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E825D21C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbeHIK3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:29:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727237AbeHIK3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:29:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83C3440216EC;
        Thu,  9 Aug 2018 08:06:05 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E801123149;
        Thu,  9 Aug 2018 08:06:01 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 0/2] KVM: s390: vsie: simulate VCPU SIE entry/exit
Date:   Thu,  9 Aug 2018 10:05:59 +0200
Message-Id: <20180809080601.31797-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 09 Aug 2018 08:06:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 09 Aug 2018 08:06:05 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While discussing AP changes, we discovered that we will have to force
a CPU using the vSIE to regenerate/reload shadow data structures. For now,
we have no mechanism for that.

E.g. when clearing AP masks later, we could still have a vSIE CPU making
use of AP adapters as the masks might not be considered yet in the vSIE
data structures. We need a way to block entering the vSIE and regenerate
all shadow data structures once done.

Looks like we can achieve that by simply simulating an ordinary SIE
entry/exit in the VCPU sie control block (when executing sie64 in context
of the vSIE).

This way, we can support blocking and also synchronous CPU requests.

Only compile tested.

RFC -> v1:
- Move entry/exit simulation right to the sie64 code to minimize latency
- Added R-b's, dropped Tested-by.

David Hildenbrand (2):
  KVM: s390: vsie: simulate VCPU SIE entry/exit
  KVM: s390: introduce and use KVM_REQ_VSIE_RESTART

 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/kvm-s390.c         | 16 ++++++++++++++--
 arch/s390/kvm/kvm-s390.h         |  1 +
 arch/s390/kvm/vsie.c             | 21 +++++++++++++++++----
 4 files changed, 33 insertions(+), 6 deletions(-)

-- 
2.17.1

