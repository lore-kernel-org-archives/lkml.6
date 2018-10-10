Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CAFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517D9214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517D9214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJJNE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:04:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbeJJNE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:04:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9A5dKwQ003070
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:43:56 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n18f3x3n6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:43:56 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Wed, 10 Oct 2018 06:43:54 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Oct 2018 06:43:51 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9A5ho0164684118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Oct 2018 05:43:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 795B6A4057;
        Wed, 10 Oct 2018 08:43:23 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B58F4A4055;
        Wed, 10 Oct 2018 08:43:21 +0100 (BST)
Received: from [9.124.31.81] (unknown [9.124.31.81])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Oct 2018 08:43:21 +0100 (BST)
Subject: Re: perf report segfault
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Anthony LaTorre <tlatorre9@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, jolsa@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Milian Wolff <milian.wolff@kdab.com>
References: <CAO49afLqUGuBi_R7BKyojqnkHrMGqXquy-FdVFscOu6Ez0cVFw@mail.gmail.com>
 <20181009164743.GA22886@krava>
 <CAO49af+zxxVh9HGfjKxS=vQcD5po7-oLU87Zp0F21M-C64nWUA@mail.gmail.com>
 <CAO49afJVHsywYdosSqceQiMzFdaYivm4kiNnC_+WKq15jsA7Dg@mail.gmail.com>
 <20181009214158.GB31206@krava>
 <CAO49af+5TaWrdYeM3XyHoti0obH--0txq9_a6_9ZPMuB-J=hjg@mail.gmail.com>
 <20181009222004.GA19295@krava>
From:   Sandipan Das <sandipan@linux.ibm.com>
Date:   Wed, 10 Oct 2018 11:13:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009222004.GA19295@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101005-0016-0000-0000-00000210EE28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101005-0017-0000-0000-000032685998
Message-Id: <f5ce21f8-6c80-b6a0-8b8a-e7a90c23a98c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-10_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Yes, this happens when entry->map is NULL. While your fix seems correct, the
following commit from Milian Wolff had already addressed this. I think this
was pulled in with one of Arnaldo's recent perf/urgent updates.

ff4ce2885af8 ("perf report: Don't try to map ip to invalid map")

Adding Milian to the loop as well.

With Regards,
Sandipan

On 10/10/18 3:50 AM, Jiri Olsa wrote:
> On Tue, Oct 09, 2018 at 04:47:31PM -0500, Anthony LaTorre wrote:
>> I can try building perf from the latest sources. I've attached the
>> perf.data and perf.data.tar.bz2 from the test program I sent earlier.
> 
> cool, reproduced.. it seems to get introduced by:
>   2a9d5050dc84 perf script: Show correct offsets for DWARF-based unwinding
> 
> reverting that patch fixes the issue for me, but looks like
> we could just make th attached check and prevent the crash
> 
> adding Sandipan Das to the loop, the author of that commit, any idea?
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index c4acd2001db0..ea68c805c7ac 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2312,7 +2312,6 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  {
>  	struct callchain_cursor *cursor = arg;
>  	const char *srcline = NULL;
> -	u64 addr;
>  
>  	if (symbol_conf.hide_unresolved && entry->sym == NULL)
>  		return 0;
> @@ -2320,13 +2319,15 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
>  		return 0;
>  
> -	/*
> -	 * Convert entry->ip from a virtual address to an offset in
> -	 * its corresponding binary.
> -	 */
> -	addr = map__map_ip(entry->map, entry->ip);
> +	if (entry->map) {
> +		/*
> +		 * Convert entry->ip from a virtual address to an offset in
> +		 * its corresponding binary.
> +		 */
> +		u64 addr = map__map_ip(entry->map, entry->ip);
> +		srcline = callchain_srcline(entry->map, entry->sym, addr);
> +	}
>  
> -	srcline = callchain_srcline(entry->map, entry->sym, addr);
>  	return callchain_cursor_append(cursor, entry->ip,
>  				       entry->map, entry->sym,
>  				       false, NULL, 0, 0, 0, srcline);
> 

