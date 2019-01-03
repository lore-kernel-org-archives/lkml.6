Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828E7C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CCE2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rnP9D241"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbfACRQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:16:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41570 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbfACRQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:16:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x03HER2q022631;
        Thu, 3 Jan 2019 17:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=E7J82m7M+NzQi1cKwxCSHrMy1+Tu6ouRR9AjcopMr4U=;
 b=rnP9D241MZtvi8Gt2p8xXEAIvyfp7uVM0A+ZYlJYDPxaHmtohttZZ3icixcouobDurIw
 1PZ6epHHVOReK4tKazCq87CoTrdwUT8Hh4mTXww3A2TQtJKDmXTPqK2UEJc1gkoQyPoo
 s44ZE3/AqQZje8IzCiaPp7TQRpr63Kcw1oUSKBQOJKwhb4v9GeXsGjd/0uS5fThHaBXu
 1rqo/ErPVzn4icpIa0/GutKMKWmmirr6xRZo6mPYsbYJIwpMK2i40VlACdz17CsjSrYQ
 mUfDOwDVX5UCpM77zsdKwmFjgawHfDJoxRzTUkSI/nNcy1Q1yr9/gWuAcx+TNG61n2T9 HQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2pp0bu0ara-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jan 2019 17:15:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x03HFl9J009926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Jan 2019 17:15:47 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x03HFlPW016081;
        Thu, 3 Jan 2019 17:15:47 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 09:15:47 -0800
Date:   Thu, 3 Jan 2019 09:16:02 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, ying.huang@intel.com,
        tim.c.chen@intel.com, minchan@kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 1/2] mm: swap: check if swap backing device is
 congested or not
Message-ID: <20190103171602.frjmcagwwqtzwqka@ca-dmjordan1.us.oracle.com>
References: <1546145375-793-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190102230054.m5ire5gdhm5fzecq@ca-dmjordan1.us.oracle.com>
 <76d8727a-77b4-d476-af89-9ae1904ec8cd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76d8727a-77b4-d476-af89-9ae1904ec8cd@linux.alibaba.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9124 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=760
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901030152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 09:10:13AM -0800, Yang Shi wrote:
> How about the below description:
> 
> The test with page_fault1 of will-it-scale (sometimes tracing may just show
> runtest.py that is the wrapper script of page_fault1), which basically
> launches NR_CPU threads to generate 128MB anonymous pages for each thread, 
> on my virtual machine with congested HDD shows long tail latency is reduced
> significantly.
> 
> Without the patch
>  page_fault1_thr-1490  [023]   129.311706: funcgraph_entry: #57377.796 us | 
> do_swap_page();
>  page_fault1_thr-1490  [023]   129.369103: funcgraph_entry: 5.642us   | 
> do_swap_page();
>  page_fault1_thr-1490  [023]   129.369119: funcgraph_entry: #1289.592 us | 
> do_swap_page();
>  page_fault1_thr-1490  [023]   129.370411: funcgraph_entry: 4.957us   | 
> do_swap_page();
>  page_fault1_thr-1490  [023]   129.370419: funcgraph_entry: 1.940us   | 
> do_swap_page();
>  page_fault1_thr-1490  [023]   129.378847: funcgraph_entry: #1411.385 us | 
> do_swap_page();
>  page_fault1_thr-1490  [023]   129.380262: funcgraph_entry: 3.916us   | 
> do_swap_page();
>  page_fault1_thr-1490  [023]   129.380275: funcgraph_entry: #4287.751 us | 
> do_swap_page();
> 
> With the patch
>       runtest.py-1417  [020]   301.925911: funcgraph_entry: #9870.146 us | 
> do_swap_page();
>       runtest.py-1417  [020]   301.935785: funcgraph_entry: 9.802us   | 
> do_swap_page();
>       runtest.py-1417  [020]   301.935799: funcgraph_entry: 3.551us   | 
> do_swap_page();
>       runtest.py-1417  [020]   301.935806: funcgraph_entry: 2.142us   | 
> do_swap_page();
>       runtest.py-1417  [020]   301.935853: funcgraph_entry: 6.938us   | 
> do_swap_page();
>       runtest.py-1417  [020]   301.935864: funcgraph_entry: 3.765us   | 
> do_swap_page();
>       runtest.py-1417  [020]   301.935871: funcgraph_entry: 3.600us   | 
> do_swap_page();
>       runtest.py-1417  [020]   301.935878: funcgraph_entry: 7.202us   | 
> do_swap_page();

That's better, thanks!
