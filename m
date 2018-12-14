Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8042EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9A4208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jJmdFbHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbeLNU3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:29:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeLNU3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P9Nlvot3eVP0UsJbh9RKuVypGNDsz9WelOWaZg4X9fg=; b=jJmdFbHMoOY/m/W4xqzdHf2g7
        IKPvnV/nl+nRLaE4VkC4SSlABRurhQP5gcjRBRwMOu+oEC0F6WaFBbhrJmV1ODu60D5VkcmgoxKfr
        1+Z13GGG7TEgUfHbkqFj+QDpBoK3NL/FPqHO1YbMuvwLwHjVYmyTL8qUJZWVJukPRJG8wNGfRPgAy
        kyY4/n96e8qBRhP/e4LPcdO43cXeAFVTsYCAdA8veAvW26DFXI4VrxecXULL4aroXMflTqk6x4qH8
        TWhxBp3kPPjxXpttFbxBGCq1lHxsNP2musKM5h/dF6Kd+q8g3Hn65uGC9Ea1ATAlH2EJk0a/0P8Wh
        5Av01Be4g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXu5P-0005jM-GN; Fri, 14 Dec 2018 20:29:27 +0000
Date:   Fri, 14 Dec 2018 12:29:27 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        david <david@fromorbit.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181214202927.GI10600@bombadil.infradead.org>
References: <20181212215931.GG5037@redhat.com>
 <20181213005119.GD29416@dastard>
 <05a68829-6e6d-b766-11b4-99e1ba4bc87b@nvidia.com>
 <CAPcyv4jyG3YTtghyr04wws_hcSBAmPBpnCm0tFcKgz9VwrV=ow@mail.gmail.com>
 <01cf4e0c-b2d6-225a-3ee9-ef0f7e53684d@nvidia.com>
 <CAPcyv4hrbA9H20bi+QMpKNi7r=egstt61MdQSD5Fb293W1btaw@mail.gmail.com>
 <20181214194843.GG10600@bombadil.infradead.org>
 <ed49a260-ffd5-613d-e48b-dfb4b550e8bb@intel.com>
 <20181214200311.GH10600@bombadil.infradead.org>
 <CAPcyv4j1CJO=TAXiNzp032GnkJ0JcYSEXkn1ZqVP2o3b=P453g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j1CJO=TAXiNzp032GnkJ0JcYSEXkn1ZqVP2o3b=P453g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:17:08PM -0800, Dan Williams wrote:
> On Fri, Dec 14, 2018 at 12:03 PM Matthew Wilcox <willy@infradead.org> wrote:
> > Yes; working on the pfn-to-page structure right now as it happens ...
> > in the meantime, an XArray for it probably wouldn't be _too_ bad.
> 
> It might... see the recent patch from Ketih responding to complaints
> about get_dev_pagemap() lookup overhead:

Yeah, I saw.  I called xa_dump() on the pgmap_array() running under
QEmu and it's truly awful because the NVDIMMs presented by QEmu are
very misaligned.  If we can make the NVDIMMs better aligned, we won't
hit such a bad case in the XArray data structure.

