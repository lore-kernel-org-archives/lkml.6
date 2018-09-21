Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12857ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF8B21550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF8B21550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391364AbeIVBbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:31:41 -0400
Received: from ale.deltatee.com ([207.54.116.67]:45888 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391102AbeIVBbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:31:41 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g3RIi-0002FT-Hh; Fri, 21 Sep 2018 13:41:17 -0600
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Cc:     "mhocko@suse.com" <mhocko@suse.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
References: <20180920215824.19464.8884.stgit@localhost.localdomain>
 <20180920222415.19464.38400.stgit@localhost.localdomain>
 <a40a78c0-207b-03b7-344c-847b12a4f896@microsoft.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4d984974-ff16-35e4-76ff-f5e43e5e90da@deltatee.com>
Date:   Fri, 21 Sep 2018 13:41:12 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a40a78c0-207b-03b7-344c-847b12a4f896@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kirill.shutemov@linux.intel.com, dan.j.williams@intel.com, akpm@linux-foundation.org, jglisse@redhat.com, dave.hansen@intel.com, mingo@kernel.org, dave.jiang@intel.com, mhocko@suse.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, alexander.h.duyck@linux.intel.com, Pavel.Tatashin@microsoft.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 1/5] mm: Provide kernel parameter to allow disabling
 page init poisoning
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-21 1:04 PM, Pasha Tatashin wrote:
> 
>> +			pr_err("vm_debug option '%c' unknown. skipped\n",
>> +			       *str);
>> +		}
>> +
>> +		str++;
>> +	}
>> +out:
>> +	if (page_init_poisoning && !__page_init_poisoning)
>> +		pr_warn("Page struct poisoning disabled by kernel command line option 'vm_debug'\n");
> 
> New lines '\n' can be removed, they are not needed for kprintfs.

No, that's not correct.

A printk without a newline termination is not emitted
as output until the next printk call. (To support KERN_CONT).
Therefore removing the '\n' causes a printk to not be printed when it is
called which can cause long delayed messages and subtle problems when
debugging. Always keep the newline in place even though the kernel will
add one for you if it's missing.

Logan

