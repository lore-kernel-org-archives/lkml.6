Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5422BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A71320854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548172367;
	bh=K+yRUm5FC5i6VX6PeVSsWpQAE4q9EouTsdh1N4j0iXw=;
	h=From:To:Subject:Date:List-ID:From;
	b=nq3mhh0tM5Iecuq+msp9hgbmbshaxTQfGS0mU3qmXbKANQb65I17wZ7EuOPSgdxQH
	 eoLj8HHO+MPCpIGsTEZJUMfX6kV1Mgo6y69o7ervFFrZZ4uE1z/Fx5TFDKn64qxeYW
	 CBrf6cMQzfpM7yE0UoOHRK9YiHEPjq5zW+cGTSZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfAVPwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:52:44 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39522 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfAVPwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:52:44 -0500
Received: by mail-oi1-f195.google.com with SMTP id i6so17772674oia.6;
        Tue, 22 Jan 2019 07:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dp1AW7FOcWjCzmDodaUU8xKqbFfUgPNbofInvPo9T80=;
        b=BYGtjXjRnf3vtoWQ+UyX1Mi2KbFFfMvJ3VVS+nbhRxa0fXBdTy2hoMTzG8eHL4rTwP
         SnkFzJzRjxuI0iam55a/c5ogHNJTiFbwfpeEf0XZCQ0xz/7Y23AGMEGQcK85pl+uhl0y
         jh/wk5wrZKfry0k4rqJixoR/ADGXkNKfiL44wKOMz/sB5zGldUG9MyK31emL88p/QDxp
         4FSEmIdM5PavhAcTDDDB5+Mfv3Mt3A0wVoQ6LFQOXcU0PCnPCRYJqPxiwqd2v0s7R2UI
         XQ8KGRTNwDUYbY9gK8PzF5etzb97pvYbT9zjbZwAN/elx2ep/UF/esTj+HJNUPwfc7xk
         VFDA==
X-Gm-Message-State: AJcUukeqR8iManSBSKBctr5uavWno2+ZohtpU+/TWJr56yelpjjs7Q0Q
        ey5t3Gc71JiHrR79XwkxkyretqpQsg==
X-Google-Smtp-Source: ALg8bN7fr8FrGGPUtR2bBQjo4dZp5OygGtDkJ6OU/oa+eUFIX9pNXYO9CvEHDHSPewDZ/upK8nl0fw==
X-Received: by 2002:aca:be85:: with SMTP id o127mr8375371oif.164.1548172363604;
        Tue, 22 Jan 2019 07:52:43 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j11sm7911135oif.9.2019.01.22.07.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 07:52:43 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Fix dt_binding_check target for in tree builds
Date:   Tue, 22 Jan 2019 09:52:42 -0600
Message-Id: <20190122155242.2770-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On in tree builds, subsequent builds will incorrectly include
the intermediate file 'processed-schema.yaml' with the input schema
files resulting in a build error. Update the find command to ignore
processed-schema.yaml.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 6e5cef0ed6fb..50daa0b3b032 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -17,7 +17,11 @@ extra-y += $(DT_TMP_SCHEMA)
 quiet_cmd_mk_schema = SCHEMA  $@
       cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(filter-out FORCE, $^)
 
-DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
+DT_DOCS = $(shell \
+	cd $(srctree)/$(src) && \
+	find * \( -name '*.yaml' ! -name $(DT_TMP_SCHEMA) \) \
+	)
+
 DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
 
 extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
-- 
2.19.1

