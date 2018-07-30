Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40602FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF7020870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF7020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbeG3PqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:46:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:34700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbeG3PqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:46:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66CB9AD35;
        Mon, 30 Jul 2018 14:10:59 +0000 (UTC)
Date:   Mon, 30 Jul 2018 16:10:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        mingo@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        dan.j.williams@intel.com, jack@suse.cz, mawilcox@microsoft.com,
        jglisse@redhat.com, Souptick Joarder <jrdr.linux@gmail.com>,
        kirill.shutemov@linux.intel.com, Vlastimil Babka <vbabka@suse.cz>,
        osalvador@techadventures.net, yasu.isimatu@gmail.com,
        malat@debian.org, Mel Gorman <mgorman@suse.de>,
        iamjoonsoo.kim@lge.com
Subject: Re: [PATCH v1] mm: inititalize struct pages when adding a section
Message-ID: <20180730141058.GV24267@dhcp22.suse.cz>
References: <20180727165454.27292-1-david@redhat.com>
 <20180730113029.GM24267@dhcp22.suse.cz>
 <6cc416e7-522c-a67e-2706-f37aadff084f@redhat.com>
 <20180730120529.GN24267@dhcp22.suse.cz>
 <7b58af7b-5187-2c76-b458-b0f49875a1fc@redhat.com>
 <CAGM2reahiWj5LFq1npRpwK2k-4K-L9hr3AHUV9uYcmT2s3Bnuw@mail.gmail.com>
 <56e97799-fbe1-9546-46ab-a9b8ee8794e0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56e97799-fbe1-9546-46ab-a9b8ee8794e0@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-07-18 15:51:45, David Hildenbrand wrote:
> On 30.07.2018 15:30, Pavel Tatashin wrote:
[...]
> > Hi David,
> > 
> > Have you figured out why we access struct pages during hot-unplug for
> > offlined memory? Also, a panic trace would be useful in the patch.
> 
> __remove_pages() needs a zone as of now (e.g. to recalculate if the zone
> is contiguous). This zone is taken from the first page of memory to be
> removed. If the struct pages are uninitialized that value is random and
> we might even get an invalid zone.
>
> The zone is also used to locate pgdat.
> 
> No stack trace available so far, I'm just reading the code and try to
> understand how this whole memory hotplug/unplug machinery works.

Yes this is a mess (evolution of the code called otherwise ;) [1].
Functionality has been just added on top of not very well thought
through bases. This is a nice example of it. We are trying to get a zone
to 1) special case zone_device 2) recalculate zone state. The first
shouldn't be really needed because we should simply rely on altmap.
Whether it is used for zone device or not. 2) shouldn't be really needed
if the section is offline and we can check that trivially.

[1] on the other hand I can see why people were reluctant to understand
the mess and rather tweak their tiny thing on top...
-- 
Michal Hocko
SUSE Labs
