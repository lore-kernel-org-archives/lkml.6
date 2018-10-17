Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC45ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C0E2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C0E2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJQTLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:11:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:45294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbeJQTLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:11:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E62CAD21;
        Wed, 17 Oct 2018 11:15:45 +0000 (UTC)
Date:   Wed, 17 Oct 2018 13:15:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     vbabka@suse.cz, hpa@zytor.com, torvalds@linux-foundation.org,
        ak@linux.intel.com, dave.hansen@intel.com,
        kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Subject: Re: l1tf: Kernel suggests I throw away third of my memory. I'd
 rather not
Message-ID: <20181017111544.GO18839@dhcp22.suse.cz>
References: <20181017105610.GA4260@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017105610.GA4260@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-10-18 12:56:10, Pavel Machek wrote:
> Hi!
> 
> 6a012288 suggests I throw away 1GB on RAM. On 3GB system.. that is not
> going to be pleasant.
> 
> l1tf.html says:
> 
> # The Linux kernel contains a mitigation for this attack vector, PTE
> # inversion, which is permanently enabled and has no performance
> # impact.
> 
> I don't believe it has "no" performance impact, but I guess it is lost
> in the noise.

Please prove otherwise. I would be more than surprised if inverting pfn
part of the pte is noticeable. But I can be wrong of course.

> #  The kernel ensures that the address bits of PTEs, which are
> # not marked present, never point to cacheable physical memory space.
> 
> # A system with an up to date kernel is protected against attacks from
> # malicious user space applications.
> 
> These are not true.
> 
> cat /sys/devices/system/cpu/vulnerabilities/l1tf
> Vulnerable
> uname -a
> Linux amd 4.19.0-rc8-next-20181017autobisect1539371050 #189 SMP Wed
> Oct 17 12:04:23 CEST 2018 i686 GNU/Linux

This is a result of you having memory above MAX_PFN/2 right?

> Now question is... can we do better? Kernel stores information about
> swapped-out pages there, right? That sounds like a cool hack, but
> maybe it is time to get rid of that hack?

Patches are welcome.
 
> As a workaround, can I simply do swapoff -a to be safe for now?

Well, that depends. Do you care about PROT_NONE attacks as well? If not
then no-swap would help you. But even then no-swap is rather theoretical
attack on a physical host unless you allow an arbitrary swapout to a
malicious user (e.g. allow a user controlled memcg hard limit that would
cause excessive local swapouts).

-- 
Michal Hocko
SUSE Labs
