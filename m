Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72B3C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718772146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1T4GyXw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718772146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeK3Kwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbeK3Kwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:52:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C35C02145D;
        Thu, 29 Nov 2018 23:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543535123;
        bh=49zSS3k4eVEOrNLBfQTbyTe+luG824xEl9+CeksydJY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=1T4GyXw/zxaLfcGQJ4aE0ByvOhGtC2wi3rJibQdfCUuLt1xB7ManGeFtJg+SYj8qR
         J26vRrAyay0YiMf4XJATTUkabb/Ao7rLBI7nuym4oFhnsT0z+eV6ts5sH+ZzQVjlqo
         v/AVxXIhbY5qjVZVDVDiTGl+4GwFdg7B1+vAAmZ0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Nicholas Mc Guire <hofrat@osadl.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542803310-32673-1-git-send-email-hofrat@osadl.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
References: <1542803310-32673-1-git-send-email-hofrat@osadl.org>
Message-ID: <154353512315.88331.4548631955021366823@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2] clk: zynq: do not allow kmalloc failure
Date:   Thu, 29 Nov 2018 15:45:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicholas Mc Guire (2018-11-21 04:28:30)
> The kmalloc here is small (< 16 bytes) and occurs during initialization
> during system startup here (can not be built as module) thus if this
> kmalloc failed it is an indication of something more serious going on
> and it is fine to hang the system here rather than cause some harder
> to understand error by dereferencing NULL.
> =

> Explicitly checking would not make that much sense here as the only
> possible reaction would be would BUG() here anyway.
> =

> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---

Nak. We don't have any __GFP_NOFAIL in drivers/clk and I don't see a
reason why we would want it here either. Just handle the failure, or
don't care if this is so critical to system boot.

