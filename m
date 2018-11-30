Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D987C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8E12082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8E12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeK3MRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:17:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39793 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3MRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:17:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so1917250pld.6;
        Thu, 29 Nov 2018 17:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XLYG3LVFQNBTC8lBR+0H/CHsBDoOnb+dCtmQYcLJ0HQ=;
        b=F5Hnhpf7wY4hbVS3zQqP0l2vhgmlrVDg6BqWFwaCxG3M09n+7zheAuWtCVNJuBhYDI
         KyDLXtDtpDICDtJmnfMh2s3OBY4x3wY72FF0Y3KYuBnQQFQJztGip0p6WbsEKXK4Rmcn
         QhzIzHVHpfmFawUuZ2/QWFn+5q+YFr8thELR7wSmJr9wMVhbBcuGWa4KK1Pf3ICGUXq+
         xta1MgEL0GyZvyqENifv0wdst3/JWLlPrSetedz8YMHf70Rs64wniir+jw/0IUWcJ54L
         zwdYAc7V4AJIgwj/98ngGC6+Um/PbJUx3F5h0PiI4B6Y/ZJeVI8g+VkasGYCLCgLExBE
         nMwQ==
X-Gm-Message-State: AA+aEWYUxkgsdukm4cLv4OJ8Oj2kI1V3aJRU6Nx1VfBPLsAsC3uRdLV3
        HRQUJv22gMiqkLpne8Dc7tk=
X-Google-Smtp-Source: AFSGD/VRnG+shIXeXY6DYmg0p6C3u9wF9E5Uampq6Rl+6Jez7OmeJ18NhVNd9NF0FXIG9HzzvZFY6A==
X-Received: by 2002:a17:902:887:: with SMTP id 7mr3669887pll.164.1543540172337;
        Thu, 29 Nov 2018 17:09:32 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id b7sm4585047pfa.52.2018.11.29.17.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 17:09:31 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 17:09:28 -0800
Date:   Thu, 29 Nov 2018 17:09:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Radoslaw Burny <rburny@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jsperbeck@google.com
Subject: Re: [PATCH] fs: Make /proc/sys inodes be owned by global root.
Message-ID: <20181130010928.GM4922@garbanzo.do-not-panic.com>
References: <20181126172607.125782-1-rburny@google.com>
 <20181127011627.GI4922@garbanzo.do-not-panic.com>
 <87k1kzjdff.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1kzjdff.fsf@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:29:40PM -0600, Eric W. Biederman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> > Thanks for the description of how to run into the issue described but
> > is there also a practical use case today where this is happening? I ask
> > as it would be good to know the severity of the issue in the real world
> > today.
> 
> People trying to run containers without a root user in the container.
> It atypical but something doable.  

My question was if there are generic tools / propreitary tools which are
doing this widely *today*. Or is this just a custom setup some folks
use?

> We spoke about this at LPC.  And this is the correct behavioral change.
> 
> The problem is there is a default value for i_uid and i_gid that is
> correct in the general case.  That default value is not corect for
> sysctl, because proc is weird.  As the sysctl permission check in
> test_perm are all against GLOBAL_ROOT_UID and GLOBAL_ROOT_GID we did not
> notice that i_uid and i_gid were being set wrong.
> 
> So all this patch does is fix the default values i_uid and i_gid.
> 
> The commit comment seems worth cleaning up.  But for the
> content of the code.

The logic seems sensible then, but are we implicating what a container
does with its sysctl values onto the entire system? If so, sure, it
seems you want this for networking purposes as there are a series of
sysctl values a container may want to muck with, but are we sure we
want the same for *all* sysctl entries?

  Luis
