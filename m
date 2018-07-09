Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17FFC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1E920875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUI6QdAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1E920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933009AbeGIOd7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932633AbeGIOd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:33:58 -0400
Received: from [192.168.0.101] (unknown [49.77.238.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB3A12086A;
        Mon,  9 Jul 2018 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531146837;
        bh=9SwiTIRq9EcqfKYdiHbPGwWphbUZ/0NegJXsWuEMHVo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=tUI6QdAzLv6wsD79CAENKR7RsjrlI4QUQU00gnAkdLbvkrLAEz73Ljh36U38gRP7N
         CbeGD7XfDyStQvj6Rkxyjk/vWafxkkZ7Pag6l3B/vOnZWSZVZbGzsu39WC//aJ31uA
         9vQUSTRBObgeO5s0sposPs8CKmVDPZTrzGugJTTQ=
Subject: Re: [f2fs-dev] [PATCH 2/4] f2fs: allow wrong configure dio to
 buffered write
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-2-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <af7e2fa5-b9e9-3090-7659-bd76585fd3aa@kernel.org>
Date:   Mon, 9 Jul 2018 22:33:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180706210903.77887-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/7 5:09, Jaegeuk Kim wrote:
> This fixes to support unaligned dio as buffered writes.

Should we return -EINVAL as manual of write said:

EINVAL fd is attached to an object which is unsuitable for writing; or the file
was opened with the O_DIRECT flag,  and  either  the  address
specified in buf, the value specified in count, or the current file offset is
not suitably aligned.

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index e66379961804..6e8e78bb64a7 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2425,7 +2425,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  
>  	err = check_direct_IO(inode, iter, offset);
>  	if (err)
> -		return err;
> +		return 0;
>  
>  	if (f2fs_force_buffered_io(inode, rw))
>  		return 0;
> 
