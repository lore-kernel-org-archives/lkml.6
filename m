Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C4BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CC420870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544731168;
	bh=+U0xK0aZyzqE88zIoPECx8eDRwonMiP3VRZN9KpKEYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E399+r/cQdm+cPOjthnTr2wiHiSZBb28mlruJmZ8OdSDBLmtJN9cz6Y4HuakhcL0Y
	 iZ24JIO9WyzBosaiLAdv9EU/Y74ro9AIBlxBBiOQeJWwajRM5EJFi8YUUygPLfRKoc
	 S/EYu8FcmhEgCXHKK+5mjSrT/6oR/EdgHVJt1NnI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CC420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeLMT70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbeLMT70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:59:26 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 502AF20811;
        Thu, 13 Dec 2018 19:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544731165;
        bh=+U0xK0aZyzqE88zIoPECx8eDRwonMiP3VRZN9KpKEYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vrb6XUwOyBVH+qTD7Fzvu89DDgxxsBjQgaldP5/p7VRID8Y9Y9WnxL3DvIUxDVPzm
         JwrZTiR+369r4iM6vDDbymfJsSrvrYDrpwekJkLsEguAns3zaN3xSMoXWw5qyE02XA
         J5C8qYFcvw2x1tjprU5pHvUXLoY368fMAXMZ3NgI=
Date:   Thu, 13 Dec 2018 14:59:23 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "'apw@canonical.com'" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Return -EINVAL for the sys files for
 unopened channels
Message-ID: <20181213195923.GL2746@sasha-vm>
References: <PU1P153MB0169DDAA2CBC2901505AE692BFA00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169DDAA2CBC2901505AE692BFA00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 04:35:43PM +0000, Dexuan Cui wrote:
>
>Before 98f4c651762c, we returned zeros for unopened channels.
>With 98f4c651762c, we started to return random on-stack values.
>
>We'd better return -EINVAL instead.
>
>Fixes: 98f4c651762c ("hv: move ringbuffer bus attributes to dev_groups")
>Cc: stable@vger.kernel.org
>Cc: K. Y. Srinivasan <kys@microsoft.com>
>Cc: Haiyang Zhang <haiyangz@microsoft.com>
>Cc: Stephen Hemminger <sthemmin@microsoft.com>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>

Queued up, thank you.

--
Thanks,
Sasha
