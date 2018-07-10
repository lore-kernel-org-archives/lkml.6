Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996DFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3206520863
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3206520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933384AbeGJBDZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:03:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9165 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933206AbeGJBDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:03:22 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5911F5162DF2C;
        Tue, 10 Jul 2018 09:03:09 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Tue, 10 Jul 2018
 09:03:05 +0800
Subject: Re: [V9fs-developer] [PATCH] version pointer uninitialized
To:     Tomas Bortoli <tomasbortoli@gmail.com>, <ericvh@gmail.com>,
        <rminnich@sandia.gov>, <lucho@ionkov.net>
References: <20180709222943.19503-1-tomasbortoli@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller@googlegroups.com>,
        <v9fs-developer@lists.sourceforge.net>, <davem@davemloft.net>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B4405C0.3060705@huawei.com>
Date:   Tue, 10 Jul 2018 09:02:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180709222943.19503-1-tomasbortoli@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM

On 2018/7/10 6:29, Tomas Bortoli wrote:
> The p9_client_version() does not initialize the version
> pointer. If the call to p9pdu_readf() returns an error and version has not
> been allocated in p9pdu_readf(), then the program will jump to the "error"
> label and will try to free the version pointer. If version is not
> initialized, free() will be called with uninitialized, garbage data and
> will provoke a crash.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com
Reviewed-by: Jun Piao <piaojun@huawei.com>
> ---
>  net/9p/client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 18c5271910dc..40f7c47f2f74 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -957,7 +957,7 @@ static int p9_client_version(struct p9_client *c)
>  {
>  	int err = 0;
>  	struct p9_req_t *req;
> -	char *version;
> +	char *version = NULL;
>  	int msize;
>  
>  	p9_debug(P9_DEBUG_9P, ">>> TVERSION msize %d protocol %d\n",
> 
