Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F9CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9043F2089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oALU/CEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfAHE7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:59:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34046 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfAHE7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:59:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so2720116wrw.1;
        Mon, 07 Jan 2019 20:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hlWw0voukglhdooGQz/SxyLb0Z75gM5J6LEq6IH1cuE=;
        b=oALU/CExrpuSqA0/Z/YDes/IUFd5Tpy9nt2W4Tpj0Cjz62o1esVW0SaSRX4VPJ4tQr
         lYf/MZGNX21t0nv1p9suxcJesJe74nalGniz2hMtPfFJ9Mktt7QJPy3YlyFuUI2pKWwW
         CPOep5XpS33FxvdAEiH6Wb0bQJ6m7/xStSInnJMP0/6WJwrIp9N9uLVzfoH+yAliGgZe
         vUt0VUJPR482J/a4cPhPt23GFBRHR3TutiZ5hlFDte7rd8q9yl9lKnldkWMpdSG/4QI4
         rlV3LkiRx6iX9UY3gaTEUTm36nXmHg1w4pOijBBspRzPddS5sEHQH+iybXzE+VJMkapm
         N4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hlWw0voukglhdooGQz/SxyLb0Z75gM5J6LEq6IH1cuE=;
        b=DK5CyyN7O3tIb1ugX4aPheBw7T6pJ94puxjrZDWvTIUFM7yxW3V7mPkCVMH+ViXzEb
         AuW8C5NXOtN0GfPVq2LP4OQQwOHHADs1oZ96jhJzMBNdZFIUlFmazwinYdNYDwWQBtfE
         LtIyY40ysbpudeeoCWUd9pyyV5c4RIdQ6kM4ga1PvJGpLOspQATztgzPcXYjM20+1MO6
         wm6KaHFnB90dZeeGCQrFe/3VlNxNIrJ588QVyXwR+3mweCQuomD54vMdCD5bNR+Hd+D8
         YKJ89sljKP4/eGmeLfzWXL0VGGm8TXXaGD1XWYYIvUqodVGmLNkwcPLXuA6b+Ts9SRS/
         rzww==
X-Gm-Message-State: AJcUukfwZ6tG3uHhydz0tALLzE8k/dZNr0xsdgrtTVBm5UKVAxYZFoHA
        YRRNPWqTj2hzE1pgJlqiiN8=
X-Google-Smtp-Source: ALg8bN5aJUxWXQsn9ZUmRPp9NxxUMR+MmA1OMQ7B911iG/jDjDk6Z1I/J8i7dtrIdfrV6iqJh6wmaA==
X-Received: by 2002:adf:be8b:: with SMTP id i11mr214953wrh.235.1546923553035;
        Mon, 07 Jan 2019 20:59:13 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id i13sm51827837wrw.32.2019.01.07.20.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 20:59:11 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] nfit: Hide unused functions behind CONFIG_X86
Date:   Mon,  7 Jan 2019 21:58:53 -0700
Message-Id: <20190108045853.5471-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 little endian allyesconfig:

drivers/acpi/nfit/intel.c:149:12: warning: unused function 'intel_security_unlock' [-Wunused-function]
static int intel_security_unlock(struct nvdimm *nvdimm,
           ^
drivers/acpi/nfit/intel.c:230:12: warning: unused function 'intel_security_erase' [-Wunused-function]
static int intel_security_erase(struct nvdimm *nvdimm,
           ^
drivers/acpi/nfit/intel.c:279:12: warning: unused function 'intel_security_query_overwrite' [-Wunused-function]
static int intel_security_query_overwrite(struct nvdimm *nvdimm)
           ^
drivers/acpi/nfit/intel.c:316:12: warning: unused function 'intel_security_overwrite' [-Wunused-function]
static int intel_security_overwrite(struct nvdimm *nvdimm,
           ^
4 warnings generated.

These functions are only used in __intel_security_ops when CONFIG_X86 is
set so only define these functions under that same condition.

Fixes: 4c6926a23b76 ("acpi/nfit, libnvdimm: Add unlock of nvdimm support for Intel DIMMs")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/acpi/nfit/intel.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 850b2927b4e7..2ba0f1543940 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -144,6 +144,7 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
 	}
 }
 
+#ifdef CONFIG_X86
 static void nvdimm_invalidate_cache(void);
 
 static int intel_security_unlock(struct nvdimm *nvdimm,
@@ -186,6 +187,7 @@ static int intel_security_unlock(struct nvdimm *nvdimm,
 
 	return 0;
 }
+#endif
 
 static int intel_security_disable(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key_data)
@@ -227,6 +229,7 @@ static int intel_security_disable(struct nvdimm *nvdimm,
 	return 0;
 }
 
+#ifdef CONFIG_X86
 static int intel_security_erase(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key,
 		enum nvdimm_passphrase_type ptype)
@@ -360,16 +363,10 @@ static int intel_security_overwrite(struct nvdimm *nvdimm,
  * TODO: define a cross arch wbinvd equivalent when/if
  * NVDIMM_FAMILY_INTEL command support arrives on another arch.
  */
-#ifdef CONFIG_X86
 static void nvdimm_invalidate_cache(void)
 {
 	wbinvd_on_all_cpus();
 }
-#else
-static void nvdimm_invalidate_cache(void)
-{
-	WARN_ON_ONCE("cache invalidation required after unlock\n");
-}
 #endif
 
 static const struct nvdimm_security_ops __intel_security_ops = {
-- 
2.20.1

