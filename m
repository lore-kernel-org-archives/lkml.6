Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2DEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBDF218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545152145;
	bh=JMwEeeSSbSML21l4eV1WGnzLk+tfle034092yeOdo8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fLYa5qNLK/DfeXAth2qsByzzW5xGbpcN314pZf6w6BlEogAOm3s8uzFDP9EoWUJGN
	 1mo9bkyd2XZ15QbSvGUSgLAMW3IdyxpZ7+uzKJp+JGTgPYsxmlWmqa9Vpbv5PYXUC1
	 G+JNPKmZ0IHheXsECI5vFXCFoJEzWl2zxG1LF3uM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeLRQzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:55:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbeLRQzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:55:44 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F8E321841;
        Tue, 18 Dec 2018 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545152143;
        bh=JMwEeeSSbSML21l4eV1WGnzLk+tfle034092yeOdo8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okgp2NmihbPBHhUbzIs9C+IQVYCKoDb+7OSNLhwJGEi2Lx2U9Dkt7w6M1oaQ7Ar7t
         SNDBWQy4Yv5auvWYux1fv/337/gnSpwTjjLpuo+/x6HqBEimvQPXUYuuI3qrZKmCby
         GMWKrtHaxot7c+KxkRbXW0PxzTiJCpQ28uTvpgaA=
Date:   Tue, 18 Dec 2018 11:55:42 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Check for ring when getting debug
 info
Message-ID: <20181218165542.GA2746@sasha-vm>
References: <PU1P153MB016995B94393BB024F6DE7F8BFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PU1P153MB016995B94393BB024F6DE7F8BFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 08:16:09PM +0000, Dexuan Cui wrote:
>
>fc96df16a1ce is good and can already fix the "return stack garbage" issue,
>but let's also improve hv_ringbuffer_get_debuginfo(), which would silently
>return stack garbage, if people forget to check channel->state or
>ring_info->ring_buffer, when using the function in the future.
>
>Having an error check in the function would eliminate the potential risk.
>
>Add a Fixes tag to indicate the patch depdendency.
>
>Fixes: fc96df16a1ce ("Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels")
>Cc: stable@vger.kernel.org
>Cc: K. Y. Srinivasan <kys@microsoft.com>
>Cc: Haiyang Zhang <haiyangz@microsoft.com>
>Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
>
>*NOTE*: the patch is based on char-misc's char-misc-linus branch.

Queued up, thank you.

--
Thanks,
Sasha
