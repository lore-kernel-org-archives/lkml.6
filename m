Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FCFC282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBE4218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbfBASmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:42:18 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35222 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfBASmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:42:18 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so8755073qtc.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 10:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fwFQnH9OuB2MvnyRpWht+yCfAp3mugwnL8IAAdrFt5M=;
        b=fIZcdn8axg0mgah8y4XqLzmKJ1wwpQxr+kbOmqhXwxH1q6RQfeDyh15Y8HP5mlsVgv
         35AihoS7g9B5kQtIEbcU/LWzm1z9p4/hTZUMZjJayIQvQnw67KxxWUKebFyhH7bW0qLm
         0u0A/2ne/JGc/5ALVOiVOd2RiKupieZ0gJ2TXXIWtNUt9GF4xaW9kh6M1aZJCyO4nylg
         RQ9wHbd6gew3ypXa7xlqsH7i2EJaHhGuk58BEeHuHVd4JgkWQuaVOkz+RVFG/UuaGkCn
         IXrKA784JWWOkdcQVNJyNlWPHBBkwChnv2hqWu/7/xpSrZDTd+kwHE891Tbgm9/4Jm+2
         VgLw==
X-Gm-Message-State: AJcUukcSEIJ/h3wRFMoAM4+ZDppFhA7xZtshi6xE1i+sB00l3pw8eckT
        InsT8+jyn1x2dnebNN7Cz8qUww==
X-Google-Smtp-Source: ALg8bN7HmZNiBvoGLrsOhjOmh62mH0+md5FzB0sceRpiXhf+0M+tFPz8q52CV0Ao8f9kG5OcDoyurA==
X-Received: by 2002:ac8:fd4:: with SMTP id f20mr41042364qtk.63.1549046536928;
        Fri, 01 Feb 2019 10:42:16 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id o21sm7689506qto.18.2019.02.01.10.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 10:42:16 -0800 (PST)
Date:   Fri, 1 Feb 2019 11:42:14 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: Re: [PATCH] tpm/tpm_crb: Avoid unaligned reads in crb_recv():
Message-ID: <20190201184214.aohoxqu7cyngehqk@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>
References: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Feb 01 19, Jarkko Sakkinen wrote:
>The current approach to read first 6 bytes from the response and then tail
>of the response, can cause the 2nd memcpy_fromio() to do an unaligned read
>(e.g. read 32-bit word from address aligned to a 16-bits), depending on how
>memcpy_fromio() is implemented. If this happens, the read will fail and the
>memory controller will fill the read with 1's.
>
>This was triggered by 170d13ca3a2f, which should be probably refined to
>check and react to the address alignment. Before that commit, on x86
>memcpy_fromio() turned out to be memcpy(). By a luck GCC has done the right
>thing (from tpm_crb's perspective) for us so far, but we should not rely on
>that. Thus, it makes sense to fix this also in tpm_crb, not least because
>the fix can be then backported to stable kernels and make them more robust
>when compiled in differing environments.
>
>Cc: stable@vger.kernel.org
>Cc: Linus Torvalds <torvalds@linux-foundation.org>
>Cc: James Morris <jmorris@namei.org>
>Cc: Tomas Winkler <tomas.winkler@intel.com>
>Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>---
> drivers/char/tpm/tpm_crb.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>index 36952ef98f90..7f47e43aa9f1 100644
>--- a/drivers/char/tpm/tpm_crb.c
>+++ b/drivers/char/tpm/tpm_crb.c
>@@ -288,18 +288,18 @@ static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> 	unsigned int expected;
>
> 	/* sanity check */
>-	if (count < 6)
>+	if (count < 8)
> 		return -EIO;
>
> 	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> 		return -EIO;
>
>-	memcpy_fromio(buf, priv->rsp, 6);
>+	memcpy_fromio(buf, priv->rsp, 8);
> 	expected = be32_to_cpup((__be32 *) &buf[2]);
>-	if (expected > count || expected < 6)
>+	if (expected > count || expected < 8)
> 		return -EIO;
>
>-	memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);
>+	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
>
> 	return expected;
> }
>-- 
>2.17.1
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
