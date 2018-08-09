Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE79C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 00:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67CE21BC9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 00:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k6zhje77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67CE21BC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbeHICaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 22:30:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHICaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 22:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D15PlVrM6McY8FCCYPL2KQvSLeLTkgNeJ3IDyovko88=; b=k6zhje77W6Z49t8q6mvfqOt41
        1OKRsyJJU6EV0aj5e1S9v93+yAJML0RzBeiQYFEkfVU7dQSOPK6eFRiMd2nCxvB2zfoA3xz+tUijm
        joiqGh1zeD4RPicbF1UyYTP5G+r1ncuv/1nbUDPg26JKAN2HJfCywd6f3Bb47vBmk58UjcyD6Trrd
        rEztib/OOjUSiwosqse40vvDJsMLw3Pnh4KHTGSWGh/aGxXBTZxQXMcKVqDCDEyirPVa3cqnf8rFt
        lHDGryZBkuL0BPFS91cD1nxUUS1mGyi/pcLCG4rFXn39/5P0zRrDwJ5vQleaaxm9yZfdZQnu/KJkb
        t+szYeGhg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnYTs-0002lh-Vh; Thu, 09 Aug 2018 00:07:08 +0000
Date:   Wed, 8 Aug 2018 17:07:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, darrick.wong@oracle.com,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, hughd@google.com, shuah@kernel.org,
        robh@kernel.org, ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, sfr@canb.auug.org.au,
        vdavydov.dev@gmail.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        ying.huang@intel.com, shakeelb@google.com, jbacik@fb.com,
        mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 01/10] rcu: Make CONFIG_SRCU unconditionally enabled
Message-ID: <20180809000708.GA5566@bombadil.infradead.org>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
 <20180808072040.GC27972@dhcp22.suse.cz>
 <d17e65bb-c114-55de-fb4e-e2f538779b92@virtuozzo.com>
 <20180808102734.GH27972@dhcp22.suse.cz>
 <20180808213125.GM2234@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808213125.GM2234@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 07:31:25AM +1000, Dave Chinner wrote:
> IMO, we've had enough recent bugs to deal with from shrinkers being
> called before the filesystem is set up and from trying to handle
> allocation errors during setup. Do we really want to make shrinker
> shutdown just as prone to mismanagement and subtle, hard to hit
> bugs? I don't think we do - unmount is simply not a critical
> performance path.

It's never been performance critical for me, but I'm not so sure that
there aren't container workloads which unmount filesystems multiple
times per second.
