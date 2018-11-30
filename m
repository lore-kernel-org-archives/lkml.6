Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8723C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F0420867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0dsc5VD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F0420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeLAFrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:47:21 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37792 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAFrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:47:21 -0500
Received: by mail-yb1-f194.google.com with SMTP id w129-v6so1029576ybe.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3QucDN4c6LhmArqpBJNDjt5ano557pOI5HtgceMAoOE=;
        b=b0dsc5VD3FyxbKftzqSK3HLLhtKq7txfc/MlSIeotLsOQcm5lpNwLrjmUwsOBwyvh5
         ZyTGq4C/gGdxhPzO7wwC7jWl4fzLjYBp8SCdO4qqosQISrgr+Y6lXzADiTL40fu3D6uI
         D6GFnHSodAvZOu1GvSlfP8skyZGzyZiktt2Y/hV+je0FUaHxRRta+bfZ2J5nfzqdBX0x
         hExh3UnpnlOKCwZfGRSDlDm/0Kt4m8H2AzSp4DDZRsbD/2IUp6R/NdWuJb/ofXpfa4k/
         lI/uU1uzJfhgvf8mKjae8+lV4WXLOnFe90cJvGnKrOAHIGk/uTaHkMr8EGSd280FuAUh
         VJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3QucDN4c6LhmArqpBJNDjt5ano557pOI5HtgceMAoOE=;
        b=SljSe4fUqbgULHYDKfB0QR/bUCw/9ZQQIKRMjZrrGVkP58HMCdgsiQYqPK5/oaVf3N
         ITrI6xi5mD7FjgMFKsT0remPv8wC/7Ne7r3DoBQ7G0591SZStARBpEsT+kj6bYbVrEa4
         I65dWT26t/TT2VJKP9mFAcTnhU3DBfggPLGkkwr/3gsPHeipLfJkDCpi9nINU0xa4aE2
         EfLHG8zh5OPvzyY5TaZ+PRq5HiFZvtCMtRrnY5bRaFctKBMJ1mOtiyYpOjjGlKUZSBR2
         38Qxl43otiZ4ZSGOeOEQl2B/wsrKx7WKqo4O7XO8e2k4WuFiMxnLI1GV/SqsO1qPQhlS
         +03w==
X-Gm-Message-State: AA+aEWYlxk5MYIqiNJMYfXXTPdUu/fISdDCFI2aUTSxEPmY2ZvHB3sOl
        CJkL6v/OYy23UbiRUJrTabheIu63
X-Google-Smtp-Source: AFSGD/VOhZQKsfBqJqZJoKT0fIwNOzuzxHfE93n1O/vNbZy1rNnIbU0Z3pUGMjsNaFlJOdlhsRzlsg==
X-Received: by 2002:a25:5e44:: with SMTP id s65-v6mr6505342ybb.491.1543603030178;
        Fri, 30 Nov 2018 10:37:10 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:51cf])
        by smtp.gmail.com with ESMTPSA id f67sm2094341ywa.93.2018.11.30.10.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 10:37:09 -0800 (PST)
Date:   Fri, 30 Nov 2018 10:37:07 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] async: remove some duplicated includes
Message-ID: <20181130183707.GH2509588@devbig004.ftw2.facebook.com>
References: <20181126143710.31409-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126143710.31409-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 09:37:10AM -0500, Yangtao Li wrote:
> we include workqueue.h twice.It's unnecessary,so
> just remove them.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Ditto.  Please route through the trivial tree.

Thanks.

-- 
tejun
