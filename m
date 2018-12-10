Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FC0C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387B12081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZeYc7Y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387B12081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbeLJAmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:42:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38167 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeLJAmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:42:22 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so8074489ede.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 16:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hE20hDo5Rwwr+mkT8oHP/UWTe73s8sswUikAmc5hLMQ=;
        b=cZeYc7Y4ZQD9c8PhB+oqm14Ck7co6KMatalBCtfTOAxwUv9wHWjjb14b/ngbedS+7r
         wyFJcjfm4OXEGSksoPLQUtLYe9/kVDWEfAyExZh01fv47j9z2FzvBIvctXL2vxdYKOhN
         G1Taw+TGgCaFtBa8LAWh5NQ3eKKREsdIu77hqNfMVyuFryFY8hsnlS3m4F/WIUr5hOjp
         RfTkMaJicaZbmsxkOsuTfCXeaqqyIj9Dr+FymlFOQVVhyOdMty2joX3J6cPrgehUUWRT
         489nJvE+vW0qJYL5MZ9/nR5jBuC/ME/83xRIJTLmXlc8QSsBBfP/Wa810Qm51Gadib67
         CjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hE20hDo5Rwwr+mkT8oHP/UWTe73s8sswUikAmc5hLMQ=;
        b=bjKelMiGH7IFFHOabZPezhGlI77TP4h+NSIMAS4N9esFLcZwLjEThGxunOYuNGO5Br
         zN25gdZj1cfZYBAx9UD7zMjfc03fRcbQQSFUa2ZnLsnVylFS7SgyoHrWCLzqPmL2j5KI
         LMmPzuJHjU5QyW7IFdxJ2SpjMgEUIHhxy/CB+OUOoIAK8x4ng2EVs5nWGpSUW787DHg6
         vRo8n5TvkOcpai9elS7Fl/z13NmV2v0gFKn+vdcuRFi3cOEXWw+aXa1DCSlXI4YUNjF2
         ibVerP6cz/U6+027XQiBS7Jb2Zsee77RliOeDweP0/N0APed5Ctq3Lpnndd4DR3j417i
         ts6Q==
X-Gm-Message-State: AA+aEWa0wbQ3bjYFe+Od7h6+PQwlinm92DYUkdxR1v7pDSwZdXFFig6x
        yKe6ShdM/0aU2jzYX73si8I=
X-Google-Smtp-Source: AFSGD/U9PfRVnyqDMNaZ9p5AQ+4V1K/IgdshJZ9fDvaMGpqxHdPKeNZFCXGXqqqrHcPUSDotZeHD5Q==
X-Received: by 2002:a17:906:4ed9:: with SMTP id i25-v6mr8091952ejv.75.1544402540492;
        Sun, 09 Dec 2018 16:42:20 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:e8b1:47b5:cae1:da95])
        by smtp.gmail.com with ESMTPSA id a11sm2979095edc.28.2018.12.09.16.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 16:42:19 -0800 (PST)
Date:   Mon, 10 Dec 2018 01:42:18 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Thomas Jespersen <laumann.thomas@gmail.com>,
        gaoxiang25@huawei.com, yuchao0@huawei.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: erofs: Add braces to do-while statements
Message-ID: <20181210004217.ufzvj4rvykiqoufd@ltop.local>
References: <20181209155900.10164-1-laumann.thomas@gmail.com>
 <20181209162007.GA22432@kroah.com>
 <f741ac1808f05f2efe6532491e8b1eb6ac74e260.camel@perches.com>
 <20181209194029.GA31163@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209194029.GA31163@kroah.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 08:40:29PM +0100, Greg KH wrote:
> On Sun, Dec 09, 2018 at 09:27:01AM -0800, Joe Perches wrote:
> > On Sun, 2018-12-09 at 17:20 +0100, Greg KH wrote:
> > > On Sun, Dec 09, 2018 at 04:59:00PM +0100, Thomas Jespersen wrote:
> > > > This fixes warning reported by sparse (with -Wsparse-all).
> > > 
> > > Why is sparse warning about this?
> > 
> > Probably because it's the kernel preferred style
> > to use single statement
> > 
> > 	do {
> > 		<foo>;
> > 	} while (<bar>);
> > 
> > over
> > 
> > by about a 20:1 ratio.
> 
> Sparse is spitting out coding style complaints now?

To my own surprise, it's effectively sparse that complained:
	warning: do-while statement is not a compound statement

with the flag -Wsparse-all (or -Wdo-while).
But -Wsparse-all is not a flag normally used for the kernel
(or normaly used on anything at all).

-- Luc
