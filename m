Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E79EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6A4208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfAJRmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:42:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbfAJRmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:42:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD347C0C5A4E;
        Thu, 10 Jan 2019 17:42:03 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5DF05C6C1;
        Thu, 10 Jan 2019 17:42:01 +0000 (UTC)
Date:   Thu, 10 Jan 2019 12:42:00 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Yao Yuan <yuan.yao@intel.com>, Fan Du <fan.du@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Peng Dong <dongx.peng@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-accelerators@lists.ozlabs.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC][PATCH v2 00/21] PMEM NUMA node and hotness
 accounting/migration
Message-ID: <20190110174159.GD4394@redhat.com>
References: <20181228050806.ewpxtwo3fpw7h3lq@wfg-t540p.sh.intel.com>
 <20181228084105.GQ16738@dhcp22.suse.cz>
 <20181228094208.7lgxhha34zpqu4db@wfg-t540p.sh.intel.com>
 <20181228121515.GS16738@dhcp22.suse.cz>
 <20181228133111.zromvopkfcg3m5oy@wfg-t540p.sh.intel.com>
 <20181228195224.GY16738@dhcp22.suse.cz>
 <20190102122110.00000206@huawei.com>
 <20190108145256.GX31793@dhcp22.suse.cz>
 <20190110155317.GB4394@redhat.com>
 <20190110164248.GO31793@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190110164248.GO31793@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 10 Jan 2019 17:42:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 05:42:48PM +0100, Michal Hocko wrote:
> On Thu 10-01-19 10:53:17, Jerome Glisse wrote:
> > On Tue, Jan 08, 2019 at 03:52:56PM +0100, Michal Hocko wrote:
> > > On Wed 02-01-19 12:21:10, Jonathan Cameron wrote:
> > > [...]
> > > > So ideally I'd love this set to head in a direction that helps me tick off
> > > > at least some of the above usecases and hopefully have some visibility on
> > > > how to address the others moving forwards,
> > > 
> > > Is it sufficient to have such a memory marked as movable (aka only have
> > > ZONE_MOVABLE)? That should rule out most of the kernel allocations and
> > > it fits the "balance by migration" concept.
> > 
> > This would not work for GPU, GPU driver really want to be in total
> > control of their memory yet sometimes they want to migrate some part
> > of the process to their memory.
> 
> But that also means that GPU doesn't really fit the model discussed
> here, right? I thought HMM is the way to manage such a memory.

HMM provides the plumbing and tools to manage but right now the patchset
for nouveau expose API through nouveau device file as nouveau ioctl. This
is not a good long term solution when you want to mix and match multiple
GPUs memory (possibly from different vendors). Then you get each device
driver implementing their own mem policy infrastructure and without any
coordination between devices/drivers. While it is _mostly_ ok for single
GPU case, it is seriously crippling for the multi-GPUs or multi-devices
cases (for instance when you chain network and GPU together or GPU and
storage).

People have been asking for a single common API to manage both regular
memory and device memory. As anyway the common case is you move things
around depending on which devices/CPUs is working on the dataset.

Cheers,
Jérôme
