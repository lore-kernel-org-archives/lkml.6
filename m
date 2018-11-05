Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0275C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5F020854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KG7BWaSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5F020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbeKEQnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:43:53 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19848 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbeKEQnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:43:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bdff05d0001>; Sun, 04 Nov 2018 23:25:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 04 Nov 2018 23:25:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 04 Nov 2018 23:25:35 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 5 Nov
 2018 07:25:32 +0000
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 5 Nov
 2018 07:25:32 +0000
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
To:     Jan Kara <jack@suse.cz>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        <john.hubbard@gmail.com>, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        "Jerome Glisse" <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
 <20181008211623.30796-3-jhubbard@nvidia.com>
 <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
 <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
 <20181010164541.ec4bf53f5a9e4ba6e5b52a21@linux-foundation.org>
 <20181011084929.GB8418@quack2.suse.cz> <20181011132013.GA5968@ziepe.ca>
 <97e89e08-5b94-240a-56e9-ece2b91f6dbc@nvidia.com>
 <b9899626-9033-348b-6f07-dc90bcd8a468@nvidia.com>
 <20181018101951.GO23493@quack2.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <4f47f3d4-1b00-e534-309c-7fb044337040@nvidia.com>
Date:   Sun, 4 Nov 2018 23:25:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181018101951.GO23493@quack2.suse.cz>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL102.nvidia.com (172.18.146.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541402721; bh=ReYcnE3LiIYKJSvJ8lc9RYRagqIEWXrM25ZXw9DLIFI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KG7BWaSJO8jNFEu/qSw+p2BrGGH8eMI47YwOJrucbCskrETafvtWXRhRln1+sLmPw
         MbMnKYqARY8wXUJLmV+rkL2N+1FGfTLLoYtBzHhFqaDtgaAfRtc9s0wM+C4HmwjXrw
         bckMJ+QVR4ef+QHKYA+uhThuWpynF6yu7esAjalAyGNYWcbL4Xq5+5ALbXiYrBWE0G
         RMEzHARdydC44BNhVz3FtMsk+oFw6oHX10NA1aA1JUmoCG+ai1lbxvb5EisYqfJ1oT
         p0h8AtOjOFG5j14R9HpP+ZQc7fLqxZeZpyacS7j97iGEJ5jBhstVOwg1T8sKfvVq42
         DGBcx3Krxfk4g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 3:19 AM, Jan Kara wrote:
> On Thu 11-10-18 20:53:34, John Hubbard wrote:
>> On 10/11/18 6:23 PM, John Hubbard wrote:
>>> On 10/11/18 6:20 AM, Jason Gunthorpe wrote:
>>>> On Thu, Oct 11, 2018 at 10:49:29AM +0200, Jan Kara wrote:
[...]
> Well, put_page() cannot assert page is not dma-pinned as someone can still
> to get_page(), put_page() on dma-pinned page and that must not barf. But
> put_page() could assert that if the page is pinned, refcount is >=
> pincount. That will detect leaked pin references relatively quickly.
> 

That assertion is definitely a life saver. I've been attempting a combination
of finishing up more call site conversions, and runtime testing, and this
lights up the missing conversions pretty nicely.

As I mentioned in another thread just now, I'll send out an updated RFC this week,
so that people can look through it well before the LPC (next week).

thanks,
-- 
John Hubbard
NVIDIA
