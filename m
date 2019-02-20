Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E83C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF7020700
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfBTT7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:59:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfBTT7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:59:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36B7BE9517;
        Wed, 20 Feb 2019 19:59:20 +0000 (UTC)
Received: from localhost (ovpn-200-19.brq.redhat.com [10.40.200.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C126D177AD;
        Wed, 20 Feb 2019 19:59:16 +0000 (UTC)
Date:   Wed, 20 Feb 2019 20:59:10 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     jiri@resnulli.us, vkoul@kernel.org, sfr@canb.auug.org.au,
        netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190220205910.7bd7fd40@redhat.com>
In-Reply-To: <20190220.110201.2245447687492293995.davem@davemloft.net>
References: <20190220044055.GD21884@vkoul-mobl>
        <20190219.224813.723564128666927693.davem@davemloft.net>
        <20190220083611.GJ3080@nanopsycho>
        <20190220.110201.2245447687492293995.davem@davemloft.net>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 20 Feb 2019 19:59:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 11:02:01 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Jiri Pirko <jiri@resnulli.us>
> Date: Wed, 20 Feb 2019 09:36:11 +0100
> 
> > Would be good to have some robot checking "Fixes" sanity...  
> 
> I want to add a script to my trees that locally do it for me but the
> backlog for patch review for me is so huge that I never get to "fun"
> tasks like that....

If it helps, this is what I use after being bitten once:

#!/bin/sh

[ ${#} -ne 2 ] && echo "Usage: %0 PATCH_FILE GIT_TREE" && exit 1
grep "^Fixes: " "${1}" | while read -r f; do
	sha="$(echo "${f}" | cut -d' ' -f2)"
	if [ -z "${sha}" ] || [ "${f}" != "$(git -C "${2}" show -s --abbrev=12 --pretty=format:"Fixes: %h (\"%s\")" "${sha}" 2>/dev/null)" ]; then
		echo "Bad tag: ${f}" && exit 1
	fi
done

-- 
Stefano
