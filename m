Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEFBC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CA32190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWCYSGu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390065AbfBMCz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:55:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33934 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732781AbfBMCzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:55:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so462826plz.1;
        Tue, 12 Feb 2019 18:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ArRQuu63wfSGm9vQ4Wjr9p0mZMu12amiLX7g9jOUEg=;
        b=rWCYSGu7p6Vj4bjiuNz0hl+Yjd5OhoADxM21vIIdTyo8hbG/Q3lP/2sJ9JYchAKxlK
         c7ffV9lkZjeeJpz2oRc29I+a4ka5kvdEPq3GeEK/M4DhxdDhfavn/UyLsPWBgClIFkKJ
         mdMFNsSjWiDfJypLQQCCW7XT8mMJplA/gZt4HH52+2JmDOm4uECWGA+yigNaH1xM6plw
         rq4njzWynP0UBqi/mfG4CmpX17ALsMePAuYq23LEJr0z1kHbjIgXUIIoRhlS7cheMJk+
         +03NNxHaMfqy6b/g5BYq9kQeFsisFL0REE2BJzhYoR12El+cBbaJWB9Ghkegf2RwK4OU
         36TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ArRQuu63wfSGm9vQ4Wjr9p0mZMu12amiLX7g9jOUEg=;
        b=bhsRAzOJrVpBxlJSPX4OpvHFDPOSQHuAbnj+lm5fnNQV/rIXu1NyrEW0fUclT7m761
         zVLT0n+UBATTY7ASoKMw1vgd2zm97Ge6WoMQIao7nVwJxjVOEYhUa8hY6b407AdmaBrN
         0BWuUvjiVG0eUC02y2A/mc4ByghnipeuHdXbBeNBoSiarM5/Ai1PucYrcRzxWc4tQx+V
         LCXMNdhW1pCNllkvsV7D05HAviRI2WXKcte0Y8JwHu3MgFlsASt2fUbah7FUHkLC9O6B
         OuSWiGSKP83Rc7XTyza5V3d/b3cE5yVUQIVi6hUaUnY2cRvuhoSqWfAYXltHeBzfA8cr
         1cmw==
X-Gm-Message-State: AHQUAuZhzaqsyjrIb2oHxU3H7p9D6R7dZh3K66UPmWv5Y4va8YGPNaxk
        DvD7Em8AIYa0rwCtUG7DJTQ=
X-Google-Smtp-Source: AHgI3IYhtCUBTS14Ll5e3mHhgjPMOL3q7UobsmNfSDukxVHLVyNJiKh2ACH/hWhIhBo/gKBcj1U2Cg==
X-Received: by 2002:a17:902:7882:: with SMTP id q2mr7498828pll.305.1550026524823;
        Tue, 12 Feb 2019 18:55:24 -0800 (PST)
Received: from localhost ([39.7.15.189])
        by smtp.gmail.com with ESMTPSA id c4sm37662303pfm.151.2019.02.12.18.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 18:55:23 -0800 (PST)
Date:   Wed, 13 Feb 2019 11:55:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Message-ID: <20190213025520.GA5803@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/12/19 15:29), John Ogness wrote:
> 
> - A dedicated kernel thread is created for printing to all consoles in
>   a fully preemptible context.

How do you handle sysrq-<foo> printouts on systems which can't
schedule printk-kthread?

	-ss
