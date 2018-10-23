Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDE5C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539D1207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539D1207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeJWRXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:23:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34321 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbeJWRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:23:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so11096000wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IuJ6Ztf6Y30g1yRYKpTKTKqEwQlISTp0J/qfNueSsoo=;
        b=W7gLuXC8gKJpXgQ0Dwm48CAVmlInuUS3UhAfOa9WQdeAxExs44RGUYDf7fi5GZrmq/
         PJaQjuA6TDW082kfTMBGS6bPDeSh+0gIpugLfnuF6VmAk81qaCikz2w4fM+v4zeSUTV1
         Ep6L9KHoO3RItEM9cGiXMmEkVq7+Oocn2IOzayFMp71eso2XTCt6UT1FuuDDh5sQg6ma
         XaCF6TlcTq2w+DemF19ihpEkyNCbn0Bx7t2TABSAZW2Ngb1z9Ud7em4vzAa1W0WpHs0i
         tJ2Z1qqt0vjlooo7GQw8AI/NlYFC85noNdWtqJieFAaHkNEK1d/w967Fi96IhGM9QvBF
         6uWg==
X-Gm-Message-State: ABuFfoi1rp77XdcIfgGuf/+JsR+Qb6j8VSRyQLD4eYlbx+Ptx10PzNge
        VMTuiOl4O6MYfJ0V/1V93UaRDA==
X-Google-Smtp-Source: ACcGV63xUnsggZTMpHsoOojDryIpSRnGyXhjvERCzVqrNIG/JdYZiE4MIGh7Hq5CMNokzuUgJpojlg==
X-Received: by 2002:a1c:8601:: with SMTP id i1-v6mr18863866wmd.148.1540285281566;
        Tue, 23 Oct 2018 02:01:21 -0700 (PDT)
Received: from localhost ([185.7.230.215])
        by smtp.gmail.com with ESMTPSA id p7-v6sm1054098wrt.10.2018.10.23.02.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 02:01:20 -0700 (PDT)
Date:   Tue, 23 Oct 2018 10:01:19 +0100
From:   Moritz Fischer <mdf@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        mdf@kernel.org, atull@kernel.org
Subject: Re: [PATCH] zynq-fpga: Only route PR via PCAP when required
Message-ID: <20181023090119.GA2205@archbook>
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

seems like a good usecase (though uncommon), question below

On Tue, Oct 23, 2018 at 08:31:19AM +0200, Mike Looijmans wrote:
> The Xilinx Zynq FPGA driver takes ownership of the PR interface, making
> it impossible to use the ICAP interface for partial reconfiguration.
> 
> This patch changes the driver to only activate PR over PCAP while the
> device is actively being accessed by the driver for programming.
> 
> This allows both PCAP and ICAP interfaces to be used for PR.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  drivers/fpga/zynq-fpga.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 3110e00..f6c205a 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -497,6 +497,10 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
>  	int err;
>  	u32 intr_status;
>  
> +	/* Release 'PR' control back to the ICAP */
> +	zynq_fpga_write(priv, CTRL_OFFSET,
> +		zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
> +

Shouldn't that be after the below stanza that enables the clock?

>  	err = clk_enable(priv->clk);
>  	if (err)
>  		return err;
> -- 
> 1.9.1
> 

Cheers,

Moritz
