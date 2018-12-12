Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7169FC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E1220870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544612681;
	bh=NKajZ9vE+sC+5xLK302X1D51k7iZ5DvyIXoormARi64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n41ae/WbktoNm9D9ZVrDbrNkf9Jft6RluAhQiTyNk/POpPn8qHmG5mdmEjcAdMbOy
	 CVRQNxeK/FTm4OGqVD8+ZhFIlF2d/nArSTEnSP3h5qYcCxk4kNctMHiDfGdvoFGXMJ
	 jH7AKxv6UqE3hgKIpEEuirwDYLFNgnWAVimYhGWs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E1220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeLLLEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:04:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbeLLLEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:04:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC2062086D;
        Wed, 12 Dec 2018 11:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544612677;
        bh=NKajZ9vE+sC+5xLK302X1D51k7iZ5DvyIXoormARi64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0D7xqUgtHSFzxDbqnoUbWU+/3WTc+JYaKeQJTHbL0IIvY/hSQGdzQ9I6+vfMycaWT
         jDnxa/RryGqmI0HfI/WwgvAa6SdvSNVnBmJm6wq805O90WCOejwkhKhxOMQPB3qdi9
         Jk58aH1WgmQloekfCLQ1Yvxk2S70hu++LXeMnqEQ=
Date:   Wed, 12 Dec 2018 12:04:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>, oohall@gmail.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, jroedel@suse.de,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/6] driver core: Introduce device_iommu_mapped() function
Message-ID: <20181212110435.GC1990@kroah.com>
References: <20181211134343.10664-1-joro@8bytes.org>
 <20181211134343.10664-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211134343.10664-2-joro@8bytes.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 02:43:38PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Some places in the kernel check the iommu_group pointer in
> 'struct device' in order to find ot whether a device is
> mapped by an IOMMU.
> 
> This is not good way to make this check, as the pointer will
> be moved to 'struct dev_iommu_data'. This way to make the
> check is also not very readable.
> 
> Introduce an explicit function to perform this check.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

No need to have a cc: line if I have already acked it :)

thanks,

greg k-h
