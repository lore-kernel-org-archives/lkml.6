Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A71ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34B920856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aqqN8v7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34B920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbeGWWmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:42:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38489 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388151AbeGWWmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:42:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14-v6so2098646wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8FDskwpmSla9CJp78cSwPvcyGMeCAp5auc8Du6fRaXA=;
        b=aqqN8v7s+Ei9PYO5pAoZwCoWypgWUWCmmWoofST4afH+MvnvPhLSyjhDb8u415QtI5
         3G5Q/OzLejlmuYJ24WSHUX9ME7mEtk6m0crReRC3l3CXLFPxKrSWQaskuLVQ7IWjhu0I
         3Sehv9IPI1VaPOriWhP0ktQbReJea9DXOXPNbxJjz83R9HAYXoPcLfiFR8AMiENIhLsz
         B3ZpEKywCAcP4ffIirP0ZEI6LV9xNHvjVHh/CJouwntYjdJOCilXCkvbblZgSy30zdEs
         PcR6PxQPsioFlxMXQao5CJrV1/3PFfs1l3DgNGep3UhoxQyEdj2I4EH2Qkg/gpwaLuP5
         fJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8FDskwpmSla9CJp78cSwPvcyGMeCAp5auc8Du6fRaXA=;
        b=GupmYSKkroyZ4nb5YtaFtJCmvkNbGjopyVD4lRj8JxGOaKpJqBq12Vscd2jJlcEkY9
         inSCw5sZNgE79qFbdOZFr0Rj0ssbuOxBCPJXrR4BzOj703hsDQJGtQYLEfci9IwhqRx0
         xBYRZ+dHUQ/BFycWFNr6BrFdBAdh60TSjr0sgceDBIpXq+tfLgaQh2WawTumxM0fSCeh
         DOTwWPklKz3oUEYbkvXvOxnWXvDahWDjmbLYvzxqUUadBm33S5Xvk8Jg5JkE5exrHDTQ
         AZWMT/rzP3FfvUaClCgOaY8VXdkutIB66fFsWZseYkFEsi2hrpPn/iHm5BUPSAgX+/Z5
         n3Ig==
X-Gm-Message-State: AOUpUlEyjShVRLMUP5cu1jGTmY7Pjgi4kDvsD5islJhA7kAb+C9DM4u5
        fmadZWS2hEQLWXwAI4BhdS2f5g==
X-Google-Smtp-Source: AAOMgpc99yFmKjWTfU4K6w0OGfN7BAY34bwzpWjc6kCz3OmbBWdm1ys2SZRoItcF3Ngdjrkhs5cyeQ==
X-Received: by 2002:adf:ae01:: with SMTP id x1-v6mr10234511wrc.45.1532381937662;
        Mon, 23 Jul 2018 14:38:57 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id c124-v6sm11742352wma.47.2018.07.23.14.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:38:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fhiXb-0005mY-KH; Mon, 23 Jul 2018 15:38:51 -0600
Date:   Mon, 23 Jul 2018 15:38:51 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Alex Vesker <valex@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Feras Daoud <ferasda@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Evgenii Smirnov <evgenii.smirnov@profitbricks.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH] IPoIB: use kvzalloc to allocate an array of bucket
 pointers
Message-ID: <20180723213851.GA22162@ziepe.ca>
References: <1531144263-24717-1-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531144263-24717-1-git-send-email-jan.dakinevich@virtuozzo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:51:03PM +0300, Jan Dakinevich wrote:
> This table by default takes 32KiB which is 3rd memory order. Meanwhile,
> this memory is not aimed for DMA operation and could be safely allocated
> by vmalloc.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
> Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
