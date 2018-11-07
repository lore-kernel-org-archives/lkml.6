Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B23C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A3B2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z59vj1zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A3B2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeKHCsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:48:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeKHCsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NNpnCzR2QQAKynW5TjEUeevcpIewY978IDwI5s4Vbz0=; b=Z59vj1zsAjVNV1ghlaFOe+ASb
        IysUvia6w6DjGBxTrmQqJh0KhFl6XpaALPIC1cOWB913TjzPfmMkulicnHeWEV3/pTGgLSOjZJ9eV
        p7gwiIwXIG4a0bRq00F/xoAtSbY4wsl5FuRnEhNvusxFepZiW4aujAIXZwUuFNXWuPH2aKUCK1bsK
        SKbYvAluc9UUWztRrQm2VnRJ94Ngoo+dkQWcvEOx/u32ybzXPd7qvlJGMXY+T2qsKHAOG75jCF/bS
        oqvsafSb4fhnkgrj5zgfnUQbK8OaXPSXML/ok+JOXsgMF76VdAUflJTclAj2F3zg5CzesHr8AmbhM
        9FsGT0dsA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKRRc-0007zB-67; Wed, 07 Nov 2018 17:16:44 +0000
Date:   Wed, 7 Nov 2018 09:16:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel@vger.kernel.org, timmurray@google.com,
        joelaf@google.com, surenb@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
Message-ID: <20181107171644.GK3074@bombadil.infradead.org>
References: <20181031150625.147369-1-dancol@google.com>
 <20181105132205.138695-1-dancol@google.com>
 <20181106060113.GA4499@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106060113.GA4499@rapoport-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 08:01:13AM +0200, Mike Rapoport wrote:
> > diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> > index 12a5e6e693b6..0b14460f721d 100644
> > --- a/Documentation/filesystems/proc.txt
> > +++ b/Documentation/filesystems/proc.txt
> > @@ -125,6 +125,13 @@ process running on the system, which is named after the process ID (PID).
> >  The link  self  points  to  the  process reading the file system. Each process
> >  subdirectory has the entries listed in Table 1-1.
> >  
> > +Note that an open a file descriptor to /proc/<pid> or to any of its

"open file descriptor" (the "a" is unnecessary)

> > +contained files or subdirectories does not prevent <pid> being reused
> > +for some other process in the event that <pid> exits. Operations on
> > +open /proc/<pid> file descriptors corresponding to dead processes
> > +never act on any new process that the kernel may, through chance, have
> > +also assigned the process ID <pid>. Instead, operations on these FDs
> > +usually fail with ESRCH.

The paragraph is a bit wordy.  More pithy:

An open file descriptor for /proc/<pid> (or any of the files or
subdirectories in it) does not prevent <pid> from being reused after
the process exits.  Operations on a file descriptor referring to a dead
process usually return ESRCH.  They do not act on any new process which
has been assigned the same <pid>.
