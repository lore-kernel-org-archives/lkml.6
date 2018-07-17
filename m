Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22CCECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06C020862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06C020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbeGQIyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:54:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:35110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728067AbeGQIyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:54:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F1D5ADED;
        Tue, 17 Jul 2018 08:22:41 +0000 (UTC)
Date:   Tue, 17 Jul 2018 10:22:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        yasu.isimatu@gmail.com, keescook@chromium.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        vbabka@suse.cz, mgorman@techsingularity.net
Subject: Re: Bug report about KASLR and ZONE_MOVABLE
Message-ID: <20180717082239.GC16803@dhcp22.suse.cz>
References: <20180711104944.GG1969@MiWiFi-R3L-srv>
 <20180711124008.GF2070@MiWiFi-R3L-srv>
 <72721138-ba6a-32c9-3489-f2060f40a4c9@cn.fujitsu.com>
 <20180712060115.GD6742@localhost.localdomain>
 <20180712123228.GK32648@dhcp22.suse.cz>
 <20180712235240.GH2070@MiWiFi-R3L-srv>
 <20180716113845.GM17280@dhcp22.suse.cz>
 <20180716130202.GB1724@MiWiFi-R3L-srv>
 <20180716152410.GU17280@dhcp22.suse.cz>
 <20180717015120.GC1724@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717015120.GC1724@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-07-18 09:51:20, Baoquan He wrote:
> On 07/16/18 at 05:24pm, Michal Hocko wrote:
> > On Mon 16-07-18 21:02:02, Baoquan He wrote:
> > > On 07/16/18 at 01:38pm, Michal Hocko wrote:
> > > > On Fri 13-07-18 07:52:40, Baoquan He wrote:
> > > > > Hi Michal,
> > > > > 
> > > > > On 07/12/18 at 02:32pm, Michal Hocko wrote:
> > > > [...]
> > > > > > I am not able to find the beginning of the email thread right now. Could
> > > > > > you summarize what is the actual problem please?
> > > > > 
> > > > > The bug is found on x86 now. 
> > > > > 
> > > > > When added "kernelcore=" or "movablecore=" into kernel command line,
> > > > > kernel memory is spread evenly among nodes. However, this is right when
> > > > > KASLR is not enabled, then kernel will be at 16M of place in x86 arch.
> > > > > If KASLR enabled, it could be put any place from 16M to 64T randomly.
> > > > >  
> > > > > Consider a scenario, we have 10 nodes, and each node has 20G memory, and
> > > > > we specify "kernelcore=50%", means each node will take 10G for
> > > > > kernelcore, 10G for movable area. But this doesn't take kernel position
> > > > > into consideration. E.g if kernel is put at 15G of 2nd node, namely
> > > > > node1. Then we think on node1 there's 10G for kernelcore, 10G for
> > > > > movable, in fact there's only 5G available for movable, just after
> > > > > kernel.
> > > > 
> > > > OK, I guess I see that part. But who is going to use movablecore along
> > > > with KASLR enabled? I mean do we really have to support those two
> > > > obscure command line parameters for KASLR?
> > > 
> > > Not very sure whether we have to support both of those to work with
> > > KASLR. Maybe it's time to make clear of it now.
> > 
> > Yes, I would really like to deprecate this. It is an ugly piece of code
> > and it's far from easily maintainable as well.
> > 
> > > For 'kernelcore=mirror', we have solved the conflict to make it work well
> > > with KASLR. For 'movable_node' conflict with KASLR, Chao is posting
> > > patches to fix it. As for 'kernelcore=' and 'movablecore=', 
> > > 
> > > 1) solve the conflict between them with KASLR in
> > >    find_zone_movable_pfns_for_nodes();
> > > 2) disable KASLR when 'kernelcore=' | 'movablecore=' is set;
> > > 3) disable 'kernelcore=' | 'movablecore=' when KASLR is enabled;
> > > 4) add note in doc to notice people to not add them at the same time;
> > 
> > I would simply warn that those kernel parameters are not supported
> > anymore. If somebody shows up with a valid usecase we can reconsider.
> 
> OK, got it. The use case I can think of is that people want to check 
> hotplug on system w/o hotplug ACPI info.

Let's see whether there is really somebody like that and complain.
 
> I am fine with warning people they are not supported. Should I post a
> patch to address this, or you will do it? Both is fine to me.

I will happily ack it if you create a patch.

-- 
Michal Hocko
SUSE Labs
