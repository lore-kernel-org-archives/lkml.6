Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ABCC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BAC2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BAC2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeIFAKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:10:47 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41611 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbeIFAJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:26 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so15892501oiw.8;
        Wed, 05 Sep 2018 12:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w5y2GFORKjExM0nWitCpBSerVbpnpsUXlRB1soYRGOY=;
        b=kmNKlpEjpwGzBWAkvC9mBGWRpHPNtvEr3D8DwcVlKMRoiLIl+SGDnRkBzMWtm8qr52
         dpIdn2Gi1XEFnHvPZycazNwCYKIc3mnsmG0eLp8bIrCIid5wi0HMCXAM6FGpPaF48nJC
         uxJvOx4AY+vz6OeBqeiNe6wAYulbXcuQw9nHTGTAM+WjwmvWefEdBJaJhP0Ky0plPM6l
         jEsJ/aJjXDPVGYoPDPmBiEWnE0SCrT4WZRdbN4fjH1T4wxzIBIdvRm7NSL1Rdbc6u0pO
         +kLGgsQneEuUCX3nVC0eq4LWEiRoA6GPY3IU3cmQiMjW0lm7gZFgirStmQ4nehC8SZdn
         7TEg==
X-Gm-Message-State: APzg51CESvcVWwbIEVbVfhuQD1FkIuFVFp/C2VEbwLp+r6Uxzu86/gbi
        fmakhGZgBhUlzRy1FCxlySKt1LI=
X-Google-Smtp-Source: ANB0VdYLEw5f4c9qEUcwbAiP+bJB084xDcMrJH8EZITz4aXpLhVqcKcZsqmUPqlAt0tpCe4pgMvUlQ==
X-Received: by 2002:aca:af11:: with SMTP id y17-v6mr29484832oie.274.1536176268642;
        Wed, 05 Sep 2018 12:37:48 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:48 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: [PATCH 07/21] c6x: use for_each_of_cpu_node iterator
Date:   Wed,  5 Sep 2018 14:37:24 -0500
Message-Id: <20180905193738.19325-8-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
has the side effect of defaulting to iterating using "cpu" node names
in preference to the deprecated (for FDT) device_type == "cpu".

Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: linux-c6x-dev@linux-c6x.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/c6x/kernel/setup.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/c6x/kernel/setup.c b/arch/c6x/kernel/setup.c
index 786e36e2f61d..2e97455ca0b7 100644
--- a/arch/c6x/kernel/setup.c
+++ b/arch/c6x/kernel/setup.c
@@ -96,7 +96,7 @@ static void __init get_cpuinfo(void)
 	unsigned long core_khz;
 	u64 tmp;
 	struct cpuinfo_c6x *p;
-	struct device_node *node, *np;
+	struct device_node *node;

 	p = &per_cpu(cpu_data, smp_processor_id());

@@ -190,13 +190,8 @@ static void __init get_cpuinfo(void)

 	p->core_id = get_coreid();

-	node = of_find_node_by_name(NULL, "cpus");
-	if (node) {
-		for_each_child_of_node(node, np)
-			if (!strcmp("cpu", np->name))
-				++c6x_num_cores;
-		of_node_put(node);
-	}
+	for_each_of_cpu_node(node)
+		++c6x_num_cores;

 	node = of_find_node_by_name(NULL, "soc");
 	if (node) {
--
2.17.1
