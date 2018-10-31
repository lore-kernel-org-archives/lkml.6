Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D956C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D59D20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D59D20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbeJaUoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:44:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:13000 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbeJaUoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:44:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 04:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="104086037"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by fmsmga001.fm.intel.com with ESMTP; 31 Oct 2018 04:46:24 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
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
In-Reply-To: <b694312e-b668-3546-f9e8-dc740f330f14@redhat.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com> <1540368316-12998-9-git-send-email-luwei.kang@intel.com> <87a7n37iuf.fsf@ashishki-desk.ger.corp.intel.com> <bc192976-2c56-3cfc-a697-cf941a92ad0a@redhat.com> <alpine.DEB.2.21.1810301058060.5984@nanos.tec.linutronix.de> <b694312e-b668-3546-f9e8-dc740f330f14@redhat.com>
Date:   Wed, 31 Oct 2018 13:46:24 +0200
Message-ID: <87o9ba5ofj.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 30/10/2018 11:00, Thomas Gleixner wrote:
>> So at least we need a way for perf on the host to programmatically detect,
>> that 'guest traces itself' is enabled, so it can inject that information
>> into the host data and post processing can tell that. W/o something like
>> that it's going to be a FAQ.
>
> In guest-tracing mode there will be already a TIP.PGD and TIP.PGE packet
> respectively before vmentry and after vmexit, caused by the RTIT_CTL
> WRMSRs in pt_guest_enter and pt_guest_exit.  The target IP of the
> packets will come from kvm-intel.ko.

Most people aren't tracing the kernel, so they'd just get a PGD with no
address and a PGE after the kvm is done without any indication of what
happened in between.

> In system mode instead you get a Paging Information Packet on
> vmentry/vmexit, with bit 0 set in the third byte.  You won't get it if
> guest-side tracing is on (because tracing has been disabled by
> pt_guest_enter and won't be re-enabled until pt_guest_exit).  I don't
> think it's correct to "fake" the PIP in guest-tracing mode, because
> TIP.PGD should be followed immediately by TIP.PGE.

Indeed, we should most definitely not fake PIP. Perf has RECORD_AUX,
which already has PARTIAL flag that was introduced specifically because
of kvm.

Regards,
--
Alex
