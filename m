Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D651C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6F22080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6F22080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeLLPVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:21:43 -0500
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:33363 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeLLPVn (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:8:1>);
        Wed, 12 Dec 2018 10:21:43 -0500
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 12 Dec 2018 08:21:42 -0700
Message-Id: <5C112783020000780020589C@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Wed, 12 Dec 2018 08:21:39 -0700
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Chao Gao" <chao.gao@intel.com>
Cc:     "Roger Pau Monne" <roger.pau@citrix.com>,
        "Jia-Ju Bai" <baijiaju1990@gmail.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen: xen-pciback: Reset MSI-X state when exposing
 a device
References: <1543976357-1053-1-git-send-email-chao.gao@intel.com>
 <20181205093223.dncg4nq4dh6xmrhk@mac>
 <c27236d3-6125-4049-6268-3d9c93cf3ef2@oracle.com>
 <20181212070654.GA13411@gao-cwp>
 <5C10CBF50200007800205596@prv1-mh.provo.novell.com>
 <20181212151824.GA17227@gao-cwp>
In-Reply-To: <20181212151824.GA17227@gao-cwp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 12.12.18 at 16:18, <chao.gao@intel.com> wrote:
> On Wed, Dec 12, 2018 at 01:51:01AM -0700, Jan Beulich wrote:
>>>>> On 12.12.18 at 08:06, <chao.gao@intel.com> wrote:
>>> On Wed, Dec 05, 2018 at 09:01:33AM -0500, Boris Ostrovsky wrote:
>>>>On 12/5/18 4:32 AM, Roger Pau Monné wrote:
>>>>> On Wed, Dec 05, 2018 at 10:19:17AM +0800, Chao Gao wrote:
>>>>>> I find some pass-thru devices don't work any more across guest reboot.
>>>>>> Assigning it to another guest also meets the same issue. And the only
>>>>>> way to make it work again is un-binding and binding it to pciback.
>>>>>> Someone reported this issue one year ago [1]. More detail also can be
>>>>>> found in [2].
>>>>>>
>>>>>> The root-cause is Xen's internal MSI-X state isn't reset properly
>>>>>> during reboot or re-assignment. In the above case, Xen set maskall bit
>>>>>> to mask all MSI interrupts after it detected a potential security
>>>>>> issue. Even after device reset, Xen didn't reset its internal maskall
>>>>>> bit. As a result, maskall bit would be set again in next write to
>>>>>> MSI-X message control register.
>>>>>>
>>>>>> Given that PHYSDEVOPS_prepare_msix() also triggers Xen resetting MSI-X
>>>>>> internal state of a device, we employ it to fix this issue rather than
>>>>>> introducing another dedicated sub-hypercall.
>>>>>>
>>>>>> Note that PHYSDEVOPS_release_msix() will fail if the mapping between
>>>>>> the device's msix and pirq has been created. This limitation prevents
>>>>>> us calling this function when detaching a device from a guest during
>>>>>> guest shutdown. Thus it is called right before calling
>>>>>> PHYSDEVOPS_prepare_msix().
>>>>> s/PHYSDEVOPS/PHYSDEVOP/ (no final S). And then I would also drop the
>>>>> () at the end of the hypercall name since it's not a function.
>>>>>
>>>>> I'm also wondering why the release can't be done when the device is
>>>>> detached from the guest (or the guest has been shut down). This makes
>>>>> me worry about the raciness of the attach/detach procedure: if there's
>>>>> a state where pciback assumes the device has been detached from the
>>>>> guest, but there are still pirqs bound, an attempt to attach to
>>>>> another guest in such state will fail.
>>>>
>>>>I wonder whether this additional reset functionality could be done out
>>>>of xen_pcibk_xenbus_remove(). We first do a (best effort) device reset
>>>>and then do the extra things that are not properly done there.
>>> 
>>> No. It cannot be done in xen_pcibk_xenbus_remove() without modifying
>>> the handler of PHYSDEVOP_release_msix. To do a successful Xen internal
>>> MSI-X state reset, PHYSDEVOP_{release, prepare}_msix should be finished
>>> without error. But ATM, xen expects that no msi is bound to pirq when
>>> doing PHYSDEVOP_release_msix. Otherwise it fails with error code -EBUSY.
>>> However, the expectation isn't guaranteed in xen_pcibk_xenbus_remove().
>>> In some cases, if qemu fails to unmap MSIs, MSIs are unmapped by Xen
>>> at last minute, which happens after device reset in 
>>> xen_pcibk_xenbus_remove().
>>
>>But that may need taking care of: I don't think it is a good idea to have
>>anything left from the prior owning domain when the device gets reset.
>>I.e. left over IRQ bindings should perhaps be forcibly cleared before
>>invoking the reset;
> 
> Agree. How about pciback to track the established IRQ bindings? Then
> pciback can clear irq binding before invoking the reset.

How would pciback even know of those mappings, when it's qemu
who establishes (and manages) them?

>>in fact I'd expect this to happen in the course of
>>domain destruction, and I'd expect the device reset to come after the
>>domain was cleaned up. Perhaps simply an ordering issue in the tool
>>stack?
> 
> I don't think reversing the sequences of device reset and domain
> destruction would be simple. Furthermore, during device hot-unplug,
> device reset is done when the owner is alive. So if we use domain
> destruction to enforce all irq binding cleared, in theory, it won't be
> applicable to hot-unplug case (if qemu's hot-unplug logic is
> compromised).

Even in the hot-unplug case the tool stack could issue unbind
requests, behind the back of the possibly compromised qemu,
once neither the guest nor qemu have access to the device
anymore.

Jan

