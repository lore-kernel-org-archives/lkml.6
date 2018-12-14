Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B868AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E304D206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MDpAD2yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbeLNSHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:07:00 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40688 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbeLNSG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:06:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id d3so5657669edx.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fyO1+rvO4ZQjIrQnFJKpU15GjzUp5SBrPC/B8cK2XEY=;
        b=MDpAD2ycZNTcJgySxaDNjB8qxOzBmp6YwTF6cpN61bfqHPZb4k1gQzAjf9CZ8dQC+z
         zlXb/mIdvTWpLFIefx7b8h7ZOVvHdFxNaaVr66RXoFo3bpB5+8om9e3SFYUkZ5yFh96S
         xd/ReV7U3oN23tuHXp6iWV49kpyDr6GD/H4D9mERkOKFdKho5EBactoWeZoRS0UfQadz
         8NJVpp4IuWnqVXdJT1CPe6O5Bi6crtrTwt4i5WPXD5+anSdW2dKpvjKFgHiP0c/nXcRn
         aDXT8Sdf22R9AWBXquBa2l8z5apeqkVmt15ra7LWq1AHvSJGJgihFUv8oVndm5IxJzJ4
         MMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fyO1+rvO4ZQjIrQnFJKpU15GjzUp5SBrPC/B8cK2XEY=;
        b=oBBb4SfzlaDeXjtvL5DMw7ZDPr0hwU79rZ2auwvy9Zr20r15ZmGS2uOBvq6ophe218
         odZOg6D0H62DWANHphOmHqLxQIx64ZyzSDhKHB5NwdRgdqgXu7i0w5ZELHEJJmHyQ4SH
         BQoz2Qd2YiLLQDTaIwLbIEygNsJJ3zZEOuiO3Nz8CRpYc/CKbHTQh227cxR+sdQmo7+m
         plV00LsfFAm4q4OfqkpuVOriiRgYUwb/3kmoo5KnVNhSmyItvi//EwND5wgoWMbeN5Cg
         0RVOHn7YVK2wcT9EAGiz+/NsTjC/44usQO5MovgnUKYeEj62b8cweJytzg/bRMtJ1Df8
         VSaA==
X-Gm-Message-State: AA+aEWYpmWYhf5zgKEbzcae/eHCCPHuFk416gKK+15U9bRoZaMk8Parq
        QzHwGt82VRHL4BlRnkJ5QQGfSA==
X-Google-Smtp-Source: AFSGD/UHBPHFciLDIK3dg1Skuv65EuNu3DVvQbrQ2UEZkiIfE7GJUJmwv2xXIllhtxWQFie7ZRy6xQ==
X-Received: by 2002:aa7:c0d0:: with SMTP id j16mr3790146edp.173.1544810818018;
        Fri, 14 Dec 2018 10:06:58 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d8-v6sm870177ejy.34.2018.12.14.10.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 10:06:57 -0800 (PST)
Subject: Re: [PATCH] debugobjects: Move printk out of db lock critical
 sections
To:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
References: <1544653694-27873-1-git-send-email-longman@redhat.com>
 <9cb1526a-e82f-dfa7-4b3c-5ea911a8d476@arista.com>
 <c06a5233-0566-e391-6fc6-4ff6122c265c@redhat.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <bae90b7f-0b1e-e5d9-d9e2-509b50612427@arista.com>
Date:   Fri, 14 Dec 2018 18:06:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <c06a5233-0566-e391-6fc6-4ff6122c265c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/18 10:10 PM, Waiman Long wrote:
> The bucket lock is for protecting the insertion and deletion of
> debug_obj to/from the bucket list as well as searching within the bucket
> list. It has nothing to do with the life time of the debug_obj itself.

The bucket lock also protects lookups on a bucket.

1. Imagine, you have object in ODEBUG_STATE_DESTROYED.
If you will try debug_object_activate() with this patch, it will debug
print object outside of bucket lock, which means that
debug_check_no_obj_freed() may concurrently fixup/free object and
meta-data on another CPU.

I don't see this state is being used in many places around the kernel,
except selftest and i915 driver.

2. If you try to deactivate already non-active object - you will have
debug print outside of bucket lock. The other CPU can fixup/free page
with this object concurrently.

(before your patch the lookup would fail and no printing)

So, I might be mistaken, I'm mostly worried about dereferencing the
descriptor inside of the object during printing.
And in my opinion, i.e., there was a reason to save `descr` before
releasing the bucket lock here:
https://elixir.bootlin.com/linux/latest/source/lib/debugobjects.c#L789

Anyway, I see that your patch is already in -mm tree and Thomas seems to
be fine with the change so whatever %)

Thanks,
          Dima
