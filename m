Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E38C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD06421508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HHdwjMsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD06421508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbeIRW6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:58:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44654 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbeIRW6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:58:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so1354209pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QFO829D5xhR+ZdLGyEW5lo0+ywypKe64BGYOpjFtu2w=;
        b=HHdwjMshQID9Ezw1gA3vh3icPqIBT+ZDlOjxmV56XzvRLzTWSMmxH2X64KSGnlJmc5
         4hwOBuASbm6eG1jczYrWN//Gyd6B0GsDNQ1v5JTqIlJLsfzWvh2MrVAZikyMl+hFVPjg
         81uQ4YS9Jz1EJXxDFJpz06NK08AtGtBh0K6Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QFO829D5xhR+ZdLGyEW5lo0+ywypKe64BGYOpjFtu2w=;
        b=dW4dMYjExCER5nyD8mpYRID9D+utdM0wA1bt1T2rSyY/hHuB8KdM/AvTp7tt5VhBXr
         smnWW5S92vHWp/jfReUGgi4Tsz6TDA+Ll20MRsuwQLC/y5FgPc1GgT5wnKR1VynsV3eL
         9H0iNYXea5KvYkTHUzEe8e4GU03jYPT6lVggai2wlYOUAtgObAeME7LavjnzPWYozdiu
         o2peNxJL5Qfqzoh6XtN6Ru+UajW/a11qF5Teko/j0lyyvL9C0kbj0wvt0ZNIQ1HGTdXq
         o9uLcSlaDaUWlpJKQu8qeIkrI27oZGJfv7DXf/bTdzgDSapyf7qesWKP6CozPAPuvwha
         EpmQ==
X-Gm-Message-State: APzg51DkPvOVYNt+pnFdtsYIsM85GM7WLhr/l+Nn/fN1gLFnnvY/a5AT
        1w/MuK/QUa6JStnz3LDZL4JFQw==
X-Google-Smtp-Source: ANB0Vda1PzA40ebHt4bvNbyVzPhL0QOITJ6sDxVtp/k82VB3Qu4eCpQdwZr6vi0c8e/2XNgKOkTu5Q==
X-Received: by 2002:a63:fb57:: with SMTP id w23-v6mr28691407pgj.441.1537291470458;
        Tue, 18 Sep 2018 10:24:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id m20-v6sm44404115pfg.61.2018.09.18.10.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 10:24:29 -0700 (PDT)
Date:   Tue, 18 Sep 2018 10:24:27 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/sysrq: Make local variable 'killer' in
 sysrq_handle_crash() global
Message-ID: <20180918172427.GO22824@google.com>
References: <20180917213304.44476-1-mka@chromium.org>
 <a75e8a5d-25d0-83b8-6f7c-b80e69985b60@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a75e8a5d-25d0-83b8-6f7c-b80e69985b60@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 08:11:33AM +0200, Jiri Slaby wrote:
> On 09/17/2018, 11:33 PM, Matthias Kaehlcke wrote:
> > sysrq_handle_crash() dereferences a NULL pointer on purpose to force
> > an exception, the local variable 'killer' is assigned to NULL and
> > dereferenced later. Clang detects the NULL pointer dereference at compile
> > time and emits a BRK instruction (on arm64) instead of the expected NULL
> > pointer exception. Change 'killer' to a global variable (and rename it
> > to 'sysrq_killer' to avoid possible clashes) to prevent Clang from
> > detecting the condition. By default global variables are initialized
> > with zero/NULL in C, therefore an explicit initialization is not needed.
> > 
> > Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > Suggested-by: Evan Green <evgreen@chromium.org>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/tty/sysrq.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > index 06ed20dd01ba..49fa8e758690 100644
> > --- a/drivers/tty/sysrq.c
> > +++ b/drivers/tty/sysrq.c
> > @@ -132,10 +132,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
> >  #define sysrq_unraw_op (*(struct sysrq_key_op *)NULL)
> >  #endif /* CONFIG_VT */
> >  
> > +char *sysrq_killer;
> > +
> >  static void sysrq_handle_crash(int key)
> >  {
> > -	char *killer = NULL;
> > -
> >  	/* we need to release the RCU read lock here,
> >  	 * otherwise we get an annoying
> >  	 * 'BUG: sleeping function called from invalid context'
> > @@ -144,7 +144,7 @@ static void sysrq_handle_crash(int key)
> >  	rcu_read_unlock();
> >  	panic_on_oops = 1;	/* force panic */
> >  	wmb();
> > -	*killer = 1;
> > +	*sysrq_killer = 1;
> 
> Just because a static analyzer is wrong? Oh wait, even compiler is
> wrong. At least make it a static global. Or what about OPTIMIZER_HIDE_VAR?

With a static global the compiler still can know that the value is
constant.

Anyway, our compiler folks raised concerns that the variable could
still be identified as constant with Link Time Optimization (LTO)
enabled, so this patch isn't a good solution.

On the positive side the compiler engs don't expect the NULL pointer
access being optimized away with -fno-delete-null-pointer-checks
enabled, which recently landed in upstream LLVM.

I confirmed that with -fno-delete-null-pointer-checks Clang does not
emit 'brk' in this case and the kernel crashes with a NULL pointer
exception when this code path is triggered.

Seems we can forget about this patch, though we might still want to
replace the forced crash with a panic() as mentioned in this thread.

Thanks

m.



