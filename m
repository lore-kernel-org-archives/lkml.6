Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394BAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53002083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53002083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeHaMHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:07:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:63090 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbeHaMHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:07:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 01:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,309,1531810800"; 
   d="scan'208";a="84932414"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2018 01:00:44 -0700
Received: from tiger-server (unknown [10.239.48.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 68AA4580224;
        Fri, 31 Aug 2018 01:00:42 -0700 (PDT)
Date:   Sat, 1 Sep 2018 00:39:42 +0800
From:   Yi Zhang <yi.z.zhang@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        yu.c.zhang@intel.com, pagupta@redhat.com, david@redhat.com,
        jack@suse.cz, hch@lst.de, linux-mm@kvack.org, rkrcmar@redhat.com,
        jglisse@redhat.com, yi.z.zhang@intel.com
Subject: Re: [PATCH V4 4/4] kvm: add a check if pfn is from NVDIMM pmem.
Message-ID: <20180831163941.GA1220@tiger-server>
Mail-Followup-To: Dave Hansen <dave.hansen@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        pbonzini@redhat.com, dan.j.williams@intel.com, dave.jiang@intel.com,
        yu.c.zhang@intel.com, pagupta@redhat.com, david@redhat.com,
        jack@suse.cz, hch@lst.de, linux-mm@kvack.org, rkrcmar@redhat.com,
        jglisse@redhat.com, yi.z.zhang@intel.com
References: <cover.1534934405.git.yi.z.zhang@linux.intel.com>
 <a4183c0f0adfb6d123599dd306062fd193e83f5a.1534934405.git.yi.z.zhang@linux.intel.com>
 <4192066a-79f3-2b3e-386f-c4ec9b6dd8fd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4192066a-79f3-2b3e-386f-c4ec9b6dd8fd@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-30 at 12:07:11 -0700, Dave Hansen wrote:
> On 08/22/2018 03:58 AM, Zhang Yi wrote:
> >  bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
> >  {
> > -	if (pfn_valid(pfn))
> > -		return PageReserved(pfn_to_page(pfn));
> > +	struct page *page;
> > +
> > +	if (pfn_valid(pfn)) {
> > +		page = pfn_to_page(pfn);
> > +		return PageReserved(page) && !is_dax_page(page);
> > +	}
> 
> This is in desperate need of commenting about what it is doing and why.
> 
> The changelog alone doesn't cut it.
Thanks, Dave, Will add some comments
