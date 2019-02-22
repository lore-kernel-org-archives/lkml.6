Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6B6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE16206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfBVRUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:20:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43662 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVRUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:20:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id m10so1364892plt.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 09:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GWpzjiavm/BX8DVb6TKwVDHiACx1tJ4YeSYSxDxnwCA=;
        b=aAjSZR33rbO+C6Cjsi07Mzj1b6uu6Vfdz9yVrUxET+boVc5b3JEVJibVtjTTV8Jv64
         bIZg59jAa7O0/k/9rMZJhyMTTIbDDCGoeJMM54O3yTJ6946Q6ypSOU4rA91jXkdEo40w
         ReVPage54/Fuz0VUZmmOd5g59seOZ8kLYi/i94NGz7hj3nd1R3y9PawWHawBR4MgPSAk
         R3YRhS7uajbGKswjOF405+ESJoY8jh7DPPaH+V4lRZRtiu2Es2dEp70cFA/GmtOPvI9K
         o5ZNvUDZtvgd+ekrUT8mkySFn9RU0cOX/zPlsmAHHzWVLKkU2wqAgp+xHKIU793j9BGp
         /jvw==
X-Gm-Message-State: AHQUAuZdcCNz8+jx/uovkbLesgEKiwHMnH5xVqUIKyMqD5yvj2aXu5c3
        DPQnO3njsy+71bu6fEq9OGvAxmnJsvc=
X-Google-Smtp-Source: AHgI3IbzGzHfhXoGFUjIZLMvVDC0iJ+Kz3mUZXINBaiXzmqVbSQEhGWYshKqx+6HT6+5LpR0MHkUjA==
X-Received: by 2002:a17:902:63:: with SMTP id 90mr5056827pla.122.1550856036683;
        Fri, 22 Feb 2019 09:20:36 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id a24sm3099465pfo.160.2019.02.22.09.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 09:20:35 -0800 (PST)
Subject: Re: [PATCH v7 00/23] locking/lockdep: Add support for dynamic keys
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
References: <20190214230058.196511-1-bvanassche@acm.org>
 <1550786525.31902.140.camel@acm.org>
 <20190222162622.GB32494@hirez.programming.kicks-ass.net>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7216ba17-8e38-d8e9-6ba3-1bc0e6a9fc2d@acm.org>
Date:   Fri, 22 Feb 2019 09:20:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190222162622.GB32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 8:26 AM, Peter Zijlstra wrote:
> I've gone over all and I think it looks ok now; I'll give it another
> round tomorrow^Wmonday and then queue bits.
> 
> So far the only changes I've made are the below. I'm not entirely sure
> on the unconditional validity check on DEBUG_LOCKDEP, maybe I'll add a
> boot param for that.

Hi Peter,

Please keep in mind that calling check_data_structures() slows down the 
kernel a lot and also that it makes systems much less responsive. This 
is because the consistency checks disable interrupts for a long time, up 
to several seconds. That is why I think it should be possible to enable 
and disable the consistency checks independent of other kernel config 
options.

Thanks,

Bart.
