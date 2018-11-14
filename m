Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379A1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098F222360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098F222360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbeKNTMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:12:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbeKNTMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:12:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8AD53001943;
        Wed, 14 Nov 2018 09:09:47 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B67785D9C7;
        Wed, 14 Nov 2018 09:09:47 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8914D4BB74;
        Wed, 14 Nov 2018 09:09:47 +0000 (UTC)
Date:   Wed, 14 Nov 2018 04:09:47 -0500 (EST)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Barret Rhoden <brho@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, yu c zhang <yu.c.zhang@intel.com>,
        yi z zhang <yi.z.zhang@intel.com>
Message-ID: <1826878055.33695230.1542186587142.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181113105628.37449f52@gnomeregan.cam.corp.google.com>
References: <20181109203921.178363-1-brho@google.com> <20181109203921.178363-3-brho@google.com> <043a592d-6592-3053-15a0-68cc54a26deb@redhat.com> <286665658.33247363.1542103353780.JavaMail.zimbra@redhat.com> <20181113105628.37449f52@gnomeregan.cam.corp.google.com>
Subject: Re: [PATCH 2/2] kvm: Use huge pages for DAX-backed files
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.213, 10.4.195.9]
Thread-Topic: Use huge pages for DAX-backed files
Thread-Index: zeMs9nesIGx8sF5CHL5ykF2Xzt/5dg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 14 Nov 2018 09:09:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > As this patch is dependent on PageReserved patch(which is in progress),
> > just
> > wondering if we are able to test the code path for hugepage with DAX.
> 
> For testing, I used the following patch.  It's not 100%, since it
> intercepts at kvm_is_reserved_pfn(), and not PageReserved() directly.
> The only difference is with kvm_set_pfn_dirty() I think.
> 

Yes, this should be ok.

Thanks,
Pankaj 

> I also have a nasty module that would dump the EPT's and the host page
> table's mappings so I could confirm that the huge pages are being mapped
> correctly.
> 
> -----------------------
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2679e476b6c3..1b394a0752a0 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -148,6 +148,10 @@ __weak int kvm_arch_mmu_notifier_invalidate_range(struct
> kvm *kvm,
>  
>  bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
>  {
> +	// XXX hack
> +	if (is_zone_device_page(pfn_to_page(pfn)))
> +		return false;
> +
>  	if (pfn_valid(pfn))
>  		return PageReserved(pfn_to_page(pfn));
>  
> -----------------------
> 
> Thanks,
> 
> Barret
> 
> 
