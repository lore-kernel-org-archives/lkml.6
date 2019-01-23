Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0247EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3A721855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAWUPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:15:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfAWUPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:15:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D423C7C0A;
        Wed, 23 Jan 2019 20:15:12 +0000 (UTC)
Received: from redhat.com (ovpn-124-254.rdu2.redhat.com [10.10.124.254])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A4CD6C510;
        Wed, 23 Jan 2019 20:15:09 +0000 (UTC)
Date:   Wed, 23 Jan 2019 15:15:06 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, dave@sr71.net,
        dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com, fengguang.wu@intel.com,
        bp@suse.de, bhelgaas@google.com, baiyaowei@cmss.chinamobile.com,
        tiwai@suse.de
Subject: Re: [PATCH 2/4] mm/memory-hotplug: allow memory resources to be
 children
Message-ID: <20190123201506.GG3097@redhat.com>
References: <20190116181859.D1504459@viggo.jf.intel.com>
 <20190116181902.670EEBC3@viggo.jf.intel.com>
 <20190116191635.GD3617@redhat.com>
 <2b52778d-f120-eec7-3e7a-3a9c182170f0@intel.com>
 <20190116233849.GE3617@redhat.com>
 <b1f22eda-b52f-af20-637f-b45971a12d33@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1f22eda-b52f-af20-637f-b45971a12d33@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 23 Jan 2019 20:15:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 12:03:54PM -0800, Dave Hansen wrote:
> On 1/16/19 3:38 PM, Jerome Glisse wrote:
> > So right now i would rather that we keep properly reporting this
> > hazard so that at least we know it failed because of that. This
> > also include making sure that we can not register private memory
> > as a child of an un-busy resource that does exist but might not
> > have yet been claim by its rightful owner.
> 
> I can definitely keep the warning in.  But, I don't think there's a
> chance of HMM registering a IORES_DESC_DEVICE_PRIVATE_MEMORY region as
> the child of another.  The region_intersects() check *should* find that:

Sounds fine to (just keep the warning).

Cheers,
Jérôme

> 
> >         for (; addr > size && addr >= iomem_resource.start; addr -= size) {
> >                 ret = region_intersects(addr, size, 0, IORES_DESC_NONE);
> >                 if (ret != REGION_DISJOINT)
> >                         continue;
> 
