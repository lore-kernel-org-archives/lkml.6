Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE907C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7524E20865
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkE69wQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7524E20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeJMMaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:30:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42794 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeJMMat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:30:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so6736470pgq.9;
        Fri, 12 Oct 2018 21:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XMDnNdUW/sDd17o9F9TmJbiIxv65t1vRquMBQw128TM=;
        b=DkE69wQRrK5yz6q10N0/zzSN4tjKocDLbD5B/P1nMv+DQSSvO/PKPv4D4ZCzfXYeo1
         bfYK3FzpeulvPJguvMj28f8znYmQCUW6k6gg6CquRQ8CuPsaay/Ce5FLCP7o4Z783IX3
         6LrKeUbowH7A/sQ/xaQMVzi9X5v+SYYZWBZIJk3JI6eskCfxyKuwDP+8cfv0C5lXhn8q
         Mxpa+SD+ZewIgd3wO6wT7NUkJLNUuz8U+3XIF+TLm4smM9mfgAExDgNK3lyyex8k8OFF
         /RW3UUG1ZlLTKKRhqyQ5Exhwuo9cyiCFWfjAMNBQbJBrvEun3jDZmmu7/EPhme6mLJI7
         xE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XMDnNdUW/sDd17o9F9TmJbiIxv65t1vRquMBQw128TM=;
        b=og31tXh7XoIn8QZwP5stDW5a+0bAT7MKCyb86JYbzpOHWEnbyIqakt3DXR8dLZTl3Z
         K+J+1mmQPtNEV/G896hQe/7x+SrPOeVjA5s5WDsyoy0UEO34eEG9uMg6lXjZ0yBKbtvv
         DbCQzNi92Mv1QvbvXUif4dR+3WC1NSIdttjY3T64cNLMjBhKkX/o8JDU/vRIqtowS0lr
         +xD5+efdHLnzlVgjxq4HLFdmVQRiTFbIa/ZfVSUp0MNipC/+BG2jHn3XncaG2rVRrqrM
         +1Sj2OgpadI0RuwCAVxtI12GB3ujVlwQ9ogegEqBeNvAwZLSbZD0GLUiZ8VwBbeJvfPj
         0YXw==
X-Gm-Message-State: ABuFfoiNom/sWhTSlG8jkTSrDrifK9YZOYjSYRyPY0iGpQrt8oMTRXEB
        QXDsnhakpv3nvgkKhliFzoo=
X-Google-Smtp-Source: ACcGV63O/Z7W+La/xikCOyTH2Em6nqwV6pogOiouMWZHCDyZ2FkSu3kUqaV7Qveg8yjYowc513kDsA==
X-Received: by 2002:a62:7a81:: with SMTP id v123-v6mr9097572pfc.240.1539406508248;
        Fri, 12 Oct 2018 21:55:08 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 21:55:07 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v2 03/18] of: overlay: add missing of_node_get() in __of_attach_node_sysfs
Date:   Fri, 12 Oct 2018 21:53:23 -0700
Message-Id: <1539406418-18162-4-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

There is a matching of_node_put() in __of_detach_node_sysfs()

Remove misleading comment from function header comment for
of_detach_node().

This patch may result in memory leaks from code that directly calls
the dynamic node add and delete functions directly instead of
using changesets.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

This patch should result in powerpc systems that dynamically
allocate a node, then later deallocate the node to have a
memory leak when the node is deallocated.

The next patch in the series will fix the leak.

 drivers/of/dynamic.c | 3 ---
 drivers/of/kobj.c    | 4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index b04ee021a891..275c0d7e2268 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -272,9 +272,6 @@ void __of_detach_node(struct device_node *np)
 
 /**
  * of_detach_node() - "Unplug" a node from the device tree.
- *
- * The caller must hold a reference to the node.  The memory associated with
- * the node is not freed until its refcount goes to zero.
  */
 int of_detach_node(struct device_node *np)
 {
diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index 7a0a18980b98..c72eef988041 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -133,6 +133,9 @@ int __of_attach_node_sysfs(struct device_node *np)
 	}
 	if (!name)
 		return -ENOMEM;
+
+	of_node_get(np);
+
 	rc = kobject_add(&np->kobj, parent, "%s", name);
 	kfree(name);
 	if (rc)
@@ -159,6 +162,5 @@ void __of_detach_node_sysfs(struct device_node *np)
 		kobject_del(&np->kobj);
 	}
 
-	/* finally remove the kobj_init ref */
 	of_node_put(np);
 }
-- 
Frank Rowand <frank.rowand@sony.com>

