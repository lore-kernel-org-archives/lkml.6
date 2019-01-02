Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C849C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245032070D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L/hMUhEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfABXAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 18:00:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55644 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfABXAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 18:00:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x02Ms7IM002525;
        Wed, 2 Jan 2019 23:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=PJ9K7ciMWXZgk87IyP0blkqgvN+X4giuiFG4xHt9beM=;
 b=L/hMUhEzgwQtIhsG+MvALIQpkcu9GI3ZPzMBtGQM6zV0x8t1RS0yOceTc60xl7Bcxvib
 LfcGVXEaJMEXl8TGCcxruti2uYcTokRtCEHGMlg6VDqgQHeSdNg419QjZPYjwN0KpRrQ
 CDhtW6LcZ5rhViNw0KLZE3f3yduYlK5om3mer0VwgD3GEtICE6jFGzZgsmPirTtnppFo
 RZenKoJQBbHfizq/DVlx/FRpgUv3foqw/+IyTqSjNVd+4X1NTKUpYtSXfI6wHB5XQrfW
 BPM7qqHmViFzHq7IvcC9ymG7nq7Yi/Hs5+Y9rRiha3AafW1Un7E8oQUWPcx4WAKnxwSW rQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2pp0btvfra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 23:00:41 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x02N0dOa021660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 23:00:40 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x02N0djF027270;
        Wed, 2 Jan 2019 23:00:39 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jan 2019 15:00:38 -0800
Date:   Wed, 2 Jan 2019 15:00:54 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ying.huang@intel.com, tim.c.chen@intel.com, minchan@kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 1/2] mm: swap: check if swap backing device is
 congested or not
Message-ID: <20190102230054.m5ire5gdhm5fzecq@ca-dmjordan1.us.oracle.com>
References: <1546145375-793-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546145375-793-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9124 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=871
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 12:49:34PM +0800, Yang Shi wrote:
> The test on my virtual machine with congested HDD shows long tail
> latency is reduced significantly.
> 
> Without the patch
>  page_fault1_thr-1490  [023]   129.311706: funcgraph_entry:      #57377.796 us |  do_swap_page();
>  page_fault1_thr-1490  [023]   129.369103: funcgraph_entry:        5.642us   |  do_swap_page();
>  page_fault1_thr-1490  [023]   129.369119: funcgraph_entry:      #1289.592 us |  do_swap_page();
>  page_fault1_thr-1490  [023]   129.370411: funcgraph_entry:        4.957us   |  do_swap_page();
>  page_fault1_thr-1490  [023]   129.370419: funcgraph_entry:        1.940us   |  do_swap_page();
>  page_fault1_thr-1490  [023]   129.378847: funcgraph_entry:      #1411.385 us |  do_swap_page();
>  page_fault1_thr-1490  [023]   129.380262: funcgraph_entry:        3.916us   |  do_swap_page();
>  page_fault1_thr-1490  [023]   129.380275: funcgraph_entry:      #4287.751 us |  do_swap_page();
> 
> With the patch
>       runtest.py-1417  [020]   301.925911: funcgraph_entry:      #9870.146 us |  do_swap_page();
>       runtest.py-1417  [020]   301.935785: funcgraph_entry:        9.802us   |  do_swap_page();
>       runtest.py-1417  [020]   301.935799: funcgraph_entry:        3.551us   |  do_swap_page();
>       runtest.py-1417  [020]   301.935806: funcgraph_entry:        2.142us   |  do_swap_page();
>       runtest.py-1417  [020]   301.935853: funcgraph_entry:        6.938us   |  do_swap_page();
>       runtest.py-1417  [020]   301.935864: funcgraph_entry:        3.765us   |  do_swap_page();
>       runtest.py-1417  [020]   301.935871: funcgraph_entry:        3.600us   |  do_swap_page();
>       runtest.py-1417  [020]   301.935878: funcgraph_entry:        7.202us   |  do_swap_page();

Hi Yang, I guess runtest.py just calls page_fault1_thr?  Being explicit about
this may improve the changelog for those unfamiliar with will-it-scale.

May also be useful to name will-it-scale and how it was run (#thr, runtime,
system cpus/memory/swap) for more context.
