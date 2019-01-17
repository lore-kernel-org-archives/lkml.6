Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC89C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5AB20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YTu6rxWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfAQJCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:02:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfAQJCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XAoos3UGtKwWZX9H/mGqjf00n0NGLotPlsblsRqXSb4=; b=YTu6rxWc3FQhzcXk3EPBU7HLR
        OyTcM1f9sS+6kF4/dVoOiKp7CInaF4VTp0EiSmTfXRJQQ7/W/5jP8KonkowGVKrIqaMfiWeRU9je5
        JdkFycpKIs5gVzdRP72xc0breLM7wMeHKOyDQwsHuHIKniHsaArS6313YXeXrat/4HSzD6OBn+TdG
        lK3d9GrluWcorLd5oSjaRJ+uhRR7MzmSPenrDm1V48o/T8q3VVbkGRvr0/INmLgsCX6p0kCXPAZ3p
        v9S1sckbTwakh55iMk1TPS/zJOgjwyk+EItRLxvtawaefglh4KMJYL0C1CwW/bPPIcnbWcd2xcXB7
        3oo01m5Lw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gk3ZU-0006xa-40; Thu, 17 Jan 2019 09:02:44 +0000
Date:   Thu, 17 Jan 2019 01:02:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Liam Mark <lmark@codeaurora.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 13/14] staging: android: ion: Do not sync CPU cache on
 map/unmap
Message-ID: <20190117090243.GA21651@infradead.org>
References: <20190111180523.27862-1-afd@ti.com>
 <20190111180523.27862-14-afd@ti.com>
 <alpine.DEB.2.10.1901140910130.23879@lmark-linux.qualcomm.com>
 <79eb70f6-00b0-2939-5ec9-65e196ab4987@ti.com>
 <alpine.DEB.2.10.1901150937280.4046@lmark-linux.qualcomm.com>
 <cfcd3daf-bd1d-0dbc-7b5c-8e504d179564@ti.com>
 <b6cb5596-6beb-73e0-0d8c-d9a13466d626@redhat.com>
 <99ca0b08-02bd-64fd-d43c-c330f0d11639@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ca0b08-02bd-64fd-d43c-c330f0d11639@ti.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:17:23AM -0600, Andrew F. Davis wrote:
> I wouldn't go as far as to remove them just yet.. Liam seems pretty
> adamant that they have valid uses. I'm just not sure performance is one
> of them, maybe in the case of software locks between devices or
> something where there needs to be a lot of back and forth interleaved
> access on small amounts of data?

We shouldn't add unused features to start with.  If mainline users for
them appear we can always add them back once we've reviewed the uses
cases and agree that they are sane and have no better solution.
