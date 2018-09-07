Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AA3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FE92083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FE92083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeIGWqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:46:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbeIGWqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:46:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9735C12D0;
        Fri,  7 Sep 2018 18:04:18 +0000 (UTC)
Received: from redhat.com (ovpn-123-145.rdu2.redhat.com [10.10.123.145])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A17E12027EA4;
        Fri,  7 Sep 2018 18:04:14 +0000 (UTC)
Date:   Fri, 7 Sep 2018 14:04:13 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Kenneth Lee <liguozhu@hisilicon.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, kvm@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Hao Fang <fanghao11@huawei.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Alex Williamson <alex.williamson@redhat.com>,
        linux-crypto@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        linux-accelerators@lists.ozlabs.org
Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180907180412.GC3519@redhat.com>
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
 <20180904150019.GA4024@redhat.com>
 <20180904101509.62314b67@t450s.home>
 <20180906094532.GG230707@Turing-Arch-b>
 <20180906133133.GA3830@redhat.com>
 <20180907040138.GI230707@Turing-Arch-b>
 <20180907165303.GA3519@redhat.com>
 <404f0944-d514-b450-f743-89ae798ac694@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <404f0944-d514-b450-f743-89ae798ac694@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 18:04:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 18:04:18 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 06:55:45PM +0100, Jean-Philippe Brucker wrote:
> On 07/09/2018 17:53, Jerome Glisse wrote:
> > So there is no reasons to do that under VFIO. Especialy as in your example
> > it is not a real user space device driver, the userspace portion only knows
> > about writting command into command buffer AFAICT.
> > 
> > VFIO is for real userspace driver where interrupt, configurations, ... ie
> > all the driver is handled in userspace. This means that the userspace have
> > to be trusted as it could program the device to do DMA to anywhere (if
> > IOMMU is disabled at boot which is still the default configuration in the
> > kernel).
> 
> If the IOMMU is disabled (not exactly a kernel default by the way, I
> think most IOMMU drivers enable it by default), your userspace driver
> can't bypass DMA isolation by accident. It just won't be allowed to
> access the device. VFIO requires an IOMMU unless the admin forces the
> NOIOMMU mode with the "enable_unsafe_noiommu_mode" module parameter, and
> the userspace explicitly asks for it with VFIO_NOIOMMU_IOMMU, which
> taints the kernel. Not for production. A normal userspace driver that
> uses VFIO can only do DMA to its own memory.
> 

Didn't know about VFIO check, which is a sane thing. On Intel  IOMMU
is disabled by default (see INTEL_IOMMU_DEFAULT_ON Kconfig option).
I am pretty sure it use to be the same for AMD but maybe it is now
enabled by default.

Cheers,
Jérôme
