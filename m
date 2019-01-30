Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082B5C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33A42083B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfA3GtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:49:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbfA3GtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:49:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0U6mQ93142213
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:49:05 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qb6wcg674-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:49:05 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 30 Jan 2019 06:49:03 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 30 Jan 2019 06:48:59 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0U6mxWH6291890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 06:48:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2824A4054;
        Wed, 30 Jan 2019 06:48:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60BD1A405C;
        Wed, 30 Jan 2019 06:48:58 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.107])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Jan 2019 06:48:58 +0000 (GMT)
Date:   Wed, 30 Jan 2019 08:48:56 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/3] mm: Shuffle initial free memory to improve
 memory-side-cache utilization
References: <154882453052.1338686.16411162273671426494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154882453604.1338686.15108059741397800728.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154882453604.1338686.15108059741397800728.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19013006-0012-0000-0000-000002EEC23D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013006-0013-0000-0000-0000212607D6
Message-Id: <20190130064856.GB17937@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 09:02:16PM -0800, Dan Williams wrote:
> Randomization of the page allocator improves the average utilization of
> a direct-mapped memory-side-cache. Memory side caching is a platform
> capability that Linux has been previously exposed to in HPC
> (high-performance computing) environments on specialty platforms. In
> that instance it was a smaller pool of high-bandwidth-memory relative to
> higher-capacity / lower-bandwidth DRAM. Now, this capability is going to
> be found on general purpose server platforms where DRAM is a cache in
> front of higher latency persistent memory [1].

[ ... ]
 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/list.h    |   17 ++++
>  include/linux/mmzone.h  |    4 +
>  include/linux/shuffle.h |   45 +++++++++++
>  init/Kconfig            |   23 ++++++
>  mm/Makefile             |    7 ++
>  mm/memblock.c           |    1 
>  mm/memory_hotplug.c     |    3 +
>  mm/page_alloc.c         |    6 +-
>  mm/shuffle.c            |  188 +++++++++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 292 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/shuffle.h
>  create mode 100644 mm/shuffle.c

...

> diff --git a/mm/memblock.c b/mm/memblock.c
> index 022d4cbb3618..c0cfbfae4a03 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -17,6 +17,7 @@
>  #include <linux/poison.h>
>  #include <linux/pfn.h>
>  #include <linux/debugfs.h>
> +#include <linux/shuffle.h>

Nit: does not seem to be required

>  #include <linux/kmemleak.h>
>  #include <linux/seq_file.h>
>  #include <linux/memblock.h>

-- 
Sincerely yours,
Mike.

