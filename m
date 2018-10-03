Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27B2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C666208AE
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C666208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeJCKWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 06:22:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbeJCKWR (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 06:22:17 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w933YKX6006109
        for <Linux-kernel@vger.kernel.org>; Tue, 2 Oct 2018 23:35:45 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mvjdx6dnr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <Linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 23:35:45 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <Linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 3 Oct 2018 04:35:44 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Oct 2018 04:35:40 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w933Zd4b655640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Oct 2018 03:35:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 845A111C04C;
        Wed,  3 Oct 2018 06:35:16 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5179E11C05B;
        Wed,  3 Oct 2018 06:35:15 +0100 (BST)
Received: from [9.124.35.153] (unknown [9.124.35.153])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Oct 2018 06:35:15 +0100 (BST)
Subject: Re: [PATCH] perf record: use unmapped IP for inline callchain cursors
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20181002073949.3297-1-milian.wolff@kdab.com>
 <20181002153236.GD3541@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 3 Oct 2018 09:05:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002153236.GD3541@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100303-4275-0000-0000-000002C42B85
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100303-4276-0000-0000-000037CF3CD0
Message-Id: <f71ed02b-1234-db9c-6a48-1a399359b5e8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-03_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810030036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2018 09:02 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 02, 2018 at 09:39:49AM +0200, Milian Wolff escreveu:
>> Only use the mapped IP to find inline frames, but keep
>> using the unmapped IP for the callchain cursor. This
>> ensures we properly show the unmapped IP when displaying
>> a frame we received via the dso__parse_addr_inlines API
>> for a module which does not contain sufficient debug symbols
>> to show the srcline.
> 
> So, the patch came mangled, I fixed it up, please check, I'm adding Ravi
> to the CC list, so that he can check as well and retest, right Ravi?
> 
> - Arnaldo
> 
> From d9ddee9653d5676130471de9bc688fc7ec7b4fc4 Mon Sep 17 00:00:00 2001
> From: Milian Wolff <milian.wolff@kdab.com>
> Date: Tue, 2 Oct 2018 09:39:49 +0200
> Subject: [PATCH 1/1] perf record: use unmapped IP for inline callchain cursors
> 
> Only use the mapped IP to find inline frames, but keep using the unmapped IP
> for the callchain cursor. This ensures we properly show the unmapped IP when
> displaying a frame we received via the dso__parse_addr_inlines API for a module
> which does not contain sufficient debug symbols to show the srcline.
> 
> Before:
> 
>   $ perf record -e cycles:u --call-graph ls
>   $ perf script
>   ...
>   ls 12853  2735.563911:      43354 cycles:u:
>                      17878 __GI___tunables_init+0xffff01d1d63a0118 (/usr/lib/ld-2.28.so)
>                      19ee9 _dl_sysdep_start+0xffff01d1d63a02e9 (/usr/lib/ld-2.28.so)
>                       3087 _dl_start+0xffff01d1d63a0287 (/usr/lib/ld-2.28.so)
>                       2007 _start+0xffff01d1d63a0007 (/usr/lib/ld-2.28.so)
> 
> After:
> 
>   $ perf script
>   ...
>   ls 12853  2735.563911:      43354 cycles:u:
>               7f1714e46878 __GI___tunables_init+0x118 (/usr/lib/ld-2.28.so)
>               7f1714e48ee9 _dl_sysdep_start+0x2e9 (/usr/lib/ld-2.28.so)
>               7f1714e32087 _dl_start+0x287 (/usr/lib/ld-2.28.so)
>               7f1714e31007 _start+0x7 (/usr/lib/ld-2.28.so)

With current perf/urgent:

  $ sudo ./perf record --call-graph=dwarf -e probe_libc:inet_pton -- ping -6 -c 1 ::1
  $ sudo ./perf script
  ping  4109 [011] 767269.031273: probe_libc:inet_pton: (7fff944cb458)
                  15b458 __inet_pton+0xffff0000d7920008 (inlined)
                  10feb3 gaih_inet.constprop.7+0xffff0000d7920f43 (/usr/lib64/libc-2.26.
                  110a13 __GI_getaddrinfo+0xffff0000d7920163 (inlined)
               13c752d6f _init+0xbfb (/usr/bin/ping)
                   2371f generic_start_main.isra.0+0xffff0000d792013f (/usr/lib64/libc-2
                   2391b __libc_start_main+0xffff0000d79200bb (/usr/lib64/libc-2.26.so)

With this patch:

  $ sudo ./perf script
  ping  4109 [011] 767269.031273: probe_libc:inet_pton: (7fff944cb458)
            7fff944cb458 __inet_pton+0x8 (inlined)
            7fff9447feb3 gaih_inet.constprop.7+0xf43 (/usr/lib64/libc-2.26.so)
            7fff94480a13 __GI_getaddrinfo+0x163 (inlined)
               13c752d6f _init+0xbfb (/usr/bin/ping)
            7fff9439371f generic_start_main.isra.0+0x13f (/usr/lib64/libc-2.26.so)
            7fff9439391b __libc_start_main+0xbb (/usr/lib64/libc-2.26.so)

LGTM.

Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

