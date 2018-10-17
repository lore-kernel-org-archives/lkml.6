Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59472ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB4A21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EU3G2Elc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB4A21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeJQUDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:03:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbeJQUDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=INthpbZcLMtOLXqHlawkIhN/DbRyhVWYqCFt/3e1ceY=; b=EU3G2ElcsM8cnxl+IeHs5JSOB
        ZJNg5lndXqe1xKDAfksa6ghs01HzoIiRe0th8sO8GXlFsfqB6nIy+JoK4vI1dNj6v8X6SU8jAO4uD
        5fePp3r/ximdVrTjtyhpY20srB9iC6rLrGfStpPEYPSmhLev0oGfRKjxA54GHYZvs/luJDnn8Y4wJ
        84EvL3wV/TxX2SuXlJ2mdI43IpyuDzk1BkFr39ZADtGEa13KSIEhsuDHRqDQQ39sAnUzpxDZ8T97m
        af2yOZ0tNf0zDy50r/3nN72mBD1XZFNjdIcGRLry0d95/DJ7L1v5UbjH9tdAMQCqHOmuTcvQdbUsr
        CuK+G/AcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCkco-00008F-3d; Wed, 17 Oct 2018 12:08:30 +0000
Date:   Wed, 17 Oct 2018 05:08:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
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
Message-ID: <20181017120829.GA19731@infradead.org>
References: <20181009222042.9781-1-joel@joelfernandes.org>
 <20181017095155.GA354@infradead.org>
 <20181017103958.GB230639@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017103958.GB230639@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 03:39:58AM -0700, Joel Fernandes wrote:
> > > This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> > > To support the usecase, this patch adds a new F_SEAL_FS_WRITE seal which
> > > prevents any future mmap and write syscalls from succeeding while
> > > keeping the existing mmap active. The following program shows the seal
> > > working in action:
> > 
> > Where does the FS come from?  I'd rather expect this to be implemented
> > as a 'force' style flag that applies the seal even if the otherwise
> > required precondition is not met.
> 
> The "FS" was meant to convey that the seal is preventing writes at the VFS
> layer itself, for example vfs_write checks FMODE_WRITE and does not proceed,
> it instead returns an error if the flag is not set. I could not find a better
> name for it, I could call it F_SEAL_VFS_WRITE if you prefer?

I don't think there is anything VFS or FS about that - at best that
is an implementation detail.

Either do something like the force flag I suggested in the last mail,
or give it a name that matches the intention, e.g F_SEAL_FUTURE_WRITE.

> I could make it such that this seal would not be allowed unless F_SEAL_SHRINK
> and F_SEAL_GROW are either previously set, or they are passed along with this
> seal. Would that make more sense to you?

Yes.

> > >  static int memfd_add_seals(struct file *file, unsigned int seals)
> > >  {
> > > @@ -219,6 +220,9 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
> > >  		}
> > >  	}
> > >  
> > > +	if ((seals & F_SEAL_FS_WRITE) && !(*file_seals & F_SEAL_FS_WRITE))
> > > +		file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
> > > +
> > 
> > This seems to lack any synchronization for f_mode.
> 
> The f_mode is set when the struct file is first created and then memfd sets
> additional flags in memfd_create. Then later we are changing it here at the
> time of setting the seal. I donot see any possiblity of a race since it is
> impossible to set the seal before memfd_create returns. Could you provide
> more details about what kind of synchronization is needed and what is the
> race condition scenario you were thinking off?

Even if no one changes these specific flags we still need a lock due
to rmw cycles on the field.  For example fadvise can set or clear
FMODE_RANDOM.  It seems to use file->f_lock for synchronization.
