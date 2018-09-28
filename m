Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D0DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AC820671
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AC820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeI2DwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:52:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeI2DwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:52:10 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D4D44CAB;
        Fri, 28 Sep 2018 21:26:31 +0000 (UTC)
Date:   Fri, 28 Sep 2018 14:26:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     nixiaoming <nixiaoming@huawei.com>
Cc:     <jack@suse.cz>, <amir73il@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joelaf@google.com>,
        Geliang Tang <geliangtang@gmail.com>
Subject: Re: [PATCH] fix memory leak in ramoops_init
Message-Id: <20180928142630.f4501105f413f2b5b4772a8b@linux-foundation.org>
In-Reply-To: <20180917091531.21356-1-nixiaoming@huawei.com>
References: <20180917091531.21356-1-nixiaoming@huawei.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018 17:15:31 +0800 nixiaoming <nixiaoming@huawei.com> wrote:

> 1, memory leak in ramoops_register_dummy.
>    dummy_data = kzalloc(sizeof(*dummy_data), GFP_KERNEL);
>    but no free when platform_device_register_data return fail
> 
> 2, if kzalloc(sizeof(*dummy_data), GFP_KERNEL) return NULL,
>     but platform_driver_register(&ramoops_driver) return 0
>    kfree(NULL) in ramoops_exit
> so, add return val for ramoops_register_dummy, and check it in ramoops_init
> 
> 3, memory leak in ramoops_init.
>    miss platform_device_unregister(dummy) and kfree(dummy_data)
>    when platform_driver_register(&ramoops_driver) return fail

Looks right.

It's unclear (to me) who maintains fs/pstore/ram.c.  Let's add some
Cc's and see if we can catch a reviewed-by.


From: nixiaoming <nixiaoming@huawei.com>
Subject: fs/pstore/ram.c: fix memory leak in ramoops_init()

1, memory leak in ramoops_register_dummy.
   dummy_data = kzalloc(sizeof(*dummy_data), GFP_KERNEL);
   but no free when platform_device_register_data return fail

2, if kzalloc(sizeof(*dummy_data), GFP_KERNEL) return NULL,
    but platform_driver_register(&ramoops_driver) return 0
   kfree(NULL) in ramoops_exit
so, add return val for ramoops_register_dummy, and check it in ramoops_init

3, memory leak in ramoops_init.
   miss platform_device_unregister(dummy) and kfree(dummy_data)
   when platform_driver_register(&ramoops_driver) return fail

Link: http://lkml.kernel.org/r/20180917091531.21356-1-nixiaoming@huawei.com
Signed-off-by: nixiaoming <nixiaoming@huawei.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/pstore/ram.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- a/fs/pstore/ram.c~fix-memory-leak-in-ramoops_init
+++ a/fs/pstore/ram.c
@@ -898,17 +898,17 @@ static struct platform_driver ramoops_dr
 	},
 };
 
-static void ramoops_register_dummy(void)
+static int ramoops_register_dummy(void)
 {
 	if (!mem_size)
-		return;
+		return -EINVAL;
 
 	pr_info("using module parameters\n");
 
 	dummy_data = kzalloc(sizeof(*dummy_data), GFP_KERNEL);
 	if (!dummy_data) {
 		pr_info("could not allocate pdata\n");
-		return;
+		return -ENOMEM;
 	}
 
 	dummy_data->mem_size = mem_size;
@@ -932,13 +932,25 @@ static void ramoops_register_dummy(void)
 	if (IS_ERR(dummy)) {
 		pr_info("could not create platform device: %ld\n",
 			PTR_ERR(dummy));
+		kfree(dummy_data);
+		return PTR_ERR(dummy);
 	}
+	return 0;
 }
 
 static int __init ramoops_init(void)
 {
-	ramoops_register_dummy();
-	return platform_driver_register(&ramoops_driver);
+	int ret = ramoops_register_dummy();
+
+	if (ret != 0)
+		return ret;
+
+	ret = platform_driver_register(&ramoops_driver);
+	if (ret != 0) {
+		platform_device_unregister(dummy);
+		kfree(dummy_data);
+	}
+	return ret;
 }
 late_initcall(ramoops_init);
 
_

