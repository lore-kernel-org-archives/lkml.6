Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1902CC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE00720671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE00720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeGYH6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:58:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728222AbeGYH6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:58:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0EA97401DEA9;
        Wed, 25 Jul 2018 06:48:21 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41309111DCE6;
        Wed, 25 Jul 2018 06:48:16 +0000 (UTC)
Date:   Wed, 25 Jul 2018 14:48:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
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
Message-ID: <20180725064813.GI6480@MiWiFi-R3L-srv>
References: <20180718024944.577-1-bhe@redhat.com>
 <20180718024944.577-5-bhe@redhat.com>
 <20180718153326.b795e9ea7835432a56cd7011@linux-foundation.org>
 <20180719151753.GB7147@localhost.localdomain>
 <20180723143443.GD18181@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723143443.GD18181@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 25 Jul 2018 06:48:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 25 Jul 2018 06:48:21 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/18 at 04:34pm, Michal Hocko wrote:
> On Thu 19-07-18 23:17:53, Baoquan He wrote:
> > Kexec has been a formal feature in our distro, and customers owning
> > those kind of very large machine can make use of this feature to speed
> > up the reboot process. On uefi machine, the kexec_file loading will
> > search place to put kernel under 4G from top to down. As we know, the
> > 1st 4G space is DMA32 ZONE, dma, pci mmcfg, bios etc all try to consume
> > it. It may have possibility to not be able to find a usable space for
> > kernel/initrd. From the top down of the whole memory space, we don't
> > have this worry. 
> 
> I do not have the full context here but let me note that you should be
> careful when doing top-down reservation because you can easily get into
> hotplugable memory and break the hotremove usecase. We even warn when
> this is done. See memblock_find_in_range_node

Kexec read kernel/initrd file into buffer, just search usable positions
for them to do the later copying. You can see below struct kexec_segment, 
for the old kexec_load, kernel/initrd are read into user space buffer,
the @buf stores the user space buffer address, @mem stores the position
where kernel/initrd will be put. In kernel, it calls
kimage_load_normal_segment() to copy user space buffer to intermediate
pages which are allocated with flag GFP_KERNEL. These intermediate pages
are recorded as entries, later when user execute "kexec -e" to trigger
kexec jumping, it will do the final copying from the intermediate pages
to the real destination pages which @mem pointed. Because we can't touch
the existed data in 1st kernel when do kexec kernel loading. With my
understanding, GFP_KERNEL will make those intermediate pages be
allocated inside immovable area, it won't impact hotplugging. But the
@mem we searched in the whole system RAM might be lost along with
hotplug. Hence we need do kexec kernel again when hotplug event is
detected.

#define KEXEC_CONTROL_MEMORY_GFP (GFP_KERNEL | __GFP_NORETRY)


struct kexec_segment {
        /*
         * This pointer can point to user memory if kexec_load() system
         * call is used or will point to kernel memory if
         * kexec_file_load() system call is used.
         *
         * Use ->buf when expecting to deal with user memory and use ->kbuf
         * when expecting to deal with kernel memory.
         */
        union {
                void __user *buf;
                void *kbuf;
        };
        size_t bufsz;                                                                                                                             
        unsigned long mem;
        size_t memsz;
};

Thanks
Baoquan
