Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC06C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525052083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525052083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeJAMSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:18:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728114AbeJAMSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:18:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w915dDG9099175
        for <linux-kernel@vger.kernel.org>; Mon, 1 Oct 2018 01:42:50 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mu7a9jey1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 01:42:50 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 1 Oct 2018 06:42:48 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Oct 2018 06:42:44 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w915ggG366912342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Oct 2018 05:42:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BDC042042;
        Mon,  1 Oct 2018 08:42:24 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60E4C4203F;
        Mon,  1 Oct 2018 08:42:22 +0100 (BST)
Received: from [9.124.35.37] (unknown [9.124.35.37])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Oct 2018 08:42:22 +0100 (BST)
Subject: Re: [PATCH 4/6] perf report: Use the offset address to find inline
 frames
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180928122539.29326-1-acme@kernel.org>
 <20180928122539.29326-5-acme@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Mon, 1 Oct 2018 11:12:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928122539.29326-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100105-0020-0000-0000-000002CDA6B3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100105-0021-0000-0000-0000211BDFA5
Message-Id: <ab64d0a8-f810-2868-59ff-cb2e28811e1d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milian, 

Seems this has a regression:

With acme/perf/urgent:

  $ ./perf record -e cycles:u --call-graph=dwarf ls
  $ ./perf script
  ls 13585 602082.534478:      28032 cycles:u: 
                   1f1f4 __GI___tunables_init+0xffff0000d3dc00a4 (/usr/lib64/ld-2.26.so)
                   20e2b _dl_sysdep_start+0xffff0000d3dc04ab (/usr/lib64/ld-2.26.so)
                    1ca7 _dl_start_final+0xffff0000d3dc00f7 (/usr/lib64/ld-2.26.so)
                    29b3 _dl_start+0xffff0000d3dc0553 (/usr/lib64/ld-2.26.so)
                    1437 _start+0xffff0000d3dc0017 (/usr/lib64/ld-2.26.so)

After reverting this patch:

  $ git revert d9c910d5f8c3a1858f115dc9d3b157df32da70a3
  [a/perf/urgent 72cada4e6b30] Revert "perf report: Use the offset address to find inline frames"

  $ ./perf script
  ls 13585 602082.534478:      28032 cycles:u: 
            7fff9613f1f4 __GI___tunables_init+0xa4 (/usr/lib64/ld-2.26.so)
            7fff96140e2b _dl_sysdep_start+0x4ab (/usr/lib64/ld-2.26.so)
            7fff96121ca7 _dl_start_final+0xf7 (/usr/lib64/ld-2.26.so)
            7fff961229b3 _dl_start+0x553 (/usr/lib64/ld-2.26.so)
            7fff96121437 _start+0x17 (/usr/lib64/ld-2.26.so)

Thanks,
Ravi


On 09/28/2018 05:55 PM, Arnaldo Carvalho de Melo wrote:
> From: Milian Wolff <milian.wolff@kdab.com>
> 
> To correctly find inlined frames, we have to use the file offset instead
> of the virtual memory address. This was already fixed for displaying
> srcline information while displaying in commit 2a9d5050dc84fa20 ("perf
> script: Show correct offsets for DWARF-based unwinding"). We just need
> to use the same corrected address also when trying to find inline
> frames.
> 
> This is another follow-up to commit 19610184693c ("perf script: Show
> virtual addresses instead of offsets").
> 
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Sandipan Das <sandipan@linux.ibm.com>
> Fixes: 19610184693c ("perf script: Show virtual addresses instead of offsets")
> Link: http://lkml.kernel.org/r/20180926135207.30263-2-milian.wolff@kdab.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/machine.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 0cb4f8bf3ca7..73a651f10a0f 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2317,9 +2317,6 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	if (symbol_conf.hide_unresolved && entry->sym == NULL)
>  		return 0;
>  
> -	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
> -		return 0;
> -
>  	/*
>  	 * Convert entry->ip from a virtual address to an offset in
>  	 * its corresponding binary.
> @@ -2327,6 +2324,9 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	if (entry->map)
>  		addr = map__map_ip(entry->map, entry->ip);
>  
> +	if (append_inlines(cursor, entry->map, entry->sym, addr) == 0)
> +		return 0;
> +
>  	srcline = callchain_srcline(entry->map, entry->sym, addr);
>  	return callchain_cursor_append(cursor, entry->ip,
>  				       entry->map, entry->sym,
> 

