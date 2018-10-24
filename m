Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8942AC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AA020824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiPYhrH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AA020824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeJXTFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:05:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42848 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbeJXTFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:05:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id c23so4484931otl.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=czyffd/8Q7c1ySXu5+NjsYfYPQIH6Hi52cZ0vgivYgc=;
        b=PiPYhrH0iCqb37T0TtVQZpMiM76uOPydvDZwHs/lqtTgGEEayIacbWM7Q2q0dS5OCc
         XPzU4SKhribAV3upGvsoM6H2eXFIGADLMzsXomKO/H2fZd+WAk4dmfW1FoZWR/4dJHaJ
         RQiRzxjwjo8/sEyaOLpx12qsG0ReBep+2TBqYXHnzEFSQ+SfKS+v6OnQ2YXVfHxM+//f
         HWg25B34caBt9X96ugzte9hGHBKJOMRONII57Nir2ZzaIck868pu7qS7ylvvN/LHe2PX
         cmIZ5t9GIMqXEM2lcc/kVEEEdy/FJCb1DSDttZa1YJdHEi3Hku2nGgRdPrw5N44p+1MM
         Mvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=czyffd/8Q7c1ySXu5+NjsYfYPQIH6Hi52cZ0vgivYgc=;
        b=nHNv3SPp86diqRoRSNaJmCOhD63YpT+WmyfKLP5ZWQipQpiDefbnjZKvCMLpdGyMrO
         2zvzNnWQmo+B+uzSW6NeL3lS2jiIhXB1qgDW7bfJtTqy9qEle2v2QArEQdy2YZ0vli5V
         yKd04BeORsLSxEAZrXL3mk4VzOiED+cGTVBRoC5Nn9MthVNNn2G1xRiG4cXvMXbqTgdy
         P6fqGw1gc8gFbjPNBw/vu2QPQ4+xak2xRYe7hTjVU0Epq0XF9wS2y/ape6QTxxGcNsYo
         QLiH3Eaopo9i5DRyzoMv6LApebOwfRyrBqRca547485WE1pRBF05FrmlqdlkCon9bXRU
         yx3Q==
X-Gm-Message-State: AGRZ1gIGo1r9Z4SlaEX8PBtC97Nlv81qhrJmq2SgzhqiP4kjhFZx4I3U
        kRcSLIpaJVdYwimrMwATB6xYGG7F
X-Google-Smtp-Source: AJdET5fYYsdb1AfWRef8iOkmRNm6qbY294YTqnAUSZQqz33X3QCkR7DuolgCbjDAFXzVzqXWLrJJ3w==
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr1331525otf.242.1540377479330;
        Wed, 24 Oct 2018 03:37:59 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([47.89.83.32])
        by smtp.gmail.com with ESMTPSA id a5sm1522364otj.46.2018.10.24.03.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 03:37:58 -0700 (PDT)
Subject: Re: [PATCH] ocfs2: dlmfs: remove set but not used variable 'status'
To:     zhong jiang <zhongjiang@huawei.com>, akpm@linux-foundation.org,
        mark@fasheh.com, jlbec@evilplan.org
Cc:     dhowells@redhat.com, piaojun@huawei.com, viro@zeniv.linux.org.uk,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <1540300179-26697-1-git-send-email-zhongjiang@huawei.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <ffed747e-b06e-d691-0df0-e0d39ae4ac5c@gmail.com>
Date:   Wed, 24 Oct 2018 18:37:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540300179-26697-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/10/23 21:09, zhong jiang wrote:
> status is not used after setting its value. It is safe to remove
> the unused variable.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: Joseph Qi <jiangqi903@gmail.com>

> ---
>  fs/ocfs2/dlmfs/dlmfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index 642e471..b03dd46 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -179,7 +179,7 @@ static int dlmfs_file_open(struct inode *inode,
>  static int dlmfs_file_release(struct inode *inode,
>  			      struct file *file)
>  {
> -	int level, status;
> +	int level;
>  	struct dlmfs_inode_private *ip = DLMFS_I(inode);
>  	struct dlmfs_filp_private *fp = file->private_data;
>  
> @@ -188,7 +188,6 @@ static int dlmfs_file_release(struct inode *inode,
>  
>  	mlog(0, "close called on inode %lu\n", inode->i_ino);
>  
> -	status = 0;
>  	if (fp) {
>  		level = fp->fp_lock_level;
>  		if (level != DLM_LOCK_IV)
> 
