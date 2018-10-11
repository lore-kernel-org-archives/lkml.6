Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BD0C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C77B213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4N+BGpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C77B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbeJKXQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbeJKXQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:16:29 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 473D521470;
        Thu, 11 Oct 2018 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272922;
        bh=YoW6FyINE6+TYjx4KZzHlt4aAFa3f3sBPPtzE0nB0BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4N+BGpPsg88oYW3uEbsMsCLXqo5JPiSiqGWoApXe2CFJPJyPGLYHr0m2rtkaiT0s
         zhan6dadCxTVh4HjzcjiFfcyJvo/+9VSkGEGMfTsJTteMHe8Cc6hcOib1r8E3aAdys
         QqRkHT5fNq5Rxn0pAxSFVZ7VhgnYV0dFN1piRE7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, nixiaoming <nixiaoming@huawei.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Joel Fernandes <joelaf@google.com>,
        Geliang Tang <geliangtang@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.18 08/44] pstore/ram: Fix failure-path memory leak in ramoops_init
Date:   Thu, 11 Oct 2018 17:39:46 +0200
Message-Id: <20181011152452.886432310@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/pstore/ram.c |   29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -898,8 +898,22 @@ static struct platform_driver ramoops_dr
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
 
@@ -932,21 +946,28 @@ static void ramoops_register_dummy(void)
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
 late_initcall(ramoops_init);
 
 static void __exit ramoops_exit(void)
 {
 	platform_driver_unregister(&ramoops_driver);
-	platform_device_unregister(dummy);
-	kfree(dummy_data);
+	ramoops_unregister_dummy();
 }
 module_exit(ramoops_exit);
 


