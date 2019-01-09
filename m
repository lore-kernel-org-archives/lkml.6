Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45006C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEE4206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfAICmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:42:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46361 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfAICmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:42:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so2875368pfe.13;
        Tue, 08 Jan 2019 18:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4LbXB0W91UBVtHSMv9EBVn7qg+MP+DqvKc1R4h2M4CA=;
        b=kcf2/l9AotLRQjjT3wt5YwiIk/HN1Um3s/ENZpeP1TbQwQQmbq8QWp12cRismi5wIp
         da8vMmiuXhh86QuI6faT116nle/k31SnQb3pOUGVHV68vjcD6auqaG4XuAIHXELXr/AY
         P53IchjIuFwAxfRUaXMk5q6FcMNublWLZ1St0PZ0fG5pdommg4u/ydvIc+kU348V4DcB
         QrsehqHLphyrVKwomp/nApbn7suoxt5vQEeGFlPSuKHQYmFc9T3JalO91g1yrwjJidDg
         YEoaS7ogi9RusfM42rlPwF7nKP06HN24P6D2Ca4Z/mhbcF/eCeHEPbx0OBlnmjsEoDKA
         ZzRQ==
X-Gm-Message-State: AJcUukdLUowqhcFDK4WEnrZ/aGV3dmOoz06KqutOXzLN/LtXxop2ujdI
        rA7hapFyDhdvkpyJ8zi31QUnhVLQ
X-Google-Smtp-Source: ALg8bN6Np+qYO3m06dZbd49p0TqES/2zgUgyfILjCTTTC7H9ZRhet925Rz2/Nfh/fgKm+H6u2jirEg==
X-Received: by 2002:a63:7512:: with SMTP id q18mr3480219pgc.231.1547001757097;
        Tue, 08 Jan 2019 18:42:37 -0800 (PST)
Received: from asus.site (c-73-222-28-29.hsd1.ca.comcast.net. [73.222.28.29])
        by smtp.gmail.com with ESMTPSA id d25sm113555754pfe.40.2019.01.08.18.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 18:42:36 -0800 (PST)
Subject: Re: [PATCH v2] scsi: sd: Make protection lookup tables static and
 relocate functions
To:     John Garry <john.garry@huawei.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <1546960492-218420-1-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <29616f54-5c48-96da-e3b4-c211fd28d82e@acm.org>
Date:   Tue, 8 Jan 2019 18:42:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1546960492-218420-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/19 7:14 AM, John Garry wrote:
> Currently the protection lookup tables in sd_prot_flag_mask() and
> sd_prot_op() are declared as non-static. As such, they will be rebuilt
> for each respective function call.
> 
> Optimise by making them static.
> 
> This saves ~100B object code for sd.c:
> 
> Before:
>     text	   data	    bss	    dec	    hex	filename
>    25403	   1024	     16	  26443	   674b	drivers/scsi/sd.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    25299	   1024	     16	  26339	   66e3	drivers/scsi/sd.o
> 
> In addition, since those same functions are declared in sd.h, but each are
> only referenced in sd.c, relocate them to that same c file.
> 
> The inline specifier is dropped also, since gcc should be able to make the
> decision to inline.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
