Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B84C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167A320844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3MEt1giz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfAVPp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:45:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50978 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfAVPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:45:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0MFggsY035913;
        Tue, 22 Jan 2019 15:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=8pphHybakAGfGn0y1mxEkDw9wlDRCSag7SnqO7dvbgU=;
 b=3MEt1gizM/zQntURI3E+N6/aEK1i1Hb30Uft+40ZUCS6CcWvQZyp6gRUD3A9kNA6QyjE
 9VzGPreQCGVuM/+Vm+ELPV6uo63wMyTDK/uinAlNoDqjogddWh5ti2yoi8o10xBJFWna
 p1IvJj3g2R4u6HuZPnk1h3+MDr0rS9BlR9Qj2fizQaVECzC15XNy9zuOqS+H6moYa7AP
 BRdVjOsCZwjVU2id8XV9szG6CcB5LZsXToyTVcmkr3uKOjUJVsgKhyzvjdDuMPgUbBLO
 DAsSc1fKfaS6tu2zn99th7WBwKq12YUZUicSQL6qWBxkW0NcYMdTu3OAtLOJ5L2UBfVU ww== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2q3uaume0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jan 2019 15:45:16 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0MFjGEh032008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jan 2019 15:45:16 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0MFjFpU006547;
        Tue, 22 Jan 2019 15:45:15 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jan 2019 07:45:15 -0800
Date:   Tue, 22 Jan 2019 10:45:33 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, dledford@redhat.com, jgg@mellanox.com,
        jack@suse.de, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/6] mm: make mm->pinned_vm an atomic64 counter
Message-ID: <20190122154533.qivmjnburamqi4ut@ca-dmjordan1.us.oracle.com>
References: <20190121174220.10583-1-dave@stgolabs.net>
 <20190121174220.10583-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121174220.10583-2-dave@stgolabs.net>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=957
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901220122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 09:42:15AM -0800, Davidlohr Bueso wrote:
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 6976e17dba68..640ae8a47c73 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -59,7 +59,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>  	SEQ_PUT_DEC("VmPeak:\t", hiwater_vm);
>  	SEQ_PUT_DEC(" kB\nVmSize:\t", total_vm);
>  	SEQ_PUT_DEC(" kB\nVmLck:\t", mm->locked_vm);
> -	SEQ_PUT_DEC(" kB\nVmPin:\t", mm->pinned_vm);
> +	SEQ_PUT_DEC(" kB\nVmPin:\t", atomic64_read(&mm->pinned_vm));
>  	SEQ_PUT_DEC(" kB\nVmHWM:\t", hiwater_rss);
>  	SEQ_PUT_DEC(" kB\nVmRSS:\t", total_rss);
>  	SEQ_PUT_DEC(" kB\nRssAnon:\t", anon);

This is signed on 64b but printed as unsigned, so if some bug made pinned_vm go
negative, it would appear as an obviously wrong, gigantic number.  Seems ok.

For this patch, you can add

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
