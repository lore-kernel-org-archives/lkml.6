Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9CAC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E245F20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E245F20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeILBPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:15:25 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:51793 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeILBPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:15:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fzp3L-0001sr-Ft; Tue, 11 Sep 2018 21:14:27 +0100
Message-ID: <1536696866.3024.151.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 51/79] bnxt_en: Fix for system hang if request_irq
 fails
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Vikas Gupta <vikas.gupta@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>
Cc:     stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 11 Sep 2018 21:14:26 +0100
In-Reply-To: <20180823074922.442947994@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
         <20180823074922.442947994@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-23 at 09:53 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Vikas Gupta <vikas.gupta@broadcom.com>
> 
> [ Upstream commit c58387ab1614f6d7fb9e244f214b61e7631421fc ]
> 
> Fix bug in the error code path when bnxt_request_irq() returns failure.
> bnxt_disable_napi() should not be called in this error path because
> NAPI has not been enabled yet.
[...]
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4591,7 +4591,7 @@ static int __bnxt_open_nic(struct bnxt *
>  		rc = bnxt_request_irq(bp);
>  		if (rc) {
>  			netdev_err(bp->dev, "bnxt_request_irq err: %x\n", rc);
> -			goto open_err;
> +			goto open_err_irq;
>  		}
>  	}
>  
> @@ -4629,6 +4629,8 @@ static int __bnxt_open_nic(struct bnxt *
>  
>  open_err:
>  	bnxt_disable_napi(bp);
> +
> +open_err_irq:
>  	bnxt_del_napi(bp);

Shouldn't this added statement be conditional on irq_re_init?

Ben.

>  
>  open_err_free_mem:

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
