Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4FBC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE1420659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE1420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeIEAU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:20:57 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:54529 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbeIEAU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:20:56 -0400
Received: by mail-wm0-f41.google.com with SMTP id c14-v6so5659709wmb.4;
        Tue, 04 Sep 2018 12:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aBCoseBOdUxUrK0ZT7baLqbU7j2FzF5MRvDHwlcMqao=;
        b=kspBkcRv5zRv8F4UA82vAxTdt3zp3Rw86tVmn4n8PZOemOxHCxPPcwY55dOJtrfHd8
         bH5k6RXm17iSpQgfJ2XAyg54FSqJWP58yM42RMpf1I34nob1Wb9DzeLNy2Fh95oFrhcV
         IM2ltLvqW5EvVKuNEa9KxWgHRi42drGCxvqaP9PVFN+fbZDqD48MNb4ehw8oRO9Q3HmZ
         cPP4YsivTk9DHg/Qv0b+kRutPq35pE8cI3yuBGON4gRE7KqGqYs61mnhk+RG3/RsAtQV
         tXgCqm7s7xzTkDqn58cXD+hqKJtvW8ng5LJKA/0k4hFECVoFxqt7lpm/S3OtYDLgDz5l
         hAcA==
X-Gm-Message-State: APzg51Ck+a43f2nYkz5LeVCVARXmjFEFTj4HZKXapUTPj7taqVjm5PbS
        hQH4EEDd0XUb8OF1hwFnk/OTqh85Gtv8pw==
X-Google-Smtp-Source: ANB0VdaHQhSHvSuGuaBY77qKma/KdKUgOxYHSP8qFobfWYoCXTBs3EcsybrImobkQihqYuZrt4ZW1g==
X-Received: by 2002:a1c:aa8f:: with SMTP id t137-v6mr8538476wme.54.1536090856937;
        Tue, 04 Sep 2018 12:54:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:f474:3704:f9a0:fc57])
        by smtp.gmail.com with ESMTPSA id 144-v6sm99440wma.19.2018.09.04.12.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 12:54:16 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next v2 6/9] if_link: add IFLA_TARGET_NETNSID alias
Date:   Tue,  4 Sep 2018 21:53:52 +0200
Message-Id: <20180904195355.4695-7-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904195355.4695-1-christian@brauner.io>
References: <20180904195355.4695-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds IFLA_TARGET_NETNSID as an alias for IFLA_IF_NETNSID for
RTM_*LINK requests.
The new name is clearer and also aligns with the newly introduced
IFA_TARGET_NETNSID propert for RTM_*ADDR requests.

Signed-off-by: Christian Brauner <christian@brauner.io>
Suggested-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Jiri Benc <jbenc@redhat.com>
---
v1->v2:
- patch added

v0->v1:
- patch not present
---
 include/uapi/linux/if_link.h       | 1 +
 tools/include/uapi/linux/if_link.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 43391e2d1153..29d49b989acd 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -161,6 +161,7 @@ enum {
 	IFLA_EVENT,
 	IFLA_NEW_NETNSID,
 	IFLA_IF_NETNSID,
+	IFLA_TARGET_NETNSID = IFLA_IF_NETNSID, /* new alias */
 	IFLA_CARRIER_UP_COUNT,
 	IFLA_CARRIER_DOWN_COUNT,
 	IFLA_NEW_IFINDEX,
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index cf01b6824244..1c73d63068b1 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -161,6 +161,7 @@ enum {
 	IFLA_EVENT,
 	IFLA_NEW_NETNSID,
 	IFLA_IF_NETNSID,
+	IFLA_TARGET_NETNSID = IFLA_IF_NETNSID, /* new alias */
 	IFLA_CARRIER_UP_COUNT,
 	IFLA_CARRIER_DOWN_COUNT,
 	IFLA_NEW_IFINDEX,
-- 
2.17.1

