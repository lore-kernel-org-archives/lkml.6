Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55119C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6BB21479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oMY/3ZyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6BB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJJO3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:29:20 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:52148 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeJJO3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1539155313; x=1570691313;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=w+hHEAoJ5hpaW+ULiHQyz7VhyKbzrteZy7qUlDaIHNA=;
  b=oMY/3ZyOxP63hgz3GP29txgGxCTAqHx00M7mTP9GcA4Xal/QqDGLduSZ
   IJce/wjYHwwQwJ0ES+ZaTFbrl7eaY+twwVmzKoHYxIvpJzcFFfKp/59iC
   Pg6bZanhP7LqYUiO+mun6ABMdzJWFK1K42+FY/mPCLLDzpiThC3xD2tqi
   c=;
X-IronPort-AV: E=Sophos;i="5.54,363,1534809600"; 
   d="scan'208";a="763082265"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Oct 2018 07:08:31 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9A78SoF096446
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 10 Oct 2018 07:08:30 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 10 Oct 2018 07:08:29 +0000
Received: from udc4a3e82dbc15a031435.hfa14.amazon.com (10.43.160.4) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 10 Oct 2018 07:08:24 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <talel@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>
Subject: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Date:   Wed, 10 Oct 2018 10:08:12 +0300
Message-ID: <1539155293-21750-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.4]
X-ClientProxiedBy: EX13d09UWC004.ant.amazon.com (10.43.162.114) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the dw-apb-ssi binding document, to add an optional 'cs-override'
devicetree property.

This property adds the ability for dw spi controller driver to work with
the dw spi controller found on Alpine chips.

The dw spi controller has an auto-deselect of Chip-Select, in case there is
no data inside the Tx FIFO. While working on platforms with Alpine chips,
auto-deselect mode causes an issue for some spi devices that can't handle
the Chip-Select deselect in the middle of a transaction. It is a normal
behavior for a Tx FIFO to be empty in the middle of a transaction, due to
busy cpu. In the Alpine chip family an option to change the default
behavior was added to the original dw spi controller to prevent this issue
of de-asserting Chip-Select once TX FIFO is empty. The change was to allow
SW to force the Chip-Select. With this change, as long as the Slave Enable
Register is asserted, the Chip-Select will be asserted. As a result, it is
necessary to deselect the Slave Select Register once the transaction is
done. This feature is enabled via a device property called 'cs-override'.
Once the driver identifies the 'cs-override' property, it enables the hw
fixup logic, by writing to a dedicated register found in the IP reserved
area and will starts deselecting the Slave Select Register when the
transfer ends.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 642d3fb..dd366f5 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -14,6 +14,8 @@ Optional properties:
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
   device.  Supported values are 2 or 4 (the default).
+- cs-override: Enable explicit Chip-Select deselect during transfer instead of
+  default auto-deselect upon tx FIFO becoming empty.
 
 Child nodes as per the generic SPI binding.
 
-- 
2.7.4

