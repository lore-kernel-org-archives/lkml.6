Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C0DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E3420869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b67N66qY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E3420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeJPTrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:47:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39132 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeJPTrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:47:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id d15-v6so21022244edq.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 04:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gIQobr/MsuX+iW/Aneb0dR7d9vo4B4vgjtKsuW0y+m4=;
        b=b67N66qYzFcvR1ujwdnBHc6PERhJG4Z8leXGV4xRjZMY7RzWbgDNx7UVOrk5tGIId+
         QMj8/S+WicAwj+FQkzwGdUjNVKBedWurP+TdFLANrs7lclpFwnlUHaGXYg02jqJgyMx2
         WEO00qqTJnGRgGJAjgAUB/Dt6izQWCkie0WGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIQobr/MsuX+iW/Aneb0dR7d9vo4B4vgjtKsuW0y+m4=;
        b=WbZjqSC/4/Oe1dBuEfJPPmElxupznraRSChf7JZx5lumW72xnT4pdTdQAKkgzXFkcp
         8+hxzMEE7Zmmldw4B0+zRdmlWTyZhdVlWpOsRC8iMj+zvRyAj5PTbGB16if2pzdSh9bA
         X6/1NG0Bi1TJ7XgFdAN2323vGDQhCB8IHoG8Ex7NjlFWhZWnjNk3pmcJ7cTr27TyWtUG
         2CZXFEU4CvrVNA8g7bMVKTozSsIxcH6yCKd+ciysO/EKNbW1xUoRcVE6w252QXBCAXGw
         t85syasmwmO8WX0xNgH4lPJQK/itQJL77rPbbDeXbJ7q8EIQfQw8u8b7Hdj8XQ+oFmhC
         9+Uw==
X-Gm-Message-State: ABuFfoh/IKMtI0Vgn58AwYipRRo0FJHQt2b/qQ/+s0eov/Y4DpDvg4gb
        LAEsOrT55G8UBK8yM/Skm+/Q7IFHPXXX3ok8+9YJlg==
X-Google-Smtp-Source: ACcGV62wdy0YGQQBuf8dgPdOjkT3Jtszr0cKXYa20ouTg026mFdjyGdWn2lV3sKClHq2r1fB7IY9w2+/Duo7QGa2slk=
X-Received: by 2002:a17:906:4054:: with SMTP id y20-v6mr23192497ejj.30.1539691025160;
 Tue, 16 Oct 2018 04:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <1538850861-26882-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1538850861-26882-1-git-send-email-wang6495@umn.edu>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Tue, 16 Oct 2018 17:26:54 +0530
Message-ID: <CAL2rwxqeeJgSz=DePWZvh8sr15MJK8Gqta7EbfjwAUMUcvvMJA@mail.gmail.com>
Subject: Re: [PATCH] scsi: megaraid_sas: fix a missing-check bug
To:     wang6495@umn.edu
Cc:     kjlu@umn.edu, Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "James E. J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 7, 2018 at 12:04 AM Wenwen Wang <wang6495@umn.edu> wrote:
>
> In megasas_mgmt_compat_ioctl_fw(), to handle the structure
> compat_megasas_iocpacket 'cioc', a user-space structure megasas_iocpacket
> 'ioc' is allocated before megasas_mgmt_ioctl_fw() is invoked to handle the
> packet. Since the two data structures have different fields, the data is
> copied from 'cioc' to 'ioc' field by field. In the copy process,
> 'sense_ptr' is prepared if the field 'sense_len' is not null, because it
> will be used in megasas_mgmt_ioctl_fw(). To prepare 'sense_ptr', the
> user-space data 'ioc->sense_off' and 'cioc->sense_off' are copied and saved
> to kernel-space variables 'local_sense_off' and 'user_sense_off'
> respectively. Given that 'ioc->sense_off' is also copied from
> 'cioc->sense_off', 'local_sense_off' and 'user_sense_off' should have the
> same value. However, 'cioc' is in the user space and a malicious user can
> race to change the value of 'cioc->sense_off' after it is copied to
> 'ioc->sense_off' but before it is copied to 'user_sense_off'. By doing so,
> the attacker can inject different values into 'local_sense_off' and
> 'user_sense_off'. This can cause undefined behavior in the following
> execution, because the two variables are supposed to be same.
>
> This patch enforces a check on the two kernel variables 'local_sense_off'
> and 'user_sense_off' to make sure they are the same after the copy. In case
> they are not, an error code EINVAL will be returned.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 9aa9590..f6de752 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -7523,6 +7523,9 @@ static int megasas_mgmt_compat_ioctl_fw(struct file *file, unsigned long arg)
>                 get_user(user_sense_off, &cioc->sense_off))
>                 return -EFAULT;
>
> +       if (local_sense_off != user_sense_off)
> +               return -EINVAL;
> +
>         if (local_sense_len) {
>                 void __user **sense_ioc_ptr =
>                         (void __user **)((u8 *)((unsigned long)&ioc->frame.raw) + local_sense_off);

Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> --
> 2.7.4
>
