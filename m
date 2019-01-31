Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94D7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D2F20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="b5GUbtW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfAaSXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:23:45 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38365 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfAaSXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:23:45 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so3388826ede.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3kKnYCZxaOl+LKcbycFNrKujZW9Tg4jDb8LtbcdDLSw=;
        b=b5GUbtW7MhAlicI5s0cgkMZ0ZcpEhGZliGBO/xRLBz3mcv59Y+rSyqpGt95Zwd8Cfa
         nB4b6js3PgMn4oxSLp1TMz6khmPOIuR3MfgKp5L2MwIRw9RBdeZP1rISOY9WX5yz4qRB
         aR6KhDajLQvKGyR2GwRafxFaAp+IM9AwR60+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3kKnYCZxaOl+LKcbycFNrKujZW9Tg4jDb8LtbcdDLSw=;
        b=oozLeANS49cOck6R/6O/9CXWtVNTCSZ9XdEngl7YVKL/Yn663E0VQ2gqlKZznnNK9I
         qMgg2SP1MF7jjAxGUmtRwJIicggkRzrqnxn39xjK2ytIs1LqpcLN9He1fUk5m/588bOP
         vEsuJl3GomEoT25GjP1h6gRkXC3nQTp77SqmhvHOUc+Ct4tyuRXNWKkoG7XoB0jNzP4a
         g80giZEzyqk5yx3qarV2NcLrqpuD6rLaCFqg0CO4E4pn/2xphRpyXOuLyau3QeBos+7l
         MCGRxhRH8eLYP2a20fxc5fpDnitUCJx1w4Z7n8eBZ6otGOk+sY6tDub8y4Am9Zj4X5BO
         5pPg==
X-Gm-Message-State: AJcUukfdWa5hT1A29/shYx4yYFjH8UAtYAZsRXgAf6S/Rbx1KvR6GXfk
        Y9Waxaaj85TDp0GQmA5/PhIoDw==
X-Google-Smtp-Source: ALg8bN4owv1fL3L8hLNulH7OZ4Re0xTMsyE+2rCIiS5Ey9ESers0fFI1zyuYuvAxHergkttYtavuTw==
X-Received: by 2002:a50:9291:: with SMTP id k17mr35543939eda.243.1548959023158;
        Thu, 31 Jan 2019 10:23:43 -0800 (PST)
Received: from andrea ([91.253.220.247])
        by smtp.gmail.com with ESMTPSA id f31sm1512097eda.16.2019.01.31.10.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 10:23:42 -0800 (PST)
Date:   Thu, 31 Jan 2019 19:23:34 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Add missing memory barriers in afs_manage_cell()
Message-ID: <20190131182334.GA3847@andrea>
References: <20181126164412.11184-1-andrea.parri@amarulasolutions.com>
 <20190117153132.GA10932@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117153132.GA10932@andrea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 04:31:32PM +0100, Andrea Parri wrote:
> On Mon, Nov 26, 2018 at 05:44:12PM +0100, Andrea Parri wrote:
> > As the comments for wake_up_bit() and waitqueue_active() point out,
> > the barriers are needed to order the clearing of the _FL_NOT_READY
> > bit and the waitqueue_active() load; match the implicit barrier in
> > prepare_to_wait().
> > 
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> 
> Hi David, do you have any feedback on this?

ping


> 
>   Andrea
> 
> 
> > ---
> >  fs/afs/cell.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/afs/cell.c b/fs/afs/cell.c
> > index cf445dbd5f2e0..a9488abe56029 100644
> > --- a/fs/afs/cell.c
> > +++ b/fs/afs/cell.c
> > @@ -637,6 +637,7 @@ static void afs_manage_cell(struct work_struct *work)
> >  		cell->state = AFS_CELL_ACTIVE;
> >  		smp_wmb();
> >  		clear_bit(AFS_CELL_FL_NOT_READY, &cell->flags);
> > +		smp_mb__after_atomic(); /* see comment for wake_up_bit() */
> >  		wake_up_bit(&cell->flags, AFS_CELL_FL_NOT_READY);
> >  		goto again;
> >  
> > @@ -678,6 +679,7 @@ static void afs_manage_cell(struct work_struct *work)
> >  	cell->state = AFS_CELL_ACTIVE;
> >  	smp_wmb();
> >  	clear_bit(AFS_CELL_FL_NOT_READY, &cell->flags);
> > +	smp_mb__after_atomic(); /* see comment for wake_up_bit() */
> >  	wake_up_bit(&cell->flags, AFS_CELL_FL_NOT_READY);
> >  	_leave(" [deact->act]");
> >  	return;
> > -- 
> > 2.17.1
> > 
