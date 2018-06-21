Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571C7C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0745E20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0745E20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lab.ntt.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754539AbeFUCmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:42:15 -0400
Received: from tama500.ecl.ntt.co.jp ([129.60.39.148]:57255 "EHLO
        tama500.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754172AbeFUCmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:42:13 -0400
Received: from vc2.ecl.ntt.co.jp (vc2.ecl.ntt.co.jp [129.60.86.154])
        by tama500.ecl.ntt.co.jp (8.13.8/8.13.8) with ESMTP id w5L2fwHZ013547;
        Thu, 21 Jun 2018 11:41:58 +0900
Received: from vc2.ecl.ntt.co.jp (localhost [127.0.0.1])
        by vc2.ecl.ntt.co.jp (Postfix) with ESMTP id 9CA9B638435;
        Thu, 21 Jun 2018 11:41:58 +0900 (JST)
Received: from jcms-pop21.ecl.ntt.co.jp (jcms-pop21.ecl.ntt.co.jp [129.60.87.134])
        by vc2.ecl.ntt.co.jp (Postfix) with ESMTP id 912406383E4;
        Thu, 21 Jun 2018 11:41:58 +0900 (JST)
Received: from [127.0.0.1] (redpepper.sic.ecl.ntt.co.jp [129.60.241.98])
        by jcms-pop21.ecl.ntt.co.jp (Postfix) with ESMTPSA id 88204400A77;
        Thu, 21 Jun 2018 11:41:58 +0900 (JST)
Subject: Re: [PATCH] nilfs2: use 64-bit superblock timstamps
References: <20180620075041.4154396-1-arnd@arndb.de>
From:   Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
Organization: NTT OSS Center
Message-ID: <57ac1977-b060-77b1-61a5-8e7b690e162d@lab.ntt.co.jp>
Date:   Thu, 21 Jun 2018 11:41:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620075041.4154396-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CC-Mail-RelayStamp: 1
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, linux-nilfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/20 16:50, Arnd Bergmann wrote:
> The mount time field in the superblock uses a 64-bit timestamp, but
> calling get_seconds() may truncate the current time to 32 bits.
> 
> This changes it to ktime_get_real_seconds() to avoid the potential
> overflow.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me.

Thanks, all.

Acked-by: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>


> ---
>   fs/nilfs2/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
> index 6ffeca84d7c3..1b9067cf4511 100644
> --- a/fs/nilfs2/super.c
> +++ b/fs/nilfs2/super.c
> @@ -834,7 +834,7 @@ static int nilfs_setup_super(struct super_block *sb, int is_mount)
>   		sbp[0]->s_max_mnt_count = cpu_to_le16(NILFS_DFL_MAX_MNT_COUNT);
>   
>   	sbp[0]->s_mnt_count = cpu_to_le16(mnt_count + 1);
> -	sbp[0]->s_mtime = cpu_to_le64(get_seconds());
> +	sbp[0]->s_mtime = cpu_to_le64(ktime_get_real_seconds());
>   
>   skip_mount_setup:
>   	sbp[0]->s_state =
> 


