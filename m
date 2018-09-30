Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446C3C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 17:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE383206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 17:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1Z5aQnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE383206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeI3XmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 19:42:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37136 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbeI3XmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 19:42:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so7790157pgq.4;
        Sun, 30 Sep 2018 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bYLo1+WKKDCAf3A+9jD/YWEBJOcAFIzOp5NhTCDhvIc=;
        b=c1Z5aQnWt6VBDJiPvhnB/7Q2bVqZoe1xHBQwsgfjPCMzh5eIIAC7qXeuv9dp+kLdPk
         kWW9RurCZjGBQLQZ4rVfnb3y0S9VhhnVj1OiUUbb7tq2W9QPMDveljxg+1obM4EjQCXn
         lN3soFr4hNtBF+x5A4059/Xa3mIeAHb47OfYazMIdzrMX+SdXk0fspWMgCNGi/JtVebn
         69IV+q8p3QuCyGMreFsva+7EcQuuf0xWrAqHLgOWGNm4vkOmYzXTnVgN1xAqH1egZiGM
         Pcf0fWqb3RZF0BkD1JgSYKhy1jV56EK8xY/m/icMswaDM0nxtmjT/1efFCU7n2mTSxnH
         7VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=bYLo1+WKKDCAf3A+9jD/YWEBJOcAFIzOp5NhTCDhvIc=;
        b=hhzcRO6k80vszM8HOoQyodHkTR0D9LM5Ws2Yf6Fb3YiEGci1wXJgfA+N+0rfgcpIi2
         iQqouLjhY/k/oJWA+NYERvbS/2GGM3KyCv+4tL4lnDRUyZJXsqykMnp80B475VvtRVwe
         NFxG4fP4tZax29gxb4XtJoV/0YAjtnnGQGj2zvLyl/9WGUeOVD5ORxVU0H72z97FKDfg
         ONQGl6ocDEDfabBu1I3PTj1fsNWt/edV2Zauhl2tkuL7LsqfWqna5fnJosBMko/YpkDK
         3Vpz0jx1gMN3/bYgBm5f/T+PZngim4SFsI2DYvF3un4tmwmc13D6w/jgFu0NN1vGtXhi
         3Fpw==
X-Gm-Message-State: ABuFfogl+R+WSkp1rfY6cydaPm/8ALY0Pk9IRiw6KiTkOmWW4xP7q7ea
        3hfZG7It4QGAlQ75OdNWqak=
X-Google-Smtp-Source: ACcGV63l+kcwVzCEuVm/ddpMOs7zsp9uKrQIbYi12gKezb+rqyU7Zc9/p3jDg42cs3/mrIkctVKu9Q==
X-Received: by 2002:a17:902:d890:: with SMTP id b16-v6mr2382541plz.140.1538327298835;
        Sun, 30 Sep 2018 10:08:18 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v8-v6sm14675485pfl.6.2018.09.30.10.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 10:08:17 -0700 (PDT)
Date:   Sun, 30 Sep 2018 10:08:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] s390: vmlinux.lds: move JUMP_TABLE_DATA into output
 section
Message-ID: <20180930170816.GA26630@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 06:49:50PM +0200, Ard Biesheuvel wrote:
> Commit e872267b8bcbb179 ("jump_table: move entries into ro_after_init
> region") moved the __jump_table input section into the __ro_after_init
> output section, but inadvertently put the macro in the wrong place in
> the s390 linker script. Let's fix that.
> 
> Fixes: e872267b8bcbb179 ("jump_table: move entries into ro_after_init region")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/s390/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index 4042bbf3f9ad..457713f48734 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -64,9 +64,9 @@ SECTIONS
>  	__start_ro_after_init = .;
>  	.data..ro_after_init : {
>  		 *(.data..ro_after_init)
> +		JUMP_TABLE_DATA
>  	}
>  	EXCEPTION_TABLE(16)
> -	JUMP_TABLE_DATA
>  	. = ALIGN(PAGE_SIZE);
>  	__end_ro_after_init = .;
>  
> -- 
> 2.17.1
> 
