Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD769C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71692080A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="igRa5A0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfABX2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 18:28:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40330 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfABX2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 18:28:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so15821011pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 15:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QC3KDRNg78ZjCdaYRzmXMg4fN3X9D3EMFOzaXBEjkuk=;
        b=igRa5A0O7uVPEiWOEJan6YaUgB5SS6IuRI9x2VZOPWVLf6Wz5CQpZpRf26GfeCQFDF
         3NNmjS3UBgpTHzBePe+eK9cjALqpp9j+nzrwa+4jKXupfNPvn4OUVf1pp/rdCglVpJ0c
         /5TYHRopo0wmfdT6XBRBA84G01+9bp3im1A4lD2adIuWXMIBXvMleCuBhqPpODTSjflg
         SLIEYuA7NRu7MfYT0/tvnqNP5eqwbXZu14uknISmijGHxCMIMESgq1o2sG4kpig9thLr
         VJgC9lq0pQA/IBJMJDAEFSaVoBspDQEb+wMdguFYQutP0gjdnX+vcTkuKOtBFELaQh2R
         B9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QC3KDRNg78ZjCdaYRzmXMg4fN3X9D3EMFOzaXBEjkuk=;
        b=GBkTidXVEPxY56v31k9KFnSVEBpSiUbtR2qP9wDzldrf8HxxsKg0BQyhgJYDH8fEJX
         oEzlCdP34URTl3wBaEJw00T52PiSOgnnIx+fN6g2l4bJE4avwiwBtwkuZkoTA7OM2mWY
         Na/UmOCm5qjOpmtqR4ZzgV/8fl7x6f3CfzSEw7JccT0WHH+3p15xRCzteY0fZ6xWEpUA
         /Ry9FJSmF3D2kDlesP+2J5WvxIje+kdNZgI+koh99NM43+hwkKjyfMHksgnCNGGeNSar
         aMyR8Ftb2+tIF8ZU/YkBJRGZcMftz0MqAfUKuxnUxf7HMp+MNtKAaNnV+zJothLBLsRI
         fqNA==
X-Gm-Message-State: AJcUukdMErC97qboZ+lKwvzyO+DglyreQaLsp+B6+AKdsQH/gA9qwI4S
        oUgoHjxDBJOzXS7FdwQJQKp3tQ==
X-Google-Smtp-Source: AFSGD/VVXyV29wFyP7Xgzmj6FlY4dbgvnTKwAVYfonD2JKyzkZ6fWayUmt4XLW93NJbpfcFF0OtddA==
X-Received: by 2002:a62:868b:: with SMTP id x133mr48570543pfd.252.1546471691085;
        Wed, 02 Jan 2019 15:28:11 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 186sm106375178pga.36.2019.01.02.15.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 15:28:10 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gepvl-0007o5-2v; Wed, 02 Jan 2019 16:28:09 -0700
Date:   Wed, 2 Jan 2019 16:28:09 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband/qedr: Potential null ptr dereference of qp
Message-ID: <20190102232809.GA29987@ziepe.ca>
References: <20181224182445.21256-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224182445.21256-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 12:24:45PM -0600, Aditya Pakki wrote:
> idr_find() may fail and return a NULL pointer. The fix checks the
> return value of the function and returns an error in case of NULL.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> Acked-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-rc thanks

Jason
