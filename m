Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88358C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFFA2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFFA2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeLDGfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:35:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:9565 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeLDGfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:35:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 22:35:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,312,1539673200"; 
   d="scan'208";a="106805120"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 03 Dec 2018 22:35:49 -0800
Received: from tiger-server (dazhang1-ssd.sh.intel.com [10.239.48.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 629EB580117;
        Mon,  3 Dec 2018 22:35:48 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:35:34 +0800
From:   Yi Zhang <yi.z.zhang@linux.intel.com>
To:     Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Nicusor CITU <ncitu@bitdefender.com>,
        Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH V2 00/11] Intel EPT-Based Sub-page Protection Support
Message-ID: <20181204063533.GA73736@tiger-server>
Mail-Followup-To: Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
        Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Nicusor CITU <ncitu@bitdefender.com>,
        Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
References: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
 <1c7e9821-df4b-9b1c-76aa-d1c4c654c952@redhat.com>
 <1543809373.23880.17.camel@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543809373.23880.17.camel@bitdefender.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-03 at 05:56:13 +0200, Mihai Donțu wrote:
> Hi Paolo,
> 
> On Fri, 2018-11-30 at 11:07 +0100, Paolo Bonzini wrote:
> > On 30/11/18 08:52, Zhang Yi wrote:
> > > Here is a patch-series which adding EPT-Based Sub-page Write Protection Support.
> > > 
> > > Introduction:
> > > 
> > > EPT-Based Sub-page Write Protection referred to as SPP, it is a capability which
> > > allow Virtual Machine Monitors(VMM) to specify write-permission for guest
> > > physical memory at a sub-page(128 byte) granularity.  When this capability is
> > > utilized, the CPU enforces write-access permissions for sub-page regions of 4K
> > > pages as specified by the VMM. EPT-based sub-page permissions is intended to
> > > enable fine-grained memory write enforcement by a VMM for security(guest OS
> > > monitoring) and usages such as device virtualization and memory check-point.
> > > 
> > > SPPT is active when the "sub-page write protection" VM-execution control is 1.
> > > SPPT looks up the guest physical addresses to derive a 64 bit "sub-page
> > > permission" value containing sub-page write permissions. The lookup from
> > > guest-physical addresses to the sub-page region permissions is determined by a
> > > set of SPPT paging structures.
> > > 
> > > When the "sub-page write protection" VM-execution control is 1, the SPPT is used
> > > to lookup write permission bits for the 128 byte sub-page regions containing in
> > > the 4KB guest physical page. EPT specifies the 4KB page level privileges that
> > > software is allowed when accessing the guest physical address, whereas SPPT
> > > defines the write permissions for software at the 128 byte granularity regions
> > > within a 4KB page. Write accesses prevented due to sub-page permissions looked
> > > up via SPPT are reported as EPT violation VM exits. Similar to EPT, a logical
> > > processor uses SPPT to lookup sub-page region write permissions for
> > > guest-physical addresses only when those addresses are used to access memory.
> > 
> > Hi,
> > 
> > I think the right thing to do here would be to first get VM
> > introspection in KVM, as SPP is mostly an introspection feature and it
> > should be controller by the introspector rather than the KVM userspace.
> > 
> > Mihai, if you resubmit, I promise that I will look at it promptly.
Thanks review, Paolo, What do u think we cook some user-cases for qemu or
some kvmtools? even with some other kernel hyper-calls?

SPP is not only an introspection depended features.
> 
> I'm currently traveling until Wednesday, but when I'll get into the
> office I will see about preparing a new patch set and send it to the
> list before Christmas.
Thanks Mihai, please include me in the new VMI patch set. 
> 
> Regards,
> 
> -- 
> Mihai Donțu
> 
