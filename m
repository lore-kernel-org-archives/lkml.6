Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42555ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF38720779
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF38720779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeGPIxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:53:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:51092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbeGPIxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:53:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A932AAE61;
        Mon, 16 Jul 2018 08:26:48 +0000 (UTC)
Date:   Mon, 16 Jul 2018 10:26:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ananth Narayan <ananth@in.ibm.com>, kernelfans@gmail.com
Subject: Re: [RFC PATCH v6 0/4] powerpc/fadump: Improvements and fixes for
 firmware-assisted dump.
Message-ID: <20180716082646.GF17280@dhcp22.suse.cz>
References: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-07-18 11:32:56, Mahesh J Salgaonkar wrote:
> One of the primary issues with Firmware Assisted Dump (fadump) on Power
> is that it needs a large amount of memory to be reserved. This reserved
> memory is used for saving the contents of old crashed kernel's memory before
> fadump capture kernel uses old kernel's memory area to boot. However, This
> reserved memory area stays unused until system crash and isn't available
> for production kernel to use.

How much memory are we talking about. Regular kernel dump process needs
some reserved memory as well. Why that is not a big problem?

> Instead of setting aside a significant chunk of memory that nobody can use,
> take advantage ZONE_MOVABLE to mark a significant chunk of reserved memory
> as ZONE_MOVABLE, so that the kernel is prevented from using, but
> applications are free to use it.

Why kernel cannot use that memory while userspace can?
[...]
>  Documentation/powerpc/firmware-assisted-dump.txt |   18 +++
>  arch/powerpc/include/asm/fadump.h                |    7 +
>  arch/powerpc/kernel/fadump.c                     |  123 +++++++++++++++++--
>  arch/powerpc/platforms/pseries/hotplug-memory.c  |    7 +
>  include/linux/mmzone.h                           |    2 
>  mm/page_alloc.c                                  |  146 ++++++++++++++++++++++
>  6 files changed, 290 insertions(+), 13 deletions(-)

This is quite a large change and you didn't seem to explain why we need
it.
-- 
Michal Hocko
SUSE Labs
