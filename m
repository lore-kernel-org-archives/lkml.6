Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F37C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DE52087D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DE52087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeI2RA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:00:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727756AbeI2RA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:00:58 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8TATkQL042082
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 06:33:03 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mt5hvb78w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 06:33:02 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Sat, 29 Sep 2018 11:33:01 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 29 Sep 2018 11:32:56 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8TAWtoi57606184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Sep 2018 10:32:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39D8542041;
        Sat, 29 Sep 2018 13:32:38 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F03FC42045;
        Sat, 29 Sep 2018 13:32:36 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.35])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 29 Sep 2018 13:32:36 +0100 (BST)
Date:   Sat, 29 Sep 2018 13:32:52 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kselftest@vger.kernel.org, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] userfaultfd: selftest: recycle lock threads first
References: <20180929084311.15600-1-peterx@redhat.com>
 <20180929084311.15600-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929084311.15600-4-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18092910-0012-0000-0000-000002B0265D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092910-0013-0000-0000-000020E44CF8
Message-Id: <20180929103252.GC6429@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809290111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 04:43:11PM +0800, Peter Xu wrote:
> Now we recycle the uffd servicing threads earlier than the lock
> threads.  It might happen that when the lock thread is still blocked at
> a pthread mutex lock while the servicing thread has already quitted for
> the cpu so the lock thread will be blocked forever and hang the test
> program.  To fix the possible race, recycle the lock threads first.
> 
> This never happens with current missing-only tests, but when I start to
> run the write-protection tests (the feature is not yet posted upstream)
> it happens every time of the run possibly because in that new test we'll
> need to service two page faults for each lock operation.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Mike Rapoport <rppt@linux.vnt.ibm.com>

> ---
>  tools/testing/selftests/vm/userfaultfd.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index f79706f13ce7..a388675b15af 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -623,6 +623,12 @@ static int stress(unsigned long *userfaults)
>  	if (uffd_test_ops->release_pages(area_src))
>  		return 1;
> 
> +
> +	finished = 1;
> +	for (cpu = 0; cpu < nr_cpus; cpu++)
> +		if (pthread_join(locking_threads[cpu], NULL))
> +			return 1;
> +
>  	for (cpu = 0; cpu < nr_cpus; cpu++) {
>  		char c;
>  		if (bounces & BOUNCE_POLL) {
> @@ -640,11 +646,6 @@ static int stress(unsigned long *userfaults)
>  		}
>  	}
> 
> -	finished = 1;
> -	for (cpu = 0; cpu < nr_cpus; cpu++)
> -		if (pthread_join(locking_threads[cpu], NULL))
> -			return 1;
> -
>  	return 0;
>  }
> 
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

