Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473BAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3C6214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGG+9SgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3C6214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJQNBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeJQNBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:01:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D5FE214C4;
        Wed, 17 Oct 2018 05:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539752850;
        bh=KbHobitd2NgS49iQi4FuDBo5tFX4MIq2v/rRpmN/qno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGG+9SgE4WUJCMZVo/34hXM4cmrFQGXNFHgHhCnWz/W6Y/7U9JXjDMx/qdQHZcEwu
         Nkd1UonjMRsmRZ5nqzoaDD/XSwKLydQCInHSp2W5f9YQuwJwqSLDhsKtXjGt7WHnAQ
         9Bs3ymLzJhqLJmIDcwnJMIP38yPVLQNnjM05TObo=
Date:   Wed, 17 Oct 2018 07:07:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kys@microsoft.com
Cc:     linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com,
        vkuznets@redhat.com, Haiyang Zhang <haiyangz@microsoft.com>,
        Stable@vger.kernel.org
Subject: Re: [PATCH 5/5] Tools: hv: kvp: Fix a warning of buffer overflow
 with gcc 8.0.1
Message-ID: <20181017050728.GF22447@kroah.com>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
 <20181017031406.773-5-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017031406.773-5-kys@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 03:14:06AM +0000, kys@linuxonhyperv.com wrote:
> From: Dexuan Cui <decui@microsoft.com>
> 
> The patch fixes:
> 
> hv_kvp_daemon.c: In function 'kvp_set_ip_info':
> hv_kvp_daemon.c:1305:2: note: 'snprintf' output between 41 and 4136 bytes
> into a destination of size 4096
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  tools/hv/hv_kvp_daemon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index bbb2a8ef367c..b7c2cf7eaba5 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -1176,7 +1176,7 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  	int error = 0;
>  	char if_file[PATH_MAX];
>  	FILE *file;
> -	char cmd[PATH_MAX];
> +	char cmd[PATH_MAX * 2];

Overkill?

