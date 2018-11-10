Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCBDC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C951220892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sacMhAtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C951220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeKJP15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 10:27:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37109 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbeKJP15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 10:27:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id u13-v6so1879719pfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 21:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pfuk88+N7vewG5mvrswitDW+c4hJAo1IWigof7AdliU=;
        b=sacMhAtMTkOuS+oVmP123FMHPpniFOQG2ZWzfCZVBN6i6FbUwC2iMOQBnQIu+QkbYD
         5g3XuQyG6C7ixQXLd6q8H2fVkwgWQncRSmVHP+3IIrHiHM+XHocDNxoaT7yIoBxFFRX4
         iRxcn8qhvqCbMjZuEbs9/e4lWRPIs9is0bURw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pfuk88+N7vewG5mvrswitDW+c4hJAo1IWigof7AdliU=;
        b=pg3MXsbFIAz9IInBJYuKZ5xzhByF3RDl40qO+LWqKQz3osCptamkbuKuMKRrL5M/WR
         CMmwNYxMd4c3X46ZA6KACe6Mb904yThyIiKktvP03JAxNHne5TqltxEL55dARTLIstLV
         +/XgyCWUMArSK7CSmPjTNTn5XOnOIJfRPJbnZZkxEgIUTQ5EyhTn0nNcQPGC41cxXw2p
         SxErcd5iIwKFn5Wn2d9O4u8m5HGd7+Nl/yOTsqffRxMItu/Dp2opavvdeJk3jbqPIoh4
         JVx+mZ60sripurx/GkMIyxUwBRo5JRcf8xz6JBrQn8YPJYaKcE3WzhvnouWASB9Ct13L
         N7fA==
X-Gm-Message-State: AGRZ1gIeRZnnL7OyTp4IBBsfli8WI8eL9RophUSL/gn/s3PmoL9FLWtz
        8VpbL52Pn+dUpHE605EC6ILbQA==
X-Google-Smtp-Source: AJdET5dEo3X4RSELuNEbKan1zxKBrkTYahfvoqBgseMQMRoMjaxXYJzhnAbYv+jdamqjmW3hDMdcnw==
X-Received: by 2002:aa7:8498:: with SMTP id u24-v6mr11605932pfn.220.1541822086095;
        Fri, 09 Nov 2018 19:54:46 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 69sm3101587pgg.86.2018.11.09.19.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 19:54:44 -0800 (PST)
Date:   Fri, 9 Nov 2018 19:54:43 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, jreck@google.com,
        john.stultz@linaro.org, tkjos@google.com,
        gregkh@linuxfoundation.org, hch@infradead.org,
        Al Viro <viro@zeniv.linux.org.uk>, dancol@google.com,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Lei Yang <Lei.Yang@windriver.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, minchan@kernel.org,
        Shuah Khan <shuah@kernel.org>, valdis.kletnieks@vt.edu
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to
 memfd
Message-ID: <20181110035443.GA26579@google.com>
References: <20181108041537.39694-1-joel@joelfernandes.org>
 <20181109123634.6fe7467bb9237851250c9c56@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109123634.6fe7467bb9237851250c9c56@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 12:36:34PM -0800, Andrew Morton wrote:
> On Wed,  7 Nov 2018 20:15:36 -0800 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > Android uses ashmem for sharing memory regions. We are looking forward
> > to migrating all usecases of ashmem to memfd so that we can possibly
> > remove the ashmem driver in the future from staging while also
> > benefiting from using memfd and contributing to it. Note staging drivers
> > are also not ABI and generally can be removed at anytime.
> > 
> > One of the main usecases Android has is the ability to create a region
> > and mmap it as writeable, then add protection against making any
> > "future" writes while keeping the existing already mmap'ed
> > writeable-region active.  This allows us to implement a usecase where
> > receivers of the shared memory buffer can get a read-only view, while
> > the sender continues to write to the buffer.
> > See CursorWindow documentation in Android for more details:
> > https://developer.android.com/reference/android/database/CursorWindow
> 
> It appears that the memfd_create and fcntl manpages will require
> updating.  Please attend to this at the appropriate time?

Yes, I am planning to send those out shortly. I finished working on them.

Also just to let you know, I posted a fix for the security issue Jann Horn
reported and requested him to test it:
https://lore.kernel.org/lkml/20181109234636.GA136491@google.com/T/#m8d9d185e6480d095f0ab8f84bcb103892181f77d

This fix along with the 2 other patches I posted in v3 are all that's needed. thanks!

- Joel

