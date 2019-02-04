Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D433C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296D920823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549319027;
	bh=VgTY61rxDa1HvW/9kWbawn9B/K2Aul09p6Yb4k/37WU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RniQ4GSVyBSEJ5FMmOewrN3MaaPwgJzqu0rf+qDYIyNw/dWq58ZbQd8mH+F3DivZI
	 gqhUfH9ORJCicEVritE2kZ3za3sxK7wMYdW7E5qQ8/TwxIMYTT/o9pUhQKwijWR4dU
	 KyF/Wsx6guQtjn5DGJ+ARSDox1OZZ6XH1yf6vBm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfBDWXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:23:45 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41134 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfBDWXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:23:45 -0500
Received: by mail-yb1-f193.google.com with SMTP id n6so267882ybg.8;
        Mon, 04 Feb 2019 14:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MPtEQEaye4UPLQvkJVscodsBwwpLOB6+axqeFQgy3uk=;
        b=dDRpqArHQZdLYhAZ7BE/Aqyo7P8NbkcTxTX/gx7bmA969oGMSbqFlZpWjiKLBfd6Oo
         bRhfmcoyIQwUckgN47dmMrctKwGA/jCkGqWrnVXrZ/vLo2uCG9TR0x9nK+zblCgXWCko
         dYppWKO2Ao9K9DNV2WHQsLicLHTriF6vJr+yDhU3rDyJfdnVKwChM/JDV20ALMTG/14Q
         4ZzSEh83A+zuWTzmkPyIjoj24UtcD+cqio2jTiS6cp3LvJhOI0tdSxcNuHp3K7vWtkhe
         7JJIM/od/FPD4ZaDQwR3p7jYQecCSjKkPp8PVcDaJMAsSyGOyDkzWGQQrPnFoZp8RbtE
         95fw==
X-Gm-Message-State: AHQUAuaX1KDZzSyV6CwWFi6sVG9ytkO03YGGOveC/wLuhDjmFb1h8jk2
        h4eHQ5TUuecqg6gNHJvI+aU=
X-Google-Smtp-Source: AHgI3IZvbVjxe1YNvbJI/uLMgftVnyjldcE0uVtw8PV8F1aOnZMvA/gPe8aAsYTjB9SXv6YlAPr1JQ==
X-Received: by 2002:a25:9b01:: with SMTP id y1mr1459452ybn.260.1549319024021;
        Mon, 04 Feb 2019 14:23:44 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id l3sm1800963ywb.39.2019.02.04.14.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 14:23:42 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 04 Feb 2019 14:23:39 -0800
Date:   Mon, 4 Feb 2019 14:23:39 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RESEND PATCH v4 3/3] fs/dcache: Track & report number of
 negative dentries
Message-ID: <20190204222339.GQ11489@garbanzo.do-not-panic.com>
References: <1548874358-6189-1-git-send-email-longman@redhat.com>
 <1548874358-6189-4-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548874358-6189-4-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small nit below.

On Wed, Jan 30, 2019 at 01:52:38PM -0500, Waiman Long wrote:
> diff --git a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
>  
> +nr_negative shows the number of unused dentries that are also
> +negative dentries which do not mapped to actual files.

                     which are not mapped to actual files

Is that what you meant?

  Luis
