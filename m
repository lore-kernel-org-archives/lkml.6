Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBF3C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939972081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 01:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="whnQSpuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939972081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeKJLT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 06:19:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33779 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbeKJLT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 06:19:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id q5-v6so1596688pgv.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 17:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5rVRLwmeXXqGwuTVKtGHavaKEmH1dR+39dZJf49P+RA=;
        b=whnQSpuRoDGpVcPscQFQUrRVXT36d3O2EB2Jpr+ouBGjfNlsmkDjIdOgNXjX5Qnsl6
         2TWy/1npjunwC7EWizaUuDob5LG6EPTuYJ/3Ua2YfMtxOulrC906rXOnS9f2/hLrJ88v
         p7/KFnwcrZgjeNEsHQ5tudtVWn0eDjsQ5LYuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5rVRLwmeXXqGwuTVKtGHavaKEmH1dR+39dZJf49P+RA=;
        b=WmXRWggKtXYl/eqO2A3hwTF6IetRjTe9tGiVuVWM+GUC4D7d4thlhoqlWOTp4zT0sj
         fbdlDYYzu70ekXfeqhDLQNDcRjhGsBDBgI2qGSz1ps09TY6pyxIokhAbd9C1DbWKb3+s
         pUAKmBmILWpFGg7r/vl3bNFCw2oYTX6zlz8ZcUcec1o+ZJqJN++hYDTfaFcIluFhfcfT
         FAXJaFe9YJsvHmvaEwv8ppyvUAK7fZvrku8sVYuMiuuPa00M1IvlapectP933bIYnlqj
         vD/wzKqkGaMW+hCFqdHLMo92xoxMITQRCoQDWZH77SUCT7yT5SN8g+tOyditdoYTRfEk
         xCAw==
X-Gm-Message-State: AGRZ1gIG5EVQp4e85Tnf07acH2ObmczBnevgjAKPVUw8FHBVDvUhBF5n
        oh4wrmhW+8wwk7vlmUaYGCk5BatCAOk=
X-Google-Smtp-Source: AJdET5ep6eflBnfolqJWFOwAAnFJpoqi6ZfWj1DAonSgLW/UKKu/mp2Q0xX10qiqwpUdkMTZBVD9OQ==
X-Received: by 2002:a63:d949:: with SMTP id e9mr9611511pgj.24.1541813774059;
        Fri, 09 Nov 2018 17:36:14 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id w80-v6sm14841724pfk.11.2018.11.09.17.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 17:36:12 -0800 (PST)
Date:   Fri, 9 Nov 2018 17:36:11 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        John Reck <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>, Lei.Yang@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Shuah Khan <shuah@kernel.org>, valdis.kletnieks@vt.edu,
        Hugh Dickins <hughd@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to
 memfd
Message-ID: <20181110013611.GA199560@google.com>
References: <20181108041537.39694-1-joel@joelfernandes.org>
 <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
 <CAKOZuesw1wG-YynWL7bVb+4BWtYp0Ei62vweWF+mqF1Ln-_2Tg@mail.gmail.com>
 <BB64C995-F374-49EB-8469-4820231D8152@amacapital.net>
 <CAKOZuetZrL10zWwn4Jzzg0QL2nd3Fm0JxGtzC79SZAfOK525Ag@mail.gmail.com>
 <F8A6A5DC-3BA0-43BD-B7EC-EDE199B33A02@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F8A6A5DC-3BA0-43BD-B7EC-EDE199B33A02@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 03:14:02PM -0800, Andy Lutomirski wrote:
> >>>> That aside: I wonder whether a better API would be something that
> >>>> allows you to create a new readonly file descriptor, instead of
> >>>> fiddling with the writability of an existing fd.
> >>> 
> >>> That doesn't work, unfortunately. The ashmem API we're replacing with
> >>> memfd requires file descriptor continuity. I also looked into opening
> >>> a new FD and dup2(2)ing atop the old one, but this approach doesn't
> >>> work in the case that the old FD has already leaked to some other
> >>> context (e.g., another dup, SCM_RIGHTS). See
> >>> https://developer.android.com/ndk/reference/group/memory. We can't
> >>> break ASharedMemory_setProt.
> >> 
> >> 
> >> Hmm.  If we fix the general reopen bug, a way to drop write access from
> >> an existing struct file would do what Android needs, right?  I don’t
> >> know if there are general VFS issues with that.
> > 

I don't think there is a way to fix this in /proc/pid/fd. At the proc
level, the /proc/pid/fd/N files are just soft symlinks that follow through to
the actual file. The open is actually done on that inode/file. I think
changing it the way being discussed here means changing the way symlinks work
in Linux.

I think the right way to fix this is at the memfd inode level. I am working
on a follow up patch on top of this patch, and will send that out in a few
days (along with the man page updates).

thanks!

 - Joel
