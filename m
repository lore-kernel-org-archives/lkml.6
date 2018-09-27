Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E264EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C0021508
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 02:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C0021508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeI0IWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 04:22:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35411 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbeI0IWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 04:22:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 407ACC05B1EF;
        Thu, 27 Sep 2018 02:06:53 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7F9F5DD92;
        Thu, 27 Sep 2018 02:06:50 +0000 (UTC)
Date:   Thu, 27 Sep 2018 10:06:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org, mingo@redhat.com,
        ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de,
        Dave Young <dyoung@redhat.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org
Subject: Re: [PATCH 1/4 v8] x86/ioremap: add a function ioremap_encrypted()
 to remap kdump old memory
Message-ID: <20180927020647.GH2555@MiWiFi-R3L-srv>
References: <20180907081805.368-1-lijiang@redhat.com>
 <20180907081805.368-2-lijiang@redhat.com>
 <20180926022123.GA2555@MiWiFi-R3L-srv>
 <e6cd5448-b314-e142-1169-9e3e907faf16@redhat.com>
 <e7634c77-1657-4665-3bc4-bd00196f28e4@redhat.com>
 <c076568c-aaf8-9b83-40bd-55c406bd88d0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c076568c-aaf8-9b83-40bd-55c406bd88d0@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 27 Sep 2018 02:06:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lianbo,

On 09/26/18 at 05:34pm, lijiang wrote:
> When SME is enabled on AMD machine, the memory is encrypted in the first
> kernel. In this case, SME also needs to be enabled in kdump kernel, and
> we have to remap the old memory with the memory encryption mask.
> 
> Here we only talk about the case that SME is active in the first kernel,
> and only care it's active too in kdump kernel. there are four cases we
> need considered.
> 
> a. dump vmcore
>    It is encrypted in the first kernel, and needs be read out in kdump
>    kernel.
> 
> b. crash notes
>    When dumping vmcore, the people usually need to read the useful
>    information from notes, and the notes is also encrypted.
> 
> c. iommu device table
>    It is allocated by kernel, need fill its pointer into mmio of amd iommu.
>    It's encrypted in the first kernel, need read the old content to analyze
>    and get useful information.
> 
> d. mmio of amd iommu
>    Register reported by amd firmware, it's not RAM, we don't encrypt in
>    both the first kernel and kdump kernel.
> 
> To achieve the goal, the solution is:
> 1. add a new bool parameter "encrypted" to __ioremap_caller()
>    It is a low level function, and check the newly added parameter, if it's
>    true and in kdump kernel, will remap the memory with sme mask.
> 
> 2. add a new function ioremap_encrypted() to explicitly passed in a "true"
>    value for "encrypted".
>    For above a, b, c, we will call ioremap_encrypted();
> 
> 3. adjust all existed ioremap wrapper functions, passed in "false" for
>    encrypted to make them an before.
> 
>    ioremap_encrypted()\
>    ioremap_cache()     |
>    ioremap_prot()      |
>    ioremap_wt()        |->__ioremap_caller()
>    ioremap_wc()        |
>    ioremap_uc()        |
>    ioremap_nocache()  /

Thanks, I think it's better. Since no code change, just patch log
improvement, maybe you can repost a series and carry both Tom and
Joerg's ACK.
