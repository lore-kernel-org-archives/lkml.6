Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B11C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFBA2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCHYiwT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeLRCXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:23:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32825 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeLRCXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:23:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so7347817pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 18:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LfGPyXUcMknKtJVZJHJXZusXAGI7tOUVlnsh99ett9o=;
        b=PCHYiwT2tfxxwC5gIKneGmugTWjahRblKrpOwfx3UzWKIQbOoBV0G6DzhAiGC/eK/x
         mt1bGe1NHGgM1+v+C0ItxnLaHldM+dVAdbSasyPIIEys/4IXm45UWGtFJ6bH/gMbhW+f
         JoD1gZuYgKTZRZw5GekoaHvcXbTZRpwwKij4A5M4M3Na9cdEqWeFSH4yGPf88EvKn9xt
         VZM74piPaqi6mL1yRVEZjILpTxfx1FqPkMj5riHUDRehNp8EZnY2RKpuIYQUkLY5z0T9
         5/LzZuS8TcQBj2fX5lL0iJtuirAloFT84ytMnWbsiXex5CkAVMhUHad9WLkKmynDNsLE
         xwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LfGPyXUcMknKtJVZJHJXZusXAGI7tOUVlnsh99ett9o=;
        b=b+WOdoS9IO4IHCcv9Mm9qA6BHtG1hm+83QKO4nQYwgyw1DZYGbWOdKTHZ0sJ0lwnkQ
         byJCBGd7i7Pzew3wNxa+5q1Ob+npjilxPGfItY5Tarcd2HTINugTMloDnP7E/9RVHuYa
         v67CdhtyM8cVMk+YM6m1MOT+YSKzta9ouBPLqLgXA/U/DCUMatXc2EijK+ly5F3nfxAD
         KOsHBhLES0kDraZWGa7g3Hx80whDr3Ur3A/dh2Q6KJzPm6T/h/xI5ufNlY3n9YkFbK4m
         Z1fyZJLBJ3LIcWwt/soh4n7e3z46TNHedIlqWtIMvnHdAHVUyEMq1iWEwOHUXn3Ydxgf
         41Ag==
X-Gm-Message-State: AA+aEWa5jzq7ibMhlq97QcstNWMMMqpA69kpof5OdCJj1b5J3JcnMBDR
        4X6cQk3lSFiXJNRrOfl1puA=
X-Google-Smtp-Source: AFSGD/W1IbiYSTraMSCLwY4fBXXAvZxL8Ewz3Jo3BOrWu7R+T/5/7V9sBMGXn0Je1gJsMKJWii8epw==
X-Received: by 2002:a62:6303:: with SMTP id x3mr15549485pfb.110.1545099803498;
        Mon, 17 Dec 2018 18:23:23 -0800 (PST)
Received: from localhost ([175.223.2.245])
        by smtp.gmail.com with ESMTPSA id 186sm24600132pga.36.2018.12.17.18.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 18:23:22 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:23:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] debugobjects: Move printk out of db lock critical
 sections
Message-ID: <20181218022319.GA5693@jagdpanzerIV>
References: <1544738377-3848-1-git-send-email-longman@redhat.com>
 <20181217181712.GA5114@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217181712.GA5114@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/17/18 19:17), Ingo Molnar wrote:
> This makes me sad - whatever happened to the principle of keeping printk
> simple?

printk() is still simple. Console drivers are not, tho.

	-ss
