Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEC5C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D0F208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D0F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeINFWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:22:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56782 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbeINFWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:22:06 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 42083C5C;
        Fri, 14 Sep 2018 00:10:18 +0000 (UTC)
Date:   Thu, 13 Sep 2018 17:10:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     prakash.sangappa@oracle.com
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, dave.hansen@intel.com, nao.horiguchi@gmail.com,
        kirill.shutemov@linux.intel.com, khandual@linux.vnet.ibm.com,
        steven.sistare@oracle.com
Subject: Re: [PATCH V2 0/6] VA to numa node information
Message-Id: <20180913171016.55dca2453c0773fc21044972@linux-foundation.org>
In-Reply-To: <375951d0-f103-dec3-34d8-bbeb2f45f666@oracle.com>
References: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
        <20180913084011.GC20287@dhcp22.suse.cz>
        <375951d0-f103-dec3-34d8-bbeb2f45f666@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 15:32:25 -0700 "prakash.sangappa" <prakash.sangappa@oracle.com> wrote:

> >> https://marc.info/?t=152524073400001&r=1&w=2
> > It would be really great to give a short summary of the previous
> > discussion. E.g. why do we need a proc interface in the first place when
> > we already have an API to query for the information you are proposing to
> > export [1]
> >
> > [1] http://lkml.kernel.org/r/20180503085741.GD4535@dhcp22.suse.cz
> 
> The proc interface provides an efficient way to export address range
> to numa node id mapping information compared to using the API.
> For example, for sparsely populated mappings, if a VMA has large portions
> not have any physical pages mapped, the page walk done thru the /proc file
> interface can skip over non existent PMDs / ptes. Whereas using the
> API the application would have to scan the entire VMA in page size units.
> 
> Also, VMAs having THP pages can have a mix of 4k pages and hugepages.
> The page walks would be efficient in scanning and determining if it is
> a THP huge page and step over it. Whereas using the API, the application
> would not know what page size mapping is used for a given VA and so would
> have to again scan the VMA in units of 4k page size.
> 
> If this sounds reasonable, I can add it to the commit / patch description.

Preferably with some runtime measurements, please.  How much faster is
this interface in real-world situations?  And why does that performance
matter?

It would also be useful to see more details on how this info helps
operators understand/tune/etc their applications and workloads.  In
other words, I'm trying to get an understanding of how useful this code
might be to our users in general.
