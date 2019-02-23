Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EADC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4AC206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOQqKDQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfBWHb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 02:31:59 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46087 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfBWHb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 02:31:59 -0500
Received: by mail-yw1-f68.google.com with SMTP id n12so1724359ywn.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 23:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PK7F8cr+8FPab7/szyPMsCXaLuS1QZ+aV0ik+lkJsno=;
        b=KOQqKDQcc1Yu4r62etX89elwj8KOssBXA3V8Bjkn0nKZOO0vulACcwjyc9N8QskG/H
         faE7186gL9T2grfTjvxUmWirWCD1GZuZTqqQIQ3Jks0DID0LbVRc7hY/39YNOy7Fe0LO
         IoGT975DP3r4yFLHcOZnzpk2SgSYC3webpm56ow2Hq4QCQKvcf5tHC2XaiL0zXu8gkLO
         Ya0hVFCd2wZ7aH8PDvnpP2QuO9vov4y53cn8rN1b5+/SPlb65jZKlXsn45GWMwGuuRnc
         1lQ0el/CsQbp321cHKj9qkiEdhdF4VzWDWjTq6KS3SUKd7aul+VbpjJW9+pvHFYtU6EA
         Gijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PK7F8cr+8FPab7/szyPMsCXaLuS1QZ+aV0ik+lkJsno=;
        b=nl+91OAdSBYjO6rkNWUF//vUCOlhc7V1fpM2GMupVI0MftnKd8NGMtSI1HIGjh0Apg
         xopI0xIGtabrsZRIxGTwaEWxJUXihN5mrDjTFwsZ7g9JcfaJVJakYsbfNhvLADDKGlwS
         FjTlCUpL/BnPe2cp/fsZRr9lp55vwNsE3yPkR6FII7vRheVMk5oNT+FxzU1rUi4BSO0q
         Ia6emnmnmyXxmcTBFmodlIIxz7LESPYOhOKcvjkevqX6wSkiZka60Gn1D03e0JPF3mZZ
         mYnBHeirtD/LEu+GCKIWoBq0gKNvH8iMh4wr7A9YAfzpiFoDvH7aVXwXVUBd2xy2PDmX
         A8EQ==
X-Gm-Message-State: AHQUAubfwmE4HSLP+OoDSZSR/nafEQdnN5eja1iZbaB5Woip4S5ZrV2v
        IWVuIdn6NqWVAN1JA0YjhdQ=
X-Google-Smtp-Source: AHgI3IZ4jRLVFDqrwzJPKawOjaXXCm227xKM2LinGWZX/ZLjU0RUzlAS/fXGV3+NB7Yop/4XkmGKFg==
X-Received: by 2002:a81:9908:: with SMTP id q8mr6375455ywg.334.1550907118222;
        Fri, 22 Feb 2019 23:31:58 -0800 (PST)
Received: from yubo-2 ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id 130sm1338448ywp.54.2019.02.22.23.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 23:31:57 -0800 (PST)
Date:   Sat, 23 Feb 2019 02:31:56 -0500
From:   YU Bo <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, sergio.paracuellos@gmail.com,
        quytelda@tamalin.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        yuzibode@126.com
Subject: Re: [PATCH V2] staging: ks7070: removed unused varibales
Message-ID: <20190223073155.kcht3f6uagzhh5kf@yubo-2>
Mail-Followup-To: gregkh@linuxfoundation.org, sergio.paracuellos@gmail.com,
        quytelda@tamalin.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, yuzibode@126.com
References: <20190223072712.18422-1-tsu.yubo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190223072712.18422-1-tsu.yubo@gmail.com>
User-Agent: NeoMutt/20180512-62-03f98a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 02:27:12AM -0500, Bo YU wrote:
>From: Bo Yu <tsu.yubo@gmail.com>
>
>Compiling the kernel with W=1 results in the following warning:
>
>drivers/staging/ks7010/ks_hostif.c:465:6: warning: variable ‘mib_val_type’
>set but not used [-Wunused-but-set-variable]
>  u16 mib_val_type;
>
>drivers/staging/ks7010/ks_hostif.c:464:6: warning: variable ‘mib_val_size’
>set but not used [-Wunused-but-set-variable]
>    u16 mib_val_size;
>
>drivers/staging/ks7010/ks_hostif.c:786:6: warning: variable ‘result_code’
>set but not used [-Wunused-but-set-variable]
>      u16 result_code;
>
>Remove these variables.
>
>Rebase on next-20190222
>
>V2: fix patch format
Please drop it, will send V3
Thanks
>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>Cc: Quytelda Kahja <quytelda@tamalin.org>
>
>Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
>---
> drivers/staging/ks7010/ks_hostif.c | 6 ------
> 1 file changed, 6 deletions(-)
>
>diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
>index d938b0997a53..913d8996437a 100644
>--- a/drivers/staging/ks7010/ks_hostif.c
>+++ b/drivers/staging/ks7010/ks_hostif.c
>@@ -461,13 +461,9 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
> 	struct net_device *dev = priv->net_dev;
> 	u32 mib_status;
> 	u32 mib_attribute;
>-	u16 mib_val_size;
>-	u16 mib_val_type;
>
> 	mib_status = get_dword(priv);
> 	mib_attribute = get_dword(priv);
>-	mib_val_size = get_word(priv);
>-	mib_val_type = get_word(priv);
>
> 	if (mib_status) {
> 		netdev_err(priv->net_dev, "attribute=%08X, status=%08X\n",
>@@ -783,9 +779,7 @@ void hostif_ps_adhoc_set_confirm(struct ks_wlan_private *priv)
> static
> void hostif_infrastructure_set_confirm(struct ks_wlan_private *priv)
> {
>-	u16 result_code;
>
>-	result_code = get_word(priv);
> 	priv->infra_status = 1;	/* infrastructure mode set */
> 	hostif_sme_enqueue(priv, SME_MODE_SET_CONFIRM);
> }
>--
>2.11.0
>
