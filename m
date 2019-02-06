Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65415C4151A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3252A218DA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kjMhfcP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfBFUt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:49:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfBFUt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NL1MPyRU/T/2aVS0UzGM98TCSfb5ympBh3xbI7SJ34A=; b=kjMhfcP6/nCSoSlWl2K7h4tCU
        K2r5F+WrqeCQDKBF4VVmFZdO5boPVHwGwaWTO2Bqp+nKvEdq+ZNoBMPuAPs3rrnRSHvcydo8c60Ee
        Zc9rJaOiEUGEz4+y+qKlnkVU2rVOeswtzmffDldixXaGdoqxclVsWsSKObzWa5v01UXR3hxh0LUjc
        lCjORh510SMfx5CEDfyN7x2k73Ylio2FCe9iICPDP/kCOxygcV2Ds0wGEiqOZqKtEGrfgeZhRn9Fi
        s5wTUFJfgRKHPyRNWHeQS55tsIsDEtFBuKPFb6OSatbKMpWxK+FAv7MO95tcPWJ6Wmc/1xKhMsHgH
        qv1E47GOQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grU8o-0001SI-TO; Wed, 06 Feb 2019 20:49:54 +0000
Date:   Wed, 6 Feb 2019 12:49:54 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Christopher Lameter <cl@linux.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190206204954.GS21860@bombadil.infradead.org>
References: <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206194055.GP21860@bombadil.infradead.org>
 <a9df9be75966f34f55f843a3cd7e1ee7d497c7fa.camel@redhat.com>
 <20190206202021.GQ21860@bombadil.infradead.org>
 <a8dc27e81182060b3480127332c77ac624abcb22.camel@redhat.com>
 <20190206204128.GR21860@bombadil.infradead.org>
 <fbdeccb01f7d0ba2f6ebb69660b7aa3d99690042.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbdeccb01f7d0ba2f6ebb69660b7aa3d99690042.camel@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 03:47:53PM -0500, Doug Ledford wrote:
> On Wed, 2019-02-06 at 12:41 -0800, Matthew Wilcox wrote:
> > On Wed, Feb 06, 2019 at 03:28:35PM -0500, Doug Ledford wrote:
> > > On Wed, 2019-02-06 at 12:20 -0800, Matthew Wilcox wrote:
> > > > Not hot-unplugging the RDMA device but hot-unplugging an NV-DIMM.

^^^ I think you missed this line ^^^

> You said "now that I think about it, there was a desire to support hot-
> unplug which also needed revoke".  For us, hot unplug is done at the
> device level and means all connections must be torn down.  So in the
> context of this argument, if people want revoke so DAX can migrate from
> one NV-DIMM to another, ok.  But revoke does not help RDMA migrate.
> 
> If, instead, you mean that you want to support hot unplug of an NV-DIMM
> that is currently the target of RDMA transfers, then I believe
> Christoph's answer on this is correct.  It all boils down to which
> device you are talking about doing the hot unplug on.

