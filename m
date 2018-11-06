Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C753C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C562086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yQydLxYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C562086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbeKFWAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387704AbeKFWAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:00:46 -0500
Received: from linux-8ccs (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D60962085B;
        Tue,  6 Nov 2018 12:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541507745;
        bh=D5eiSkrbMck53qRKWNhEaa5TUUz6vLOwfR5xPG4uIl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yQydLxYtJmDJ4WX2iT8AdRNHLam421ebq/r6z4wrGEzZqAXzTbE1d0PnPdQLZsk5x
         iiDMptXzUk+r9JCwoRgobzBwwrvVb8JXwwqIhmVqG13l66wEbcMDhPIJhkNpgAAJ+t
         emOLsgciLIXEnl6fwaDTYmAhvTbTN6ELLsDqeaUw=
Date:   Tue, 6 Nov 2018 13:35:40 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Ke Wu <mikewu@google.com>
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modsign: use all trusted keys to verify module signature
Message-ID: <20181106123540.GA20115@linux-8ccs>
References: <20181022222614.41016-1-mikewu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181022222614.41016-1-mikewu@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.22-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Ke Wu [22/10/18 15:26 -0700]:
>Make mod_verify_sig to use all trusted keys. This allows keys in
>secondary_trusted_keys to be used to verify PKCS#7 signature on a
>kernel module.
>
>Signed-off-by: Ke Wu <mikewu@google.com>
>---
> kernel/module_signing.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/module_signing.c b/kernel/module_signing.c
>index f2075ce8e4b3..a8b923ba1a39 100644
>--- a/kernel/module_signing.c
>+++ b/kernel/module_signing.c
>@@ -83,6 +83,6 @@ int mod_verify_sig(const void *mod, struct load_info *info)
> 	}
>
> 	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
>-				      NULL, VERIFYING_MODULE_SIGNATURE,
>+				      (void *)1UL, VERIFYING_MODULE_SIGNATURE,
> 				      NULL, NULL);
> }

I've just stumbled on commit 817aef260037f ("Replace magic for trusting
the secondary keyring with #define"), so we should probably use
VERIFY_USE_SECONDARY_KEYRING in place of (void *)1UL.

Thanks,

Jessica
