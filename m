Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE01ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F7420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F7420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbeGWPgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:36:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:39390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388183AbeGWPgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:36:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73659AD39;
        Mon, 23 Jul 2018 14:34:46 +0000 (UTC)
Date:   Mon, 23 Jul 2018 16:34:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        dan.j.williams@intel.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org, fengguang.wu@intel.com, bp@suse.de,
        andy.shevchenko@gmail.com, patrik.r.jakobsson@gmail.com,
        airlied@linux.ie, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, dmitry.torokhov@gmail.com,
        frowand.list@gmail.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, tglx@linutronix.de, brijesh.singh@amd.com,
        jglisse@redhat.com, thomas.lendacky@amd.com,
        gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, devel@linuxdriverproject.org,
        linux-input@vger.kernel.org, linux-nvdimm@lists.01.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
        yinghai@kernel.org, monstr@monstr.eu, davem@davemloft.net,
        chris@zankel.net, jcmvbkbc@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH v7 4/4] kexec_file: Load kernel at top of system RAM if
 required
Message-ID: <20180723143443.GD18181@dhcp22.suse.cz>
References: <20180718024944.577-1-bhe@redhat.com>
 <20180718024944.577-5-bhe@redhat.com>
 <20180718153326.b795e9ea7835432a56cd7011@linux-foundation.org>
 <20180719151753.GB7147@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719151753.GB7147@localhost.localdomain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-07-18 23:17:53, Baoquan He wrote:
> Kexec has been a formal feature in our distro, and customers owning
> those kind of very large machine can make use of this feature to speed
> up the reboot process. On uefi machine, the kexec_file loading will
> search place to put kernel under 4G from top to down. As we know, the
> 1st 4G space is DMA32 ZONE, dma, pci mmcfg, bios etc all try to consume
> it. It may have possibility to not be able to find a usable space for
> kernel/initrd. From the top down of the whole memory space, we don't
> have this worry. 

I do not have the full context here but let me note that you should be
careful when doing top-down reservation because you can easily get into
hotplugable memory and break the hotremove usecase. We even warn when
this is done. See memblock_find_in_range_node
-- 
Michal Hocko
SUSE Labs
