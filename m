Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32264ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DC72148E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="V5bmFaDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DC72148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeJRBmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:42:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36653 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeJRBmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:42:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id f18-v6so12891152pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SX5hrNTZK3elM1qxzw8VBVb4XgG7eX3IHAsodwpu4sY=;
        b=V5bmFaDR93O9IgBkIdvjnlYVcDk6WqhKZSMhMSnIbLt4+tQ3K96ZJEK1FFCnGjrU0t
         3JothcAuM+hvr8MyoIQDtxFLt3e+hjKXgVa1WPjf4Hb+pmnuzfC9uBUigvQDQyR35MI3
         WgOHVCP6UUmM9Fu0yMkcQD5xLfx3MKsj4E5vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SX5hrNTZK3elM1qxzw8VBVb4XgG7eX3IHAsodwpu4sY=;
        b=Y7fZ65MG7pzj8RIj5Q7o3E4+Hg9Fh6Yfbu2H0vggaVZOWaWi6Iq0WuLHGZaz394RZA
         eRxADAX96pATQsXHb6enCI/2vBQBEGQRMACUZQawYprdMnJGg2uHR5IRez1cP3dgInwS
         H1AQWxViqq2o1UBLsEAO4K3RuSgaU5/2q6t2vPxX/ktH01vp1D05B7YAjaHM6he2KnVu
         NklYkanyx2cGOkrnHThwVvuv7G9LRiMEauPR6BSpRwkWuxSw80iAsD1hTAT8k2LNeTg8
         8+1hPp+gq6dUs5uFl75o5aYukqg0RX56Ol3H6wmrYVgh+4ozpbhrvoD4p9abN6rmB9gu
         7tnA==
X-Gm-Message-State: ABuFfojEYlX4SYI94G0cdnQQwSvLz0bnmkJ1vbLqhMfDXp5WVvk2zQQP
        5LMJxKdfWZC8UGSwNBLS5fIo+Q==
X-Google-Smtp-Source: ACcGV60xiSBDM2vFO2oq7nUWp4OkLeTDSVSjDzsLFWdpY8RYa+sT+4nQyEcIAWgBZlZqm8kmFG5Ohw==
X-Received: by 2002:a63:1555:: with SMTP id 21-v6mr25055634pgv.383.1539798329785;
        Wed, 17 Oct 2018 10:45:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id k71-v6sm27651452pge.44.2018.10.17.10.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 10:45:28 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:45:27 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        jreck@google.com, john.stultz@linaro.org, tkjos@google.com,
        gregkh@linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>, dancol@google.com,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        minchan@google.com, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 1/2] mm: Add an F_SEAL_FS_WRITE seal to memfd
Message-ID: <20181017174527.GA107185@joelaf.mtv.corp.google.com>
References: <20181009222042.9781-1-joel@joelfernandes.org>
 <20181017095155.GA354@infradead.org>
 <20181017103958.GB230639@joelaf.mtv.corp.google.com>
 <20181017120829.GA19731@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017120829.GA19731@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 05:08:29AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 17, 2018 at 03:39:58AM -0700, Joel Fernandes wrote:
> > > > This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> > > > To support the usecase, this patch adds a new F_SEAL_FS_WRITE seal which
> > > > prevents any future mmap and write syscalls from succeeding while
> > > > keeping the existing mmap active. The following program shows the seal
> > > > working in action:
> > > 
> > > Where does the FS come from?  I'd rather expect this to be implemented
> > > as a 'force' style flag that applies the seal even if the otherwise
> > > required precondition is not met.
> > 
> > The "FS" was meant to convey that the seal is preventing writes at the VFS
> > layer itself, for example vfs_write checks FMODE_WRITE and does not proceed,
> > it instead returns an error if the flag is not set. I could not find a better
> > name for it, I could call it F_SEAL_VFS_WRITE if you prefer?
> 
> I don't think there is anything VFS or FS about that - at best that
> is an implementation detail.
> 
> Either do something like the force flag I suggested in the last mail,
> or give it a name that matches the intention, e.g F_SEAL_FUTURE_WRITE.
> 

Ok, I agree. I like the name F_SEAL_FUTURE_WRITE you are proposing so I will
use that.

> > I could make it such that this seal would not be allowed unless F_SEAL_SHRINK
> > and F_SEAL_GROW are either previously set, or they are passed along with this
> > seal. Would that make more sense to you?
> 
> Yes.

Cool.

> > > >  static int memfd_add_seals(struct file *file, unsigned int seals)
> > > >  {
> > > > @@ -219,6 +220,9 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
> > > >  		}
> > > >  	}
> > > >  
> > > > +	if ((seals & F_SEAL_FS_WRITE) && !(*file_seals & F_SEAL_FS_WRITE))
> > > > +		file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
> > > > +
> > > 
> > > This seems to lack any synchronization for f_mode.
> > 
> > The f_mode is set when the struct file is first created and then memfd sets
> > additional flags in memfd_create. Then later we are changing it here at the
> > time of setting the seal. I donot see any possiblity of a race since it is
> > impossible to set the seal before memfd_create returns. Could you provide
> > more details about what kind of synchronization is needed and what is the
> > race condition scenario you were thinking off?
> 
> Even if no one changes these specific flags we still need a lock due
> to rmw cycles on the field.  For example fadvise can set or clear
> FMODE_RANDOM.  It seems to use file->f_lock for synchronization.

Ok, I will acquire the f_lock before setting these, thanks for the
explanation. Will post updated patches today.

 - Joel

