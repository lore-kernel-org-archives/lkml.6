Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD03DC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14B2205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14B2205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbeFTCEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:04:55 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7809 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753758AbeFTCEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:04:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b29b6480000>; Tue, 19 Jun 2018 19:04:56 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 Jun 2018 19:04:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 Jun 2018 19:04:50 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 Jun
 2018 02:04:50 +0000
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <john.hubbard@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
 <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com>
 <20180618081258.GB16991@lst.de>
 <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com>
 <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
 <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
 <0e6053b3-b78c-c8be-4fab-e8555810c732@nvidia.com>
 <20180619082949.wzoe42wpxsahuitu@quack2.suse.cz>
 <20180619090255.GA25522@bombadil.infradead.org>
 <20180619104142.lpilc6esz7w3a54i@quack2.suse.cz>
 <70001987-3938-d33e-11e0-de5b19ca3bdf@nvidia.com>
 <CAPcyv4iGKYRpbv-KK3KUrm8Ab485DwX05y4uGH2ZZ8GNYh8Q_g@mail.gmail.com>
 <ecb54f89-52dc-a37a-5592-d2c40f216047@nvidia.com>
 <CAPcyv4iZU3Cin589Tg2g=NN5XoTosbsosf27frxBCWznB+X8ng@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <e50e24f9-7867-48af-bfb2-2aa3c46cfd50@nvidia.com>
Date:   Tue, 19 Jun 2018 19:03:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iZU3Cin589Tg2g=NN5XoTosbsosf27frxBCWznB+X8ng@mail.gmail.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 06:57 PM, Dan Williams wrote:
> On Tue, Jun 19, 2018 at 6:34 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>> On 06/19/2018 06:24 PM, Dan Williams wrote:
>>> On Tue, Jun 19, 2018 at 11:11 AM, John Hubbard <jhubbard@nvidia.com> wrote:
>>>> On 06/19/2018 03:41 AM, Jan Kara wrote:
>>>>> On Tue 19-06-18 02:02:55, Matthew Wilcox wrote:
>>>>>> On Tue, Jun 19, 2018 at 10:29:49AM +0200, Jan Kara wrote:
>>> [..]
>>>>> And then there's the aspect that both these approaches are a bit too
>>>>> heavyweight for some get_user_pages_fast() users (e.g. direct IO) - Al Viro
>>>>> had an idea to use page lock for that path but e.g. fs/direct-io.c would have
>>>>> problems due to lock ordering constraints (filesystem ->get_block would
>>>>> suddently get called with the page lock held). But we can probably leave
>>>>> performance optimizations for phase two.
>>>>
>>>>
>>>> So I assume that phase one would be to apply this approach only to
>>>> get_user_pages_longterm. (Please let me know if that's wrong.)
>>>
>>> I think that's wrong, because get_user_pages_longterm() is only a
>>> filesystem-dax avoidance mechanism, it's not trying to address all the
>>> problems that Jan is talking about. I don't see any viable half-step
>>> solutions.
>>>
>>
>> OK, but in that case, I'm slightly confused by Jan's comment above, about leaving
>> performance optimizations until phase two. Because that *is* a half-step approach:
>> phase one, phase two.
> 
> No, sorry, I might be confusing things. The half step is leaving
> truncate broken, or my strawman that only addressed unmap.
> 
>> Are you disagreeing with Jan, or are you suggesting "fix get_user_pages first, and
>> leave get_user_pages_fast alone for now?"
> 
> I'm agreeing with Jan, we need to fix page_mkclean() and
> try_to_unmap() without regressing truncate behavior.
> 

OK, perfect, thanks for clarifying.  It all sounds consistent now. :)
