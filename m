Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbeCTQwG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:52:06 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46818 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCTQwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:52:01 -0400
X-Google-Smtp-Source: AG47ELsGJQsI2lwUuawyx4HZfEfdc5eLJkGjsR0P5Mql5CX10qpUK5NZzB1HMfUfGri4GZWdM1koDw==
Message-ID: <1521564718.13995.1.camel@redhat.com>
Subject: Re: [PATCH v4 1/7] scsi: hpsa: Eliminate duplicate barriers on
 weakly-ordered archs
From: Laurence Oberman <loberman@redhat.com>
To: Sinan Kaya <okaya@codeaurora.org>, linux-scsi@vger.kernel.org,
        timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-kernel@vger.kernel.org
Date: Tue, 20 Mar 2018 12:51:58 -0400
In-Reply-To: <1521514207-10695-2-git-send-email-okaya@codeaurora.org>
References: <1521514207-10695-1-git-send-email-okaya@codeaurora.org>
         <1521514207-10695-2-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-19 at 22:50 -0400, Sinan Kaya wrote:
> Code includes wmb() followed by writel(). writel() already has a
> barrier on some architectures like arm64.
> 
> This ends up CPU observing two barriers back to back before executing
> the register write.
> 
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/scsi/hpsa.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/hpsa.h b/drivers/scsi/hpsa.h
> index 018f980..c7d7e6a 100644
> --- a/drivers/scsi/hpsa.h
> +++ b/drivers/scsi/hpsa.h
> @@ -599,7 +599,7 @@ static unsigned long
> SA5_ioaccel_mode1_completed(struct ctlr_info *h, u8 q)
>  		 * but with current driver design this is easiest.
>  		 */
>  		wmb();
> -		writel((q << 24) | rq->current_entry, h->vaddr +
> +		writel_relaxed((q << 24) | rq->current_entry, h-
> >vaddr +
>  				IOACCEL_MODE1_CONSUMER_INDEX);
>  		atomic_dec(&h->commands_outstanding);
>  	}

This looks like it would work for the x86_64 and arm because of how its
defined architecture specific for the x86_64 and the arm64

I guess its up to Don and the driver folks and if its worth the change.
I am generally not a fan of messing with these barrier things though.

Reviewed-by: Laurence Oberman <loberman@redhat.com>
