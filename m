Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D175EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBE52086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBE52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeLLHDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:03:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:10182 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeLLHDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:03:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 23:03:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="301463562"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.28])
  by fmsmga006.fm.intel.com with ESMTP; 11 Dec 2018 23:03:13 -0800
Date:   Wed, 12 Dec 2018 15:06:56 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        xen-devel@lists.xenproject.org, Jan Beulich <jbeulich@suse.com>
Subject: Re: [PATCH] xen: xen-pciback: Reset MSI-X state when exposing a
 device
Message-ID: <20181212070654.GA13411@gao-cwp>
References: <1543976357-1053-1-git-send-email-chao.gao@intel.com>
 <20181205093223.dncg4nq4dh6xmrhk@mac>
 <c27236d3-6125-4049-6268-3d9c93cf3ef2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c27236d3-6125-4049-6268-3d9c93cf3ef2@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 09:01:33AM -0500, Boris Ostrovsky wrote:
>On 12/5/18 4:32 AM, Roger Pau Monné wrote:
>> On Wed, Dec 05, 2018 at 10:19:17AM +0800, Chao Gao wrote:
>>> I find some pass-thru devices don't work any more across guest reboot.
>>> Assigning it to another guest also meets the same issue. And the only
>>> way to make it work again is un-binding and binding it to pciback.
>>> Someone reported this issue one year ago [1]. More detail also can be
>>> found in [2].
>>>
>>> The root-cause is Xen's internal MSI-X state isn't reset properly
>>> during reboot or re-assignment. In the above case, Xen set maskall bit
>>> to mask all MSI interrupts after it detected a potential security
>>> issue. Even after device reset, Xen didn't reset its internal maskall
>>> bit. As a result, maskall bit would be set again in next write to
>>> MSI-X message control register.
>>>
>>> Given that PHYSDEVOPS_prepare_msix() also triggers Xen resetting MSI-X
>>> internal state of a device, we employ it to fix this issue rather than
>>> introducing another dedicated sub-hypercall.
>>>
>>> Note that PHYSDEVOPS_release_msix() will fail if the mapping between
>>> the device's msix and pirq has been created. This limitation prevents
>>> us calling this function when detaching a device from a guest during
>>> guest shutdown. Thus it is called right before calling
>>> PHYSDEVOPS_prepare_msix().
>> s/PHYSDEVOPS/PHYSDEVOP/ (no final S). And then I would also drop the
>> () at the end of the hypercall name since it's not a function.
>>
>> I'm also wondering why the release can't be done when the device is
>> detached from the guest (or the guest has been shut down). This makes
>> me worry about the raciness of the attach/detach procedure: if there's
>> a state where pciback assumes the device has been detached from the
>> guest, but there are still pirqs bound, an attempt to attach to
>> another guest in such state will fail.
>
>I wonder whether this additional reset functionality could be done out
>of xen_pcibk_xenbus_remove(). We first do a (best effort) device reset
>and then do the extra things that are not properly done there.

No. It cannot be done in xen_pcibk_xenbus_remove() without modifying
the handler of PHYSDEVOP_release_msix. To do a successful Xen internal
MSI-X state reset, PHYSDEVOP_{release, prepare}_msix should be finished
without error. But ATM, xen expects that no msi is bound to pirq when
doing PHYSDEVOP_release_msix. Otherwise it fails with error code -EBUSY.
However, the expectation isn't guaranteed in xen_pcibk_xenbus_remove().
In some cases, if qemu fails to unmap MSIs, MSIs are unmapped by Xen
at last minute, which happens after device reset in xen_pcibk_xenbus_remove().

Thanks
Chao
