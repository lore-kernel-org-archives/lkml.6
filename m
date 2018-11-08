Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF44C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1516720840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="T15MGFWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1516720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeKIIeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:34:02 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:44367 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKIIeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:34:00 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 15C418781F;
        Fri,  9 Nov 2018 11:56:12 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1541717772;
        bh=3icy1bdjKwYRadB8YMcxkqJOJV9nsuQSkD1bLtX/uaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=T15MGFWgexb46ZCQ5U00ob0LLlvCSFx41c4Mti6Xazmyo5Q5/W+58kqzGnzfDQQZL
         mquBH2WHdqLzDTqv24ZY7EImSBjGi8dlTooruKjaaFnviY947oLB8q2z2aYSK34KT4
         uNMWq/zt0vehloCTsiKaeWGtdRdtjJPjLjJ4T/WJVnhA/WWFvXgxk3E4Zaah3QjJtl
         Qtob8qR5OUJcbYqHrT2+ulWvjzvLPW+St+DXxdlLdZWdBv2TjNh4gW17M8/gRozdX+
         3TnSzpU+zZqb2MjE2N8Stl4aJ9GHC1H1/NCXSJLMO85ChLYdWlcLglL1p/yqETvbpN
         YHIbZnOjyL99w==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5be4bf0c0002>; Fri, 09 Nov 2018 11:56:12 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 0132013EEA1;
        Fri,  9 Nov 2018 11:56:17 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id B17331E0968; Fri,  9 Nov 2018 11:56:11 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, robh+dt@kernel.org, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/2] hwmon: (adt7475): add support for inverting the pwm output
Date:   Fri,  9 Nov 2018 11:56:07 +1300
Message-Id: <20181108225607.7521-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108225607.7521-1-chris.packham@alliedtelesis.co.nz>
References: <20181108225607.7521-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a "invert-pwm" device-tree property to allow hardware designs to use
inverted logic on the PWM output. We intentionally preserve the invert
PWM output bit if the property is not found to allow for
bootloaders/bios which may have configured this earlier.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- use "pwm-polarity" and support setting both logic high and logic low

=20drivers/hwmon/adt7475.c | 28 ++++++++++++++++++++++++++++
=201 file changed, 28 insertions(+)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index f4c7516eb989..ce2c7d6493c0 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -23,6 +23,7 @@
=20#include <linux/err.h>
=20#include <linux/jiffies.h>
=20#include <linux/util_macros.h>
+#include <linux/pwm.h>
=20
=20/* Indexes for the sysfs hooks */
=20
@@ -1536,6 +1537,23 @@ static int adt7475_update_limits(struct i2c_client=
=20*client)
=20	return 0;
=20}
=20
+static int adt7475_set_pwm_polarity(struct i2c_client *client, int index=
,
+				    enum pwm_polarity pol)
+{
+	int ret;
+
+	ret =3D adt7475_read(PWM_CONFIG_REG(index));
+	if (ret < 0)
+		return ret;
+
+	if (pol =3D=3D PWM_POLARITY_INVERSED)
+		ret |=3D BIT(4);
+	else
+		ret &=3D ~BIT(4);
+
+	return i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index), ret);
+}
+
=20static int adt7475_probe(struct i2c_client *client,
=20			 const struct i2c_device_id *id)
=20{
@@ -1638,6 +1656,16 @@ static int adt7475_probe(struct i2c_client *client=
,
=20	for (i =3D 0; i < ADT7475_PWM_COUNT; i++)
=20		adt7475_read_pwm(client, i);
=20
+	if (client->dev.of_node) {
+		enum pwm_polarity polarity;
+
+		ret =3D of_property_read_u32(client->dev.of_node, "pwm-polarity",
+					   &polarity);
+		if (!ret)
+			for (i =3D 0; i < ADT7475_PWM_COUNT; i++)
+				adt7475_set_pwm_polarity(client, i, polarity);
+	}
+
=20	/* Start monitoring */
=20	switch (chip) {
=20	case adt7475:
--=20
2.19.1
