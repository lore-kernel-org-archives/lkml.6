Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F6CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703B72084D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703B72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeLJEDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:03:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbeLJEDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:03:01 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBA3rRqK074155
        for <linux-kernel@vger.kernel.org>; Sun, 9 Dec 2018 23:03:00 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p98m3xmba-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 23:02:59 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <maddy@linux.vnet.ibm.com>;
        Mon, 10 Dec 2018 04:02:58 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Dec 2018 04:02:51 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBA42oji65536252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 04:02:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 503775204E;
        Mon, 10 Dec 2018 04:02:50 +0000 (GMT)
Received: from [9.79.201.44] (unknown [9.79.201.44])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 27A375205A;
        Mon, 10 Dec 2018 04:02:44 +0000 (GMT)
Subject: Re: [PATCH v3 09/12] powerpc: perf/core: use PERF_PMU_CAP_NO_EXCLUDE
 for exclude incapable PMUs
To:     Andrew Murray <andrew.murray@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Russell King <linux@armlinux.org.uk>, suzuki.poulose@arm.com,
        robin.murphy@arm.com, Michael Ellerman <mpe@ellerman.id.au>
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-alpha@vger.kernel.org
References: <1544114849-47266-1-git-send-email-andrew.murray@arm.com>
 <1544114849-47266-10-git-send-email-andrew.murray@arm.com>
From:   Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date:   Mon, 10 Dec 2018 09:32:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544114849-47266-10-git-send-email-andrew.murray@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18121004-0020-0000-0000-000002F4C615
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121004-0021-0000-0000-00002144E4C0
Message-Id: <f82ff395-1de9-18e9-a00a-b4a186f71c2f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/12/18 10:17 PM, Andrew Murray wrote:
> For PowerPC PMUs that do not support context exclusion let's
> advertise the PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that
> perf will prevent us from handling events where any exclusion flags
> are set. Let's also remove the now unnecessary check for exclusion
> flags.

Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

>
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>   arch/powerpc/perf/hv-24x7.c | 10 +---------
>   arch/powerpc/perf/hv-gpci.c | 10 +---------
>   arch/powerpc/perf/imc-pmu.c | 19 +------------------
>   3 files changed, 3 insertions(+), 36 deletions(-)
>
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 72238ee..d2b8e60 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -1306,15 +1306,6 @@ static int h_24x7_event_init(struct perf_event *event)
>   		return -EINVAL;
>   	}
>
> -	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> -		return -EINVAL;
> -
>   	/* no branch sampling */
>   	if (has_branch_stack(event))
>   		return -EOPNOTSUPP;
> @@ -1577,6 +1568,7 @@ static struct pmu h_24x7_pmu = {
>   	.start_txn   = h_24x7_event_start_txn,
>   	.commit_txn  = h_24x7_event_commit_txn,
>   	.cancel_txn  = h_24x7_event_cancel_txn,
> +	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>   };
>
>   static int hv_24x7_init(void)
> diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
> index 43fabb3..735e77b 100644
> --- a/arch/powerpc/perf/hv-gpci.c
> +++ b/arch/powerpc/perf/hv-gpci.c
> @@ -232,15 +232,6 @@ static int h_gpci_event_init(struct perf_event *event)
>   		return -EINVAL;
>   	}
>
> -	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> -		return -EINVAL;
> -
>   	/* no branch sampling */
>   	if (has_branch_stack(event))
>   		return -EOPNOTSUPP;
> @@ -285,6 +276,7 @@ static struct pmu h_gpci_pmu = {
>   	.start       = h_gpci_event_start,
>   	.stop        = h_gpci_event_stop,
>   	.read        = h_gpci_event_update,
> +	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>   };
>
>   static int hv_gpci_init(void)
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 1fafc32b..1dbb0ee 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -473,15 +473,6 @@ static int nest_imc_event_init(struct perf_event *event)
>   	if (event->hw.sample_period)
>   		return -EINVAL;
>
> -	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> -		return -EINVAL;
> -
>   	if (event->cpu < 0)
>   		return -EINVAL;
>
> @@ -748,15 +739,6 @@ static int core_imc_event_init(struct perf_event *event)
>   	if (event->hw.sample_period)
>   		return -EINVAL;
>
> -	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> -		return -EINVAL;
> -
>   	if (event->cpu < 0)
>   		return -EINVAL;
>
> @@ -1069,6 +1051,7 @@ static int update_pmu_ops(struct imc_pmu *pmu)
>   	pmu->pmu.stop = imc_event_stop;
>   	pmu->pmu.read = imc_event_update;
>   	pmu->pmu.attr_groups = pmu->attr_groups;
> +	pmu->pmu.capabilities = PERF_PMU_CAP_NO_EXCLUDE;
>   	pmu->attr_groups[IMC_FORMAT_ATTR] = &imc_format_group;
>
>   	switch (pmu->domain) {

