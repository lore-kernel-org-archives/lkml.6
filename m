Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16E2C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6747D20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6747D20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJ3UUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:20:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:18611 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeJ3UUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:20:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 04:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="275643314"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by fmsmga005.fm.intel.com with ESMTP; 30 Oct 2018 04:26:57 -0700
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
In-Reply-To: <bc192976-2c56-3cfc-a697-cf941a92ad0a@redhat.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com> <1540368316-12998-9-git-send-email-luwei.kang@intel.com> <87a7n37iuf.fsf@ashishki-desk.ger.corp.intel.com> <bc192976-2c56-3cfc-a697-cf941a92ad0a@redhat.com>
Date:   Tue, 30 Oct 2018 13:26:57 +0200
Message-ID: <87y3af65fi.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

>> If you "have to enable or disable anything" it means you have to
>> override the default.  But the default in this patches is "no change
>> compared to before the patches", leaving tracing of both host and guest
>> entirely to the host, so I don't understand your remark.  What workflow
>> is broken?
>> 
>>> There already are controls in perf that enable/disable guest tracing.
>> 
>> You are confusing "tracing guest from the host" and "the guest can trace
>> itself".  This patchset is adding support for the latter, and that

I'm not confusing anything. In the terminology that you're using, the
latter breaks the former. This cannot happen.

>> affects directly whether the tracing CPUID leaf can be added to the
>> guest.  Therefore it's not perf that can decide whether to turn it on;
>> KVM must know it when /dev/kvm is opened, which is why it is a module
>> parameter.

There is a control in the perf event attribute that enables tracing the
guest. If this control is enabled, the kvm needs to stay away from any
PT related MSRs. Conversely, if kvm is using PT (or, as you say, "the
guest is tracing itself"), the host should not be allowed to ask for
tracing the guest at the same time.

Regards,
--
Alex
