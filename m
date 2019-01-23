Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84134C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FEE20868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548209722;
	bh=R/EP2X3Zl8NUNxmaATAW1uc2KUSeccvdq6+FWpvYBcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VmsCFwWO65izPN0ErdNjVXjcGLJJc5Zu2Ev0WbIVSllFekJWM1BX9d3Te6msoQLUA
	 uY5Ss7EbfURsemhIE3B208yNPMFajmU5EcRk9KdCU066IJibfg3dCJq2xc4in55N7/
	 g5CXhuPzMO2zs/thHUts82Ag1HG9pb2R5POtZ1bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfAWCPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 21:15:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbfAWCPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 21:15:20 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3CA720868;
        Wed, 23 Jan 2019 02:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548209719;
        bh=R/EP2X3Zl8NUNxmaATAW1uc2KUSeccvdq6+FWpvYBcM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QmE9na6grbAmKzT6VeSl6YcJ0KywqQPbAkeOW3SbFe0vgzwu7JIURp8WO2Nb19Abi
         eRuzofa4jjP7d+NxKamwB9VavyrtL0QHfQnkUv7W/wbmQ0ar4tl7AbLH5OPgnpEHii
         bbIK2UyOhIDFmWkAXAQPEEyoz8+uH4kQJLERCqZI=
Date:   Wed, 23 Jan 2019 11:15:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] kprobes: no need to check return value of
 debugfs_create functions
Message-Id: <20190123111516.d5fd81cb315810235205fbeb@kernel.org>
In-Reply-To: <20190122152151.16139-47-gregkh@linuxfoundation.org>
References: <20190122152151.16139-47-gregkh@linuxfoundation.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 16:21:46 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/kprobes.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f4ddfdd2d07e..7287e7de2350 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2566,33 +2566,20 @@ static const struct file_operations fops_kp = {
>  
>  static int __init debugfs_kprobe_init(void)
>  {
> -	struct dentry *dir, *file;
> +	struct dentry *dir;
>  	unsigned int value = 1;
>  
>  	dir = debugfs_create_dir("kprobes", NULL);
> -	if (!dir)
> -		return -ENOMEM;

Here, I think IS_ERR(dir) is OK for debugfs_create_file(),
but dir == NULL has different meaning. I think we'd better
keep this check. (I see, -ENOMEM will be no good...)

Thank you,

>  
> -	file = debugfs_create_file("list", 0400, dir, NULL,
> -				&debugfs_kprobes_operations);
> -	if (!file)
> -		goto error;
> +	debugfs_create_file("list", 0400, dir, NULL,
> +			    &debugfs_kprobes_operations);
>  
> -	file = debugfs_create_file("enabled", 0600, dir,
> -					&value, &fops_kp);
> -	if (!file)
> -		goto error;
> +	debugfs_create_file("enabled", 0600, dir, &value, &fops_kp);
>  
> -	file = debugfs_create_file("blacklist", 0400, dir, NULL,
> -				&debugfs_kprobe_blacklist_ops);
> -	if (!file)
> -		goto error;
> +	debugfs_create_file("blacklist", 0400, dir, NULL,
> +			    &debugfs_kprobe_blacklist_ops);
>  
>  	return 0;
> -
> -error:
> -	debugfs_remove(dir);
> -	return -ENOMEM;
>  }
>  
>  late_initcall(debugfs_kprobe_init);
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
