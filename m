Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB13DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A401920685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A401920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeJaUg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:36:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:12442 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbeJaUg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:36:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 04:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="104788439"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by orsmga002.jf.intel.com with ESMTP; 31 Oct 2018 04:38:40 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org,
        x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        rkrcmar@redhat.com, joro@8bytes.org, songliubraving@fb.com,
        peterz@infradead.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
        konrad.wilk@oracle.com, mattst88@gmail.com,
        Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        jpoimboe@redhat.com, marcorr@google.com, ubizjak@gmail.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: Re: [PATCH v13 08/12] KVM: x86: Add Intel PT context switch for each vcpu
In-Reply-To: <a2cf06c2-1747-4d3a-b806-72236dc0d6e4@redhat.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com> <1540368316-12998-9-git-send-email-luwei.kang@intel.com> <87a7n37iuf.fsf@ashishki-desk.ger.corp.intel.com> <bc192976-2c56-3cfc-a697-cf941a92ad0a@redhat.com> <87y3af65fi.fsf@ashishki-desk.ger.corp.intel.com> <a2cf06c2-1747-4d3a-b806-72236dc0d6e4@redhat.com>
Date:   Wed, 31 Oct 2018 13:38:39 +0200
Message-ID: <87r2g65osg.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 30/10/2018 12:26, Alexander Shishkin wrote:
>> There is a control in the perf event attribute that enables tracing the
>> guest. If this control is enabled, the kvm needs to stay away from any
>> PT related MSRs.
>
> This cannot happen once the guest has been told it can trace itself.

So, they need to be made mutually exclusive.

> There is no standard way to tell the guest that the host overrode its
> choice to use PT.  However, the host will get a PGD/PGE packet around
> vmentry and vmexit, so there _will_ be an indication that the guest
> owned the MSRs for that period of time.

Not if they are not tracing the kernel.

> If PT context switching is enabled with the module parameter, we could
> also reject creation of events with the attribute set.  However that
> won't help if the event is created before KVM is even loaded.

In that case, modprobe kvm should fail.

Regards,
--
Alex
