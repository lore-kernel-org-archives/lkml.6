Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEB0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 23:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA32D208B6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 23:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA32D208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754391AbeFQXGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 19:06:25 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48163 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754256AbeFQXGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 19:06:23 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fUgkV-00023d-OI; Mon, 18 Jun 2018 00:06:19 +0100
Message-ID: <1529276779.2289.243.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 234/268] enic: enable rq before updating rq
 descriptors
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Govindarajulu Varadarajan <gvaradar@cisco.com>
Cc:     stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 18 Jun 2018 00:06:19 +0100
In-Reply-To: <20180528100229.860636552@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100229.860636552@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 12:03 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Govindarajulu Varadarajan <gvaradar@cisco.com>
> 
> [ Upstream commit e8588e268509292550634d9a35f2723a207683b2 ]
[...]
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
[...]
> @@ -1765,8 +1765,12 @@ static int enic_open(struct net_device *
> >  	return 0;
>  
>  err_out_free_rq:
> -	for (i = 0; i < enic->rq_count; i++)
> +	for (i = 0; i < enic->rq_count; i++) {
> +		err = vnic_rq_disable(&enic->rq[i]);
> +		if (err)
> +			return err;

This added code is wrong: it overwrites the error code that was
previously in err.  If vnic_rq_disable() succeeds, enic_open() will
wrongly return 0.  If vnic_rq_disable() fails, I still don't think it
makes sense to skip the remaining cleanup actins.

Ben.

>  		vnic_rq_clean(&enic->rq[i], enic_free_rq_buf);
> +	}
>  	enic_dev_notify_unset(enic);
>  err_out_free_intr:
>  	enic_unset_affinity_hint(enic);
> 
> 
> 
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
