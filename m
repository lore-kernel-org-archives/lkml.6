Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB05C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D97E2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D97E2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754745AbeGJB15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:27:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754625AbeGJB12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:27:28 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BE55A9E70A879;
        Tue, 10 Jul 2018 09:27:14 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.382.0; Tue, 10 Jul 2018
 09:27:14 +0800
Subject: Re: [V9fs-developer] [PATCH] Integer underflow in pdu_read()
To:     Tomas Bortoli <tomasbortoli@gmail.com>, <ericvh@gmail.com>,
        <rminnich@sandia.gov>, <lucho@ionkov.net>
References: <20180709192651.28095-1-tomasbortoli@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller@googlegroups.com>,
        <v9fs-developer@lists.sourceforge.net>, <davem@davemloft.net>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B440B6A.9090000@huawei.com>
Date:   Tue, 10 Jul 2018 09:27:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180709192651.28095-1-tomasbortoli@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

It looks like pdu->size should always be greater than pdu->offset, right?
My question may be very easy for you, please help explaining.

Thanks,
Jun

On 2018/7/10 3:26, Tomas Bortoli wrote:
> The pdu_read() function suffers from an integer underflow.
> When pdu->offset is greater than pdu->size, the length calculation will have
> a wrong result, resulting in an out-of-bound read.
> This patch modifies also pdu_write() in the same way to prevent the same
> issue from happening there and for consistency.
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
> +	if (len != 0)
> +		memcpy(&pdu->sdata[pdu->size], data, len);
>  	pdu->size += len;
>  	return size - len;
>  }
> 
