Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7A3C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0652075E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cr7d8QAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0652075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJIIyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:54:41 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37847 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeJIIyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:54:41 -0400
Received: by mail-yw1-f65.google.com with SMTP id y14-v6so8903879ywa.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 18:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7qA+dtOcdI9urqDaS/IIx7h3l7wueuGPmWbY8bS/3GU=;
        b=Cr7d8QAz0kukYdX0iBqB5KVdL/yUDjRmOJyD2dc6Vca6WvhfsP421Td/pzu5oqOyHg
         vWlxQnjXCC7v55mqc/rDdr5wc7MeIxqZ7muGiZA+v5x01nSspt/SnK8V1DwKWl6Gkwbm
         uO8CQq0kdGPN3kyueDJcm9Vjm72pamEF8xH0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7qA+dtOcdI9urqDaS/IIx7h3l7wueuGPmWbY8bS/3GU=;
        b=F1ufE37nhHYAYOLUz8KDUFLKFmng7YmKslBM/mrHMwAqt1H2PLLbNtnqLSNfOakzts
         LGp40O+yEFp6k+iSfVh2M3j5vVSWS6dtTfrWjLa3IYkyv3jUyMug86mIK/Um24jvus+L
         +CltiZALuTum5jSzguFWNsCc3btR2tywKuyauc4OH7loROUMBVn6DpwrJVSJN3OEkdyI
         hvHH4cZ36frySnj66jVoGQvqvx9t5/ndaAyKhqVHuFbuLtJIuZ0altajG+Ug2z4E7DHs
         PLFg3jFPHcRMys+r4BndvTB8UyWr/n84b1bPo4XVK7WQddNSAIolnG5n3QIIZW4OFQkN
         326Q==
X-Gm-Message-State: ABuFfoi+Dm4BWaxYac5uGs6M8Y4PhDjrWBDRH4PS7SEtto+/3g+7q9jI
        cs6ezdFAKOuX093USGDrbMB+pCXF7YY=
X-Google-Smtp-Source: ACcGV62RCIb/aH6vpCIHZLvxrjkVWLtouSHubLaA0orWeGvymodsXcYOIpIsldcmpQN/NqARtUGIcg==
X-Received: by 2002:a81:9148:: with SMTP id i69-v6mr14945814ywg.371.1539049211039;
        Mon, 08 Oct 2018 18:40:11 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id i62-v6sm9430634ywb.32.2018.10.08.18.40.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 18:40:09 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id j75-v6so8902199ywj.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 18:40:09 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr14391598ywg.353.1539049208850;
 Mon, 08 Oct 2018 18:40:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 18:40:08 -0700 (PDT)
In-Reply-To: <c06eb47c-05d3-f51c-625b-9bfdd33a426a@infradead.org>
References: <c06eb47c-05d3-f51c-625b-9bfdd33a426a@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 8 Oct 2018 18:40:08 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+B82dt9KvO0UVMBLoFxZEZF76xic4Sz41HtVfKHWpwWQ@mail.gmail.com>
Message-ID: <CAGXu5j+B82dt9KvO0UVMBLoFxZEZF76xic4Sz41HtVfKHWpwWQ@mail.gmail.com>
Subject: Re: [PATCH] security: fix LSM description location
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 5:46 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix Documentation location reference for where LSM descriptions should
> be placed.
>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

Jon, can you take this?

-Kees

> ---
>  Documentation/security/LSM.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lnx-419-rc7.orig/Documentation/security/LSM.rst
> +++ lnx-419-rc7/Documentation/security/LSM.rst
> @@ -5,7 +5,7 @@ Linux Security Module Development
>  Based on https://lkml.org/lkml/2007/10/26/215,
>  a new LSM is accepted into the kernel when its intent (a description of
>  what it tries to protect against and in what cases one would expect to
> -use it) has been appropriately documented in ``Documentation/security/LSM.rst``.
> +use it) has been appropriately documented in ``Documentation/admin-guide/LSM/``.
>  This allows an LSM's code to be easily compared to its goals, and so
>  that end users and distros can make a more informed decision about which
>  LSMs suit their requirements.
>
>



-- 
Kees Cook
Pixel Security
