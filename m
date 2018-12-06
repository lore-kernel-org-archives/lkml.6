Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE804C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8B520878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544098316;
	bh=kRg434GESQd2lDp4Eh0KrX1YXHlUjdoRutCXfSAi7js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vxWch9xek+ltgBqwrb2jZUgRa5PdqkITFdGR5u6C99uyT4oF2haXJzYKBRkDqAikG
	 06FJEiX5Z/lZ9GuU07/uocJNYWSgZ6yuWlxQ+EtkZ+8OTBNXnqp08JHHSZtq+yI6+2
	 9h2hTGrLnEoOheBBkRD0whtfuWrUOSqQGLLdqz0Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8B520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeLFMLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:11:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:60914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727763AbeLFMLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:11:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57A99AF63;
        Thu,  6 Dec 2018 12:11:53 +0000 (UTC)
Date:   Thu, 6 Dec 2018 13:11:52 +0100
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
Message-ID: <20181206121152.GH1286@dhcp22.suse.cz>
References: <CAFgQCTv56drDBx-sTr6KdeQNKJnojG3g_a-k8wKe_q2y9w9NtA@mail.gmail.com>
 <20181204085601.GC1286@dhcp22.suse.cz>
 <CAFgQCTuyKBZdwWG=fOECE6J8DbZJsErJOyXTrLT0Kog3ec7vhw@mail.gmail.com>
 <20181205092148.GA1286@dhcp22.suse.cz>
 <CAFgQCTtj4m637tAzConCfeWQXSrWeNY-DLD5=f9-ZSmJMRe31Q@mail.gmail.com>
 <186b1804-3b1e-340e-f73b-f3c7e69649f5@suse.cz>
 <CAFgQCTv5-jeqwRVkJuDHvv0vq6uCzfdV2ZmVAU3eUzn2w2ReEQ@mail.gmail.com>
 <20181206082806.GB1286@dhcp22.suse.cz>
 <CAFgQCTsMdQSRFruZRGBuo30TjfiQ=sbrf9kUJAGgwN6uw+LsBw@mail.gmail.com>
 <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-12-18 18:44:03, Pingfan Liu wrote:
> On Thu, Dec 6, 2018 at 6:03 PM Pingfan Liu <kernelfans@gmail.com> wrote:
[...]
> > Which commit is this patch applied on? I can not apply it on latest linux tree.
> >
> I applied it by manual, will see the test result. I think it should
> work since you instance all the node.
> But there are two things worth to consider:
> -1st. why x86 do not bring up all nodes by default, apparently it will
> be more simple by that way

What do you mean? Why it didn't bring up before? Or do you see some
nodes not being brought up after this patch?

> -2nd. there are other archs, do they obey the rules?

I am afraid that each arch does its own initialization.
-- 
Michal Hocko
SUSE Labs
