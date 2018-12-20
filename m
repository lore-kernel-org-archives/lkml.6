Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF59DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5E921905
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXZRmiDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390123AbeLTV5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:57:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39574 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbeLTV5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:57:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so3278046wra.6;
        Thu, 20 Dec 2018 13:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sTlddInhxxNsc8rjvJZAEy50kCyb9rVmaWzGN+Ka4a8=;
        b=FXZRmiDSNj0qtXNwFk38VhFR1GVngeahC80VJgd4eII1SSAcFfkE3CN/gctmbrzn8b
         GOUL9ZjKWiqLsjWVGd1/MfVTXJlcyO7TQsYmx3awr1of0d/2YxPFDmC774e0L6IkXm+J
         6tMgzaBMo9n0g8aPcEht5JsufbKo/FJ40ohCHxotFs5WAHSD1PY5LAq+l9hM2+Gd5Lmb
         peXhoapTIOKIPAakrWQcBgY0BiyZnlslzIT6fCANGr0DgMiTpr3kvpyKw4HHVxjqeNCi
         jD/MJR9C332PNXZBEpC7rMf/h96ymHTSIJufWiHFhBD7Icm/axpmW0yUVZ3iv/l2znWu
         qgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sTlddInhxxNsc8rjvJZAEy50kCyb9rVmaWzGN+Ka4a8=;
        b=CEimv1WbmSHIz29iUVRIgIS9S3ICvyQRzUuGTGzO8f1ZmAy+BC2gXIrk/0zHqNyVNp
         +hQccAySTAtEOoq54HYcjakHXNH//RpNC+kh09hFSqf5l4DC/vJ463vtk15yGmaQzdN0
         kRIQG6VuDGv5NWLlaJeeAVUI+0+NQbqOPFDSVFKMRVMXX6by30lRajd83mHf2l00hrZe
         au8t+bWxbvvbGiOF/PR6c0VHi/+l4K1IcoZTZt/JSHIOb8mRRA7i16j51CnZX1OJLPuM
         QVvqJACk9fcolluRvBx2e5Xg7Jt/IoQ4jZg+gslDM4eLmrACTOFzPeWUWU6lSVT+s03S
         0iEQ==
X-Gm-Message-State: AA+aEWbyB/XZtQpi7X1bf95Vy8s2MI6IGu5wM3mU7ay+XgnUdxZMwxI/
        uXXDFIrf3qVJwpFdeT8Zkzs=
X-Google-Smtp-Source: AFSGD/Wb7miW0VivVnXD6kY7ZsoCP0E9rzjdIl9D7gzpAlzv9WiAyW4i0swNZmpT2x+cqQb9J/VXGw==
X-Received: by 2002:adf:db01:: with SMTP id s1mr23322170wri.214.1545343049369;
        Thu, 20 Dec 2018 13:57:29 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g67sm10428130wmd.38.2018.12.20.13.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:57:28 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:57:27 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] ACPI / tables: Add an ifdef around amlcode and
 dsdt_amlcode
Message-ID: <20181220215727.GA29539@flashbox>
References: <20181220193856.7833-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220193856.7833-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 12:38:56PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/acpi/tables.c:715:14: warning: unused variable 'amlcode'
> [-Wunused-variable]
> static void *amlcode __attribute__ ((weakref("AmlCode")));
>              ^
> drivers/acpi/tables.c:716:14: warning: unused variable 'dsdt_amlcode'
> [-Wunused-variable]
> static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
>              ^
> 2 warnings generated.
> 
> The only uses of these variables are hiddem behind CONFIG_ACPI_CUSTOM_DSDT
> so do the same thing here.
> 
> Fixes: 82e4eb4e9653 ("ACPI / tables: add DSDT AmlCode new declaration name support")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/acpi/tables.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index ccb90eff00e5..48eabb6c2d4f 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -712,8 +712,10 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
>  					  table_length);
>  }
>  
> +#ifdef CONFIG_ACPI_CUSTOM_DSDT
>  static void *amlcode __attribute__ ((weakref("AmlCode")));
>  static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
> +#endif
>  
>  acpi_status
>  acpi_os_table_override(struct acpi_table_header *existing_table,
> -- 
> 2.20.1
> 

+ Nick for review
