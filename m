Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEE6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC352147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550727257;
	bh=nvpYcxoY6112t2ls0yhRUAmCHjtFWZfjgKn6ueQJDss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BQ+aMVCPYEW2zXp6lVhufVpYLo7oAff6KMijHwvrpC0J91CBBCqZcrtvpZPjqAkef
	 ihvD0vKRcffQQA+8ep04xJMBsidkGWfgAmyXnZ10LKXHN1PMrqI7aX7vwJDhKUS6o+
	 iZJbDzTkoZB+d9Vs1uoDmQi208P5dCDvIrRRtQD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfBUFeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:34:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUFeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:34:15 -0500
Received: from localhost (unknown [106.201.39.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6705E2080F;
        Thu, 21 Feb 2019 05:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550727255;
        bh=nvpYcxoY6112t2ls0yhRUAmCHjtFWZfjgKn6ueQJDss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v4OUmr7YiE0HqY8MhTRBmX3LX1Qo2+BlApDasQypdN3Eeekp+DvsYHYmpo+cK9M03
         DUB4UKqdrUJlsErkDm2jWm1du2UxUeZmCxSfotJGiH5x3ZiRVVLLVAbI7zwgVhrZCe
         J5EmlObNe8oJxWUSjTtIOQkPYoIorXvEW7bimCKw=
Date:   Thu, 21 Feb 2019 11:04:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     David Miller <davem@davemloft.net>, jiri@resnulli.us,
        sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190221053409.GH2736@vkoul-mobl>
References: <20190220044055.GD21884@vkoul-mobl>
 <20190219.224813.723564128666927693.davem@davemloft.net>
 <20190220083611.GJ3080@nanopsycho>
 <20190220.110201.2245447687492293995.davem@davemloft.net>
 <20190220205910.7bd7fd40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220205910.7bd7fd40@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-02-19, 20:59, Stefano Brivio wrote:
> On Wed, 20 Feb 2019 11:02:01 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
> 
> > From: Jiri Pirko <jiri@resnulli.us>
> > Date: Wed, 20 Feb 2019 09:36:11 +0100
> > 
> > > Would be good to have some robot checking "Fixes" sanity...  
> > 
> > I want to add a script to my trees that locally do it for me but the
> > backlog for patch review for me is so huge that I never get to "fun"
> > tasks like that....
> 
> If it helps, this is what I use after being bitten once:
> 
> #!/bin/sh
> 
> [ ${#} -ne 2 ] && echo "Usage: %0 PATCH_FILE GIT_TREE" && exit 1
> grep "^Fixes: " "${1}" | while read -r f; do
> 	sha="$(echo "${f}" | cut -d' ' -f2)"
> 	if [ -z "${sha}" ] || [ "${f}" != "$(git -C "${2}" show -s --abbrev=12 --pretty=format:"Fixes: %h (\"%s\")" "${sha}" 2>/dev/null)" ]; then
> 		echo "Bad tag: ${f}" && exit 1
> 	fi
> done

Awesome thanks, I am adding this into my patch commit script and well as
send script

-- 
~Vinod
