Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943E0C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3533A20856
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2RqU4Bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3533A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbeJDHWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:22:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38629 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeJDHWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:22:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id r77-v6so2304635pgr.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 17:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IR4L5sY3osFQfSsbbpfpMeUP7zquVGvASIBs/79thSQ=;
        b=R2RqU4BkEwcoOhfscl481xlbT6ETjwnXLizQPx6v+9zWSX3hZ0ApslcWbtPQwxRJxe
         vZ4lR+MXTaM6P7Q517Mydk8l4bmWmQp8nw6vOqzgDUAnF97AJJOvx07dFLnycucrlaMg
         VJi3ND8tk+ddU2FFGuH301O9tEVUgl/3J37xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IR4L5sY3osFQfSsbbpfpMeUP7zquVGvASIBs/79thSQ=;
        b=JUiUvysO2NaYragnP+ZfkxkQG4MHUmNTNetvAzk4G6077DWORm9XDrXBThlpS6z6Qf
         YjEqKk+7DLH6eZLopgBGvo6cfX/UoLrpYQHN2txjF7hPPxY2LWl0dki1VliAU016rCIg
         hrF0ncir+ht7KlY/rirA/DAZC2m8Dlp3oFYAqOx14+hCD2jDtKkezwSOBtvASoi3lgV+
         8jKr4FgqKG2Dqfvu5qp3udRBZdWNTrpU40mjjWu6JuCEiftWi34KlAUA8kLoEyKAnt0V
         5J662p8MEcAlEw+8/DIq5q/RsX3+/+xsZaZbfoqgKUyDAWpVWwMyJD3ky5eUbF2m/0Xf
         VZVA==
X-Gm-Message-State: ABuFfoiHndCVHD3KvVukCJzNwoHXz9jKEJC9n2fL9Ow7m5ocEkkojixZ
        P+tP7R47cs01MzIpB4lX68xDmA==
X-Google-Smtp-Source: ACcGV632ANbZBQJR0OF5RSvADSfynwy4DORlxr35Jxib9AcZAJ9QfPjiTqQ4fNSxHxV6D6HotPf2sQ==
X-Received: by 2002:a62:c999:: with SMTP id l25-v6mr4078411pfk.10.1538613097362;
        Wed, 03 Oct 2018 17:31:37 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c24-v6sm8719102pgn.60.2018.10.03.17.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 17:31:36 -0700 (PDT)
Date:   Wed, 3 Oct 2018 17:31:34 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     ohad@wizery.com, clew@codeaurora.org, sricharan@codeaurora.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] rpmsg: wakeup poll to notify signal update
Message-ID: <20181004003134.GV2523@minitux>
References: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
 <1538566463-24627-5-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538566463-24627-5-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03 Oct 04:34 PDT 2018, Arun Kumar Neelakantam wrote:

> Add support to wait on poll to get signal notifications.
> Send POLLPRI mask to indicate the signal change.
> 
> Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
> ---
>  drivers/rpmsg/rpmsg_char.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index c983d6c..aee5561 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -64,6 +64,7 @@ struct rpmsg_ctrldev {
>   * @queue_lock:	synchronization of @queue operations
>   * @queue:	incoming message queue
>   * @readq:	wait object for incoming queue
> + * @sig_pending:state of signal notification
>   */
>  struct rpmsg_eptdev {
>  	struct device dev;
> @@ -78,6 +79,8 @@ struct rpmsg_eptdev {
>  	spinlock_t queue_lock;
>  	struct sk_buff_head queue;
>  	wait_queue_head_t readq;
> +
> +	atomic_t sig_pending;
>  };
>  
>  static int rpmsg_eptdev_destroy(struct device *dev, void *data)
> @@ -125,6 +128,12 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>  static int rpmsg_sigs_cb(struct rpmsg_device *rpdev, void *priv,
>  			 u32 old, u32 new)
>  {
> +	struct rpmsg_eptdev *eptdev = priv;
> +
> +	atomic_set(&eptdev->sig_pending, 1);
> +
> +	/* wake up any blocking processes, waiting for signal notification */
> +	wake_up_interruptible(&eptdev->readq);

This will execute a full memory barrier, so you shouldn't need to use
atomic_t to carry this information.

>  	return 0;
>  }
>  

The rest looks good.

Regards,
Bjorn
