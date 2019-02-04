Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE57C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E032081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549319500;
	bh=BeNxM4eKb0Y40u61OmYB4D7vy196GCYEg7FjsVxsrwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EnOHnyeTWtCWSkG50yQCPUiIwcDOtyOD5LR9V7uFklyBC8pUzCofi9M+h0tB3y8ZQ
	 3WOYFFp3G5eYxQ6giyfa70aSeyOMgX9+bEsGOLesvcNZzNPJ9L3K0LfjPvDeuOqf8Q
	 LBrj7dBCZVWLmTygPj3H6192r9vViiIjHVUWDUhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfBDWbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:31:39 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33098 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfBDWbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:31:34 -0500
Received: by mail-yb1-f195.google.com with SMTP id m132so275437ybf.0;
        Mon, 04 Feb 2019 14:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XgmVIz2EDz4KH+I2dNa7InV3AIXUsuAuDfIa1Ztp+LU=;
        b=rAJV4o/EHq1u8MJEbIL9gP1ZB9wqTYb9w3cIcX+IxeDK//8KLYxZ10ibklO0fjdICX
         OJwur+yIwfWdnGK9oeDyVpvbVdjGHSUFq0FgsaIVBFBwVp+hJY9gTwiI2MIplqVwAKwy
         efHpoaAg5pHiQcXpq7tcNMS0bVWDYfBGpNoiSree1BXfBK6c9kTUdh9slAG/nRkm0O/R
         Wqu8nEQBdBxVHff+5/BzrbNAp1zqdaEA5KlpecY7quhuWG/7cvD9hlCBjF0nf7pLZOPW
         h0k+zRh95KkFC6cnwqNaTWxpHWgErJdDrFsklLb1A70aDQ8yibO3UnKpJfYBFdi7ExIJ
         Gflw==
X-Gm-Message-State: AHQUAuabDzlYkdLHZNunNpWYiNtYjYwUCBkWMUWu9xFlDChG5rETEjGV
        jTezJY6YEDFOUIepuiPDzZE=
X-Google-Smtp-Source: AHgI3IaGtjxjCx24VN1GfDKJS3LM3t0K8xjiEXGakYlCt/nHmX1FEb2AZ6giwBbuKR8d1ABddMjVRA==
X-Received: by 2002:a25:b1a6:: with SMTP id h38mr1470469ybj.58.1549319493408;
        Mon, 04 Feb 2019 14:31:33 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id y2sm1837098ywy.107.2019.02.04.14.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 14:31:32 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 04 Feb 2019 14:31:27 -0800
Date:   Mon, 4 Feb 2019 14:31:27 -0800
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
Message-ID: <20190204223127.GS11489@garbanzo.do-not-panic.com>
References: <1548874358-6189-1-git-send-email-longman@redhat.com>
 <1548874358-6189-4-git-send-email-longman@redhat.com>
 <20190204222339.GQ11489@garbanzo.do-not-panic.com>
 <cef8c6ab-6aaf-cca2-1e94-e90c2278afaa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cef8c6ab-6aaf-cca2-1e94-e90c2278afaa@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 05:28:00PM -0500, Waiman Long wrote:
> On 02/04/2019 05:23 PM, Luis Chamberlain wrote:
> > Small nit below.
> >
> > On Wed, Jan 30, 2019 at 01:52:38PM -0500, Waiman Long wrote:
> >> diff --git a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
> >>  
> >> +nr_negative shows the number of unused dentries that are also
> >> +negative dentries which do not mapped to actual files.
> >                      which are not mapped to actual files
> >
> > Is that what you meant?
> >
> >   Luis
> 
> Sorry for the grammatical error. Maybe I should send a patch to fix that.

If its already merged sure. Otherwise I don't care.

  Luis
