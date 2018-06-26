Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F6EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC9B219CA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC9B219CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934041AbeFZS3N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:29:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40043 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932509AbeFZS3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:29:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so2854252wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+CC/jjQ9PI6r3pw6gJkgwB2ZG00Mz7S0Cuf6inRAS/U=;
        b=DEdgqKCLdtk7GJQghWtckdV3rZtjvqDfNY2lVN5TvVbv+6QL1Mb+TdFvwXRZkPg8j/
         IhowThfLQtI92IE09GgQPe1XCTqit9OABLfbN+Qu/7m/NcYgkoO810iGm1AUmYlpAfQ0
         c96KTGVUg4cN09PJJCoA+zlDfTlFFowgwYgIHPp9/szNG05229Zjzq6OELecuEY48nik
         CFaeKo0/WbNcsBjEunELKn9Vg3qJGyiJsixXJ95UGHPrUP4Vh2WEHKcHFpmCL2XBveXg
         qzkWjy5vUlRnwladYZ+5fLzr6fjLht9BICE35pqZU7ueGAkvN75kV+CtuOQ769ACbuGp
         2VSA==
X-Gm-Message-State: APt69E2O/JQ3tf08IAcb1bGUVjnJeOtBLIuuXWacmRMP/ddBmqztplS/
        ZMVoY3QlH0/+KKX35NnfuRbYL7JhuXM=
X-Google-Smtp-Source: AAOMgpdbenF7tyDYLZVcNybIxqxRgGfnkpfO8JByXVbmx/6aGslWarLx9UM88iSh7D2WVZe1+3DF/Q==
X-Received: by 2002:a1c:2d15:: with SMTP id t21-v6mr2454697wmt.42.1530037749343;
        Tue, 26 Jun 2018 11:29:09 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k12-v6sm2988196wrr.40.2018.06.26.11.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 11:29:08 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180626135535.2990-1-hdegoede@redhat.com>
 <20180626135535.2990-3-hdegoede@redhat.com>
 <20180626104740.0067bd5e@gandalf.local.home>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <91a98281-979f-9479-a31a-363243948372@redhat.com>
Date:   Tue, 26 Jun 2018 20:29:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626104740.0067bd5e@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-06-18 16:47, Steven Rostedt wrote:
> On Tue, 26 Jun 2018 15:55:34 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Replace comments about places where the console lock should be held with
>> calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.
> 
> Why replace the comments? I prefer them, even with the WARN. The reason
> is, when using functions, I don't tend to look inside the function I'm
> about to use, but instead, I expect the comment above the function to
> have basic information I need to use it. Especially what locks are
> expected to be held.
> 
> Please keep the comments in place, but the WARNs are fine. They are not
> a replacement for the comments.
> 
> Nack on removing comments.

Ok, I will submit a v4 with the comments left in place.

Regards,

Hans

