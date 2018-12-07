Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A19CC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283F0208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544194216;
	bh=nKU/JsvTYsm4TryZVUibxA3/XhuBLxXjeVsl/RhZk80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TkRo5zbri6/H0yIdGuV2xJB76FMhAkVMzMZ0dl/oW5EYC8eR8CvNrdifUeZ99ei9Q
	 px9thReqDgI1oXFT72S1cKD/LldG9YPS0CB1kRcV1UE2ZlFt5RF48A8fQyfsMghDXq
	 EOZ41AGzPbf+64exODhW9Xht6DwAFCnPDBF8syxE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283F0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeLGOuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:50:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:51324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbeLGOuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:50:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4865DADCE;
        Fri,  7 Dec 2018 14:50:13 +0000 (UTC)
Date:   Fri, 7 Dec 2018 15:50:11 +0100
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
Message-ID: <20181207145011.GF1286@dhcp22.suse.cz>
References: <CAFgQCTsMdQSRFruZRGBuo30TjfiQ=sbrf9kUJAGgwN6uw+LsBw@mail.gmail.com>
 <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com>
 <20181206121152.GH1286@dhcp22.suse.cz>
 <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
 <20181207075322.GS1286@dhcp22.suse.cz>
 <CAFgQCTsFBUcOE9UKQ2vz=hg2FWp_QurZMQmJZ2wYLBqXkFHKHQ@mail.gmail.com>
 <20181207113044.GB1286@dhcp22.suse.cz>
 <CAFgQCTuf95pJSWDc1BNQ=gN76aJ_dtxMRbAV9a28X6w8vapdMQ@mail.gmail.com>
 <20181207142240.GC1286@dhcp22.suse.cz>
 <CAFgQCTuu54oZWKq_ppEvZFb4Mz31gVmsa37gTap+e9KbE=T0aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTuu54oZWKq_ppEvZFb4Mz31gVmsa37gTap+e9KbE=T0aQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-12-18 22:27:13, Pingfan Liu wrote:
> On Fri, Dec 7, 2018 at 10:22 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 07-12-18 21:20:17, Pingfan Liu wrote:
> > [...]
> > > Hi Michal,
> > >
> > > As I mentioned in my previous email, I have manually apply the patch,
> > > and the patch can not work for normal bootup.
> >
> > I am sorry, I have misread your previous response. Is there anything
> > interesting on the serial console by any chance?
> 
> Nothing. It need more effort to debug. But as I mentioned, enable all
> of the rest possible node, then it works. Maybe it can give some help
> for you.

I will have a look. Thanks!

-- 
Michal Hocko
SUSE Labs
