Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C04C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E8220864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSLnfJqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E8220864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754935AbeFRG1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:27:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34458 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754543AbeFRG1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:27:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id a63-v6so7642671pfl.1;
        Sun, 17 Jun 2018 23:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B1sy2nA0goVTcv/3oZ9b1w/x/Xcq7kdQ2jxucQ1xIdM=;
        b=TSLnfJqV3NbJbjfe6grnbrQbDzbTNCS8okty2m+LIx+V9p92X4bPl/QT/nTYS277pz
         +vAOci/FeqCBQvtDF0RmKJeyhFvu/l+IZE0TNp0KJZ7O8I6ciQgBM1o0/OuuUtrijOk7
         1AQuCw7dItjIN29Nk38m5l8QHghqu5DD91Tsl1/gEnsqSYchzhRyyh2w9AxXarYh++31
         /NbkVrMIJrYv5Jx1FxpH+QMOa3SlyhNqLUxJmjWtzPDBCxR4pBfszZg90qM+UbJTYzLt
         A1kTtBezOoEhezRFdEyChWBuyVoajl7DyMX1FfxmZkmMOHZSj3BIYzpKeQBR3hPd8o9r
         YPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B1sy2nA0goVTcv/3oZ9b1w/x/Xcq7kdQ2jxucQ1xIdM=;
        b=pa9CUrfloeU5EP+6aWtvh8HhYguCaJ229+Vi+ouMH+wPMRrWTUlSbA745pQQ69wLP7
         RZi39eCGDrMQ/FHN3ze6AeB0+qyBXHck80T/oVMliIyDUy9jALFKLHmaj59vZBbNBL7p
         KAH/IMHTWRNF8+22EuK6CBbsDkxMKyMidClaGqxugG0yQVJNwMUzZNb3k7G7OUjp4Il5
         uKvfVg/OrcnbXwArXRu9L+N+UMo17w88440R092zjhjBQB0GW7yg/tnrz/8LqBV72sdc
         5NgvraIjut9S9dAOa5JSZCl1JrJUDBGuXa6x3YHxCuEiM1JnVXhbMe8mg+vzOpMfVksd
         1Rqw==
X-Gm-Message-State: APt69E3XiBVwt+xNDQc5n0x1McfFpih0Fr1d+Ia38ORBCxfJ+ZmT/wUm
        rrbf0tWx0mvVEIbTyYCM0ok=
X-Google-Smtp-Source: ADUXVKKVovlj0gSwRvBrsRgNGgxsbpNoBPrABvcKEl1WO02TfXAltFwV2WGoXjfVr+oUpNQGvWvLEA==
X-Received: by 2002:a65:5143:: with SMTP id g3-v6mr9805663pgq.190.1529303255784;
        Sun, 17 Jun 2018 23:27:35 -0700 (PDT)
Received: from localhost ([110.70.54.122])
        by smtp.gmail.com with ESMTPSA id q69-v6sm39938046pfl.16.2018.06.17.23.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 23:27:34 -0700 (PDT)
Date:   Mon, 18 Jun 2018 15:27:31 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 1/6] printk: move printk_safe macros to printk header
Message-ID: <20180618062731.GB27996@jagdpanzerIV>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180615093919.559-2-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615093919.559-2-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/15/18 18:39), Sergey Senozhatsky wrote:
> Make printk_safe_enter_irqsave()/etc macros available to the
> rest of the kernel, so we can use them in TTY and UART code.

Sorry, this patch is incomplete. Since we are going to use printk_safe()
API in modules (serial console drivers) printk_safe() functions [enter and
exit] must be exported via EXPORT_SYMBOL_GPL().

	-ss
