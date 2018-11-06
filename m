Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87451C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA1E20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 02:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1ivrkcyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA1E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeKFLno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:43:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51380 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeKFLnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 06:43:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA62E6fx150543;
        Tue, 6 Nov 2018 02:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=B6XoYAY6LF16BXw+4FFWo0vr29M5z99hR+TuIk0fbNE=;
 b=1ivrkcyOLUbmy/I6wa0G39hzlISl5pAK/9eCsJA0OAmgxgQRKXLEDWjfjp0kukP0st+4
 Tq/dKRzvgVS7xODIbDXz/JX25dLK9EFoF/OlONVH+TmSGji83KpULxR18vRLzHzk3sTA
 e+Jrm/KXveoQaK949TDQOGgXfirbpsQYsSQsaToG0gRcM7d43Hw3FCS2O4iap85EjXd2
 Ye2mrbNZagikA0h+eInZIjET3rjsfy434uKvqh956bU+pXiVwEvNyOwNRkLctLDutove
 3k5O5Fh1Bk0vDYDfyoSkr6YrIYFy6f8HcH+bQM2ALvkTjkKOjxWW8hPMX/+YAYHqBXg6 fQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nh33ttkhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 02:20:20 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA62KJMQ012900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 02:20:20 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA62KIw6027956;
        Tue, 6 Nov 2018 02:20:18 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 18:20:17 -0800
Date:   Mon, 5 Nov 2018 18:20:24 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Zi Yan <zi.yan@cs.rutgers.edu>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz
Subject: Re: [RFC PATCH v4 00/13] ktask: multithread CPU-intensive kernel work
Message-ID: <20181106022024.ndn377ze6xljsxkb@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <FC2EB02D-3D05-4A13-A92E-4171B37B15BA@cs.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FC2EB02D-3D05-4A13-A92E-4171B37B15BA@cs.rutgers.edu>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=871
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zi,

On Mon, Nov 05, 2018 at 01:49:14PM -0500, Zi Yan wrote:
> On 5 Nov 2018, at 11:55, Daniel Jordan wrote:
>
> Do you think if it makes sense to use ktask for huge page migration (the data
> copy part)?

It certainly could.

> I did some experiments back in 2016[1], which showed that migrating one 2MB page
> with 8 threads could achieve 2.8x throughput of the existing single-threaded method.
> The problem with my parallel page migration patchset at that time was that it
> has no CPU-utilization awareness, which is solved by your patches now.

Did you run with fewer than 8 threads?  I'd want a bigger speedup than 2.8x for
8, and a smaller thread count might improve thread utilization.

It would be nice to multithread at a higher granularity than 2M, too: a range
of THPs might also perform better than a single page.

Thanks for your comments.

> [1]https://lkml.org/lkml/2016/11/22/457
