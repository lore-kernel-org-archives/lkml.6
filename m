Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A161C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D40C21850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IiQe15jC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeLSDDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:03:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35418 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSDDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 22:03:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so8787151plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 19:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=skcC9yTKN6OhykAwH0gk1qJQnKNaZMTmHaA2t5VlfTE=;
        b=IiQe15jCnrcrN2RuDm6w1R6UFlKqly/R226l4g8wbnHemiNuIO8YluCKcMJYNj4/iy
         w2oIAjNdtLivXA2enG+p4opYwRbHs5NPU4xT1KFmdoJkwEM3GGYMguirCQMCep5yENAW
         bD1YAIPJ7tVSK2Fmokg/iXAdPtejyrRYQhgJvqmsleR0+AC6uG+kPsaouvWP5QV/Df4m
         2mQitqXftpYpBZ0kcVP26whYxM+1OhZIS1mbVuvkICwxVYYw6WVEZlb1tx3Hf9naXTxk
         Swmfc+XmWxRzQxQP2wjWz8IN4f/s7y6lWAKhZkprI6hCnFFJc6kl4m1zQ9BQHqZPzSyb
         4zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=skcC9yTKN6OhykAwH0gk1qJQnKNaZMTmHaA2t5VlfTE=;
        b=JtmEqKNOeMwbqFk1dl6WpWz2Cv24R0tJVjXXSNb0h330Uq1xt+BWLg0b93nbq7F8wv
         I3mw6vfc6wFrX5VY86vYouShhCPgTukp5GERLVvIqTZzW5qnPWzbHw0LTYs6PEGQDEiy
         MN06FOn+8k/0oXjvwhY+9RUUvPJDTluvuLCYSoJEWP/MmDx4/9oaVrLWQZ1jtgcMwCa8
         I7dSEaXh8SbFTN2U1EHBZcEa8J3ekuC4baT23Ezr1bSa/9AjWw//1P2gzLMI0t4zh07A
         U4mEawtwrSDsDrVPYayOZ5RpuzoCnRbOB8hOshk9C7FJRkb1qEoxWKC6eeMxt5VQ94Nz
         oitg==
X-Gm-Message-State: AA+aEWbHMy1bZidRO4n4JyFUhAiQmA3CCKG35eJwtKWEMcXqYLMb5/Oc
        v179tsdD1M5vK0qKZCamAJ+vtA==
X-Google-Smtp-Source: AFSGD/WN1kLoraaguNMwBDHiPRF4PS1qLKupwrAgA424341deQL5mi6oFVgLEN9YueuOJmNP9I5BdQ==
X-Received: by 2002:a17:902:c85:: with SMTP id 5mr19096484plt.339.1545188611688;
        Tue, 18 Dec 2018 19:03:31 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id b26sm35017680pfe.91.2018.12.18.19.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 19:03:30 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gZS8v-0003uX-I6; Tue, 18 Dec 2018 20:03:29 -0700
Date:   Tue, 18 Dec 2018 20:03:29 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181219030329.GI21992@ziepe.ca>
References: <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <20181212214641.GB29416@dastard>
 <20181214154321.GF8896@quack2.suse.cz>
 <20181216215819.GC10644@dastard>
 <20181218103306.GC18032@quack2.suse.cz>
 <20181218234254.GC31274@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218234254.GC31274@dastard>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 10:42:54AM +1100, Dave Chinner wrote:

> Essentially, what we are talking about is how to handle broken
> hardware. I say we should just brun it with napalm and thermite
> (i.e. taint the kernel with "unsupportable hardware") and force
> wait_for_stable_page() to trigger when there are GUP mappings if
> the underlying storage doesn't already require it.

If you want to ban O_DIRECT/etc from writing to file backed pages,
then just do it.

Otherwise I'm not sure demanding some unrealistic HW design is
reasonable. ie nvme drives are not likely to add page faulting to
their IO path any time soon.

A SW architecture that relies on page faulting is just not going to
support real world block IO devices.

GPUs and one RDMA are about the only things that can do this today,
and they are basically irrelevant to O_DIRECT.

Jason
