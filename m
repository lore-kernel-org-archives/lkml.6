Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D5720834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D5720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeLAF34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:29:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36226 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeLAF34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:29:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so2847573pgm.3;
        Fri, 30 Nov 2018 10:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1WqnWyUidrdmKZlFoULb0ASi02Ebvxr7V6EWBACfkz8=;
        b=Iz9YjwYxeqiKJXtMIAS7pDvflIzlyhx/tfc1gw4Ktsak52gFfGHTlq9vjBHKmvjLVt
         n3uET5tiM50l4RmDu3Us7I7wRa7Rap6WvyO64sJzERTQqXjje/Ure+eeEBYhIOcAJqrm
         plqi6x5KHH+OQDBYhHou9CWJtXxi33PHzYhXIHHH3qM/L+PjnK+7ETcrcgPFmi8aMgmD
         oyotOp7LLkl99cDJqYUFurzQWkbzzxsrUoSCJvhpaFcP49RW34asUsvN0KdbaZbRN3M9
         8jDPWaBpptoRJKFBstlNf813eEA0dWK+EEEuVoZdqoBeRkz9yAV98iQmYvAESmYjefRr
         KoTQ==
X-Gm-Message-State: AA+aEWbu2/218bpB4hvxTbciD0Mtcfbnd+eVejpnimtmE40SsqlEJVRQ
        EVNiVxsAemOglWuoY+EkfTY=
X-Google-Smtp-Source: AFSGD/XU6zeyyZZxWfBrdFvtbuJQ3O48h6Oz64QFF3nucU+NlEoUiZMD5V/+kknK01UwtdhMwGMfgw==
X-Received: by 2002:a62:ca05:: with SMTP id n5mr6624873pfg.154.1543601988115;
        Fri, 30 Nov 2018 10:19:48 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id q195sm5822062pgq.7.2018.11.30.10.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 10:19:46 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Fri, 30 Nov 2018 10:19:43 -0800
Date:   Fri, 30 Nov 2018 10:19:43 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Radoslaw Burny <rburny@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jsperbeck@google.com
Subject: Re: [PATCH] fs: Make /proc/sys inodes be owned by global root.
Message-ID: <20181130181943.GR18410@garbanzo.do-not-panic.com>
References: <20181126172607.125782-1-rburny@google.com>
 <20181127011627.GI4922@garbanzo.do-not-panic.com>
 <87k1kzjdff.fsf@xmission.com>
 <20181130010928.GM4922@garbanzo.do-not-panic.com>
 <87k1ku39lg.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1ku39lg.fsf@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 08:48:11AM -0600, Eric W. Biederman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
> > The logic seems sensible then, but are we implicating what a container
> > does with its sysctl values onto the entire system? If so, sure, it
> > seems you want this for networking purposes as there are a series of
> > sysctl values a container may want to muck with, but are we sure we
> > want the same for *all* sysctl entries?
> 
> No.  Please look at the patch again.  It sets the default uid and gid
> for sysctl entries to 0.  AKA GLOBAL_ROOT_UID and GLOBAL_ROOT_GID
> because there is a bug and they were not set to that value.
> 
> Those are the uids and gids that are tested agasint.  It just happens
> you have to be in a weird configuration for this bug to become a problem.

Thanks, then provided the commit lot is modified:

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
