Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3B9C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421D820866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CghbByFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421D820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeIKUix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:38:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40303 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbeIKUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:38:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id l63-v6so12455662pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ob5BRhp5wcGH7FAFFwf5FJfV2+4Ssan30hOv8Hcvxu8=;
        b=CghbByFS/4vROeoHHLNy3IeNr+oYwkWjoQa+m1iC35Y4lAq8JVC+NnrawC/7ki8gIp
         XfN75/sED82u/ThYE1yG8kr4vZrINpnytmqMgFzdtH5CaCOrU3mNBEAHzzObmYGhcaTE
         6SWn6nqXbVfqgxVnOMJXIC7W+lckgtlonWIEi885vegcz5USlRiaDe65AU70uhX61GOc
         2t70K6gfFVF+39xXGXjR/mSf4YBIw3EdLU/2ddW0cGJUhYwlA5jKFhQq0fLIuIZA+/pp
         U6YonSPADPvBl7F4b9QY9rgD+KyTHM6TEveDrdc0VI6LOaxtXgLqyqM2zJavN74tqgaW
         RJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ob5BRhp5wcGH7FAFFwf5FJfV2+4Ssan30hOv8Hcvxu8=;
        b=lxHfnGjk2Pc5BU0HVaExnpnfM+JI59shgHIFHmozF2oPdOBabtbi5+kQCX+y/nRONh
         Hobdi818RSvfvg6cT9QKiRPqgNRiqVqQlVx7Cmvx+KbbE2YAeHMD/R9Fg/6KMj+MA4RT
         2+cnnNjn68yTzRPtRpwWRGLyfVL0KKX4eBdj8IbZHsRuExRCUnGDOhMBSaX6goNXI0wG
         YU9zaYEIquc4NYyJmTxLT7GMnholA8OC8JU+jLx7RPrVekjJzeS4Hj8oOMWSJ/WqG4s4
         pfW3b0fvE1M1YnIM9a1QJ1e9XCA5JJNVqckmKHmX5UHpxY6rwStWQn2uFA3uASehuyYt
         HPWw==
X-Gm-Message-State: APzg51DuPBoGn6c0PnqxTOKRl2ri7Ifn5bPClZ+2U/HX2nhiGNnMKGDL
        sivfHNYbCrEZ2zPdPFC2EjGwcw==
X-Google-Smtp-Source: ANB0Vdb/dKG46tQdqj+0XhIu5y9APwwLkZhX/dIEIJU279rwPql9AoilUZ6n2bS1YjLPev0GGLG45g==
X-Received: by 2002:a62:49d5:: with SMTP id r82-v6mr30081091pfi.245.1536680342101;
        Tue, 11 Sep 2018 08:39:02 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id r17-v6sm44305499pgu.83.2018.09.11.08.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 08:39:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fzkkm-0004l3-RX; Tue, 11 Sep 2018 09:39:00 -0600
Date:   Tue, 11 Sep 2018 09:39:00 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     dledford@redhat.com, benve@cisco.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: remove redundant condition check before
 debugfs_remove
Message-ID: <20180911153900.GA18253@ziepe.ca>
References: <1536414571-32675-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536414571-32675-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 09:49:31PM +0800, zhong jiang wrote:
> debugfs_remove has taken the IS_ERR_OR_NULL into account. Just
> remove the unnecessary condition.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_debugfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
