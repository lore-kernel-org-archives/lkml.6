Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4E8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FFA20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OJ1aN1X1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FFA20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbeLMD0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 22:26:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43881 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLMD0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 22:26:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so573917otr.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 19:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XOHDmXBO5zEIQbWMLHCVcDIKaK1XBR0yp39ppUNKbOA=;
        b=OJ1aN1X1PvEA5pofydik6Wj0c8JYh7HWbGjI90efl2bUNQLEozQrh9CdDsAXE1Cno6
         TpxqSfs91A+olAd+42ZlP7dc9l6Lp3crpDsWo7vTrZ3Cg3GphROCfapn3qCt6h28rSlo
         W6EpcmMnKRhGoHkgrwnrxp/q800rdfL2ywKhGOhhTE3QHB+YHK3dZKWukf0POGZCOm/C
         xwD0QUmLLWKcmYvJ2yQ2NAkTaVQ1AwxHlfElWWzhFLmPP+h5g+YNkMQXcl9kD0pAQAgI
         +pQNJS6QeRfLGrsZ+Ct0wOnhP6TL5551UIQSUE3xtWzqIhOkDUARAiE3Cjfo84zYpM3o
         WlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XOHDmXBO5zEIQbWMLHCVcDIKaK1XBR0yp39ppUNKbOA=;
        b=XJvWc20SeS0jcckkmjvQXqdDpJPJXNXHmrUurmBET1/xEbMsc+UyYuvmRwy4h7GKls
         xvdAY3J3cBoXiNNpUm8a4OJ7C/wSv55+QMgI52hgln500vjoPtISP3eabPHyoYW6uhoK
         VdvuXdIta18z+gZcppClAZN4jQABftREAwWXbR1kj7OKeBIHamsxi/izH1/SSXrFnabN
         14Bt3pOwURSJrvFed+JSpXjvuHRglZroKvthBxDfhgiCfwjKlldla4Urnr+jsiptSMNb
         eZWqJHRP9qm2bGLPa4Q0zR6d+3J0qSb+GOP/xf8SlbVPAJXLOQLeUPR7tMJ+tgdK4Iy3
         VqgA==
X-Gm-Message-State: AA+aEWbOTmC2/ZHC5+WY3bCbZnjPbCxGCBYCx34KOjrjiXnsrJ3DR/dW
        b8Ku4BbHo12ovf4NW8aaVsuchA==
X-Google-Smtp-Source: AFSGD/VpCvP09C7w2Lk2lbx6Erg7JF6se5adtQ3FYNsxrOIu4fwRSdl3nKAWVgUTa6B4SYxoX2mDjA==
X-Received: by 2002:a9d:4c88:: with SMTP id m8mr16515753otf.360.1544671598894;
        Wed, 12 Dec 2018 19:26:38 -0800 (PST)
Received: from ziepe.ca (rrcs-24-227-213-164.sw.biz.rr.com. [24.227.213.164])
        by smtp.gmail.com with ESMTPSA id 127sm312690oid.36.2018.12.12.19.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 19:26:38 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gXHe1-0000rp-2w; Wed, 12 Dec 2018 20:26:37 -0700
Date:   Wed, 12 Dec 2018 20:26:37 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181213032637.GB3204@ziepe.ca>
References: <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <CAPcyv4go0Xzhz8rXdfscWuXDu83BO9v8WD4upDUJWb7gKzX5OQ@mail.gmail.com>
 <20181212213005.GE5037@redhat.com>
 <CAPcyv4gJHeFjEgna1S-2uE4KxkSUgkc=e=2E5oqfoirec84C-w@mail.gmail.com>
 <20181212215348.GF5037@redhat.com>
 <20181212233703.GB2947@ziepe.ca>
 <20181213000109.GK5037@redhat.com>
 <CAPcyv4ii6hyrNj=fijoZ1no8w6N1Kk2jGZyWCn7hFKNKaNsyXQ@mail.gmail.com>
 <20181213004437.GL5037@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213004437.GL5037@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 07:44:37PM -0500, Jerome Glisse wrote:

> On many GPUs you can do that, it is hardware dependant and you have
> steps to take but it is something you can do (and GPU can do
> continuous DMA traffic have they have threads running that can
> do continuous memory access). So i assume that other hardware
> can do it too.

RDMA has no generic way to modify a MR and then guarntee the HW sees
the modifications. Some HW can do this (ie the same HW that can do
ODP, because ODP needs this capability), other HW is an unknown as
this has never been asked for as a driver API.

Jason
