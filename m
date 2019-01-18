Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4105BC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1142F2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IVd/VRzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfARTss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:48:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58710 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbfARTsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:48:47 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0IJi1JN104691;
        Fri, 18 Jan 2019 19:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dUpyIyqvVNa/xZR/KMTTiG6nH4zSpELQFKQs3EkKJv4=;
 b=IVd/VRzsAxM0WyjHj6RUjlpHs74zGjPzvxliQI2rbEFL57wAZ5Fu9iRbGvYaN0TcScsv
 r9UG1KO20Mhn5l9pLPFlJyu+XXBaUVfv2nb6ritvgMYpvkHaXPwy0H+F4muOmTxbweyG
 at5jb9UFCO0XzQPFekjLP2J486inO+VoepnIpE3BAjd4MZwfGUFG93k3g9ODk3ZKRIdE
 qWElCFFPAPfOv0PMp0GujEhFiMHfYzaCxP4MDURFtQGjTpsLIZnugRUVco4QwEaGJ4CE
 LrpRf3mTGyeG/P8jH0bymKOfRJ/NuXoDk7WaXs0A0hbPV7Su1XBRLf9X+ZVYYDKkUmrH lA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2pybjp7buw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jan 2019 19:48:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0IJmdB0013377
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jan 2019 19:48:40 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0IJmdau011720;
        Fri, 18 Jan 2019 19:48:39 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Jan 2019 11:48:39 -0800
Date:   Fri, 18 Jan 2019 14:48:53 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com
Subject: Re: [PATCH] workqueue: Try to catch flush_work() without INIT_WORK().
Message-ID: <20190118194853.pgdkz2ugwrob3zun@ca-dmjordan1.us.oracle.com>
References: <1547831098-7930-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547831098-7930-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9140 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=959
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901180142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 02:04:58AM +0900, Tetsuo Handa wrote:
> syzbot found a flush_work() caller who forgot to call INIT_WORK()
> because that work_struct was allocated by kzalloc(). But the message
> 
>   INFO: trying to register non-static key.
>   the code is fine but needs lockdep annotation.
>   turning off the locking correctness validator.
> 
> by lock_map_acquire() is failing to tell that INIT_WORK() is missing.
> 
> Since flush_work() without INIT_WORK() is a bug, and INIT_WORK() should
> set ->func field to non-zero, let's warn if ->func field is zero.

Agree that it's a good idea to catch this.  So the caller did flush_work
without queueing it beforehand?  Out of curiosity, what situation leads to
this?  Link to the report might be helpful.

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 392be4b..a503ad9 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2908,6 +2908,9 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
>  	if (WARN_ON(!wq_online))
>  		return false;
>  
> +	if (WARN_ON(!work->func))
> +		return false;
> +

__queue_work has a sanity check already for work, but using list_empty.  Seems
slightly better to be consistent?
