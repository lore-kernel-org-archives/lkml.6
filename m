Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E3C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FCD2177F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3UcOAqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FCD2177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeHUTQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:16:56 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45758 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbeHUTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:16:56 -0400
Received: by mail-yw1-f68.google.com with SMTP id p206-v6so1210154ywg.12;
        Tue, 21 Aug 2018 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2XOSRmyYILfQdGy9o7ZG1Q8FlnqCKSSYncVUOZVSocc=;
        b=h3UcOAqaaEgDeGKPgAwmOxtNMLQ50V0bjmua+KkaveSShAxSHJESbuYEWJuZh9UA70
         x7OitKm+URmpnCRcxfsEUlBWEzMpbqCLc6P9gCdrzPNSBUmt0REzTqaDGd03DD7Ydx9t
         ZQcn5xC6GozbhKwfezQfyu00APDbEE3jSoIaq3aoZIQjJrpFALUtxOPEH25TM0awlGcd
         3RhVvYk/Jz7NJ7a/wvjlr5JnoVHLNCjKaUllILocYcPSTgZ2pk6dFaaO/FBxRDAFxZ4F
         M2cRrQt132YHUCYCOJhWKATS/lIF0Y17kOfP3dSxEj8NsKDG9m/bUhqcUx7sYB0qPP1v
         8gVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2XOSRmyYILfQdGy9o7ZG1Q8FlnqCKSSYncVUOZVSocc=;
        b=Rr6nC1DSfjbfna/6RaAjSqYOo3xVH5F6/C8TRngX/fttb3BUfJ8X1JugvoH3rPhcgh
         dDph/sLa6N+AZ03lalYkmYDrvdnlyZG58gmHOzMSY7Z5vRkjZ2S9XsaMKCCLl1mtSKML
         X/XK3nxYD/rrH1wl2718bFLzP5Up2AknvFLBDbHTHiO/63x5U3Y8EM6H+8gHpSW05/7x
         8SIl6oDFSKOqM1eXvv3Cj1Gv6OUPi7PIx24AxRQid/fk7cDTyRCmYtVtUiyRUdjhP3lr
         NU8j3W3oZ9b/l6qTRqG60J4XELrkiTia4A1O0SeeVKObsuIaPJLHdcSytFsJWHNe0CNI
         /d/Q==
X-Gm-Message-State: AOUpUlEfFlbvk29P+3X6ui7gU/qJG+5ivD0zdiCQXy4URKwFiCfI+nAl
        KTKwnuGot2KsuHeetKHlcpM=
X-Google-Smtp-Source: AA+uWPxwx4jekYVjqNZAnEqzpVin5c5PsLC+Yks9s03jK1MochapiFqRU2gOsNcAR5VQAe30ra38uQ==
X-Received: by 2002:a81:778b:: with SMTP id s133-v6mr9144610ywc.31.1534866974316;
        Tue, 21 Aug 2018 08:56:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:9c5d])
        by smtp.gmail.com with ESMTPSA id f6-v6sm6744577ywc.21.2018.08.21.08.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 08:56:13 -0700 (PDT)
Date:   Tue, 21 Aug 2018 08:56:11 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Alexander Pateenok <pateenoc@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennisszhou@gmail.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: cleanup PER_CPU_DEF_ATTRIBUTES macro
Message-ID: <20180821155611.GN3978217@devbig004.ftw2.facebook.com>
References: <20180821134030.lycgq7l7czetdngs@K55DR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821134030.lycgq7l7czetdngs@K55DR>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 21, 2018 at 04:40:30PM +0300, Alexander Pateenok wrote:
> The macro is not used:
> 
>   $ grep -r PER_CPU_DEF_ATTRIBUTES
>   include/linux/percpu-defs.h:	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak		\
>   include/linux/percpu-defs.h:	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES		\
>   include/asm-generic/percpu.h:#ifndef PER_CPU_DEF_ATTRIBUTES
>   include/asm-generic/percpu.h:#define PER_CPU_DEF_ATTRIBUTES
> 
> It was added with b01e8dc34379 ("alpha: fix percpu build breakage") and
> removed in 2009 with b01e8dc34379..6088464cf1ae.
> 
> Signed-off-by: Alexander Pateenok <pateenoc@gmail.com>

I'm not sure this is a meaningful cleanup, but then again, why not?
Can you please repost the patch to Andrew so that it can go through
-mm tree?  Please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
