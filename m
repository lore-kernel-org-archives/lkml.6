Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73877C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A769217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfBFRUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:20:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:52239 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfBFRUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:20:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 09:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="114187766"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2019 09:20:07 -0800
Date:   Wed, 6 Feb 2019 10:19:37 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
Subject: Re: [PATCHv5 00/10] Heterogeneuos memory node attributes
Message-ID: <20190206171935.GJ28064@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
 <20190206123100.0000094a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206123100.0000094a@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 12:31:00PM +0000, Jonathan Cameron wrote:
> On Thu, 24 Jan 2019 16:07:14 -0700
> Keith Busch <keith.busch@intel.com> wrote:
> 
> 1) It seems this version added a hard dependence on having the memory node
>    listed in the Memory Proximity Domain attribute structures.  I'm not 100%
>    sure there is actually any requirement to have those structures. If you aren't
>    using the hint bit, they don't convey any information.  It could be argued
>    that they provide info on what is found in the other hmat entries, but there
>    is little purpose as those entries are explicit in what the provide.
>    (Given I didn't have any of these structures and things  worked fine with
>     v4 it seems this is a new check).

Right, v4 just used the node(s) with the highest performance. You mentioned
systems having nodes with different performance, but no winner across all
attributes, so there's no clear way to rank these for access class linkage.
Requiring an initiator PXM present clears that up.

Maybe we can fallback to performance if the initiator pxm isn't provided,
but the ranking is going to require an arbitrary decision, like prioritize
latency over bandwidth.
 
>    This is also somewhat inconsistent.
>    a) If a given entry isn't there, we still get for example
>       node4/access0/initiators/[read|write]_* but all values are 0.
>       If we want to do the check you have it needs to not create the files in
>       this case.  Whilst they have no meaning as there are no initiators, it
>       is inconsistent to my mind.
> 
>    b) Having one "Memory Proximity Domain attribute structure" for node 4 linking
>       it to node0 is sufficient to allow
>       node4/access0/initiators/node0
>       node4/access0/initiators/node1
>       node4/access0/initiators/node2
>       node4/access0/initiators/node3
>       I think if we are going to enforce the presence of that structure then only
>       the node0 link should exist.

We'd link the initiator pxm in the Address Range Structure, and also any
other nodes with identical performance access. I think that makes sense.
 
> 2) Error handling could perhaps do to spit out some nasty warnings.
>    If we have an entry for nodes that don't exist we shouldn't just fail silently,
>    that's just one example I managed to trigger with minor table tweaking.
> 
> Personally I would just get rid of enforcing anything based on the presence of
> that structure.
