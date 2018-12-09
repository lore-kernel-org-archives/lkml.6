Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57789C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2440520672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2440520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeLIWCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:02:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35830 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726649AbeLIVzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:31 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72u-0002ia-7e; Sun, 09 Dec 2018 21:55:28 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003dF-1j; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Anton Vorontsov" <anton@enomsg.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Joel Fernandes" <joelaf@google.com>,
        "Colin Cross" <ccross@android.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "nixiaoming" <nixiaoming@huawei.com>,
        "Geliang Tang" <geliangtang@gmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.474437376@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 281/328] pstore/ram: Fix failure-path memory leak in
 ramoops_init
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit bac6f6cda206ad7cbe0c73c35e494377ce9c4749 upstream.

As reported by nixiaoming, with some minor clarifications:

1) memory leak in ramoops_register_dummy():
   dummy_data = kzalloc(sizeof(*dummy_data), GFP_KERNEL);
   but no kfree() if platform_device_register_data() fails.

2) memory leak in ramoops_init():
   Missing platform_device_unregister(dummy) and kfree(dummy_data)
   if platform_driver_register(&ramoops_driver) fails.

I've clarified the purpose of ramoops_register_dummy(), and added a
common cleanup routine for all three failure paths to call.

Reported-by: nixiaoming <nixiaoming@huawei.com>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/pstore/ram.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -557,8 +557,22 @@ static struct platform_driver ramoops_dr
 	},
 };
 
-static void ramoops_register_dummy(void)
+static inline void ramoops_unregister_dummy(void)
 {
+	platform_device_unregister(dummy);
+	dummy = NULL;
+
+	kfree(dummy_data);
+	dummy_data = NULL;
+}
+
+static void __init ramoops_register_dummy(void)
+{
+	/*
+	 * Prepare a dummy platform data structure to carry the module
+	 * parameters. If mem_size isn't set, then there are no module
+	 * parameters, and we can skip this.
+	 */
 	if (!mem_size)
 		return;
 
@@ -588,21 +602,28 @@ static void ramoops_register_dummy(void)
 	if (IS_ERR(dummy)) {
 		pr_info("could not create platform device: %ld\n",
 			PTR_ERR(dummy));
+		dummy = NULL;
+		ramoops_unregister_dummy();
 	}
 }
 
 static int __init ramoops_init(void)
 {
+	int ret;
+
 	ramoops_register_dummy();
-	return platform_driver_register(&ramoops_driver);
+	ret = platform_driver_register(&ramoops_driver);
+	if (ret != 0)
+		ramoops_unregister_dummy();
+
+	return ret;
 }
 postcore_initcall(ramoops_init);
 
 static void __exit ramoops_exit(void)
 {
 	platform_driver_unregister(&ramoops_driver);
-	platform_device_unregister(dummy);
-	kfree(dummy_data);
+	ramoops_unregister_dummy();
 }
 module_exit(ramoops_exit);
 

