Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3ABECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C21208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QbgS1ddd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C21208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbeGMIBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:01:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34986 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbeGMIBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:01:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so14888854wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Pa+KSX0G1/Fp2+itA7p8L/Ps2d6v1MepkijOR4Lq9oQ=;
        b=QbgS1dddYUJYt7fO8WG4NFZDERubp59DIBH5w9Xy+nBiG+V5H+PZAZ8eZsso8WLeQs
         jw5f1pbA83m7K8vjkBcrDYsde4NeJcHZvQm5yrMvSqd++r1+ZGT+D/AvlrKnlCSrv2IY
         ZybpGCx8ufF4asSzan+38osJjtLrNmwooAm90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Pa+KSX0G1/Fp2+itA7p8L/Ps2d6v1MepkijOR4Lq9oQ=;
        b=SqQGYSwhTsd7xvlKaypWSOFRGXI6KlcWrL+8k4otM13KJTPOkek0T5AQYpRHgd0ZcX
         mIaP6QSsDxLYTjRo6Xio/h4bjjH8Du2Pxt8mWnyYjBhuYj5R5sUJ2zU9jRiI8XMQairn
         hNUYkPlozGUbej8GNIuU4+o0aHg8g3V5RKv4X9lpDfihPI/O9SE2ad/yrYZFMFWGDlrT
         Ny5x7YuKD5emX3h4jS6kGZ7on6QhnoXWIC4JQ8PI5A58k/Frwj6aFXK4mKoUaoYkLy5M
         uMyELFKL5FHW0KCSwSLmlgAEKFU6TgvBJrkR7knfV/AuYlHLrQ5Qsby9T2Padl7mR7Si
         HoKA==
X-Gm-Message-State: AOUpUlHfw7h6xBr3NZHlY03UMjcu4Nzu56ZGOK0U8U0i3j3dvgZWfHBO
        tOFGBxjmuOhOOhGT/NvYJG9Fu8tU
X-Google-Smtp-Source: AAOMgpdSBqtnlTpCj+WoBvW3lUjr6pSXTYnrzGETcW24pygf5YGbe+LkdM2+BPgyfc0d2d0o66t8yw==
X-Received: by 2002:a5d:44c6:: with SMTP id z6-v6mr3925241wrr.236.1531468057366;
        Fri, 13 Jul 2018 00:47:37 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id u4-v6sm17074819wrt.31.2018.07.13.00.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 00:47:36 -0700 (PDT)
Subject: Re: [PATCH 11/18] wireless/ti: change strncpy+truncation to strlcpy
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominique Martinet <asmadeus@codewreck.org>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <1531445149-19607-1-git-send-email-asmadeus@codewreck.org>
 <20180713073810.GA31984@kroah.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Joe Perches <joe@perches.com>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5B485917.7090102@broadcom.com>
Date:   Fri, 13 Jul 2018 09:47:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20180713073810.GA31984@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/2018 9:38 AM, Greg Kroah-Hartman wrote:
> On Fri, Jul 13, 2018 at 03:25:49AM +0200, Dominique Martinet wrote:
>> Generated by scripts/coccinelle/misc/strncpy_truncation.cocci
>>
>> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
>
> I don't know about other maintainers, but I know I wouldn't take such a
> horrid changelog description as this :)
>
> good luck!

especially as that script is not in the kernel tree yet. The patch 
adding that script contains a good motivation, but I would want to see 
that in commit message of every patch or at least the gist of it.

Regards,
Arend
