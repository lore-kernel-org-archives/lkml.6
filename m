Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5AAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687B12154F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIhTfdRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687B12154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeHWXhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:37:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36519 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeHWXhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:37:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so3375907pfo.3;
        Thu, 23 Aug 2018 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dyBvAe2WITBpsgCNtiSOZ8xEQlWYjd2HWrBaq9BO4ho=;
        b=HIhTfdRsO1r9BghW3EGkAIYWQySxwnCg/Sr4iRZ0rNfIj1gqDned4xrpFgGWRCFa0+
         /RW2xet2wBpOFrqYTxUsZiJShppGf2iyfk8CkuZgvgKVCBkP7Gh1mk7QnIdp/MGrTB0W
         MryiiGD38UC3560FqnKvleuyUor4NpDUu3NvsX/EOva+6SEtWNUUP7gXo+dxA4bWKDGN
         6i0V3DqiIZX1N4J5fKKF44gKgdpSOPa6inLyGerwOZcWvYrFky5/6058G10R193EedKQ
         IDWv2w7/PdmMO7YKMFSZWK3k4nDewlhmVmAPCuzSlhm/xLIz0p46mLLAlATNIOxsFXfu
         5TCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dyBvAe2WITBpsgCNtiSOZ8xEQlWYjd2HWrBaq9BO4ho=;
        b=cJlkAYYbUkGR+DTSH/uOLUipEzaiP/UzHhrq/yN+zJDXtzJ8w2WJ8PEWG9ksQ77CEY
         A+DXzpUWrK1/QReV5rJ2JZcDhdTg+faPoPRd2S0cHbzrOOnmTj1guHk/t2mk8fQsIcdV
         6RuShjmJDCvx3HP+WyqnZWb+s86X9gdAFFYbhDwNIoCue25O7B/dLSwjTDr5aW4AWdRL
         DcacxFwcmx8u2L3nJMA8mMcuAzshvriljnrlYjc/WJGif48ttgPK5+wE0cjFKZHIjacF
         gAIMfvOiY+Q+bgkqPlV4SUCC1scNbJwRy5DX7REJriAZc2kcrBGUG0JJiiPoMv8gaKGI
         x4jA==
X-Gm-Message-State: AOUpUlHqUeTzc0qtO2H2GhkBZ2hDrZ7UBPbHCmga7z3D3lpQo5LhR8n4
        +87bHEQq2jhxTA6K8GDizw5eIK4qgoIsJDIyHtI=
X-Google-Smtp-Source: AA+uWPwYJwYjwXWOESUnrvc2336Gqff9zKT0E1UsgUrAc1fLx4S/X+Yq5WDbpFp6jK1evGUc36Ojb0WLaF2wTV4n7CY=
X-Received: by 2002:a63:2643:: with SMTP id m64-v6mr29723807pgm.55.1535054794378;
 Thu, 23 Aug 2018 13:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <1535019842-18103-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1535019842-18103-1-git-send-email-hofrat@osadl.org>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 23 Aug 2018 15:06:22 -0500
Message-ID: <CAH2r5muTn2+yP6wdcadGe9WRX6Zr91kdVz29Rh3EcCbuvr4CuQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: check kmalloc before use
To:     hofrat@osadl.org
Cc:     Steve French <sfrench@samba.org>,
        Jerome Marchand <jmarchan@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next
On Thu, Aug 23, 2018 at 11:02 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> The kmalloc was not being checked - if it fails issue a warning
> and return -ENOMEM to the caller.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: b8da344b74c8 ("cifs: dynamic allocation of ntlmssp blob")
> ---
>
> Problem was located with an experimental coccinelle script
>
> Both call-sites will expect non-0 to indicate error so -ENOMEM
> should be OK here. Setting buflen to 0 seems to be the expected
> behavior on failure although it will not be checked/used at
> the call-sites - probably this could be removed here as well as
> in the handling of authentication error (preceding this change)
> it was just retained for consistency.
>
> Patch was compile tested with: x86_64_defconfig + CONFIG_CIFS=y
> (with sparse and smatch warning unrelated to proposed change)
>
> Patch is against 4.18 (localversion-next is next-20180823)
>
>  fs/cifs/sess.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
> index 8b0502c..aa23c00 100644
> --- a/fs/cifs/sess.c
> +++ b/fs/cifs/sess.c
> @@ -398,6 +398,12 @@ int build_ntlmssp_auth_blob(unsigned char **pbuffer,
>                 goto setup_ntlmv2_ret;
>         }
>         *pbuffer = kmalloc(size_of_ntlmssp_blob(ses), GFP_KERNEL);
> +       if (!*pbuffer) {
> +               rc = -ENOMEM;
> +               cifs_dbg(VFS, "Error %d during NTLMSSP allocation\n", rc);
> +               *buflen = 0;
> +               goto setup_ntlmv2_ret;
> +       }
>         sec_blob = (AUTHENTICATE_MESSAGE *)*pbuffer;
>
>         memcpy(sec_blob->Signature, NTLMSSP_SIGNATURE, 8);
> --
> 2.1.4
>


-- 
Thanks,

Steve
