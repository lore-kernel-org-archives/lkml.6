Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CA7ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C9E20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2MqTLvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C9E20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbeIRWun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:50:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41982 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbeIRWun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:50:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so1309717plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8wIKFqsDLnVjh58s2XzwP4xys912ppD/9lWjCPT3hJQ=;
        b=U2MqTLvtmvdphxlr8xk1BLmyI6hhjL7aooyShNrI6ov4wr74GnCZ0Zi/1vFPofaFps
         ogqDybsi/2hIuIo8ZT2x2qjkdqTRr4x6ANOj1OPMu4j7gVoXUvGF1MbGj9zKuq5D+HGp
         mbv5nyqrKRi9VONWLX58cbVhBYoLNYjq0dtZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8wIKFqsDLnVjh58s2XzwP4xys912ppD/9lWjCPT3hJQ=;
        b=jBKIqY+1Noa8WHH6gGxdvKC2zvrOHJTPQhb1lsKHqg4CjkJOG1ah6K4XLafnZJiLxH
         TM6PGKG1V8L9kRc4sqf6NvtEej3XnkA+K384AymmCG0wDPfnKMXpzwmKJEcAywaB/8f5
         LAFscBfGMJYXPvkGF9Kh+GpbqV8E1JI+x6G+Sc1Ve3Uh+mUB+loOZoo94m4m93r/O6wH
         M4eFHHXwK8tVtT1HBCSW0r2FwN0ksU6uVwL5lwJ/SZqcGRk+SZjaiU+RxTDQx9Mw2kXr
         KjTEvcB1Kwmj9dzmRuVERxJ4uJf3XJG4pHEUVunIJ+7TlQMfxE+Ktb2OtTpTFJOGhYI6
         xYvA==
X-Gm-Message-State: APzg51A3/NPRPhYqUufoFdpfPdUjPxBIYWvBOcbvEzY1Fy5jbqHB4PEd
        60IFz3HtzfWdOAxK2X6dWZ2lbA==
X-Google-Smtp-Source: ANB0Vdb6hUrsX4bg4JdjsAtG1lBBJzk9b8ywjp2AHrIcecuN0ZDzqz3pCnSsxJZ27GAvI3EmOzXgPg==
X-Received: by 2002:a17:902:4081:: with SMTP id c1-v6mr30531544pld.169.1537291029574;
        Tue, 18 Sep 2018 10:17:09 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id f6-v6sm22130419pgf.52.2018.09.18.10.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 10:17:08 -0700 (PDT)
Date:   Tue, 18 Sep 2018 10:17:07 -0700
From:   Andy Gross <andy.gross@linaro.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: Fix a uninitialized warning.
Message-ID: <20180918171707.GA6240@hector.localdomain>
References: <1537247208-33632-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1537247208-33632-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 01:06:48PM +0800, zhong jiang wrote:
> Fix the following compile warning:
> 
> drivers/soc/qcom/cmd-db.c:194:38: warning: ‘ent.addr’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   return ret < 0 ? 0 : le32_to_cpu(ent.addr);
> 
> drivers/soc/qcom/cmd-db.c:247:38: warning: ‘ent.len’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   return ret < 0 ? 0 : le16_to_cpu(ent.len);
> 
> drivers/soc/qcom/cmd-db.c:269:24: warning: ‘ent.addr’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   addr = le32_to_cpu(ent.addr);
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/soc/qcom/cmd-db.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

This is kind of an odd subject for the patch.  It should be something like
drivers: qcom: cmd-db: XXXXXXXXXXXXX

ASOC is sound related.


Regards,

Andy
