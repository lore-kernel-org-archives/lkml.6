Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E06C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6868214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ux8cQIpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfAIFjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:39:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43842 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbfAIFjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:39:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so2795707pgk.10;
        Tue, 08 Jan 2019 21:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fcp/99fnMkGR/s9JNz8s1K5nWFgNYA49MagXrcAXAEc=;
        b=ux8cQIpXNcKsMg2Nok9PFHTlS+U0b7cie/ztAP0bXVA2TrYBgcnJtu5088tIvS6MkM
         nl8EVpgUXedyVSjfQ5YM2E/5mks6OmU1N2jsOeDVWgpfKhJs0hWS8umRegkIRhGn+BI9
         aQVxW2t6slVSQe0pPMePEIb9427EcKm+turuI/G017pQb1erTy4wQa4KoFPV0JpDgZSq
         YtyAKA7Ye5C62S7sEcjYMrBwy5gXiD2AsBNmgytlB6hlO18SjikJ8JB08z105k7+yT78
         G7luw5vTBdYH8Dxm0FLdXbZzlqHZHFDQf3JdlsO0o5QONaNPqZxPMxptBI9++c6G+cVj
         uZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fcp/99fnMkGR/s9JNz8s1K5nWFgNYA49MagXrcAXAEc=;
        b=h2DujMLLs4uhx/X3c9zLZIEHwopVomPs5boTRabhM09nwzh59Ypy1LvNOhKne8nAtk
         eMDzvmZsIulTL/0OPJQubhBKgIR7n5iawDwbL4OXHwlVUi7TEvLY0951a0eHrrdhSA15
         iHAUK2qU4flRs9uTfhFvjoWes5TdVkVZZF/fUBxv4I2lUQonJOhf2FdCds1vc7bLjwMY
         hOadYkzDWUuEoIyzyFTo+IQYNaKqTOUSyYuivQFi1PhEAZ4sr7eINqA+4LhSq4Q3kHLO
         fJebUwHJf9U57M+/ay+RyXXPq78wTSOPdtmP04xCNZYc8MrLQr2lQ/Z43V+d+V3cnC7x
         uxLQ==
X-Gm-Message-State: AJcUukeGJmKIGFs5ZpzfiQk8jaV7I+5UAmTJAIKnlKHFx4cohzvCxqeP
        LCb08k5lFrIBdTU8FP0kTbE=
X-Google-Smtp-Source: ALg8bN7yojEPSHIc+ozAV/Fh0Bn+GMZWEzPt+SOWVDAJ4fdSKQ9i3Am0fngjC31PaV4TTiBM7k3i5g==
X-Received: by 2002:a63:5455:: with SMTP id e21mr4222261pgm.316.1547012385769;
        Tue, 08 Jan 2019 21:39:45 -0800 (PST)
Received: from localhost ([175.223.22.241])
        by smtp.gmail.com with ESMTPSA id z127sm111131466pfb.80.2019.01.08.21.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 21:39:44 -0800 (PST)
Date:   Wed, 9 Jan 2019 14:39:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Helge Deller <deller@gmx.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] parisc: replace oops_in_progress manipulation with
 bust_spinlocks()
Message-ID: <20190109053941.GA28834@jagdpanzerIV>
References: <20190107095612.7086-1-sergey.senozhatsky@gmail.com>
 <d09f4a9a-f966-80d7-01e1-5d92401b5d7e@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09f4a9a-f966-80d7-01e1-5d92401b5d7e@gmx.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/08/19 08:44), Helge Deller wrote:
> Date: Tue, 8 Jan 2019 08:44:19 +0100
> From: Helge Deller <deller@gmx.de>
> To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "James E . J .
>  Bottomley" <jejb@parisc-linux.org>
> Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey
>  Senozhatsky <sergey.senozhatsky@gmail.com>
> Subject: Re: [PATCH] parisc: replace oops_in_progress manipulation with
>  bust_spinlocks()
> Message-ID: <d09f4a9a-f966-80d7-01e1-5d92401b5d7e@gmx.de>
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
>  Thunderbird/60.4.0
> 
> On 07.01.19 10:56, Sergey Senozhatsky wrote:
> > Use bust_spinlocks() function to set oops_in_progress.
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> I've added this patch to the parisc for-next tree.

Thanks.

BTW,
    jejb at parisc-linux.org bounces. Shall it be replaced with
HansenPartnership.com email address?

---

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fc7813cd9c2..86b174dbe506 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11511,7 +11511,7 @@ F:	Documentation/blockdev/paride.txt
 F:	drivers/block/paride/
 
 PARISC ARCHITECTURE
-M:	"James E.J. Bottomley" <jejb@parisc-linux.org>
+M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
 M:	Helge Deller <deller@gmx.de>
 L:	linux-parisc@vger.kernel.org
 W:	http://www.parisc-linux.org/
