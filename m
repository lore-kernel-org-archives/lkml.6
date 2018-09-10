Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622D4C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1248D2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJAn1UQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1248D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeIJTKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbeIJTKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:10:09 -0400
Received: from [192.168.0.101] (unknown [49.77.179.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A08620870;
        Mon, 10 Sep 2018 14:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536588951;
        bh=Bv+d/J2+pucT3E1Cwx4Os+UYIgLD+VrkpZ8fn46SgfI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=fJAn1UQGm8k5fUVE668cxYdFTi4Oj7nl7L2IlHPLTHPrxJg15Sq5rsCiUu/JSJ0UN
         r3sU761qpoFXKzd9/vrvqZi77ATwPhRNSIRDPbqTmxmabaW/bQ49+pd8yRxJc7vhXC
         fXoanEoHZQqRk6GruFXYbKbSODhTz/xk9vnVxaJw=
Subject: Re: [f2fs-dev] [PATCH] f2fs: submit bio after shutdown
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180907212804.91462-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <42844d87-587c-1fd6-e2f7-ade84007882e@kernel.org>
Date:   Mon, 10 Sep 2018 22:15:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907212804.91462-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/8 5:28, Jaegeuk Kim wrote:
> Sometimes, some merged IOs could get a chance to be submitted, resulting in
> system hang in shutdown test. This issues IOs all the time after shutdown.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/data.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8c204f896c22..26f38b224bb2 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -533,6 +533,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	if (fio->in_list)
>  		goto next;
>  out:
> +	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN))
> +		__submit_merged_bio(io);
>  	up_write(&io->io_rwsem);
>  }
>  
> 
