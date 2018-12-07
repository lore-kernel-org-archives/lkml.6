Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C466C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0B0208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544169206;
	bh=wopcDO8i+4GBvgm71NWBHmZO9xCFc4U9WvHHgjelfSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jg3ONQdVfejeFcHsSNBD1P7TyhNrXH3HaYTBDyfEl103qZAOATzcf6KyjCOC4MMwQ
	 p2k0GACn/0MlpIn6Hunr4MM5J6sjbUe27FRGv72p3fdX2gWuKXIyyBMQNBA586CdrA
	 DTuGgkinLfH6lBwTCkzDmlksp9oHEG1DPa3hn6JI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0B0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeLGHxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:53:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:40980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725952AbeLGHxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:53:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36E53B007;
        Fri,  7 Dec 2018 07:53:23 +0000 (UTC)
Date:   Fri, 7 Dec 2018 08:53:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node
 offline
Message-ID: <20181207075322.GS1286@dhcp22.suse.cz>
References: <CAFgQCTuyKBZdwWG=fOECE6J8DbZJsErJOyXTrLT0Kog3ec7vhw@mail.gmail.com>
 <20181205092148.GA1286@dhcp22.suse.cz>
 <CAFgQCTtj4m637tAzConCfeWQXSrWeNY-DLD5=f9-ZSmJMRe31Q@mail.gmail.com>
 <186b1804-3b1e-340e-f73b-f3c7e69649f5@suse.cz>
 <CAFgQCTv5-jeqwRVkJuDHvv0vq6uCzfdV2ZmVAU3eUzn2w2ReEQ@mail.gmail.com>
 <20181206082806.GB1286@dhcp22.suse.cz>
 <CAFgQCTsMdQSRFruZRGBuo30TjfiQ=sbrf9kUJAGgwN6uw+LsBw@mail.gmail.com>
 <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com>
 <20181206121152.GH1286@dhcp22.suse.cz>
 <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-12-18 10:56:51, Pingfan Liu wrote:
[...]
> In a short word, the fix method should consider about the two factors:
> semantic of online-node and the effect on all archs

I am pretty sure there is a lot of room for unification in this area.
Nevertheless I strongly believe the bug should be fixed firs with the
simplest way and all the cleanup should be done on top.

Do I get it right that the diff worked for you and I can prepare a full
patch?

-- 
Michal Hocko
SUSE Labs
