Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDCEC3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F8620861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qi4KHyTi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZyBN2eXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfAUWOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:14:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59818 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfAUWOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:14:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C4166089D; Mon, 21 Jan 2019 22:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548108891;
        bh=2Do9kADCkKchsyiKfXpH8JSxZkbeS9z1teg11DYQXBA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Qi4KHyTi/xAyKwoeFwBnskghqsffAX/ydnE7d99oyEsFnrC2KLmhQxpBbUpUCosbK
         KPuyMF2UJtDSWsaoxOUk2HY9cNoie9pXZ8yEqf3wOBm6WaQy0w7uQbHhzJ9K1nGa84
         3EpmWWL65Hx2cMZ3iiiay7aq+esxa7Ek7wkyar0M=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 297DF601D3;
        Mon, 21 Jan 2019 22:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548108889;
        bh=2Do9kADCkKchsyiKfXpH8JSxZkbeS9z1teg11DYQXBA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ZyBN2eXVqBY4h5Efh8aDV8TEL+dIJX+dU8mBOvkca9sOo+IeEgMtArQ8nEAFd5YV1
         7A1tji8XIEL8MBrmR1WCK/wSS0qhYN7ZTCPztVwbcAFKlotWw/cjdv+e15Qp4o2M5j
         Fs+IFnP9rRJh5vZflQzTgXJi+0pBF4Vri8X6hzA0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 297DF601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Mon, 21 Jan 2019 14:14:48 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        sumit.semwal@linaro.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
In-Reply-To: <20190121213028.GB28620@infradead.org>
Message-ID: <alpine.DEB.2.10.1901211412530.11004@lmark-linux.qualcomm.com>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org> <1547836667-13695-4-git-send-email-lmark@codeaurora.org> <20190119102527.GA17723@infradead.org> <7ae73c39-9049-bcf6-775f-b0817ba0ec5f@redhat.com> <20190121083046.GD12420@infradead.org>
 <alpine.DEB.2.10.1901211142560.9631@lmark-linux.qualcomm.com> <0ed7875f-15e9-184f-5b99-9a53df7c8d14@ti.com> <alpine.DEB.2.10.1901211214570.11004@lmark-linux.qualcomm.com> <20190121213028.GB28620@infradead.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Christoph Hellwig wrote:

> On Mon, Jan 21, 2019 at 12:20:42PM -0800, Liam Mark wrote:
> > I have left this to clients, but if they own the buffer they can have the 
> > knowledge as to whether CPU access is needed in that use case (example for 
> > post-processing).
> 
> That is an API design which the user is more likely to get wrong than
> right and thus does not pass the smell test.
> 

With the previous version of ION Android ION clients were successfully 
managing all their cache maintenance.



Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
