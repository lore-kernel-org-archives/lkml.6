Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BEEECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91247208CC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CM33lOZ5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VaHK0NhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91247208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbeGOCvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:51:23 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45176 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732006AbeGOCvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:51:23 -0400
Received: by mail-yw0-f196.google.com with SMTP id 139-v6so13090604ywg.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 19:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yFzM0RpwZnn2muQmo+WABxL3IzHrDcFuE91R9M0ENio=;
        b=CM33lOZ5inIR4/Xz417T8TYZT7HwY0zhISTfm47sHKhYEF9nHmmbCGpupYWXVf/65p
         O4fl90W7PKOAlJQsiSojaVtdzetkg6+UHksnTr9C2UIYpJaI15o3KOXKEuBAcJuCPgPX
         S3PDrp0KgtubyM6f5tAUDySvtpC0SZKwUayKtcwxWkPRUb4fsmKF+j+kcZzPEu2BX0Pn
         OV2B15lh6vvh40pzwW10CGae5NOt9np9n/MVTD/LX7WyPUuppyOts5pvYV0if4ClSnRB
         lFrF8Es6oogxsQgM2tgmw7ZMoFBTf0MQbYz1IJ/OnAHT0/9k5nJ8iVq1H5zkdgKt1GYN
         ZF0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yFzM0RpwZnn2muQmo+WABxL3IzHrDcFuE91R9M0ENio=;
        b=VaHK0NhWLSaEv/B46qJpG+4B9etbMz3lkmD9qLTsQNu4kLBwJ7Qp8F/FTF6p8ik/Zw
         23QGiLYx4lWEkIXlWjgu4e0gkEMjpt3FW6t8kA6RjFnWbfDVYzBskFtmMOKYWVq5jrSv
         3Nnd5SjIqruuJoEbdEWqDeCgOvdPsUBAnNjB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yFzM0RpwZnn2muQmo+WABxL3IzHrDcFuE91R9M0ENio=;
        b=HCOKWNhNKki5yuO02WILWDgN8QVGkfnc5pJcuvOJgJq9Rgk9qRfP5WvV4muyDJjCDk
         nzi5GNrcs9xflVgDPA46xomZFFHVRZcwBYIbDxhf0dpBrmKL3nWekC4/fWvaN+jStg0m
         NGIg3Zr4uVGtAC3RYMZOmFPyLSERG0HQzeZ/+oXRkLcmHUS7h8aoqIrk+rsEHRUUWM73
         0y2BxSj2KbmisjmeElV06Nvp5vgD3kVbV2t4DpnGjsFBPR4bbe1tRZdKuqI8/OR6E91/
         mPJ+NMkRBDnZ6h0jF+9lJ57Dy5aizSfUB5P61XkY9EF3K/wMiqUu66OWVUKb2r/hmp4Y
         Fsjw==
X-Gm-Message-State: AOUpUlExDbSLxyE6N0K71C4za2+13JwXWbsu1/mdCqkJLrgYeX5Xpcdy
        bdExJWtl6Ox+oJCsPtm08phb5B3xAQOlAs5RYD296g==
X-Google-Smtp-Source: AAOMgpfPF6OWf4gyrizLlkE2obqChcnb3nEOoTrIm6AM+mvyME8kV43LrYGIBTkLxeMHK9LAoSNx1JDrdLK629vKp10=
X-Received: by 2002:a81:8742:: with SMTP id x63-v6mr5877480ywf.129.1531621810833;
 Sat, 14 Jul 2018 19:30:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 19:30:10
 -0700 (PDT)
In-Reply-To: <1531505163-20227-8-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-8-git-send-email-zohar@linux.vnet.ibm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 14 Jul 2018 19:30:10 -0700
X-Google-Sender-Auth: dXe2F_noq_hjktFHg70rwvVclkk
Message-ID: <CAGXu5j+RvX+CKMP5PWjAPmDpvO4N+t1JQ3C5zr3F-y-T-AH_ng@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] module: replace the existing LSM hook in init_module
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Both the init_module and finit_module syscalls call either directly
> or indirectly the security_kernel_read_file LSM hook.  This patch
> replaces the direct call in init_module with a call to the new
> security_kernel_load_data hook and makes the corresponding changes
> in SELinux, LoadPin, and IMA.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Kees Cook <keescook@chromium.org>
> Acked-by: Jessica Yu <jeyu@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>

Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
