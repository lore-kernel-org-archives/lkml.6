Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05FAC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 05:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8A520896
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 05:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3AE/Rsv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Lf3/JTlA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8A520896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753962AbeFPFEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 01:04:36 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41763 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeFPFEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 01:04:34 -0400
Received: by mail-qk0-f193.google.com with SMTP id w23-v6so6817229qkb.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 22:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LtkncO6ICCujrX1d2Cbs7dsIf9AHKQGWi3jLxRLv5Kc=;
        b=S3AE/RsvjeB4RBlg+0KqC1Etxcv6vLldWnBOW8PHDRViquy7m37ZDtRYDqUBO60oyO
         C6JXedAsD1g1+8xDpNsdpHJvtnsuPxx/1pFgEZtGcZrqiemC3vf7K9muULfkvPiAQnwq
         XQ2DzmEBE4d2NlQcK1q58G+uT97QwnWTxJDyy7xZQzSo9/s6qs8BwkcL4J0P9nIAb+cX
         zn+OP2tDzYWdBinw7vRKzZWafABBWcfSJJ7nGj3LubLnV/Y7eY5EjV56tUKy578a/XpN
         DC90wAL7drynRt/HbwZUw93uZ7Z15hTHIsH3v5+fCtEI/qXjdz9p2Zx7dg8heN/fuWjg
         KyNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LtkncO6ICCujrX1d2Cbs7dsIf9AHKQGWi3jLxRLv5Kc=;
        b=Lf3/JTlAKP4EuznfSIFamAI5EDWvKEe4y++Vf3oPJ3JX9udbDndmgUKSCshx5f37Fd
         LvUCZxo2ZSfNoLbTBP0Z5RZEH74VnTg945k8rvXq2QBGqx2e3Fc70js8xcLzE5gqCGa5
         S9LwnE/HCvZSDbCjF9B5uCYpPSmgIJkXhXwzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LtkncO6ICCujrX1d2Cbs7dsIf9AHKQGWi3jLxRLv5Kc=;
        b=fgtVPZeihgAN2A6FqWwywMEBxNA5i1OkhSM0jTtYrdiBtPxIQmVzOMC4bTNcy/g8q4
         9QjdhwXzWm+qidH4uZ6hTVDiYPgytFSKSxINxH8SIMQNpJfV+fUzGuaKquadYPt5G0oQ
         ieX/TyCbga9DojqONonp4rEv/beCw7cDB/Op6DtMSnhLIHDrPK5QMl5F926qCeii+V8z
         4I0NaHiHU/1Hd83oyp69oiWBo94giwcUdGnUlU4XRfK/rpN4xsvhKo1WMjuVCY5OHqoH
         nBpqwtiT3HsWiCQHmjwYfFrDHWLP8dZaVSL+GEcG4DSgq/rZTIpGKrftR7SmF3aCANJg
         gQ9g==
X-Gm-Message-State: APt69E1rMXR9+iOO49esFKrcr2CNpFeaArJ6InZfmz2q/2+joh/cwKLx
        mR9VBCIE/84UEns5PNmsCg36yhydRgT/3vwPhF4awTPI
X-Google-Smtp-Source: ADUXVKJW9onEuTYqrFZ8x8csIVVmT9wb5XXShB3OggEGAF6Rjt6DAVQEX08gKwDAOCzG/016+Z0UmrZUZIE0d/IK5ic=
X-Received: by 2002:a37:6983:: with SMTP id e125-v6mr3672198qkc.352.1529125473860;
 Fri, 15 Jun 2018 22:04:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:184d:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 22:04:13
 -0700 (PDT)
In-Reply-To: <20180612051911.20690-6-benh@kernel.crashing.org>
References: <20180612051911.20690-1-benh@kernel.crashing.org> <20180612051911.20690-6-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Sat, 16 Jun 2018 14:34:13 +0930
X-Google-Sender-Auth: QJB4BN8AuqrPdoRVyWH9gVqYpa0
Message-ID: <CACPK8Xcp4gEVOrNdcZhbDx9LU1K6d=tV0vmJ9nLut4Fjwp0Xpg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] fsi/scom: Major overhaul
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 June 2018 at 14:49, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This was too hard to split ... this adds a number of features
> to the SCOM user interface:
>
>  - Support for indirect SCOMs
>
>  - read()/write() interface now handle errors and retries
>
>  - New ioctl() "raw" interface for use by debuggers
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Looks okay to me. I will put it in the openbmc tree with Eddie's ack
for more testing.

I got a warning from the 0day infra, I made comments below.

We should get Alistair review the ioctl interface to ensure we have
everything that pdbg might need.

> +++ b/include/uapi/linux/fsi.h
> @@ -0,0 +1,56 @@
> +#ifndef _UAPI_LINUX_FSI_H
> +#define _UAPI_LINUX_FSI_H
> +
> +#include <linux/ioctl.h>

This needs to include <linux/types.h> for the __u64 etc types.

We should also put a licence in the header. Probably:

/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */


Cheers,

Joel

> +
> +/*
> + * /dev/scom "raw" ioctl interface
> + *
> + * The driver supports a high level "read/write" interface which
> + * handles retries and converts the status to Linux error codes,
> + * however low level tools an debugger need to access the "raw"
> + * HW status information and interpret it themselves, so this
> + * ioctl interface is also provided for their use case.
> + */
> +
> +/* Structure for SCOM read/write */
> +struct scom_access {
> +       __u64   addr;           /* SCOM address, supports indirect */
> +       __u64   data;           /* SCOM data (in for write, out for read) */
> +       __u64   mask;           /* Data mask for writes */
> +       __u32   intf_errors;    /* Interface error flags */
> +#define SCOM_INTF_ERR_PARITY           0x00000001 /* Parity error */
> +#define SCOM_INTF_ERR_PROTECTION       0x00000002 /* Blocked by secure boot */
> +#define SCOM_INTF_ERR_ABORT            0x00000004 /* PIB reset during access */
> +#define SCOM_INTF_ERR_UNKNOWN          0x80000000 /* Unknown error */
> +       /*
> +        * Note: Any other bit set in intf_errors need to be considered as an
> +        * error. Future implementations may define new error conditions. The
> +        * pib_status below is only valid if intf_errors is 0.
> +        */
> +       __u8    pib_status;     /* 3-bit PIB status */
> +#define SCOM_PIB_SUCCESS       0       /* Access successful */
> +#define SCOM_PIB_BLOCKED       1       /* PIB blocked, pls retry */
> +#define SCOM_PIB_OFFLINE       2       /* Chiplet offline */
> +#define SCOM_PIB_PARTIAL       3       /* Partial good */
> +#define SCOM_PIB_BAD_ADDR      4       /* Invalid address */
> +#define SCOM_PIB_CLK_ERR       5       /* Clock error */
> +#define SCOM_PIB_PARITY_ERR    6       /* Parity error on the PIB bus */
> +#define SCOM_PIB_TIMEOUT       7       /* Bus timeout */
> +       __u8    pad;
> +};
> +
> +/* Flags for SCOM check */
> +#define SCOM_CHECK_SUPPORTED   0x00000001      /* Interface supported */
> +#define SCOM_CHECK_PROTECTED   0x00000002      /* Interface blocked by secure boot */
> +
> +/* Flags for SCOM reset */
> +#define SCOM_RESET_INTF                0x00000001      /* Reset interface */
> +#define SCOM_RESET_PIB         0x00000002      /* Reset PIB */
> +
> +#define FSI_SCOM_CHECK _IOR('s', 0x00, __u32)
> +#define FSI_SCOM_READ  _IOWR('s', 0x01, struct scom_access)
> +#define FSI_SCOM_WRITE _IOWR('s', 0x02, struct scom_access)
> +#define FSI_SCOM_RESET _IOW('s', 0x03, __u32)
> +
> +#endif /* _UAPI_LINUX_FSI_H */
> --
> 2.17.0
>
