Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78B4C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5985B2064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5IHKZfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5985B2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJHR2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:28:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40827 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeJHR2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:28:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so8146870pfj.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 03:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DiOOxEqDanhgutW/0IuAYDiXhY1M1+Js3XIKYvcLGqg=;
        b=N5IHKZfFyo8KF19XiZmHuhwjgzQ/H9tgzJ2N6GUemxDKv2MY/8V6Be/76tECAO19Ui
         tkLllpWmqAnjKcO5LgFYQJEDyLjUW1gd+0H38wXLEbHqjpEURMRU117Ao0FT7qG6WAKa
         GmQA90IbLFIY8OxKNkxqFKRE+81Noh0S2Fq50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DiOOxEqDanhgutW/0IuAYDiXhY1M1+Js3XIKYvcLGqg=;
        b=IhTfm+9NtlepZ4vOnKpP4+Uuki8UrHPF96lE8MdV8VShsm3LGfuBALl8gM3oYA/9Eg
         +8LblutrTPNWBOEv6yovEVz9uw13t+plRKD4Y1WY+u+xhKo2+LOAokejjDRtlSb8zl7/
         yVjhNmzuEdPzvOZFzEb9op2LiM7GOyccA19l1+Jm7GnlbV8qjiYsnhEZe5UVMEULNAG0
         214eOPRAU88qwgB5c6kVlu0hXYeXG8z/dUu6xPf48oXVMNYTB8HVAmHeo9jpbeCVEOBX
         MwuxIeay3k82kvmVX8hLc7xY9VCXt8iidf3f8//oJvJpEBV9odd+Yea4Kk0LY/vOyz8Q
         d4/Q==
X-Gm-Message-State: ABuFfohemf53NuMkS/cfV5EcR1kmBp6aVNj/hmcaF8gAuLRGx7AwsWA8
        eGxQhAS++hrawOtgbqtuXiX6gA==
X-Google-Smtp-Source: ACcGV600It/E5UFu5ade/U1z9gN/BLRQA9HvsgtRPEsFAAHCqqgweRiqmQjyZ7grBtYJLgYvJ7UKCQ==
X-Received: by 2002:a63:ea43:: with SMTP id l3-v6mr20655352pgk.427.1538993827990;
        Mon, 08 Oct 2018 03:17:07 -0700 (PDT)
Received: from jfw540.solutionip.com (165084180235.ctinets.com. [165.84.180.235])
        by smtp.gmail.com with ESMTPSA id m10-v6sm24601032pfg.180.2018.10.08.03.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 03:17:07 -0700 (PDT)
From:   Jerome Forissier <jerome.forissier@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Maydell <peter.maydell@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        tee-dev@lists.linaro.org,
        Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2] Documentation: dt: Add binding for /secure-chosen/stdout-path
Date:   Mon,  8 Oct 2018 18:16:42 +0800
Message-Id: <20181008101642.8040-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms may use a single device tree to describe two address
spaces, as described in d9f43babb998 ("Documentation: dt: Add bindings
for Secure-only devices"). For these platforms it makes sense to define
a secure counterpart of /chosen, namely: /secure-chosen. This new node
is meant to be used by the secure firmware to pass data to the secure
OS. Only the stdout-path property is supported for now.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Notes:
    Sending this again, slightly modified. Previous submission was in March
    2017 [1]. Since then, OP-TEE has implemented this binding for platforms
    that use DT [2] (fallback to /chosen/stdout-path to be implemented in
    [3]). A patch for QEMU has been proposed [4], to which the maintainer
    responded "Are the DT bindings upstream yet?" ;-)
    
    [1] https://patchwork.kernel.org/patch/9602401/
    [2] https://github.com/OP-TEE/optee_os/commit/4dc31c52544a
    [3] https://github.com/OP-TEE/optee_os/pull/2569
    [4] https://patchwork.ozlabs.org/patch/979345/
    
    Changes since v1:
    - Use "should" instead of "may" ("...the Secure OS should use the value
    of /chosen/stdout-path...").

 Documentation/devicetree/bindings/arm/secure.txt | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/secure.txt b/Documentation/devicetree/bindings/arm/secure.txt
index e31303fb233a..f27bbff2c780 100644
--- a/Documentation/devicetree/bindings/arm/secure.txt
+++ b/Documentation/devicetree/bindings/arm/secure.txt
@@ -32,7 +32,8 @@ describe the view of Secure world using the standard bindings. These
 secure- bindings only need to be used where both the Secure and Normal
 world views need to be described in a single device tree.
 
-Valid Secure world properties:
+Valid Secure world properties
+-----------------------------
 
 - secure-status : specifies whether the device is present and usable
   in the secure world. The combination of this with "status" allows
@@ -51,3 +52,19 @@ Valid Secure world properties:
    status = "disabled"; secure-status = "okay";     /* S-only */
    status = "disabled";                             /* disabled in both */
    status = "disabled"; secure-status = "disabled"; /* disabled in both */
+
+The secure-chosen node
+----------------------
+
+Similar to the /chosen node which serves as a place for passing data
+between firmware and the operating system, the /secure-chosen node may
+be used to pass data to the Secure OS. Only the properties defined
+below may appear in the /secure-chosen node.
+
+- stdout-path : specifies the device to be used by the Secure OS for
+  its console output. The syntax is the same as for /chosen/stdout-path.
+  If the /secure-chosen node exists but the stdout-path property is not
+  present, the Secure OS should not perform any console output. If
+  /secure-chosen does not exist, the Secure OS should use the value of
+  /chosen/stdout-path instead (that is, use the same device as the
+  Normal world OS).
-- 
2.15.1

