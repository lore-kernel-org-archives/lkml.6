Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130C9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76872075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=paulo.ac header.i=@paulo.ac header.b="J4357JWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76872075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulo.ac
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030239AbeFSQpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:45:19 -0400
Received: from mail.paulo.ac ([34.238.86.106]:54124 "EHLO mail.paulo.ac"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966510AbeFSQpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:45:18 -0400
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 12:45:18 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.paulo.ac (Postfix) with ESMTP id 2DF19C00362;
        Tue, 19 Jun 2018 16:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at paulo.ac
Authentication-Results: mail.paulo.ac (amavisd-new); dkim=pass (1024-bit key)
        header.d=paulo.ac
Received: from mail.paulo.ac ([127.0.0.1])
        by localhost (mail.paulo.ac [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U5sxj1vTeN9c; Tue, 19 Jun 2018 16:37:26 +0000 (UTC)
Received: from localhost (unknown [191.32.35.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.paulo.ac (Postfix) with ESMTPSA id 00C3CC76528;
        Tue, 19 Jun 2018 16:37:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.paulo.ac 00C3CC76528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=paulo.ac; s=default;
        t=1529426246; bh=3aB7YPUoItxy5+Rr2TwGBSwxc5F+deXDf712zhFp8JY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=J4357JWQTsQTRJZM/4yWkNYqUc/Ws6H7prqt/UJqCP/7oCyH6DB0DP7E7AF8LDRq9
         d0/uZJvMPds4octE9Tn6Aign7FyniukE/zNSzI/KnjSHc6vs0cn0TC0vjelIX+Cgc8
         EPizt7rig5sxmXH95qCvqdUYfiji/iAtlsjX0Lnw=
From:   Paulo Alcantara <paulo@paulo.ac>
To:     Arnd Bergmann <arnd@arndb.de>, Steve French <sfrench@samba.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Aurelien Aptel <aaptel@suse.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Kees Cook <keescook@chromium.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cifs: use timespec64 internally
In-Reply-To: <20180619153255.3634720-1-arnd@arndb.de>
References: <20180619153255.3634720-1-arnd@arndb.de>
Date:   Tue, 19 Jun 2018 13:36:31 -0300
Message-ID: <8736xibunk.fsf@paulo.ac>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> In cifs, the timestamps are stored in memory in the cifs_fattr structure,
> which uses the deprecated 'timespec' structure. Now that the VFS code
> has moved on to 'timespec64', the next step is to change over the fattr
> as well.
>
> This also makes 32-bit and 64-bit systems behave the same way, and
> no longer overflow the 32-bit time_t in year 2038.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/cifs/cifsencrypt.c |  4 ++--
>  fs/cifs/cifsglob.h    |  6 +++---
>  fs/cifs/cifsproto.h   |  6 +++---
>  fs/cifs/cifssmb.c     | 12 ++++++------
>  fs/cifs/inode.c       | 34 ++++++++++++++++------------------
>  fs/cifs/netmisc.c     | 19 ++++++++++---------
>  6 files changed, 40 insertions(+), 41 deletions(-)

Reviewed-by: Paulo Alcantara <palcantara@suse.de>

Thanks
Paulo
