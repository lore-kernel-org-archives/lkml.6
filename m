Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4952ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785A0214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="l7wcJtTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785A0214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJQSfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:35:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45035 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeJQSfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:35:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id p25-v6so12486169pli.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=20XLGh+wl6wYfEjrd60GEa6/zAKWSBNJE49uyQDUgqs=;
        b=l7wcJtTcnneuVqFC+1izIEZiJ+lFGlcKSDWa2MAqsSQJTmFpdVFXKOESGhXw/i637w
         rjIjrfCuJYrKBELe7VCeESBY7hs0bl9s1G37cKskfu40rDXY2TyCTt1GBOfUL/kAxUW9
         6iYV+jvlu6o239O08tKPMCOqFEvf4cgmisILY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=20XLGh+wl6wYfEjrd60GEa6/zAKWSBNJE49uyQDUgqs=;
        b=sHHmKVvxD5TzGmMhq3B7zjrlS0xvryBj0kgZZXoVXpB3AfKLIEbNxi+FKarYxoGm1M
         8JbT+zyESHLn1jZCnSumBBa6/mB4o2H10vmNqUYdrLBRUTR70/qRc4BgFskbD4/pKMqV
         01IYSTO701vIHzfxpf0CZxDL0e0yX/SFANCQIagn8E0uJ9aEsx9nT6+2NsvZahkFL5mc
         F+GWMLTUkNA8swo7udwUtB8Om0qxAi8S8q5RXyqR2718oHNYuiwjVMUruT+NQC50aSeK
         zZ8199yVX+O8wkRKPy1TTeCiaYT68mZW2NN9VntQAeviV8hiv8heT3vVmyJUKfiKqZtb
         29sw==
X-Gm-Message-State: ABuFfog21996F79yt0QUxPw8OZxEwG1jllGsk4iEi13eCnW+1g00KHaM
        2Tgdzh2sbdJN5lT8lSRr5sWmxg==
X-Google-Smtp-Source: ACcGV61gJPpfy7XOZMUbu6/6Jxgt2BLQUQGEuWEfViheVH6OTQJdjBSHSbOBLbma/05yEW3UIZxBRA==
X-Received: by 2002:a17:902:be01:: with SMTP id r1-v6mr24631972pls.143.1539772801140;
        Wed, 17 Oct 2018 03:40:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id v33-v6sm4946172pgn.57.2018.10.17.03.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 03:39:59 -0700 (PDT)
Date:   Wed, 17 Oct 2018 03:39:58 -0700
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
Message-ID: <20181017103958.GB230639@joelaf.mtv.corp.google.com>
References: <20181009222042.9781-1-joel@joelfernandes.org>
 <20181017095155.GA354@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017095155.GA354@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 02:51:55AM -0700, Christoph Hellwig wrote:
> On Tue, Oct 09, 2018 at 03:20:41PM -0700, Joel Fernandes (Google) wrote:
> > One of the main usecases Android has is the ability to create a region
> > and mmap it as writeable, then drop its protection for "future" writes
> > while keeping the existing already mmap'ed writeable-region active.
> 
> s/drop/add/ ?
> 
> Otherwise this doesn't make much sense to me.

Sure, you are right that "add" is more appropriate. I'll change it to that.

> > This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> > To support the usecase, this patch adds a new F_SEAL_FS_WRITE seal which
> > prevents any future mmap and write syscalls from succeeding while
> > keeping the existing mmap active. The following program shows the seal
> > working in action:
> 
> Where does the FS come from?  I'd rather expect this to be implemented
> as a 'force' style flag that applies the seal even if the otherwise
> required precondition is not met.

The "FS" was meant to convey that the seal is preventing writes at the VFS
layer itself, for example vfs_write checks FMODE_WRITE and does not proceed,
it instead returns an error if the flag is not set. I could not find a better
name for it, I could call it F_SEAL_VFS_WRITE if you prefer?

> > Note: This seal will also prevent growing and shrinking of the memfd.
> > This is not something we do in Android so it does not affect us, however
> > I have mentioned this behavior of the seal in the manpage.
> 
> This seems odd, as that is otherwise split into the F_SEAL_SHRINK /
> F_SEAL_GROW flags.

I could make it such that this seal would not be allowed unless F_SEAL_SHRINK
and F_SEAL_GROW are either previously set, or they are passed along with this
seal. Would that make more sense to you?

> >  static int memfd_add_seals(struct file *file, unsigned int seals)
> >  {
> > @@ -219,6 +220,9 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
> >  		}
> >  	}
> >  
> > +	if ((seals & F_SEAL_FS_WRITE) && !(*file_seals & F_SEAL_FS_WRITE))
> > +		file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
> > +
> 
> This seems to lack any synchronization for f_mode.

The f_mode is set when the struct file is first created and then memfd sets
additional flags in memfd_create. Then later we are changing it here at the
time of setting the seal. I donot see any possiblity of a race since it is
impossible to set the seal before memfd_create returns. Could you provide
more details about what kind of synchronization is needed and what is the
race condition scenario you were thinking off?

thanks for the review,

 - Joel

