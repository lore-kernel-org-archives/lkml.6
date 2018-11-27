Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABECC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B712208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GBQyvVNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B712208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeK1CPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:15:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59800 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeK1CPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:15:53 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wARFEBgG189958;
        Tue, 27 Nov 2018 15:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=3b1oDx5aCOjpv4StgKk3zBzo4m1h6cARzJ03WN+QJiY=;
 b=GBQyvVNUJsruizE5kvJN13AtD2wKdBTUMbRHyhdt1VbZYaTmjxjtylBDlNo12vB060uJ
 9YDZutqAfFOIWU0qv7/Ie04CCLTtKCv6SgE3yG09HFIvftRAI/wfA0qn5VLrS3nqbUyU
 s0uy+fD2JlTfD9O7odTiUIwX6BgRQZBTZAhGiFPxtxfCyGOw1TDdChaxqhuI046pCi/h
 xFl4gsPb+4SGoIjswMWx/Dp1Rt2Yh0xwSJ4arShcCqLYxIgSp4iLyaRcYvmxFxa+xB24
 0n8B0LmCwHlOboiG23YqGFejsQj9CaCuZuIv6dr/uI5na2dtezoY3HpRdC9E7dr3Vuli HA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nxy9r4hyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 15:17:04 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wARFH38J001409
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 15:17:03 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wARFH2Zc019924;
        Tue, 27 Nov 2018 15:17:02 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 07:17:02 -0800
Subject: Re: [PATCH v3 01/10] sched: Provide sparsemask, a reduced contention
 bitmap
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com, linux-kernel@vger.kernel.org
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
 <1541767840-93588-2-git-send-email-steven.sistare@oracle.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <7a3e87ac-db63-27c5-8490-2330637e59b1@oracle.com>
Date:   Tue, 27 Nov 2018 10:16:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1541767840-93588-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/2018 7:50 AM, Steve Sistare wrote:
> From: Steve Sistare <steve.sistare@oracle.com>
> 
> Provide struct sparsemask and functions to manipulate it.  A sparsemask is
> a sparse bitmap.  It reduces cache contention vs the usual bitmap when many
> threads concurrently set, clear, and visit elements, by reducing the number
> of significant bits per cacheline.  For each 64 byte chunk of the mask,
> only the first K bits of the first word are used, and the remaining bits
> are ignored, where K is a creation time parameter.  Thus a sparsemask that
> can represent a set of N elements is approximately (N/K * 64) bytes in
> size.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/linux/sparsemask.h | 260 +++++++++++++++++++++++++++++++++++++++++++++
>  lib/Makefile               |   2 +-
>  lib/sparsemask.c           | 142 +++++++++++++++++++++++++
>  3 files changed, 403 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/sparsemask.h
>  create mode 100644 lib/sparsemask.c

Hi Peter and Ingo,
  I need your opinion: would you prefer that I keep the new sparsemask type, 
or fold it into the existing sbitmap type?  There is some overlap between the 
two, but mostly in trivial one line functions. The main differences are:

  * sparsemask defines iterators that allow an inline loop body, like cpumask,
  whereas the sbitmap iterator forces us to define a callback function for
  the body, which is awkward.

  * sparsemask is slightly more efficient.  The struct and variable length
  bitmap are allocated contiguously, and sbitmap uses an extra field "depth"
  per bitmap cacheline.

  * The order of arguments is different for the sparsemask accessors and
  sbitmap accessors.  sparsemask mimics cpumask which is used extensively
  in the sched code.

  * Much of the sbitmap code supports queueing, sleeping, and waking on bit
  allocation, which is N/A for scheduler load load balancing.  However, we
  can call the basic functions which do not use queueing.

I could add the sparsemask iterators to sbitmap (90 lines), and define
a thin layer to change the argument order to mimic cpumask, but that
essentially recreates sparsemask.

Also, pushing sparsemask into sbitmap would limit our freedom to evolve the
type to meet the future needs of sched, as sbitmap has its own maintainer,
and is used by drivers, so changes to its API and ABI will be frowned upon.

FWIW, here is the amount of code involved:

include/linux/sbitmap.h
  250 lines basic operations
  284 lines for queueing
  ---
  534 lines total

lib/sbitmap.c
  201 lines basic operations
  380 lines for queueing
  ---
  581 lines total

include/linux/sparsemask.h
  260 lines total
  https://lkml.org/lkml/2018/11/9/1176

lib/sparsemask.c
  142 lines total
  https://lkml.org/lkml/2018/11/9/1176

- Steve
