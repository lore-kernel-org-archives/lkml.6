Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCFDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F272120652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O6Mqytgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfAQPbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:31:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35166 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfAQPbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:31:41 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so8706642edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 07:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g5nQozMppk8DZZa/5as2q1ELxnw4VUfa1KmQAedy0yk=;
        b=O6Mqytgky/RfbwIcMG4yXQUjH3BOLGz94nRWIQc4zvqoLXMdmqPnEoloP4yGNjA9lT
         ULZZr3J4ayw1EpOtaK9r6WYwKhhfWEJKTZ372Hu3eWH0xLCD8d/VgABwMGq05uYAzLdv
         yCyERVhswS0REKUH2qF8vj7wVrLWGLc8D+po0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g5nQozMppk8DZZa/5as2q1ELxnw4VUfa1KmQAedy0yk=;
        b=YkQUnhTqAY1key2+pafLdoCXt0y4FyePxd3uOKPCt+I1F+bNyLc/Ii04NjRPIBwbRw
         Nk676WZDavRxpJGYpojgtPA0bM5+RHZpzn2Li9NEYkxW8rO9/M26N3C1qWUmyO2UoOZ5
         341lRMUcM5Tcq/N30iEy8tk4Ag4ICROyFYS2DCUMzqXPpsuhJZsM7Tw78Z9x6nHaCPdn
         RSlxe19bb5g0/nsOAaRkbG5ZPD4c0Q5ErsbTZuVZ7xd2U2dk4Z9MoF9zcXDwpQQQaIps
         0OQik02NY+Jyz9enWOXB3rVFgcr2fxcqQBYXtgomWlxOZTGOCXYQbC34WIyKOTWejtFU
         velw==
X-Gm-Message-State: AJcUukevpNrQRgF6qyIKl5r4WzgCqpSX8u9891XKsqMFZV3B856oQF6W
        77rtiv0RYIbx1ZK1qhKpNdlqgA==
X-Google-Smtp-Source: ALg8bN7e+nlzm2+2MsxDFCruli4t9nzBpnV9NiCRw238gEdbOwM2SIjGICvPC0FlwsFxk07et/d+0g==
X-Received: by 2002:a50:903c:: with SMTP id b57mr12377573eda.161.1547739099271;
        Thu, 17 Jan 2019 07:31:39 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id v14sm6030650edq.74.2019.01.17.07.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 07:31:38 -0800 (PST)
Date:   Thu, 17 Jan 2019 16:31:32 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Add missing memory barriers in afs_manage_cell()
Message-ID: <20190117153132.GA10932@andrea>
References: <20181126164412.11184-1-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126164412.11184-1-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 05:44:12PM +0100, Andrea Parri wrote:
> As the comments for wake_up_bit() and waitqueue_active() point out,
> the barriers are needed to order the clearing of the _FL_NOT_READY
> bit and the waitqueue_active() load; match the implicit barrier in
> prepare_to_wait().
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Hi David, do you have any feedback on this?

  Andrea


> ---
>  fs/afs/cell.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/afs/cell.c b/fs/afs/cell.c
> index cf445dbd5f2e0..a9488abe56029 100644
> --- a/fs/afs/cell.c
> +++ b/fs/afs/cell.c
> @@ -637,6 +637,7 @@ static void afs_manage_cell(struct work_struct *work)
>  		cell->state = AFS_CELL_ACTIVE;
>  		smp_wmb();
>  		clear_bit(AFS_CELL_FL_NOT_READY, &cell->flags);
> +		smp_mb__after_atomic(); /* see comment for wake_up_bit() */
>  		wake_up_bit(&cell->flags, AFS_CELL_FL_NOT_READY);
>  		goto again;
>  
> @@ -678,6 +679,7 @@ static void afs_manage_cell(struct work_struct *work)
>  	cell->state = AFS_CELL_ACTIVE;
>  	smp_wmb();
>  	clear_bit(AFS_CELL_FL_NOT_READY, &cell->flags);
> +	smp_mb__after_atomic(); /* see comment for wake_up_bit() */
>  	wake_up_bit(&cell->flags, AFS_CELL_FL_NOT_READY);
>  	_leave(" [deact->act]");
>  	return;
> -- 
> 2.17.1
> 
