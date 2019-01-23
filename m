Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601B8C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2746C217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cmcuWCnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfAWCF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 21:05:28 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58688 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfAWCF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 21:05:28 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0N24A6W082611;
        Wed, 23 Jan 2019 02:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=EHVilGvpk+iACGtRwhBK/zraNM4/mO2SgAAzuTQ6jp8=;
 b=cmcuWCnQmoyiywmjkKdghVdSDYrDlp02Y5k7bsyKXKs8gldAdBp7Ak2nMQnagHSza9uY
 4zJaHzFpR8QqTiaKL2xl/a7dx33lPdwOP8QhRPBlZ/9D+9xzoqS9LsbSg0F0FfyuWxIp
 OyA1TibQkiO9vMi6PMKtA4vVXs5Bsi5m48QVa5Zzvf/7aQa53JR4HGPF57jVeMs2TGLT
 xPEE/BL75Vr8nvQKgEN1XZ37LqNfGUkWjuhU/IVEhm3xjc2iILwBEA9lTlI0bgUZDrKC
 KYZPxfZtdQGO15Z1941NprEqtFaSOQ3IXviFBBrnsG9SwuW/+12DmarbEuP1JXeAQ7L2 6w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2q3sdefa44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 02:05:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0N25Kqb020985
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 02:05:21 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0N25KNQ007384;
        Wed, 23 Jan 2019 02:05:20 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jan 2019 18:05:20 -0800
Date:   Tue, 22 Jan 2019 21:05:36 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Try to catch flush_work() without INIT_WORK().
Message-ID: <20190123020536.yv2zsyaeamkhys7c@ca-dmjordan1.us.oracle.com>
References: <90c831b3-0d09-3cf7-5a2c-2fa7afaa003e@i-love.sakura.ne.jp>
 <20190122151819.qjzihyyd4h2ukou2@ca-dmjordan1.us.oracle.com>
 <201901230044.x0N0iCdk051613@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201901230044.x0N0iCdk051613@www262.sakura.ne.jp>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 09:44:12AM +0900, Tetsuo Handa wrote:
> Daniel Jordan wrote:
> > On Sat, Jan 19, 2019 at 11:41:22AM +0900, Tetsuo Handa wrote:
> > > On 2019/01/19 4:48, Daniel Jordan wrote:
> > > > On Sat, Jan 19, 2019 at 02:04:58AM +0900, Tetsuo Handa wrote:
> > > > __queue_work has a sanity check already for work, but using list_empty.  Seems
> > > > slightly better to be consistent?
> > > > 
> > > 
> > > list_empty() won't work, for "struct work_struct" is embedded into a struct
> > > which is allocated by kzalloc().
> > 
> > Please check list_empty's definition again, it compares the address of the node
> > to its next pointer, so it should work for a zeroed node.  I'll reiterate that
> > it seems slightly better to be consistent in "is work_struct initialized?"
> > checks, but it's not a big deal and I'm fine either way.
> 
> You are talking about
> 
> 	if (WARN_ON(!list_empty(&work->entry))) {
> 		spin_unlock(&pwq->pool->lock);
> 		return;
> 	}
> 
> part in __queue_work(), aren't you? But since flush_work() is used for waiting for
> a work to complete, that work can be either queued state (list_empty() == false) or
> not queued state (list_empty() == true). Thus, I don't think that flush_work() can
> use list_empty() for checking whether that work was initialized.

Oh, you're right, sorry for the noise!

> [PATCH v2] workqueue: Try to catch flush_work() without INIT_WORK().
> 
> syzbot found a flush_work() caller who forgot to call INIT_WORK()
> because that work_struct was allocated by kzalloc() [1]. But the message
> 
>   INFO: trying to register non-static key.
>   the code is fine but needs lockdep annotation.
>   turning off the locking correctness validator.
> 
> by lock_map_acquire() is failing to tell that INIT_WORK() is missing.
> 
> Since flush_work() without INIT_WORK() is a bug, and INIT_WORK() should
> set ->func field to non-zero, let's warn if ->func field is zero.
> 
> [1] https://syzkaller.appspot.com/bug?id=a5954455fcfa51c29ca2ab55b203076337e1c770
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  kernel/workqueue.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
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
>  	if (!from_cancel) {
>  		lock_map_acquire(&work->lockdep_map);
>  		lock_map_release(&work->lockdep_map);

Thanks for updating the changelog.  FWIW, you can add

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
