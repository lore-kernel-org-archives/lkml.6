Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B9EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EFC20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544612559;
	bh=6ZVQj1/kgtry1/4NpeNrCqvhWQbKyU0EW3bgC0wNE/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yn1CMTPHYd9suCAJFv87Vb1yRN8Zs2638xnqxIqBNTWJxFIKTpPB0WxwlPStdERQ4
	 dgUzVzvR52oiPSENE0AqMDuePsl15dSun4UrAroqnUxp4KR1QFToMBy7jaJgRGJ+a7
	 z7MOpgD7wdkWGObr6UYW9sJUrpxtBcA+0CUkK8qQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EFC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeLLLCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:02:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbeLLLCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:02:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5E9120839;
        Wed, 12 Dec 2018 11:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544612557;
        bh=6ZVQj1/kgtry1/4NpeNrCqvhWQbKyU0EW3bgC0wNE/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9WWZvTzZO+qesEU/6BaYAXQwAB817gxWWOLhKJ1ogxV/wIw6r3tVoPLvTXJZ5Mrb
         kZmqsbC5S3SZUIbWbd5CG2mSDiYb5iiDOohE5BnkWsfNA+zzwrrVVmtKqsYG+JZ71l
         sGYpI9rPpFlyt3sGiFC9ZEzek6eX7KF35yOlDrrA=
Date:   Wed, 12 Dec 2018 12:02:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        bkumar@qti.qualcomm.com, thierry.escande@linaro.org
Subject: Re: [PATCH v2 3/6] misc: fastrpc: Add support for context Invoke
 method
Message-ID: <20181212110234.GB1990@kroah.com>
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
 <20181207163513.16412-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207163513.16412-4-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 04:35:10PM +0000, Srinivas Kandagatla wrote:
> +#define FASTRPC_BUILD_SCALARS(attr, method, in, out, oin, oout) \
> +		((((uint32_t)  (attr) & 0x07) << 29) | \
> +		(((uint32_t) (method) & 0x1f) << 24) | \

Why all of the uint32_t and uint64_t types in this patch, but not the
previous one?

Please just stick with u32 and u64, those are the correct kernel types
to be using everywhere.  uint32_t and friends are userspace things that
make no sense in kernel space.

Yes, I know people use them, but we should not be adding to the problem
by creating new instances of them for no good reason.

thanks,

greg k-h
