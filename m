Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF77C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B492087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="fNHfgZqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfBDROV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:14:21 -0500
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:46080 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727810AbfBDROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1549300459;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=rRIYgpkoOU9OXyNN7jqzPWMWewZIFQicQrnhsy101kA=;
        b=fNHfgZqQCAIPedvEn9/V09tGYqNz+41uFUDzEvPKPtLzF+oYs+UPyt9aF1iKxinD
        bh8DOvBrneM8djIV8FXwYLhmyfi1OX1or69dkUp1EME8XHHZE50Sl5/y2eNyzaDG0p9
        sgutHg/yTiJ/yAYnzb5sp8+EcpQzIQIv6gS10zzU=
Date:   Mon, 4 Feb 2019 17:14:19 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     john.hubbard@gmail.com
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/6] RFC v2: mm: gup/dma tracking
In-Reply-To: <20190204052135.25784-1-jhubbard@nvidia.com>
Message-ID: <01000168b980e880-a7d8e0db-84fb-4398-8269-149c66b701b4-000000@email.amazonses.com>
References: <20190204052135.25784-1-jhubbard@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.04-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frankly I still think this does not solve anything.

Concurrent write access from two sources to a single page is simply wrong.
You cannot make this right by allowing long term RDMA pins in a filesystem
and thus the filesystem can never update part of its files on disk.

Can we just disable RDMA to regular filesystems? Regular filesystems
should have full control of the write back and dirty status of their
pages.

Special filesystems that do not actually do write back (like hugetlbfs),
mmaped raw device files and anonymous allocations are fine.

