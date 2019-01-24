Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA7EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9F020811
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmfGQi1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfAXL5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:57:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35117 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfAXL5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:57:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so4102952lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 03:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XL0JqsY6X1X29UDi1xNE6P2I/jRGDNxNnBq8+JvaPgs=;
        b=hmfGQi1yYUxrzj2bb9VF/ScFMrhgpLRS/JsHgvSO+qnR4qe7OqhNIrDoQGVyleXkQS
         VsP5YnaqEJGi2LwIZumBnMC7rJLF1EmxuZg9M1T/C+YqdRntTI47XGBupJtsUvEcb3O9
         vh2tz5eAT6c/pCxQMKZXXkIX5MD0b1Mfdv1xL4uZ8kUPJEJ4/dOIFopNxtVl13Rkn5cu
         31EZUVir1ozbL0NNm7zhz1CLPmIlhlSOd9aAO3eGcLrtfirFvh0g86iRNUo/ukPAkApz
         xdz4befNoT+VruGZv2lZB/LgjxrHYJXqACFVx4nI1WEg5hAbgAB1CXbgqBwQ7hIi9vGY
         18BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XL0JqsY6X1X29UDi1xNE6P2I/jRGDNxNnBq8+JvaPgs=;
        b=tt5FB5vlO42tW2l8AKVG7ygAyMO6Gf7sHw5Bv+pv04nyRuz7YZIggOm5xB89rnyPQ3
         1kr7+8z/1PaX8XF/cz8MQQDcMv00sWaUr1RXgNhIfsXn/qR2S+37hbIzSMgIqd8ZeEAS
         Q2RwNkvD6NkIwOJena8H26A30iuThivKZ55Jr0FyAwZ/6hPRCLgq0qaBqXTeMiHTmZdh
         PSloSFfF1v/Iqtu/VMa0EyKzArLjZLcTBBZZjEoY0IHDspiT5eh11jgVAXR4vGiFH9kr
         QXceBPV89IxnAAAA0nqs7pwqmcClxERr2FsjD+4PyUdLiAl8gSWtiD54aArB7cWE+TtI
         qE5g==
X-Gm-Message-State: AJcUukeLh+aDgh0AvZFeYkGd4mKH0uDKv1rDIbmpIHHIphsDFpQQNrqT
        Pg9yO+c/42AQC14niPwV0jg=
X-Google-Smtp-Source: ALg8bN6b8N9VKyOLlWnjztkzJBVewPJvyRB8jNYmgQCYpAceT2BpsvO/5XUIEE/Hf5+qN0gvPZ6veQ==
X-Received: by 2002:a19:2d16:: with SMTP id k22mr5278535lfj.12.1548331022501;
        Thu, 24 Jan 2019 03:57:02 -0800 (PST)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id w202sm920226lff.31.2019.01.24.03.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 03:57:01 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH v1 0/2] stability fixes for vmalloc allocator
Date:   Thu, 24 Jan 2019 12:56:46 +0100
Message-Id: <20190124115648.9433-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

The vmalloc test driver(https://lkml.org/lkml/2019/1/2/52) has been
added to the linux-next. Therefore i would like to fix some stability
issues i identified using it. I explained those issues in detail here:

https://lkml.org/lkml/2018/10/19/786

There are two patches, i think they are pretty ready to go with, unless
there are any comments from you.

Thank you!

--
Vlad Rezki

Uladzislau Rezki (Sony) (2):
  mm/vmalloc: fix kernel BUG at mm/vmalloc.c:512!
  mm: add priority threshold to __purge_vmap_area_lazy()

 mm/vmalloc.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.11.0

