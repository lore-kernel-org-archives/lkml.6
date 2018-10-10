Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74CDC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86285214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XMKHydtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86285214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJJV3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:29:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40445 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJJV3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:29:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id b4-v6so5732496qtc.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uGyx9ee2MgBE3ANC+X4D2hwWA6j0A4+rtNyUpD4jAos=;
        b=XMKHydtvXllcC3YBxm0LDIGgw8evthxqTjxtykffLLIOhchIX9dUCaLkpwtYOYpRYh
         A6PbUmsBIXi2dMRHoeHxGDkzbc5IXOsy7vtq5ARbpZFzSzasDDxu9xnxLrT9j5U3hxtp
         CVuOqKVwaJWZTaP292Iq7s844wEOszeTMZWY+cnAH1TJWK3Gozn9ROyRrRZcxeR9GAIL
         bHjjSl+I18d1t7qbmEx5h0CRIRrL51kIccZ2gqdgyECRqcO/yhp9LzQlqwhFBLvQ8GvK
         gwfOLgnMybLaBXPKkoBt9I+qYu3KcQN84WEqv6waPpcUnCQmHhMFSyMue3nMSQGryioM
         bsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uGyx9ee2MgBE3ANC+X4D2hwWA6j0A4+rtNyUpD4jAos=;
        b=eD4He400oh3OnEZRajoTVlJaI0Wj1+e1zfbFtLEEIUnB8ZQpUQ5FecaKgnxGZkX/HI
         7lRHwnZb2kYPVCdCj/KS3rDtUZ94MCeJSidtsmjtfRfP1T/aJUtGAxhaR3ZRZ1YSvMp9
         u7QxsrwpVXGOfVp+7nZ/zVE755nvBt/2qvibM+NVvO3FQzz7/zPWo+j24kMYgfQk5Q7p
         BwirOJ4sYcYdSIlT+zGJ3W0ig9Z548Gosl01kvY5dV5XW0vz3Xuv2e14Jeh0HpfoXc4w
         //VUFb6PTQa803iJAbUWEc+xHYtVD+9yY9UmAo0Kzv74MskfA7HVsX4PZao3X03NVwmT
         hNwg==
X-Gm-Message-State: ABuFfoi8h0QcbYrSZHH9HoyzAf7YsUNSXvrQSxM66Y0lVnD3ZqHQAdkW
        ipV75N1kD5jMXTfKh268ugE/xA==
X-Google-Smtp-Source: ACcGV63ZZuHyIbMeCO4udo17Sz6I8LOoKOQaiExEU4aQz9Z1oL7JwYbYeZr2dsycXwFUPDuyJlqV9A==
X-Received: by 2002:aed:3d4e:: with SMTP id h14-v6mr27272521qtf.222.1539180400365;
        Wed, 10 Oct 2018 07:06:40 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id p3-v6sm7977208qtp.55.2018.10.10.07.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 07:06:39 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gAF8I-00015l-5i; Wed, 10 Oct 2018 08:06:38 -0600
Date:   Wed, 10 Oct 2018 08:06:38 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: fix unused-value issues in tpm_try_transmit
Message-ID: <20181010140638.GA3894@ziepe.ca>
References: <20181010133817.GA11485@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010133817.GA11485@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 03:38:17PM +0200, Gustavo A. R. Silva wrote:
> Currently, there are some values assigned to variable *rc*, which
> are never actually used in any computation, because such variable
> is updated at line 550, before they can be used:
> 
> 549out:
> 550        rc = tpm_go_idle(chip, flags);
> 551        if (rc)
> 552                goto out;
> 
> Fix this by removing such assignments. 

Should this be done by not quashing rc during the error unwind rather
than dropping the errors?

Jason
