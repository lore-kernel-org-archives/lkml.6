Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CA3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEEF20869
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404009AbeLUO4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:56:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:57488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730979AbeLUO4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:56:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CA41ACD2;
        Fri, 21 Dec 2018 14:56:44 +0000 (UTC)
Date:   Fri, 21 Dec 2018 15:56:43 +0100
From:   Jiri Bohac <jbohac@suse.cz>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, osandov@fb.com, bhsharma@redhat.com,
        bhe@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH 1/1] x86/gart/kcore: Exclude GART aperture from kcore
Message-ID: <20181221145643.GA6143@dwarf.suse.cz>
References: <20181221013812.22790-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221013812.22790-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 09:38:12AM +0800, Kairui Song wrote:
> On machines where the GART aperture is mapped over physical RAM,
> /proc/kcore contains the GART aperture range and reading it may lead
> to kernel panic.
> 
> In 'commit 2a3e83c6f96c ("x86/gart: Exclude GART aperture from vmcore")',
> a special workaround is applied for vmcore to let /proc/vmcore return
> zeroes when attempting to read the aperture region, as vmcore and kcore
> have the same issue, and after 'commit 707d4eefbdb3 ("Revert "[PATCH]
> Insert GART region into resource map"")', userspace tools can't detect and
> exclude GART region.
> 
> This patch applies the same workaround for kcore. Let /proc/kcore return
> zeroes too when trying to read the aperture region to fix the issue that
> reading GART region may raise unexpected exceptions.
> 
> This applies to both first and second kernels as GART may get
> initialized in the first and second kernels.
> 
> To get the same workaround work for kcore, this patch implement a hook
> infrastructure for kcore which is same as the hook infrastructure for
> vmcore introduced in 'commit 997c136f518c ("fs/proc/vmcore.c: add hook
> to read_from_oldmem() to check for non-ram pages")'', and reuses the
> checking function gart_oldmem_pfn_is_ram introduced in
> 'commit 2a3e83c6f96c ("x86/gart: Exclude GART aperture from vmcore"),'
> as the hook function, but rename to gart_mem_pfn_is_ram as now it's
> for a more generic use.
> 
> Suggested-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>

Reviewed-by: Jiri Bohac <jbohac@suse.cz>

> ---
>  arch/x86/kernel/aperture_64.c |  6 ++++--
>  fs/proc/kcore.c               | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/kcore.h         |  3 +++
>  3 files changed, 41 insertions(+), 2 deletions(-)

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

