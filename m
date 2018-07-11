Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F3FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E699208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E699208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbeGKCGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:06:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43916 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732348AbeGKCGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:06:23 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B3C1D30C010EA;
        Wed, 11 Jul 2018 10:04:27 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Wed, 11 Jul 2018
 10:04:28 +0800
Subject: Re: [V9fs-developer] [PATCH] Integer underflow in pdu_read()
To:     Tomas Bortoli <tomasbortoli@gmail.com>, <ericvh@gmail.com>,
        <rminnich@sandia.gov>, <lucho@ionkov.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180709192651.28095-1-tomasbortoli@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <syzkaller@googlegroups.com>,
        <v9fs-developer@lists.sourceforge.net>, <davem@davemloft.net>
From:   jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5B4565AA.6050309@huawei.com>
Date:   Wed, 11 Jul 2018 10:04:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180709192651.28095-1-tomasbortoli@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/10 3:26, Tomas Bortoli wrote:
> The pdu_read() function suffers from an integer underflow.
> When pdu->offset is greater than pdu->size, the length calculation will have
> a wrong result, resulting in an out-of-bound read.
> This patch modifies also pdu_write() in the same way to prevent the same
> issue from happening there and for consistency.

I guess this case may happened only when server send wrong size to
the client and then cause size < offset, or else I think this case
will not happen. Is it right? Or other cases?

In addition, the email should also send to andrew morton, because
9p maintainer already don't maintain the project, andrew can help
merge the patch.

> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com
> ---
>  net/9p/protocol.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/9p/protocol.c b/net/9p/protocol.c
> index 931ea00c4fed..f1e2425f920b 100644
> --- a/net/9p/protocol.c
> +++ b/net/9p/protocol.c
> @@ -55,16 +55,20 @@ EXPORT_SYMBOL(p9stat_free);
>  
>  size_t pdu_read(struct p9_fcall *pdu, void *data, size_t size)
>  {
> -	size_t len = min(pdu->size - pdu->offset, size);
> -	memcpy(data, &pdu->sdata[pdu->offset], len);
> +	size_t len = pdu->offset > pdu->size ? 0 :
> +	 min(pdu->size - pdu->offset, size);

I suggest this add two *Tab* lens.

> +	if (len != 0)
> +		memcpy(data, &pdu->sdata[pdu->offset], len);
>  	pdu->offset += len;
>  	return size - len;
>  }
>  
>  static size_t pdu_write(struct p9_fcall *pdu, const void *data, size_t size)
>  {
> -	size_t len = min(pdu->capacity - pdu->size, size);
> -	memcpy(&pdu->sdata[pdu->size], data, len);
> +	size_t len = pdu->size > pdu->capacity ? 0 :
> +	 min(pdu->capacity - pdu->size, size);

The same as above.

> +	if (len != 0)
> +		memcpy(&pdu->sdata[pdu->size], data, len);
>  	pdu->size += len;
>  	return size - len;
>  }
> 


