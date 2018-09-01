Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA92C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35622083A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8Jenl1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35622083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeIAEgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 00:36:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36925 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeIAEgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 00:36:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id 2-v6so5604368pgo.4;
        Fri, 31 Aug 2018 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aYfyDUOdGSNfOZV/pI/zAY7JB35GXqB2P2f068rolNQ=;
        b=Z8Jenl1LUYwyuWK1agPe3HE9kQsGp3l0rCQChLVbp17znEagSbfFwtK3d0oAEsgD9A
         rOsYi/XgduU9ayspmwBgZgCkhg/XXd+rEtWSGjr7ASZo2UclSnVzYHbSY5YS9q/5WNYv
         tdGjRN2Y9BqxZaf48tshmFB8yvpnGZe1LrJdxhTtet3IlDVwFazbg7A80v9Tmd7SSfRU
         ftAglG8VG+TAK+Xd7Ru3zKbWwByME7+fEYdDcRC+KUJeFcPLeTshxkbw5ASG1ADzyul4
         0fCxkbCXUwrQQj57Hk3D0Q5TY/Ujp+iwMxgL9Ykti4U8Q7Cbvhnx+QR7FswC+P8Dv7/O
         edsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aYfyDUOdGSNfOZV/pI/zAY7JB35GXqB2P2f068rolNQ=;
        b=ES1StDEh47NfKGewHF+M/OqcnpI01/RkkxY5UaKvrSCjhxvbN1Pp+/5B/vqtCao6aR
         zhq0a3D0FoxyneRZmdpB4CF2TrzEV7WX27i1rCeu3qMPXi/JdRplIBVTG91sBdBx6qxe
         IrIKAVOPBWMdgXSoF3ihXo6Am3eXoWXDKqz72ZD9a42fGNZBjBGPXvL8FWTvp2XGaDSJ
         O+Tp737ClOtYmw+zmylkdZTi/UFmvKBhc2/L3VUlWtwdegNp1J9VZeMzII9tPoD+m+D8
         fioetITXk/VHCacQTxoAZszf75Z3pegUluhfaBgGBJvKdxV6/xAvSzi9y71JmrGeTpDq
         He4w==
X-Gm-Message-State: APzg51Cx0k6r30NpCosCpa7yAaOvorUcwo7+WfFdNon5anBpGHw4bZrY
        6tOJZrQMsWGXjpBkPqikfkgaKNRKmzs=
X-Google-Smtp-Source: ANB0Vdap8RBj+y1BUz8a+xJdrdiD0Ngwf2rMtiEZCrGmMPycxSvL9cWg29KnmvLNAak6uGhaTFJ/mw==
X-Received: by 2002:a63:1d3:: with SMTP id 202-v6mr16598671pgb.136.1535761566642;
        Fri, 31 Aug 2018 17:26:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:a245])
        by smtp.gmail.com with ESMTPSA id e8-v6sm17548808pgi.24.2018.08.31.17.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 17:26:05 -0700 (PDT)
Date:   Fri, 31 Aug 2018 17:26:03 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] blkcg: remove additional reference to the css
Message-ID: <20180901002603.GI1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-12-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-12-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 30, 2018 at 09:53:52PM -0400, Dennis Zhou wrote:
> -	css = cgroup_get_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
>  
> -	return __bio_associate_blkg_from_css(bio, css);
> +	rcu_read_lock();
> +
> +	while (true) {
> +		css = cgroup_e_css(page->mem_cgroup->css.cgroup,
> +				   &io_cgrp_subsys);

So, while they seem similar cgroup_e_css() and cgroup_get_e_css()
behave very differently in terms of locking.  cgroup_e_css() can only
be used under cgroup_mutex because it is used during migration and has
to test cgroup_ss_mask().  The right thing to do here would be
renaming cgroup_e_css() to something else and add a new implementation
which operates in the same way as cgroup_get_e_css().

BTW, this should have triggered lockdep warning.  I'd strongly
recommend testing with lockdep enabled.

Other than that, looks good to me.

Thanks.

-- 
tejun
