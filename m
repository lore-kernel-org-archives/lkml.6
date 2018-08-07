Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFFBC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6892170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6892170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388991AbeHGPFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:05:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727605AbeHGPFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:05:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E38E87A70;
        Tue,  7 Aug 2018 12:51:33 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-32.ams2.redhat.com [10.36.116.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF94C2156897;
        Tue,  7 Aug 2018 12:51:31 +0000 (UTC)
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
Subject: [PATCH RFC 0/2] KVM: s390: vsie: support VCPU requests
Date:   Tue,  7 Aug 2018 14:51:29 +0200
Message-Id: <20180807125131.3606-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 12:51:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 12:51:33 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
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
entry/exit in the VCPU sie control block (while entering the vSIE loop).

This way, we can support blocking and also synchronous CPU requests.

Only compile tested.

David Hildenbrand (2):
  KVM: s390: vsie: simulate VCPU SIE entry/exit
  KVM: s390: introduce and use KVM_REQ_VSIE_RESTART

 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/kvm-s390.c         | 16 ++++++++++++++--
 arch/s390/kvm/kvm-s390.h         |  1 +
 arch/s390/kvm/vsie.c             | 20 ++++++++++++++++++--
 4 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.17.1

