Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CDCC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474CE20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474CE20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440006AbeKXBET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:04:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43787 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388707AbeKXBET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:04:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so10720818plb.10;
        Fri, 23 Nov 2018 06:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6GxCcx19xJrH43jtmthKHkuHB3FSP809/hUbTXcZuD8=;
        b=Vqz3hNmS1I1E/FVxTGEnbC9GKYJnrDWxvhIW1fs5n//3zltnpuhJjxrg81ENYtmx4I
         5nCbFodt2VpiwBu7Zu7CwEvtI1AIdwgOsgqetgZ7urSQW/0jv1eV7ix4Sp/jbhqcnQB4
         vTlVKk2xyS0wn/qmdWNJKQOlYyj98SwZmEtY+FQnsejr+HRFTWcwU70uzgHZA5TKZ2mu
         Q3/mQVunDMB1GkIpiaGcRRfFfxMOS3e7F/cMl+r/yJPtY2bgHPyMwkeb3jqW38VQspwN
         9k6UtbPqw+3YmWvsJL3Rq/w5icIH42ejmaixxz+x0onePPCpV4FCHAtgk6btc7sW9fW9
         D/Rw==
X-Gm-Message-State: AA+aEWa3FGdkNuhEzzBU/+h8N5aRcu4cHfRS7eI3EEpi8l8XaHhAiI73
        AuepFK10+pq7etZ1u/46TIVrCbGPFzk=
X-Google-Smtp-Source: AFSGD/W89ZO+o01zU572q4O6l2gcelmJyixaqGli6ZKoVBvUYz7z5VfEpsPvvJo3WSq7Lr9zeGg0ig==
X-Received: by 2002:a17:902:2969:: with SMTP id g96mr15731300plb.295.1542982795780;
        Fri, 23 Nov 2018 06:19:55 -0800 (PST)
Received: from asus.site (c-107-3-158-240.hsd1.ca.comcast.net. [107.3.158.240])
        by smtp.gmail.com with ESMTPSA id 12sm23376484pgd.35.2018.11.23.06.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 06:19:54 -0800 (PST)
Subject: Re: [driver-core PATCH v5 5/9] driver core: Establish clear order of
 operations for deferred probe and remove
To:     Rong Chen <rong.a.chen@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-nvdimm@lists.01.org,
        tj@kernel.org, akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
References: <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
 <201811061228.iteFLO2p%fengguang.wu@intel.com>
 <1541548274.196084.197.camel@acm.org>
 <d70f2bcb-0e1c-2d69-2692-329ef5cf81bc@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f9ccdf33-6b7a-cdb2-150b-3ab83892c96e@acm.org>
Date:   Fri, 23 Nov 2018 06:19:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <d70f2bcb-0e1c-2d69-2692-329ef5cf81bc@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/18 5:23 PM, Rong Chen wrote:
> Kbuild robot printed all warnings and the below warning was found in 
> patch 5/9.
> 
> "include/linux/device.h:1056: warning: Function parameter or member 
> 'async_probe' not described in 'device'"

Hi Rong,

Thanks for having taken a look. That's indeed something that must be 
fixed in patch 5/9.

Bart.
