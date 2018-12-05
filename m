Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229FCC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D430720661
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="egAdf8zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D430720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeLEDHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:07:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34625 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeLEDHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:07:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so9330974plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 19:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SHw5Bkw1rmVEi0OvRAFvv72UvdQYeGQcGqG3lUIovm4=;
        b=egAdf8zu/pzioyrBtdPrVwLzfeLDOqXPZVjtfyip7xkSgkARo7UMaO1I4aM4WorHuq
         sMXF+mqjxN6k4xlRhf+SxuQze6p7YmnkvoRWUH8VxS4O9PIuawjZweS1sBwYk3n873fL
         A+LOwgP7mUSxTiDcQmZplOJywD7d3dvPk5heaFLcZOfeKUkaeYjUy1CXnevabOY48bcG
         nm4SHfFq2G1CRmprYv0PTvzn+t18245TBXmnXI/nDnVwrzNNywFBtmwpe2tZ9S3usK1C
         HoiUnZsxKqQ/3hktROR6XqXD9GPZZ80fpFdeXSeV1yMPwFPTjfcnnNS+WZFOEepyvo/e
         8fTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SHw5Bkw1rmVEi0OvRAFvv72UvdQYeGQcGqG3lUIovm4=;
        b=VqRiriM5WMPf5+1ciH6LSQF2wY4nVf8JFoniLUurZnde0sIxB0NXleiIAD/f6VwB5m
         LydoAvzmc4UHBvDtIG98RPVHs+J1z+/dlZ4djoS3qMSes+N3PmDSBCruHrhiJwZl9CpT
         xWSFRrCN6dN6x+cNNkZ6HZCDx/iJFw+9ShUeLIGJ4c/qNzvfFjrN6v3eDFJeY2aKiXph
         uiNcsxVstyHe1dwaCc18LlG9nmSrMtq2uGTpujol1awySgSlHEggko/dTiN42UbCm9XN
         FofzBW7BjwRBGKRlpurcxHWMWFYwx7BeISFkHBSa29BTTM/FCXVUp14EvGbYVE8BCgHf
         SvkA==
X-Gm-Message-State: AA+aEWbfG6cnVsJiQOuNnLUbOrSMdw2I4Kh4P5FFr9GhGpIV6EUIn52T
        83nG+CxLXelCPFYSUh0L9arQ1E/T9K8=
X-Google-Smtp-Source: AFSGD/U0LJcNtW8DYpvd/1sYVm/sVy93dTcAz8hfStUjYQGr710kv1JcIJXEfxVnrkddHOK0d3kw0g==
X-Received: by 2002:a17:902:780a:: with SMTP id p10mr23113713pll.54.1543979236270;
        Tue, 04 Dec 2018 19:07:16 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g2sm24382006pfi.95.2018.12.04.19.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 19:07:15 -0800 (PST)
Subject: Re: [PATCH V8 0/3] blk-mq: refactor code of issue request directly
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542251558-10517-1-git-send-email-jianchao.w.wang@oracle.com>
 <88fe68c6-886c-1328-009a-9c7c5fa4ebc9@kernel.dk>
 <154edba0-f4dc-716f-df64-50b23db39138@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4383ef8a-4418-e341-d36d-bcbc0557c4a9@kernel.dk>
Date:   Tue, 4 Dec 2018 20:07:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154edba0-f4dc-716f-df64-50b23db39138@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 8:01 PM, jianchao.wang wrote:
> 
> 
> On 12/5/18 10:58 AM, Jens Axboe wrote:
>> On 11/14/18 8:12 PM, Jianchao Wang wrote:
>>> Hi Jens
>>>
>>> Please consider this patchset for 4.21.
>>> It refactors the code of issue request directly to unify the interface
>>> and make the code clearer and more readable.
>>>
>>> The 1st patch refactors the code of issue request directly to unify the
>>> helper interface which could handle all the cases.
>>>
>>> The 2nd patch make blk_mq_sched_insert_requests issue requests directly
>>> with 'bypass' false, then it needn't to handle the non-issued requests
>>> any more.
>>>
>>> The 3rd patch replace and kill the blk_mq_request_issue_directly.
>>
>> I'd love to get this queued up, the direct dispatch path is a mess and
>> it's even now been known to cause corruptions... I'm going to queue
>> up the direct dispatch fix shortly, and apply it to for-4.21/block
>> as well. Any chance you can respin this on top after that?
>>
> 
> OK, I will do now.

Thanks!

-- 
Jens Axboe

