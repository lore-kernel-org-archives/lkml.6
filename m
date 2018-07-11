Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A91C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029A9208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029A9208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbeGKC3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:29:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732524AbeGKC3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:29:36 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3C3F5D0F8AA70;
        Wed, 11 Jul 2018 10:27:25 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.382.0; Wed, 11 Jul 2018
 10:27:25 +0800
Subject: Re: [V9fs-developer] [PATCH] p9_check_errors() validate PDU length
To:     Tomas Bortoli <tomasbortoli@gmail.com>, <ericvh@gmail.com>,
        <rminnich@sandia.gov>, <lucho@ionkov.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180709224323.20597-1-tomasbortoli@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller@googlegroups.com>,
        <v9fs-developer@lists.sourceforge.net>, <davem@davemloft.net>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B456B0B.6020301@huawei.com>
Date:   Wed, 11 Jul 2018 10:27:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180709224323.20597-1-tomasbortoli@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/10 6:43, Tomas Bortoli wrote:
> p9_check_errors() does not validate the size of the PDU read
> in p9_parse_header(). Any size can be passed, provoking out-of-bound reads.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com
> ---
> As suggested by Dominique:
> https://lkml.org/lkml/2018/7/9/688
> Such check is not enough as it will prevent to read more than how it has
> been allocated but it won't prevent to read more than how it has been read
> So this patch will require some more changes to prevent bad sizes.
> 
>  net/9p/client.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 40f7c47f2f74..5b161b576b8a 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -520,10 +520,13 @@ EXPORT_SYMBOL(p9_parse_header);
>  static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
>  {
>  	int8_t type;
> +	int32_t size;
>  	int err;
>  	int ecode;
>  
> -	err = p9_parse_header(req->rc, NULL, &type, NULL, 0);
> +	err = p9_parse_header(req->rc, &size, &type, NULL, 0);
> +	if (size > req->rc->capacity)
> +		return -EINVAL;

Yes, currently 9p client is lacking of properly check for data from server.
Maybe we should have a bigger patch to solve this problem.

>  	/*
>  	 * dump the response from server
>  	 * This should be after check errors which poplulate pdu_fcall.
> 


