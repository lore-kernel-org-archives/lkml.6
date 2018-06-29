Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C174C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3485127BD6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iPDwYqFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3485127BD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936537AbeF2SqX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:46:23 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43018 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934465AbeF2SqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:46:21 -0400
Received: by mail-pg0-f67.google.com with SMTP id a14-v6so4355946pgw.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Ww7LnS+ED+uus7+k/xyuZ455j+pUcX68Gc3gh1nhoHk=;
        b=iPDwYqFxueQtfo5ez5Bw+de+S/L1Rn5HbBVLEsH9oknUqVdFrcqo/UITgPagMq8sMQ
         xOlbKT0OSYYL2iXKaeCBx2D5mij/X7KEA8mwAlTqTCKj2AwgTyxTFDsC5duglO02vBDo
         1widtyxGF1WS4IXfy3pqKkWaRrfwbHr9YiPRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Ww7LnS+ED+uus7+k/xyuZ455j+pUcX68Gc3gh1nhoHk=;
        b=qVX0rV6o7IAovYR4FLyvH/PYLO2ecDWcv3GwLZEwMlQiAHYEe2i1Zd1kXYoM6cH8GH
         3b5niFpkQ07rilxyMuy40iYIpQuNyQqLP+eXozkkAOvI9p3/kiHyy01VPmarNpPUZGcL
         Lio91w6ZEWNCdekApMChOhtF+H0D1eJdcfzcvZcSoThRQ8M+W19vHNm0sqmYTga8FpyJ
         dd6sJwJUDKTMQkslwXFyTBZCd/UQj7KzzBDFlVrUziGCtgS4OY6hOIHQxPlzjYqc4tj+
         H14pUuiitao2VHEgUyYrBK3W5dcA/e0ngivDktw/qxtAZRwPeMPgZTWvQwX2dc4jzPEe
         jO3Q==
X-Gm-Message-State: APt69E2vWWkenYTBqe29/2aDt8s1mIkyzoHTThR2wbjVwlWR5GD1b24k
        bxKOI6UzQyDNQBrD7fEUvyQn3w==
X-Google-Smtp-Source: ADUXVKK6cd20yzntVlakGt+Vs98VhGZCsN0bqc83Q8XzlqPtcdRYablIVEr7GS5Ja7CoI9Heq34A+g==
X-Received: by 2002:a63:24c4:: with SMTP id k187-v6mr13485065pgk.434.1530297980578;
        Fri, 29 Jun 2018 11:46:20 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q188-v6sm3435240pfb.141.2018.06.29.11.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:46:19 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:46:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoffer Dall <christoffer.dall@arm.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: vgic-its: Remove VLA usage
Message-ID: <20180629184618.GA37364@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
switches to using a maximum size and adds sanity checks. Additionally
cleans up some of the int-vs-u32 usage and adds additional bounds checking.
As it currently stands, this will always be 8 bytes until the ABI changes.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 virt/kvm/arm/vgic/vgic-its.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 4ed79c939fb4..3143fc047fcf 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -168,8 +168,14 @@ struct vgic_its_abi {
 	int (*commit)(struct vgic_its *its);
 };
 
+#define ABI_0_ESZ	8
+#define ESZ_MAX		ABI_0_ESZ
+
 static const struct vgic_its_abi its_table_abi_versions[] = {
-	[0] = {.cte_esz = 8, .dte_esz = 8, .ite_esz = 8,
+	[0] = {
+	 .cte_esz = ABI_0_ESZ,
+	 .dte_esz = ABI_0_ESZ,
+	 .ite_esz = ABI_0_ESZ,
 	 .save_tables = vgic_its_save_tables_v0,
 	 .restore_tables = vgic_its_restore_tables_v0,
 	 .commit = vgic_its_commit_v0,
@@ -180,10 +186,12 @@ static const struct vgic_its_abi its_table_abi_versions[] = {
 
 inline const struct vgic_its_abi *vgic_its_get_abi(struct vgic_its *its)
 {
+	if (WARN_ON(its->abi_rev >= NR_ITS_ABIS))
+		return NULL;
 	return &its_table_abi_versions[its->abi_rev];
 }
 
-int vgic_its_set_abi(struct vgic_its *its, int rev)
+static int vgic_its_set_abi(struct vgic_its *its, u32 rev)
 {
 	const struct vgic_its_abi *abi;
 
@@ -1881,16 +1889,19 @@ typedef int (*entry_fn_t)(struct vgic_its *its, u32 id, void *entry,
  * Return: < 0 on error, 0 if last element was identified, 1 otherwise
  * (the last element may not be found on second level tables)
  */
-static int scan_its_table(struct vgic_its *its, gpa_t base, int size, int esz,
+static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
 			  int start_id, entry_fn_t fn, void *opaque)
 {
 	struct kvm *kvm = its->dev->kvm;
 	unsigned long len = size;
 	int id = start_id;
 	gpa_t gpa = base;
-	char entry[esz];
+	char entry[ESZ_MAX];
 	int ret;
 
+	if (WARN_ON(esz > ESZ_MAX))
+		return -EINVAL;
+
 	memset(entry, 0, esz);
 
 	while (len > 0) {
-- 
2.17.1


-- 
Kees Cook
Pixel Security
