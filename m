Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4202DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BE020989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544081043;
	bh=aRHlMzdx8XH730nvmXkChwgIkpst1s2bSdJKmbZSKrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fYKatQHSDBJYTtRrlVy69bkb36lijal+0tD0pGru7D5wvaCuL9/qGwZ3dlyLxRYr7
	 7GEkZn3rsH375RaQXPIUl53Xk/KU2HOIZUYwjC9Ly4kKkSQ5kW+IvI6guJlKdyKWXs
	 8yikMh6/tc/Wz4ZCwwgbHovTkFqh2ik+ZjBJGKkI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BE020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbeLFHYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:24:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:33560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728294AbeLFHYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:24:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94044AE66;
        Thu,  6 Dec 2018 07:23:59 +0000 (UTC)
Date:   Thu, 6 Dec 2018 08:23:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node
 offline
Message-ID: <20181206072357.GA1286@dhcp22.suse.cz>
References: <1543892757-4323-1-git-send-email-kernelfans@gmail.com>
 <20181204072251.GT31738@dhcp22.suse.cz>
 <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
 <20181204085601.GC1286@dhcp22.suse.cz>
 <CAFgQCTuyKBZdwWG=fOECE6J8DbZJsErJOyXTrLT0Kog3ec7vhw@mail.gmail.com>
 <20181205092148.GA1286@dhcp22.suse.cz>
 <CAFgQCTtj4m637tAzConCfeWQXSrWeNY-DLD5=f9-ZSmJMRe31Q@mail.gmail.com>
 <20181205094327.GD1286@dhcp22.suse.cz>
 <CAFgQCTu40HNsFVDVp+iXpPDoQ7VvGdTs8HLVy8=qTU77Bywt3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTu40HNsFVDVp+iXpPDoQ7VvGdTs8HLVy8=qTU77Bywt3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-12-18 11:34:30, Pingfan Liu wrote:
[...]
> > I suspect we are looking at two issues here. The first one, and a more
> > important one is that there is a NUMA affinity configured for the device
> > to a non-existing node. The second one is that nr_cpus affects
> > initialization of possible nodes.
> 
> The dev->numa_node info is extracted from acpi table, not depends on
> the instance of numa-node, which may be limited by nr_cpus. Hence the
> node is existing, just not instanced.

Hmm, binding to memory less node is quite dubious. But OK. I am not sure
how much sanitization can we do. We need to fallback anyway so we should
better make sure that all possible nodes are initialized regardless of
nr_cpus. I will look into that.

-- 
Michal Hocko
SUSE Labs
