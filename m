Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C26FC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1167208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ys3l0kWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1167208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJFNVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 09:21:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34622 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeJFNVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 09:21:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so5644360pgs.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 23:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pIfDPQf4kmdTqtaxVRk/iC54yniFvAOAZm0UYWcczkE=;
        b=Ys3l0kWfuA65DSZ3xe9rbPCqoiUMlhn6b117HKkaQW+gsimFqCjKhP81EOyt5+UeFU
         K75uQBTnIlyWq4eADpXuA6hViU9MIND7Huu3/1KIl5HmbKU7yPUqYiblTrjG+T68NsWk
         NBfQmibk+rAdxdrnZSKbTfpjdHKt5DP83Kpmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pIfDPQf4kmdTqtaxVRk/iC54yniFvAOAZm0UYWcczkE=;
        b=EsM2GmWFlbJLw8fIxphkoQ0Dk/MkLNQ9BjCq8G+SN7mO50aSfITUf2V5Fheye/v6FG
         kTzDjU7KkgTxqJsP+d6eQVQ4yNvnyIchjOjJOvuf92T8rTbvGs07b5VCZUfS9ACcVE/0
         4zvMO4G7BgzoSPSvT3HbDvEOVby0kGYy8Td+03hs0J5JNf56/72AKhSYZ8arZ4robicO
         BoT3NZsRBrILiRA10nws5lH9xSWGrpi6VYL6ShmXmNoYM9AWYY4LhQ/miGyzEkxjjWk0
         4G0aNGg6Yz5RGWfz0H792qn7jG+2oSJFc2VA0GPaZj9AyVp2qzlsNd1Aj1FrLrON0+ow
         4/0Q==
X-Gm-Message-State: ABuFfoheYWnfW6FczVadXqVFe7E/nX7tZfOFs1B0x3MHqcrCxzHlucNu
        HxE+IkjPeHXGvVWdsry9W+rqaw==
X-Google-Smtp-Source: ACcGV60Axtw1hq1oey8Fpo+KhZuuCcUtgGrfr80IfDcye2EsFHJPtaRyokOZewMDyKx0ierB/rm/7w==
X-Received: by 2002:a63:3285:: with SMTP id y127-v6mr13258165pgy.104.1538806786247;
        Fri, 05 Oct 2018 23:19:46 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g62-v6sm15451151pgc.22.2018.10.05.23.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 23:19:45 -0700 (PDT)
Date:   Fri, 5 Oct 2018 23:22:32 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] samples/rpmsg: Introduce a module parameter for message
 count
Message-ID: <20181006062231.GF12063@builder>
References: <20180911174643.26199-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911174643.26199-1-s-anna@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11 Sep 10:46 PDT 2018, Suman Anna wrote:

> The current rpmsg_client_sample uses a fixed number of messages to
> be sent to each instance. This is currently set at 100. Introduce
> an optional module parameter 'count' so that the number of messages
> to be exchanged can be made flexible.
> 

Rather than sending N messages as fast as possible to any sample channel
that comes up, how about making the sample create a debugfs entry that
we can write messages to from user space?

That would make it possible to improve the handling of multiple
remoteprocs and would allow for a variation in message lengths etc.

Regards,
Bjorn

> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  samples/rpmsg/rpmsg_client_sample.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/rpmsg/rpmsg_client_sample.c b/samples/rpmsg/rpmsg_client_sample.c
> index f161dfd3e70a..9b6b27ea504f 100644
> --- a/samples/rpmsg/rpmsg_client_sample.c
> +++ b/samples/rpmsg/rpmsg_client_sample.c
> @@ -22,7 +22,9 @@
>  #include <linux/rpmsg.h>
>  
>  #define MSG		"hello world!"
> -#define MSG_LIMIT	100
> +
> +static int count = 100;
> +module_param(count, int, 0644);
>  
>  struct instance_data {
>  	int rx_count;
> @@ -41,7 +43,7 @@ static int rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
>  		       data, len,  true);
>  
>  	/* samples should not live forever */
> -	if (idata->rx_count >= MSG_LIMIT) {
> +	if (idata->rx_count >= count) {
>  		dev_info(&rpdev->dev, "goodbye!\n");
>  		return 0;
>  	}
> -- 
> 2.18.0
> 
