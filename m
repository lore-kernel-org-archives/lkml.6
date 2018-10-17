Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E5AECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21592151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="fTwvPxk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21592151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeJQRwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:52:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51000 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeJQRwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:52:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id i8-v6so1345959wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 02:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A1kthwDlqHJBxyjWL6NgoPzRbXnziUt45ZrJoEWCZO0=;
        b=fTwvPxk/4KGe2otNZ6+3vD2wYW9yYpGUrUVaqdG+aQ+UINUmrX0xoXJZBHhAP9fMQq
         +GJicakdI1J/+oiGt+pQB3AmJvHrgFjn7arA/dhLaBWNhweFQjYo53Y+NzR1XnzG52Mv
         FsjGzN6kUjJxcKvE6FWI7QezNRZvtJZE6bN7bQzEi7IBSkW1oItRG00ETTmLjb+Kcvwv
         INvxI8W+77GY96fe3QyeHo4MkOucjPRh0TlAU766fgLxDfX+i76d+7gk1p6kxtI+MxxV
         9JrczHldp3Vcm1+B/TdnMsGwkw1rs+wFT7PdshlDPcQmmdvn+5ZlzhCJeEIw8sFavlIS
         4WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A1kthwDlqHJBxyjWL6NgoPzRbXnziUt45ZrJoEWCZO0=;
        b=MSaziFJwfjQP7s7uZycfp5/83VWozUnC6uwHdBXZa3U569elkv2xOwCBfZxessDj6o
         q+IUNnqltOOSCA2NPZRR00GQl921nLvKv3y0jd47yz8odXs+cQtujFEMDe1YyoRS/GiZ
         M2tQv/7NE6GYb83rOYI4I/+vxovBtYnMwrkLOy7EtXnMBIukADgaq0kXyr7BeGOAnQ3e
         NhAMzip0yxEPo7ioxieI/LzOcaslHtSNVEwo0OVjdYeK5fOnXUAJP/ItsGGUfoM4yVNh
         gD1X1wlpGeG5bH8W7l9Nye74vqwWZBHsTTLGluY4unP6zpiUvF6LQcqol3OJkgkJOtX2
         dCsQ==
X-Gm-Message-State: ABuFfoj0RMttdeWPEl1Wl27zbFxCUexjmzxhNB6ZKhLzG640a7v1PWbp
        x0uwauR35a8sLbwUffaMDyBEVw==
X-Google-Smtp-Source: ACcGV63NxUDk52Cm8rTf5JUof2NIMRvLB0rACQ99RC6l559mZ2z+eDwXMkVu4m784BNH/uzEw/7pGg==
X-Received: by 2002:a1c:c90f:: with SMTP id f15-v6mr2077357wmb.48.1539770238012;
        Wed, 17 Oct 2018 02:57:18 -0700 (PDT)
Received: from brauner.io (eap108037.extern.uni-tuebingen.de. [134.2.108.37])
        by smtp.gmail.com with ESMTPSA id e196-v6sm3542030wmf.43.2018.10.17.02.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 02:57:17 -0700 (PDT)
Date:   Wed, 17 Oct 2018 11:57:11 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        adobriyan@gmail.com, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH v3 2/2] sysctl: handle overflow for file-max
Message-ID: <20181017095709.6wx6wzhbbezgeybh@brauner.io>
References: <20181016223322.16844-1-christian@brauner.io>
 <20181016223322.16844-3-christian@brauner.io>
 <20181017003548.GA32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181017003548.GA32577@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 01:35:48AM +0100, Al Viro wrote:
> On Wed, Oct 17, 2018 at 12:33:22AM +0200, Christian Brauner wrote:
> > Currently, when writing
> > 
> > echo 18446744073709551616 > /proc/sys/fs/file-max
> > 
> > /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> > crashes the system.
> > This commit sets the max and min value for file-max and returns -EINVAL
> > when a long int is exceeded. Any higher value cannot currently be used as
> > the percpu counters are long ints and not unsigned integers. This behavior
> > also aligns with other tuneables that return -EINVAL when their range is
> > exceeded. See e.g. [1], [2] and others.
> 
> Mostly sane, but...  get_max_files() users are bloody odd.  The one in
> file-max limit reporting looks like a half-arsed attempt in "[PATCH] fix
> file counting".  The one in af_unix.c, though...  I don't remember how
> that check had come to be - IIRC that was a strange fallout of a thread
> with me, Andrea and ANK involved, circa 1999, but I don't remember details;
> Andrea, any memories?  It might be worth reconsidering...  The change in
> question is in 2.2.4pre6; what do we use unix_nr_socks for?  We try to
> limit the number of PF_UNIX socks by 2 * max_files, but max_files can be

So that's something I mentioned to Kees before. It seems we should
either simply replace this check with:

        if ((atomic_long_read(&unix_nr_socks) >> 1) > get_max_files())
                goto out;

to protect against overflows or simply do

        if (atomic_long_read(&unix_nr_socks) > get_max_files())
                goto out;

> huge *and* non-constant (i.e. it can decrease).  What's more, unix_tot_inflight
> is unsigned int and max_files might exceed 2^31 just fine since "fs: allow
> for more than 2^31 files" back in 2010...  Something's fishy there...

What's more is that fs/file_table.c:files_maxfiles_init()
currently has:
void __init files_maxfiles_init(void)
{
        unsigned long n;
        unsigned long memreserve = (totalram_pages - nr_free_pages()) * 3/2;

        memreserve = min(memreserve, totalram_pages - 1);
        n = ((totalram_pages - memreserve) * (PAGE_SIZE / 1024)) / 10;

        files_stat.max_files = max_t(unsigned long, n, NR_FILE);
}

given that we currently can't handle more than LONG_MAX files should we
maybe cap here? Like:

diff --git a/fs/file_table.c b/fs/file_table.c
index e49af4caf15d..dd108b4c6d72 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -376,6 +376,8 @@ void __init files_init(void)
 /*
  * One file with associated inode and dcache is very roughly 1K. Per default
  * do not use more than 10% of our memory for files.
+ * The percpu counters only handle long ints so cap maximum number of
+ * files at LONG_MAX.
  */
 void __init files_maxfiles_init(void)
 {
@@ -386,4 +388,7 @@ void __init files_maxfiles_init(void)
        n = ((totalram_pages - memreserve) * (PAGE_SIZE / 1024)) / 10;

        files_stat.max_files = max_t(unsigned long, n, NR_FILE);
+
+       if (files_stat.max_files > LONG_MAX)
+               files_stat.max_files = LONG_MAX;
 }
