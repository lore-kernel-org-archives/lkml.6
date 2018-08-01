Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFBCC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB7B20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTKGSYtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB7B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389940AbeHARbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:31:25 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:46136 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389602AbeHARbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:31:25 -0400
Received: by mail-yw0-f180.google.com with SMTP id e23-v6so7351486ywe.13;
        Wed, 01 Aug 2018 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2iRIvTtCfT/TckvoyJnhm+lHmpLh75hcNsaKnKZrJbw=;
        b=ZTKGSYtq8j7gZS7TPnehTZ6VPT2VmmeGn+/6fqPqNNkiBywEgJyN6fZ7qAfVb/5lIS
         hhM9o5UIZkhooPd6tvUWpfLIzvy0Q3M3i7j0GE9yS7d43WIo/pyBbZ94Jla1TgIFUFNf
         DqdcCuPCx+LNI1Q3ktsQHsrpd8k/FSvgCTD0S9T2PHXFMNjrD9vWblzEh/BE+xjEtNEB
         QfCRAxxKVBmUkCkhXg11w8ZEekJEz1e0glB+memDODLLlVXKrGW4eJguIk5PjqtHkVJt
         lpI5Lr3IF0NDe09kl9jCWudDh2RzxXrfHuXcrOSSBa0vViPEQY9Lw5gqGbc35dyeQVkX
         IqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2iRIvTtCfT/TckvoyJnhm+lHmpLh75hcNsaKnKZrJbw=;
        b=saKCziNtu++NDQejHEuukHE99ZulmH+pNiZc31KehfDRTdAjxpaILM6vjafy7aPAS2
         +AThOAys6JEQ0LMrGlHcwy0d+7/lTnVMVOgZxjZYGXt+YYCxeIZj8I77NzepS+MajAGa
         /l1/w0AW/jLNFyOcbOXWaBnnLusXUqooKWhu8GFcijdjnBtOMHnNDtoxa2swC6WlbJK0
         ZxEcKaWnjBQoFFmNXDaqDcWXCcrgMANKGOvZL4MYvN0Z5NHH1L2qUcKrXb8wK91kfIXV
         hry9lonOyMwY6GAs9uDV6FjWh7z9sCVG5mpYuHkYamUb5hMu+ranBau5IK2E+CsLvrFE
         TdsA==
X-Gm-Message-State: AOUpUlEBSL+rubVRsm17YHZjjQvhMBkDNfFuMGl6jgDWywmjgMP22qhU
        mfORqpCZMtXG6gyrsuSd+68=
X-Google-Smtp-Source: AAOMgpeT7+PXYt66+szMKV+yX2q/4MxdY7R5HUq9MLLg192G0xOz5J2rp37VSO1M5EY+QJbbHfud3g==
X-Received: by 2002:a0d:ddc8:: with SMTP id g191-v6mr14150391ywe.145.1533138305764;
        Wed, 01 Aug 2018 08:45:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:d2a6])
        by smtp.gmail.com with ESMTPSA id x69-v6sm13484645ywx.105.2018.08.01.08.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 08:45:04 -0700 (PDT)
Date:   Wed, 1 Aug 2018 08:45:02 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Juergen Gross <jgross@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vinod Koul <vinod.koul@intel.com>,
        David Kershner <david.kershner@unisys.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] libata-scsi: Move sense buffers onto stack
Message-ID: <20180801154502.GO1206094@devbig004.ftw2.facebook.com>
References: <20180731195155.46664-1-keescook@chromium.org>
 <20180731195155.46664-9-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731195155.46664-9-keescook@chromium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:51:53PM -0700, Kees Cook wrote:
> To support future compile-time sizeof() checks that will be able to
> validate the length of sense buffers, this removes the only dynamically
> allocated sense buffers in the tree by putting the 96 byte sense buffers
> on the stack.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
