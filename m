Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB33C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 03:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64B7216F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 03:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP/tb+Q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64B7216F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeHOFvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 01:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbeHOFvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 01:51:25 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6368A216F8;
        Wed, 15 Aug 2018 03:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534302075;
        bh=TP4baQ+PPqpC0Ygrsb2EuwweNHv7Q4XENrs4RxHFt2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WP/tb+Q4kiip5XjbjUrvs7YSISa/E+VNBbcURMf+wYhCkgclx/ca7WZsUCsXsECx1
         lHXCcbikKNtJmD+gQAk9HwbjAh3/DYwUoQfMjcPzJ5Iq0QhGH0e9mmITzxrAvr4GZp
         qXU6RDfxmTYI8wV+EGzwc4Hry77zo04T9BjdL4zw=
Date:   Tue, 14 Aug 2018 20:01:14 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] Revert "f2fs: use printk_ratelimited for f2fs_msg"
Message-ID: <20180815030114.GD84720@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180813062845.25394-1-yuchao0@huawei.com>
 <20180814170956.GA56510@jaegeuk-macbookpro.roam.corp.google.com>
 <51fabc55-ba93-1845-da39-0ee203fe2098@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51fabc55-ba93-1845-da39-0ee203fe2098@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15, Chao Yu wrote:
> On 2018/8/15 1:09, Jaegeuk Kim wrote:
> > On 08/13, Chao Yu wrote:
> >> Don't limit printing log, so that we will not miss any key messages.
> > 
> > For example, this can avoid lots of messages during roll-forward recovery.
> 
> That's really important evidence that can prove filesystem didn't lose last
> fsynced data, when file/data is missing after SPO, otherwise, filesystem will
> still be treated as suspect... :(

It's too bad that we need to rely on kernel messages for that purpose. Anyway,
if so, we may need to use printk() for essential messages only.

> 
> Thanks,
> 
> > 
> >>
> >> This reverts commit a36c106dffb616250117efb1cab271c19a8f94ff.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/super.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index bf4c919fe418..3d89d94191e7 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -209,7 +209,7 @@ void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
> >>  	va_start(args, fmt);
> >>  	vaf.fmt = fmt;
> >>  	vaf.va = &args;
> >> -	printk_ratelimited("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
> >> +	printk("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
> >>  	va_end(args);
> >>  }
> >>  
> >> -- 
> >> 2.18.0.rc1
> > 
> > .
> > 
