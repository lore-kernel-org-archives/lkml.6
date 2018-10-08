Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADB6C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCD521479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EKy/yg6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCD521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeJIDvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:51:10 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6354 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJIDvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:51:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bbbc00c0001>; Mon, 08 Oct 2018 13:37:32 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 08 Oct 2018 13:37:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 08 Oct 2018 13:37:36 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 8 Oct
 2018 20:37:36 +0000
Subject: Re: [PATCH v3 3/3] infiniband/mm: convert put_page() to
 put_user_page*()
To:     Jason Gunthorpe <jgg@ziepe.ca>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
References: <20181006024949.20691-1-jhubbard@nvidia.com>
 <20181006024949.20691-4-jhubbard@nvidia.com>
 <20181008194240.GA27639@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <15d3daac-ba59-b1c9-873d-1876b58bde9d@nvidia.com>
Date:   Mon, 8 Oct 2018 13:37:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008194240.GA27639@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539031052; bh=UPU6gaTYUbpThaNrh0ZMyq8C3tQujLrK+BYikj3ey/4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=EKy/yg6lU+bvpXuG4Cx2fyOUBOSf8SdJgWt3PsTmcTuHxqRwqZjnC/LTVDDxS19/y
         SuiTqC7I225R1OFIcd8M0BOiZrfXAkeZidtE6sUHriI26nbteiiok1v608kel1UElx
         NgGSffCe2dOO5rvQFXNF/n0gv7Jhgas8U5KCOHhB9V0uWOCtzvMPIrD1fTWtZPGsJw
         4lwhHeIzDaDPW7O9TP1JkLp45ISeDSP4kf60YLDZDsLJ1hFB+QhDM5Q+jVGG+msIQs
         GCX4gR/HaUIWUDcGpgV3Tz7Jqi5UsZ2h1HFb9vRoQ5b+yK1+eBBpY4neeDncKqk7o9
         zf5EuLNgDWDpA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 12:42 PM, Jason Gunthorpe wrote:
> On Fri, Oct 05, 2018 at 07:49:49PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
[...]
>>  drivers/infiniband/core/umem.c              |  7 ++++---
>>  drivers/infiniband/core/umem_odp.c          |  2 +-
>>  drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++++-------
>>  drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +++---
>>  drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++++-------
>>  drivers/infiniband/hw/qib/qib_user_sdma.c   |  8 ++++----
>>  drivers/infiniband/hw/usnic/usnic_uiom.c    |  7 ++++---
>>  7 files changed, 24 insertions(+), 28 deletions(-)
> 
> I have no issues with this, do you want this series to go through the
> rdma tree? Otherwise:
> 
> Acked-by: Jason Gunthorpe <jgg@mellanox.com>
> 

The RDMA tree seems like a good path for this, yes, glad you suggested
that.

I'll post a v4 with the comment fix and the recent reviewed-by's, which
should be ready for that.  It's based on today's linux.git tree at the 
moment, but let me know if I should re-apply it to the RDMA tree.


thanks,
-- 
John Hubbard
NVIDIA
