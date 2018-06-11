Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CAFF1C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BABA2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CA8utGgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BABA2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934451AbeFKSpI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:45:08 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36978 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932890AbeFKSpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:45:06 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so12823237plc.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=43LYQuFQgVouFcoJvkN0NnW3dfJERAeNPA0OpRLdizY=;
        b=CA8utGgMcQFkWbeZpWn5FJm16CttHlxAORXmV+yG6T5wcwlNRQ+AKN85KszD1SmJyw
         ZDAUCJW09Cs8Vau1GnoI5gwibGPwqNAiYV8oL39TbsBPi17vno35JmKGuKTzkY1XJLLN
         w3JAkh4MkKr7iQHc/K5Slp4XVlTUtVnEQ3qVgDs5/yP2uTTOa0ypOs6zC8oHP4tVVC7E
         LcC+nukAj3Es7SD26t6TpsWS6c+o5hAPvs1Uftz2hy52zugf3Jx/yKWLi/yGh/wHoIb3
         CNv9irp1rwIQgl0iHc9jwzMbWoJBWWXUMH/tt+r/qfhafRpy7TVtAFrqwN04aMTYQVCM
         dIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=43LYQuFQgVouFcoJvkN0NnW3dfJERAeNPA0OpRLdizY=;
        b=qPPGTqxGg9v4Ke/+J76G3Wpnaj4Fglo/JwtE5okwY81hGuoGh3ch2nmekQ0kq9vfhR
         BG1NqveMuCxt0u6H9Lr2M7vfzX5XiGFcH/3FbsvfSpAXXifxHNDAXa8f5K2b6vcCnws6
         NHmTR8lBYwfAbHbXN1jGWDA5IN8SRdq+nPce1TKktJBuC9HShVdQ0ucfrAPaX144QtE2
         0pjl5sRvj35I1zXngGQe3rsVfvkFvgtul/pZRMmSI/YM4P07Gxm1C/Lds2weROJvBU2b
         GuUE5z9QFLcsTyyq0q06uvjZ3c1LgdCHzLq07t7Sq5lrtO3RaSnKKifwl4wLvc/yZX1K
         81cA==
X-Gm-Message-State: APt69E1IaPTlHNEqenHY35ZovMcHXlJhG320JOIkyvrFQKLNK4hH9UA9
        8jGg+Gb9inNh8oUMP5XiwwFUhWNtdzw=
X-Google-Smtp-Source: ADUXVKL702no+gHADdRp4Cq8a12fF4l8RUx0YhRAJMfVMxbdVYvaHCduV4K16lWmOm0EHpH2i1Py+Q==
X-Received: by 2002:a17:902:d20b:: with SMTP id t11-v6mr360269ply.282.1528742705835;
        Mon, 11 Jun 2018 11:45:05 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id z82-v6sm54055916pfk.30.2018.06.11.11.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 11:45:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fSRoO-00048r-Hf; Mon, 11 Jun 2018 12:45:04 -0600
Date:   Mon, 11 Jun 2018 12:45:04 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Cc:     yishaih@mellanox.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] IB/mlx4: Fix an error handling path in
 'mlx4_ib_rereg_user_mr()'
Message-ID: <20180611184504.GA15889@ziepe.ca>
References: <20180611181511.28025-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611181511.28025-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 08:15:11PM +0200, Christophe Jaillet wrote:
> Before returning -EPERM we should release some resources, as already done
> in the other error handling path of the function.
> 
> Fixes: d8f9cc328c88 ("IB/mlx4: Mark user MR as writable if actual virtual memory is writable")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/mlx4/mr.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
