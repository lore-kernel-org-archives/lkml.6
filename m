Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeEaTPu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 15:15:50 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46656 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754071AbeEaTPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 15:15:46 -0400
X-Google-Smtp-Source: ADUXVKIpqNNnvyMCBcryT1taM0Czjn5i+4kA9L+41+4SRCxSfZF7nssGtmB9/0k3Zs77i6Mjc5GYS1IBuaqrWH3M7cI=
MIME-Version: 1.0
In-Reply-To: <1527791294-21600-1-git-send-email-melnichenko@ispras.ru>
References: <1527791294-21600-1-git-send-email-melnichenko@ispras.ru>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 22:15:45 +0300
Message-ID: <CAHp75VdAWzAB1K3bGEAgM28ZZFYa-92JqERy=jKd1Fc_738eBg@mail.gmail.com>
Subject: Re: [PATCH] aic94xx: set error code on an error path in aic94xx_init
To: Peter Melnichenko <melnichenko@ispras.ru>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 9:28 PM, Peter Melnichenko
<melnichenko@ispras.ru> wrote:
> When sas_domain_attach_transport returns NULL, aic94xx_init
> frees acquired resources but returns err equal to 0, as
> assigned by a previous statement.
>
> The patch sets err to -ENOMEM before jumping to the error label.

Wouldn't be better to fix a callee to return proper error code and...

>         aic94xx_transport_template =
>                 sas_domain_attach_transport(&aic94xx_transport_functions);
> -       if (!aic94xx_transport_template)
> +       if (!aic94xx_transport_template) {
> +               err = -ENOMEM;
>                 goto out_destroy_caches;
> +       }

this becomes

err = _attach_();
if (err < 0)
 goto ;
_template = err;

?

-- 
With Best Regards,
Andy Shevchenko
