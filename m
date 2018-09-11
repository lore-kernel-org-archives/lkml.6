Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3E2C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D3C206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX/VHagr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D3C206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeILBmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:42:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34809 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeILBmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:42:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id f6-v6so11878848plo.1;
        Tue, 11 Sep 2018 13:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9RzB/BRDpX7q84tdyLiCljnkba6k7dGT74G52O2J7lo=;
        b=RX/VHagrNz4hez4DMpIbo+pAB3SPXUfDVRgLhceP2eUSoj6jJRB+W2d1mn/yLvoJai
         UpTBldh3dNRhkZeFuO4QtXgs/A5a8wSra9WLqwoysoKKAkDLz5sYFXYiecpD/ONq8hCB
         e0TLxE/+xAvevdTWUhvMNTe9kVKDx9rcTuV4VAGbi7MPB2sxKkUSOGtakGrhHBqRIeqO
         UcWVsKC28iI6eBlaoViUfZOmKGyZeTVOLkcF0tmfzISHq68nPJmCg9utcs3TmatP1gmq
         mWNvVDe5yGosGfawnCOFYxGaSCIjdbreLawGRbhQBFI+5h1J7C1m8P8sgjaeNYN30YvX
         9HjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9RzB/BRDpX7q84tdyLiCljnkba6k7dGT74G52O2J7lo=;
        b=XAuYceAaZXchwGUBF5yQLKWZNG8U07RgYBh8CImZ6zSsRse5dSM3FYBGv5Ra+VuO+L
         rCJVQ3dqGovTKfqdwwvnwnmvARcc3GwcA7O8JG35rtfrj1Ff0QWf0m8p52azQ9yza3Da
         MojWU2mbLGyxJI0D2haH8TfY37RwqZZ0Wbsik/3T2LjHH/0Shi7Kj/A47R82p2H5unqh
         6hqbygiasVvQI/kQrxL6hc4UKLtzdh4L1qdnQYVnJCsMpdLxvlSkxWf1CQX/p/E18+Bu
         7H4rWbdjhBV5K9cP7qRR2hZZqDgwsu97kYVqWylqDbD+KLkzyIElfqCdE1fObSUsEbRj
         wD6g==
X-Gm-Message-State: APzg51Di7LVPIM3sywF5FjU3qnV90UGfuPjG2TbJv2r7ElDqy5mp6AFV
        NBx55dRXbUI+NOU6dVOFeK6oAedo
X-Google-Smtp-Source: ANB0VdZCKFKSrPX7Awp/SrcXkckLI5qo0g9ymj+hCmEvL5mCRKwkg+FgsBVT6CyP40fkehablCCUqA==
X-Received: by 2002:a17:902:286a:: with SMTP id e97-v6mr29141117plb.340.1536698468782;
        Tue, 11 Sep 2018 13:41:08 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z8-v6sm24348414pfe.163.2018.09.11.13.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 13:41:08 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:41:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined
 irq events properly
Message-ID: <20180911204107.GA26017@roeck-us.net>
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <20180911183734.GA21976@roeck-us.net>
 <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 01:30:41PM -0700, Jae Hyun Yoo wrote:
> On 9/11/2018 11:37 AM, Guenter Roeck wrote:
> >Hi,
> >
> >On Thu, Aug 23, 2018 at 03:57:31PM -0700, Jae Hyun Yoo wrote:
> >>In most of cases, interrupt bits are set one by one but there are
> >>also a lot of other cases that Aspeed I2C IP sends multiple
> >>interrupt bits with combining master and slave events using a
> >>single interrupt call. It happens much more in multi-master
> >>environment than single-master. For an example, when master is
> >>waiting for a NORMAL_STOP interrupt in its MASTER_STOP state,
> >>SLAVE_MATCH and RX_DONE interrupts could come along with the
> >>NORMAL_STOP in case of an another master immediately sends data
> >>just after acquiring the bus. In this case, the NORMAL_STOP
> >>interrupt should be handled by master_irq and the SLAVE_MATCH and
> >>RX_DONE interrupts should be handled by slave_irq. This commit
> >>modifies irq hadling logic to handle the master/slave combined
> >>events properly.
> >>
> >>Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> >>Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
> >This patch causes a boot stall when booting witherspoon-bmc with
> >qemu v3.0, and all i2c device probes fail with error -110 (timeout).
> >Bisect log is attached for reference.
> >
> >With the same kernel configuration (aspeed_g5_defconfig),
> >ast2500-evb and romulus-bmc are still able to boot.
> >palmetto-bmc with aspeed_g4_defconfig also appears to work.
> >
> >Is this a problem with qemu ? Should I drop the qemu test
> >for witherspoon-bmc starting with the next kernel release ?
> >
> >Thanks,
> >Guenter
> >
> 
> Hi Guenter,
> 
> Thanks for your report.
> 
> I checked this patch again but it doesn't have any change that could
> affect to the probing flow. I'll debug the issue on qemu 3.0 environment
> and will share if I find something.
> 
The problem may be that qemu and the new code disagree how interrupts
should be generated and handled, and the new code does not handle the
interrupts it receives from the simulated hardware. This will result
in i2c device probe failure, which in turn can cause all kinds of
problems.

Thanks,
Guenter
