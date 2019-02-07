Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F54BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C16218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O6JuEwwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfBGFdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:33:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36153 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfBGFdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 00:33:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so4286106plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 21:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1dhO9WZwCYTMt9fJvM1nNU2p7dvIM4HOJh/eYKYBoFs=;
        b=O6JuEwwu6hKxxjXIys11QD16tgPe+A/2DnTr+z70AF3t0OVv1xdrIWoLuBKwz7HbIf
         iK+grMOhLiKkNbqOjg5yXtOoS4+o+jyUzZun6Nii5nU6IzXwJNZl1sWS+zC5vGNdbQ9N
         Q1jQHPwzNejWMzbh1nqmfapYsNafb5dvk/ipc36uEXNaD4va1okaOSVX+enNwIWTzdoV
         TAuJCe+EfVZna2FV4lI+R69LJDjhKWFr5CNS4i3vmw9NTidXYJviCPvM55UC+Eq4Z5Dc
         J5Mr45BsFeby+nhsnN//IzTSVyqB5FTN1uph3WPH9WKxgnp6M8RPR9qTpXPrgyb64Ivg
         vngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1dhO9WZwCYTMt9fJvM1nNU2p7dvIM4HOJh/eYKYBoFs=;
        b=RLbYuExSyblLVIorisX/z1SwHmVodlbhVd5QD4WfAZGPoDFJo50qR3K1KRyctWbuW+
         vBC7SxsbQCzJPg6SVdfx4yPeltOJ49SFZugECvQfQ/1XAZ/wTX1ccy8RlB1ajrkqy3tz
         Is9eSEozMluR6CkyvPUyzRsHbXNe87o71cY+JruUNweyrn1NtXa/odBoAPHTJv+HcAcE
         wTCcwiFFL0rk3FkzGG3TsgMp32SlhZYUmDktMD1buVa3IzgePZb4WR/ozn5WHFzVr+8F
         rq8Gx5TmNyO9JqL7wPjFM7/ZkWqo1j1akPwFJ6rqZvsnl98VwPiLeUt5oPbMqmMR3TZn
         yy9A==
X-Gm-Message-State: AHQUAuZz3TJo30A0WTiFQFqXhsQ/zYQXb2lfgaV0987UywLRMWq4LW1g
        hCZnyDnVPGAYb+ogLc/O9w9vJQ==
X-Google-Smtp-Source: AHgI3IbyZL2bQvLtIVzm60K+WCG18pBAkuTCrejV7d1gkE6Wvzsqz9paL7ZhpctoTkIDp+YArLkIEA==
X-Received: by 2002:a17:902:722:: with SMTP id 31mr14770884pli.271.1549517588507;
        Wed, 06 Feb 2019 21:33:08 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 196sm22681710pfc.77.2019.02.06.21.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 21:33:07 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1grcJ9-00067N-8V; Wed, 06 Feb 2019 22:33:07 -0700
Date:   Wed, 6 Feb 2019 22:33:07 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190207053307.GB22726@ziepe.ca>
References: <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard>
 <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <20190206232130.GK12227@ziepe.ca>
 <CAPcyv4g2r=L3jfSDoRPt4VG7D_2CxCgv3s+JLu4FQRUSRWg+4Q@mail.gmail.com>
 <20190206234132.GB15234@ziepe.ca>
 <CAPcyv4h1=GTAqHBw+Zsp9eNYR3HFbB_qjmhntwnO-jyGun4QNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h1=GTAqHBw+Zsp9eNYR3HFbB_qjmhntwnO-jyGun4QNA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:22:16PM -0800, Dan Williams wrote:
> On Wed, Feb 6, 2019 at 3:41 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> [..]
> > > You're describing the current situation, i.e. Linux already implements
> > > this, it's called Device-DAX and some users of RDMA find it
> > > insufficient. The choices are to continue to tell them "no", or say
> > > "yes, but you need to submit to lease coordination".
> >
> > Device-DAX is not what I'm imagining when I say XFS--.
> >
> > I mean more like XFS with all features that require rellocation of
> > blocks disabled.
> >
> > Forbidding hold punch, reflink, cow, etc, doesn't devolve back to
> > device-dax.
> 
> True, not all the way, but the distinction loses significance as you
> lose fs features.
> 
> Filesystems mark DAX functionality experimental [1] precisely because
> it forbids otherwise typical operations that work in the nominal page
> cache case. An approach that says "lets cement the list of things a
> filesystem or a core-memory-mangement facility can't do because RDMA
> finds it awkward" is bad precedent. 

I'm not saying these rules should apply globaly.

I'm suggesting you could have a FS that supports gup_longterm by
design, and a FS that doesn't. And that is OK. They can have different
rules.

Obviously the golden case here is to use ODP (which doesn't call
gup_longterm at all) - that works for both.

Supporting non-ODP is a trade off case - users that want to run on
limited HW must accept limited functionality. Limited functionality is
better than no-funtionality.

Linux has many of these user-choose tradeoffs. This is how it supports
such a wide range of HW capabilities. Not all HW can do all
things. Some features really do need HW support. It has always been
that way.

Jason
