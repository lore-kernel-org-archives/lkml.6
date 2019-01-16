Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2134EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB78620840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3T46Ahg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfAPTfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:35:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36409 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730757AbfAPTfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:35:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so8338489wrp.3;
        Wed, 16 Jan 2019 11:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gtvQ9KEQlr3VjHnPrshJevCpf5d8/LDJg0zUYeTkVfU=;
        b=s3T46AhgATtizBvjy2jECwbf4uNZe1wf69a7ZCqPAkz2dBpG4WjWuUoKo7l7oYBywY
         +1sEEmb5tLGan09s/tddYbSTdPJmzXnxhjFZbgpVGmqO7DyPf65fHNZRFr5NEc+57Jpt
         pNKc5v/8OOhhae0OpBDZ152G+RwFv5ED6+OpB2aYcICD2ihzrH5Y/8kOKEqBPUlW5TYX
         W73D2weSjXIgB7a1jC+3X9xVC0cueuHERKW6O8/6oLk4dPrM/tX0bJ+Z86hnTaLSxHpG
         uryzeRGvO82Aeu7Nk+mE/kBJMoUYq+7fqkh7lStpLeSSOb9yi+OCBDlUBzhfeLg13+3n
         Atmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gtvQ9KEQlr3VjHnPrshJevCpf5d8/LDJg0zUYeTkVfU=;
        b=S9M2ZW+34VPb4eiG3xDKZYPPUj/wbtpqmkecfeP4sPiD/yc2sWI4uHm1VZ1Lvpz1px
         zMX4XzD+8FCYWlKSV3KcVAGmeenXMYzfKm43f9VHKJApVeCy9V8u5UfGSMIagyF34Yqa
         CDNHXE6OCJyTJU57bGJaqDnp3hXy3xazput7UdgZ1xPpMlYjsilZIlFlDcvLqODy/Fsl
         sf0BTdJdv/eVTQUaUahhh4TIlLLxRjrQT/Y7aaGBeYqkNfZIvqfrGd+dACulxougCHO1
         vt+m1czmByZy/ZMM9KMVX2HJc5QQQqX+zO4MzXqVl7BrJmGXFfGR4u/RJeOm3Qrfe1xU
         qbDQ==
X-Gm-Message-State: AJcUukeXneR+QA014Ya/o6yylXSb2CkARq3BGzURDJYxsDUvOZSpkxyV
        tUvoFEa6qp4wPCkATaIJAdA=
X-Google-Smtp-Source: ALg8bN6tzj5Dh/ukpzzUd54riVbFaoQOVcTfOTwpaAF0QIvKFHjZUWPDpx59/dvgmFFlFH3l3PYNlQ==
X-Received: by 2002:adf:e1c3:: with SMTP id l3mr9051416wri.36.1547667334326;
        Wed, 16 Jan 2019 11:35:34 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id j124sm25407187wmb.48.2019.01.16.11.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 11:35:33 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id B1C2B11423A3; Wed, 16 Jan 2019 20:35:31 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] bpf: Annotate implicit fall through in cgroup_dev_func_proto
Date:   Wed, 16 Jan 2019 20:35:29 +0100
Message-Id: <20190116193529.32488-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190114202941.16183-1-malat@debian.org>
References: <20190114202941.16183-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warnings (W=1).

This commit remove the following warning:

  kernel/bpf/cgroup.c:719:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: Reword the patch subject

 kernel/bpf/cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 9425c2fb872f..ab612fe9862f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -718,6 +718,7 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_trace_printk:
 		if (capable(CAP_SYS_ADMIN))
 			return bpf_get_trace_printk_proto();
+		/* fall through */
 	default:
 		return NULL;
 	}
-- 
2.19.2

