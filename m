Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AE3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07F821872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MRoxCjVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfAWSd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:33:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45467 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfAWSdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:33:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so1569918plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 10:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DL3q+IUTyWeX3nP6URMGb0kr1tY0HYZhoeMEnZgMdlQ=;
        b=MRoxCjVDiMpMfRSuuTsMPA5eS5LdypuT1S2N03TZcMho7FQXUcqSoEaCerSl2mJSjA
         L3XXlEp+74C18MqYyGfU52SF5H+U6ImCqe+jaYEYH7ZVKXpJJnl7LQxStanFmrIweHS5
         /tBPeNphOUP8B2254pKoPEbLeZ1GjS0WNrviFe7UHab/ioTFcn+EnOyhQi9VbkbEjOig
         2IEXeZo0C2hgTWQPEovij6KTPPXLOhz6X2N6BvOl7lxVIdGJ/FoiuF9IoJCh7DHTD+T3
         FmErd6EGssWOCKW9HXk7eImFEe8AHlQBc6Ct7miwYIzNkUPa4wchu/ZDQvmKYJWC6SDb
         DjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DL3q+IUTyWeX3nP6URMGb0kr1tY0HYZhoeMEnZgMdlQ=;
        b=WoSzwDhWq0QG+ct2/WS2fYwWc+UajBBwbINWkayQGHzXCd2HG1EHBiplNMSBlP3C9W
         GY6agUCoX+0NN4mB/r78b21Zs+1EmFwYVrQK8amQdFcVouUDyDK0mPwuzUcjDEbFkwb8
         nEhxvViWBnVrmhKuD+TMCNBq+3z3uzl7kLfI7zUe2J1bumcGPME/LTrVFQLTgipxF9sp
         rmGErjb82plAPOBX4dOBpMyTCO/I7IvT+kCpmZU4cr/m2ISBmoOE3QiKQDVW7oYhaFon
         nmZXxQx/HgF85NNuP+3Ic37rSfY9nVSWAcpxX39YsSc7z5SCPoPLQ7VRvREp9p6R1JXN
         cM2A==
X-Gm-Message-State: AJcUukfirZPXTJr5janjzOprfuS2kPFDHlxg4ZhebFn3HOTJuJxVybli
        ++8rdOcPOSRmceiBPf7ahySAIQ==
X-Google-Smtp-Source: ALg8bN6D6auyCF7XfjhLDWY3Z0nqTfcDZippy5nFZCK123n23O0mDnr0DalQDRX5fxd/LfprIfuyPw==
X-Received: by 2002:a17:902:4225:: with SMTP id g34mr3384728pld.152.1548268435382;
        Wed, 23 Jan 2019 10:33:55 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id z8sm28599907pgg.62.2019.01.23.10.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 10:33:54 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gmNLV-00048Y-OT; Wed, 23 Jan 2019 11:33:53 -0700
Date:   Wed, 23 Jan 2019 11:33:53 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, dledford@redhat.com, jack@suse.de,
        ira.weiny@intel.com, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>,
        Christoph Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/6] mm: make mm->pinned_vm an atomic64 counter
Message-ID: <20190123183353.GA15768@ziepe.ca>
References: <20190121174220.10583-1-dave@stgolabs.net>
 <20190121174220.10583-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121174220.10583-2-dave@stgolabs.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 09:42:15AM -0800, Davidlohr Bueso wrote:
> Taking a sleeping lock to _only_ increment a variable is quite the
> overkill, and pretty much all users do this. Furthermore, some drivers
> (ie: infiniband and scif) that need pinned semantics can go to quite
> some trouble to actually delay via workqueue (un)accounting for pinned
> pages when not possible to acquire it.
> 
> By making the counter atomic we no longer need to hold the mmap_sem
> and can simply some code around it for pinned_vm users. The counter
> is 64-bit such that we need not worry about overflows such as rdma
> user input controlled from userspace.

I see a number of MM people Reviewed-by this so are we good to take
this in the RDMA tree now?

Regards,
Jason
