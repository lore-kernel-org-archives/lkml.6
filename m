Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F032BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A736E2460E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A736E2460E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbeFYWIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:08:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:31824 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752248AbeFYWIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:08:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 15:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,272,1526367600"; 
   d="scan'208";a="62137081"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.149]) ([10.24.14.149])
  by orsmga003.jf.intel.com with ESMTP; 25 Jun 2018 15:08:39 -0700
Subject: Re: [PATCH V7 00/41] Intel(R) Resource Director Technology Cache
 Pseudo-Locking enabling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     fenghua.yu@intel.com, Tony Luck <tony.luck@intel.com>,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <cover.1529706536.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1806231402500.8650@nanos.tec.linutronix.de>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <3d2bff8f-e5a8-1627-1e19-a7d190b67bdf@intel.com>
Date:   Mon, 25 Jun 2018 15:08:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806231402500.8650@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 6/23/2018 5:16 AM, Thomas Gleixner wrote:
> On Fri, 22 Jun 2018, Reinette Chatre wrote:
>> The Cache Pseudo-Locking enabling series that was recently merged to the
>> x86/cache branch of tip was found to conflict with the new kernfs support
>> for mounting with fs_context.
>>
>> In preparation for a conflict-free merge between the two repos some no-op
>> hooks are created within the RDT mount function being changed by
>> the two features. The goal is for this commit to be placed on a minimal
>> no-rebase branch to be consumed by both features.
> 
> Thanks for doing this so quick! I've picked up the lot and slightly
> modified the first patch by moving the stubs to the header file to get them
> completely out of the conflicting area.
> 
> The immutable branch for David to pull is:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git for-vfs
> 
> I've also created a branch based on Davids mount-context branch, applied
> the cleanup patch below to it and merged the for-vfs branch on top.
> 
> David feel free to pull the result from
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git for-vfs-merged
> 
> or pick up the patch below and do the merge and conflict resolution yourself.
> 
> The x86/cache branch is rebased and merges cleanly with for-vfs-merged. The
> last two patches are dropped; I folded them back to the patches they fix.
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
> 
> Reinette, can you please verify that x86/cache + for-vfs-merged are doing
> the right thing?
> 

I tested a merge of x86/cache and for-vfs-merged and Cache
Pseudo-Locking works.

The for-vfs-merged changes modify how mount options are handled so I
tried to cover this as well by testing on a (L3) CDP supporting system.
Mounting resctrl with and without the cdp mount option behaves as
expected. In fact, if I am looking right it seems that for-vfs-merged
includes a fix for the current resctrl mount option handling. The
resctrl filesystem supports mount options for CDP and the MBA software
controller. At the moment, if an error occurs after the mount options
are handled, only the CDP option handling is reverted, not the MBA
software controller handling. The for-vfs-merged changes includes an
additional snippet on the error path for handling of the MBA software
controller mount option:

+out_mba:
+       if (ctx->enable_mba_mbps)
+               set_mba_sc(false);


Reinette
