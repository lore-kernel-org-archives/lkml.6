Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6C9F3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22095208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pB49CAJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22095208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755391AbeFNRTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:19:21 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34162 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754616AbeFNRTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:19:20 -0400
Received: by mail-ua0-f194.google.com with SMTP id 74-v6so4642499uav.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2BIFdNOoc0DFNDwXpxek2nq12bb7CxUXZ6QGIZzkVlk=;
        b=pB49CAJg35HHCL9NOFr5bAyDuZ34si5lAST2h+NhzzorxpcQlOd0TjzXvM238PMOIw
         FkXiK30C+9naiu+NFWBOYwBNGTHPf9P1nD2aqbFg+1DBd7MZ6/lQHLdJnnKOn70K3Iek
         +yIqzhugNx+2TF976HeEIBBk8JfG4watFw6t0srpsX8sKYzJlz327cGgcx20a3Ck+cVy
         qj+sICpEYJQq5AWUAn6iFgvNtpcdMB/Fyl+H+p799rZf7VnkfypcTBKaTJoPMz2M8aef
         uIs7YNErULuzUl1KYNJfvcHCgiPdHqcDrx2BOKLUO8ntHuypXWH4yaxSJU5dPCrXVWI9
         Nl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2BIFdNOoc0DFNDwXpxek2nq12bb7CxUXZ6QGIZzkVlk=;
        b=NtXAewoC+ljM2w/eebwmd3aQQFlxpfgHQPpfaGGjxS4ZH19kVx3shVPRojoegu0LzM
         mRWW39/vrSpZGj6je4cY/RcawzwwViM8vpgBWhgnImCYPRKa2gssl8qee+m1SpCeraTZ
         Nb5X8O6GLk0HUHeGj78ubEAYjoEdshssd5amgQHm+hM3PdfZKbRqZHgTNzF1Vs8Ujv5a
         fJQ8JBRZKgQnp/M/LUs1Q7UNUI1BnerVMN5+Fkoc3/HPGDr6Ni4dq7qNdUC6UH4ByYFH
         xhkuZb2B/KJ4lLivPsQrwp74WyQg/OcGp1SoiToTrZfG0ttRiilx2hdNfzdDyfUlxIN4
         qcaA==
X-Gm-Message-State: APt69E0HQ06Mp0Jf48tegaCrgZXOLQIG0czZIq8dCzf1K7OhBaAvg0Yo
        7CUuNq05PSCN36KqQUIlYNA=
X-Google-Smtp-Source: ADUXVKKACDA8q/WV2a6jiz3wUPeV6CS3U8mRvb5AjFAO4aaXVu0aJVJlB+VZj5i4x/kTxYxv5hwG+w==
X-Received: by 2002:a9f:3806:: with SMTP id p6-v6mr2143968uad.15.1528996760041;
        Thu, 14 Jun 2018 10:19:20 -0700 (PDT)
Received: from javier-Z97X ([2601:582:c500:a66c::5a97])
        by smtp.gmail.com with ESMTPSA id a2-v6sm1054677uaa.9.2018.06.14.10.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 10:19:19 -0700 (PDT)
Date:   Thu, 14 Jun 2018 13:19:12 -0400
From:   Javier Martinez <javiermlinux@gmail.com>
To:     abbotti@mev.co.uk
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: comedi: ssv_dnp: Remove unnecessary comment
Message-ID: <20180614171911.GA1945@javier-Z97X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removal of a comment that was not needed at all.
We can clearly see that they are include/header files.

Signed-off-by: Javier Martinez <javiermlinux@gmail.com>
---
 drivers/staging/comedi/drivers/ssv_dnp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/ssv_dnp.c b/drivers/staging/comedi/drivers/ssv_dnp.c
index 0628060e42ca..50de018ab9bb 100644
--- a/drivers/staging/comedi/drivers/ssv_dnp.c
+++ b/drivers/staging/comedi/drivers/ssv_dnp.c
@@ -16,7 +16,6 @@
  * Status: unknown
  */
 
-/* include files ----------------------------------------------------------- */
 
 #include <linux/module.h>
 #include "../comedidev.h"
-- 
2.17.1

