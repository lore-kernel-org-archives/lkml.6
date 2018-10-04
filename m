Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA90C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124DD213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFFxayGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124DD213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeJDQbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:31:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33374 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeJDQaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:30:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id o21-v6so6291916lfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S2NIzWq2CTrMUxi7pOjRA0sdDpfcGRSSJYTlPumKW8E=;
        b=fFFxayGVShPNrglAEtPTrDrunx1hP8iKBHk9uVzKLmwPYCqps7/g4a4Jgz6DRlzKNq
         s2QU98jXs2QUDDOupfN2ptueB8SXQ7Rsk3jdBajn4Tx2RJ4zofScmZqX1TeOOZGSJMlK
         boIZjFxYjnrNiwXRZlSimVupUNauYL8kXl25egIhJMGgpVIbB7CiS6jbvZsGvSiXaRYd
         zGJPx6yijOkvbPJXMa5hy93Zw7kzHabqtS5CXjwfPkoUpb85VkIpdaHpuSH4EapDAlDc
         WBQ7XAOg/HvLCRqQJxNNS33bzQxA1LH8ITIl/gbktbUsL3QtECHfUY2O7YtfI8rsf68i
         TpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=S2NIzWq2CTrMUxi7pOjRA0sdDpfcGRSSJYTlPumKW8E=;
        b=qsO46pnxUdxCNxCsHkizeWo/lRVWZHyEAp08h7M63f4ueQgbIntfiTiXfqYcPfUtHD
         o7NqyKv1u4Sqh+wXYVxSXF/+dJlApYO+tebIrP9HUW10+7Pb1Dl8uSNAsmfl0fKP4xRh
         SXx5hr0+Cc3VBCfmM0Yq04mCEmBdklkkNMG187gyVq9nIzjHL0/jYlVM16fkpIqY7c/2
         h1flnq1/iojEuqXiCRz5BTwfWcsnDNErRsPSHaci5kgRw0j8nJqyG4QongJcnKokMs2P
         hZ5dtWW1EE6hhR0TvvGynJM7mGfNngvXgqXYOTMEuCtHHLAoG2UCemcG2AfNttC/xGr6
         ldmQ==
X-Gm-Message-State: ABuFfogOh+rwgMXPM3ht8p87GKxLpNd6CI+Z+qVme/zxzuxEDwvL/F9B
        TTqzMkO2ssX3tHsyJ+56dQM=
X-Google-Smtp-Source: ACcGV63CepNaoGQ3Oc5whWTqt8u+Pg+PwpqFNsrWBdXGEZ0VL++6k8YcgWSi18gH+XUG4dx3eBuBwA==
X-Received: by 2002:a19:9209:: with SMTP id u9-v6mr3532028lfd.26.1538645905507;
        Thu, 04 Oct 2018 02:38:25 -0700 (PDT)
Received: from localhost.localdomain (df8yyyyyyyyyyygn-tkvt-3.rev.dnainternet.fi. [2001:14ba:2700::157f:8223])
        by smtp.gmail.com with ESMTPSA id f128-v6sm899738lff.40.2018.10.04.02.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 02:38:24 -0700 (PDT)
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 5/7] staging: vc04_services: Drop VCHI_SERVICE_INIT and SERVICE_INFO_T
Date:   Thu,  4 Oct 2018 12:37:45 +0300
Message-Id: <20181004093747.21750-6-tuomas.tynkkynen@iki.fi>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These types are not used anywhere, remove them.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 103d67024335..5c5bb6ddd9ce 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -87,15 +87,6 @@ typedef struct opaque_vchi_instance_handle_t *VCHI_INSTANCE_T;
 // Opaque handle for a server or client
 typedef struct opaque_vchi_service_handle_t *VCHI_SERVICE_HANDLE_T;
 
-// Service registration & startup
-typedef void (*VCHI_SERVICE_INIT)(VCHI_INSTANCE_T initialise_instance, VCHI_CONNECTION_T **connections, uint32_t num_connections);
-
-typedef struct service_info_tag {
-   const char * const vll_filename; /* VLL to load to start this service. This is an empty string if VLL is "static" */
-   VCHI_SERVICE_INIT init;          /* Service initialisation function */
-   void *vll_handle;                /* VLL handle; NULL when unloaded or a "static VLL" in build */
-} SERVICE_INFO_T;
-
 /******************************************************************************
  Global funcs - implementation is specific to which side you are on (local / remote)
  *****************************************************************************/
-- 
2.18.0

