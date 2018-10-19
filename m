Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CFAECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAAD20843
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="O3ck/LdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAAD20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeJTGh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 02:37:59 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:59018 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeJTGh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 02:37:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id C2AF95B7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 22:29:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zBCdz86ay1Ix for <linux-kernel@vger.kernel.org>;
        Fri, 19 Oct 2018 17:29:59 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 96F3F51F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 17:29:59 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id c5-v6so32279309ioa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iwvFF46/7+gW82As8qzTKaOAJqB0Pe9GkSWO9/Fnfow=;
        b=O3ck/LdXidoDW4O+gYfKmoTbn385UsyeIAQNI5Nc8QHAiGI5WkOIYjaArR6/iyZp5S
         V7Y0rzJmliPAVfg5CCpVAVFgd3jS7xFdcGgrne0O+ikEx4GUp7YS2lHdkElg9CP47b1k
         UvD1tDOtPlD4V063FT2ZCphERCVxs/QQE9MZRQnzRh4GFMkZFKCF8F3dkZjFB7NSezvL
         J+vxGXtJcLRQo6NOOF+r/ZB+7Z/Ew14jp6Y7tcePrJ9ekLOBlGMGkJIpcy/9CFXh86kZ
         uJoppB2ePYWsrWIG75NeiVSaKUYdRpoR33c5JI6YlRBjmaXYefPE4LYAhNlBTtt9RmYp
         TitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iwvFF46/7+gW82As8qzTKaOAJqB0Pe9GkSWO9/Fnfow=;
        b=egZoTNSU8DTIMPxsn2zebjKe40mC5kbdNy/EJwGpjh2GPKwjCm5W0JR58cQt0mF0hL
         Kjw9KKYcmctZcBbLBvRfZ3NpuBP4HBC+SFmIB5ISufbMr0J1BTJYARifFEhx7eIzBVrg
         ZC9p7E0dLFxZ7aqZQIjmHuNwfv341XURkdznReQ4jhYV06+FsRDzFemhUE+bMs0dTICy
         SU7k1rB2wh95c9QrTFKMReJFZNCxaa36fimNjdWxxHEcfinxOWZoJ6FMyhuQkaNqj5TX
         QxCouRFIWLTz204st8sj2q5kMcWJ6gYKCho0YnuhMe3UpY9CEuALmtNmpwguGh933zkz
         mNxA==
X-Gm-Message-State: ABuFfoil6vltO/N9WOpnlNC1NF4k4XYSqPKIj5ahlCtzvut7m09J/DDQ
        450uGOUcOcQXuSaixSAFj7Gupfd3OOs1SXHLQb3bXaIfbIU5xt3f182Xb9VA2gQV2EmmDwdP5dt
        pR46KJkxMNWQe+9JLU/kU21cJeKbE
X-Received: by 2002:a24:d2c4:: with SMTP id z187-v6mr4273009itf.9.1539988199282;
        Fri, 19 Oct 2018 15:29:59 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62umbrEOzOhP5mW/xuHTEyVeDLtbAvibY0BHOOys8tKZLe0yThAamSlwHbSmnqA5ANMbhgaWQ==
X-Received: by 2002:a24:d2c4:: with SMTP id z187-v6mr4273002itf.9.1539988199102;
        Fri, 19 Oct 2018 15:29:59 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id 82-v6sm1691384ita.17.2018.10.19.15.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 15:29:58 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        linux-kernel@vger.kernel.org (open list:BPF (Safe dynamic programs and
        tools))
Subject: [PATCH] bpf: btf: Fix a missing-check bug
Date:   Fri, 19 Oct 2018 17:29:51 -0500
Message-Id: <1539988191-13973-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In btf_parse(), the header of the user-space btf data 'btf_data' is firstly
parsed and verified through btf_parse_hdr(). In btf_parse_hdr(), the header
is copied from user-space 'btf_data' to kernel-space 'btf->hdr' and then
verified. If no error happens during the verification process, the whole
data of 'btf_data', including the header, is then copied to 'data' in
btf_parse(). It is obvious that the header is copied twice here. More
importantly, no check is enforced after the second copy to make sure the
headers obtained in these two copies are same. Given that 'btf_data'
resides in the user space, a malicious user can race to modify the header
between these two copies. By doing so, the user can inject inconsistent
data, which can cause undefined behavior of the kernel and introduce
potential security risk.

To avoid the above issue, this patch rewrites the header after the second
copy, using 'btf->hdr', which is obtained in the first copy.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 kernel/bpf/btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 138f030..2a85f91 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2202,6 +2202,9 @@ static struct btf *btf_parse(void __user *btf_data, u32 btf_data_size,
 		goto errout;
 	}
 
+	memcpy(data, &btf->hdr,
+		min_t(u32, btf->hdr.hdr_len, sizeof(btf->hdr)));
+
 	err = btf_parse_str_sec(env);
 	if (err)
 		goto errout;
-- 
2.7.4

