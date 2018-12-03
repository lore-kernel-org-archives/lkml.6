Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8F4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB87020672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t5l2n23g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB87020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeLCQmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:42:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37826 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeLCQmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:42:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so6381765wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 08:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=e5uVplEPpQhyCY4yqBSU823SOsbgfQ7miWnib7wRxWQ=;
        b=t5l2n23gT+BlxJRvYyx5Naa6lxSPbgPCTAmLejnnwhvmtImEIuite3FAYKc/GPnKu1
         /hB56Uh7eYDLJqTHaHxFzRZR9X4e/8HdzcQzgTsC2RS22VIy9L360hDKtC9L7fM0ZvY6
         LMYuJHNIszYd5RrgDfseiBLX4KgyJl9UfyTx+EpIs4WY267caZw///zbIz7BrmTtQHki
         t7SVopram1l+5HemuDhRr8g6kjY3hT2VxiNw4lKz2ngP9vkDrKH9iQKt/8/bxnKYKGD8
         /1/rua+YqJdc/cFWbuqjo60MKQeW6CxEXJ0fcHjLn1QxXNJcKStKXJ9rrwGUoYmZESWa
         ClNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=e5uVplEPpQhyCY4yqBSU823SOsbgfQ7miWnib7wRxWQ=;
        b=VLnBq9WT1DDMnimwlvkb0pmNP7gPactl20tnZ9akgtJ0Mo46H8UUrSs8bDXfE88vzv
         lXnVYJWtMzswFxrF0kGanCAGLQ7NrPqUKNH5hWNLqquAybqzdD78khCoGaYzf/4P97kj
         0tcbAdpgin1LN1DAIvAst1S8+ftSRrvzozITWRkgo162Cwj0Ev96EHaFkEXg98KqiXpK
         Euco5K5BV1OS/kFbnLVRrE/VuFThUIjeYyTirVGAW3V5hAKlbolHk/trpCmmIeQ9fLVT
         RV1lpV9xBKFkOFk8EUicTlgMyLEPsfkX7GgsJoVMekyyR1iyJtwgJo4q47mNgRtGYjVU
         KPTQ==
X-Gm-Message-State: AA+aEWaK3xL+6bImhnGOqusISnTe5HLv2PRBFLZEubV8rYZ5vB8ngSRh
        ftzrDIAnDxUyBNtldwCN3XwGOnI=
X-Google-Smtp-Source: AFSGD/VeZ10zY2bDhpedELTlcf+Rhq8W8kfAqCmfEs70wMDWKCo5RcfEqz2yO67rt6z3elQ8+85CaA==
X-Received: by 2002:a1c:5d4f:: with SMTP id r76-v6mr9074724wmb.25.1543855365454;
        Mon, 03 Dec 2018 08:42:45 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id d4sm4482214wmb.25.2018.12.03.08.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 08:42:44 -0800 (PST)
Date:   Mon, 3 Dec 2018 19:42:42 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, nhorman@tuxdriver.com
Subject: [PATCH] proc: slightly faster /proc/*/limits
Message-ID: <20181203164242.GB6904@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Header of /proc/*/limits is a fixed string, so print it directly without
formatting specifiers.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -581,8 +581,10 @@ static int proc_pid_limits(struct seq_file *m, struct pid_namespace *ns,
 	/*
 	 * print the file header
 	 */
-       seq_printf(m, "%-25s %-20s %-20s %-10s\n",
-		  "Limit", "Soft Limit", "Hard Limit", "Units");
+	seq_puts(m, "Limit                     "
+		"Soft Limit           "
+		"Hard Limit           "
+		"Units     \n");
 
 	for (i = 0; i < RLIM_NLIMITS; i++) {
 		if (rlim[i].rlim_cur == RLIM_INFINITY)
