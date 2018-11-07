Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CECC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC2420882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="VJZ78nDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC2420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbeKGN26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:28:58 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40130 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbeKGN26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:28:58 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 69A918781F;
        Wed,  7 Nov 2018 17:00:22 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1541563222;
        bh=SViPsDaJsnCO6Z2r1PgBm6ePY1iRYTiLTPdvcxeBVvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VJZ78nDvfyHmG+f3hu3nhMvzd7aQxyG5S4Reg2Sx1kz5QWfzhkuFNOQCSn9ptCbjp
         vVrKKqwylA9sjVf3k5kZHJcK6++zEPoYHJjUZZWaytKD1vKfhRv9exNTARk3FXcJhI
         qWzZ62SPiWkTnQXFfm//5uRglXOq14sUVo0JsafRjmm+kjzRIW+uDqVooHLFp/7nj7
         ozFGrXFm6RNiJVXXhcOdYQ4HY6TwOiCOAANkN8R0OauLioycKU/sY/g1qKmvz02fCd
         U5+mnyztm3N8bYVgjZx6pMTKDzfO3RWD3BBmDFaDZQL0mdZjMq62RQnz/Tie0mLlED
         0VIzvpHmIb7yg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5be263550001>; Wed, 07 Nov 2018 17:00:21 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 7DD9413EEDE;
        Wed,  7 Nov 2018 17:00:26 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 5F3751E220C; Wed,  7 Nov 2018 17:00:21 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@roeck-us.net, robh+dt@kernel.org, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] hwmon: (adt7475): add support for inverting the pwm output
Date:   Wed,  7 Nov 2018 17:00:10 +1300
Message-Id: <20181107040010.27436-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107040010.27436-1-chris.packham@alliedtelesis.co.nz>
References: <20181107040010.27436-1-chris.packham@alliedtelesis.co.nz>
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
=20drivers/hwmon/adt7475.c | 17 +++++++++++++++++
=201 file changed, 17 insertions(+)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index f4c7516eb989..85e4dc674449 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1536,9 +1536,22 @@ static int adt7475_update_limits(struct i2c_client=
=20*client)
=20	return 0;
=20}
=20
+static int adt7475_invert_pwm(struct i2c_client *client, int index)
+{
+	int ret;
+
+	ret =3D adt7475_read(PWM_CONFIG_REG(index));
+	if (ret < 0)
+		return ret;
+
+	return i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
+					 ret | BIT(4));
+}
+
=20static int adt7475_probe(struct i2c_client *client,
=20			 const struct i2c_device_id *id)
=20{
+	struct device_node *of_node =3D client->dev.of_node;
=20	enum chips chip;
=20	static const char * const names[] =3D {
=20		[adt7473] =3D "ADT7473",
@@ -1638,6 +1651,10 @@ static int adt7475_probe(struct i2c_client *client=
,
=20	for (i =3D 0; i < ADT7475_PWM_COUNT; i++)
=20		adt7475_read_pwm(client, i);
=20
+	if (of_node && of_property_read_bool(of_node, "invert-pwm"))
+		for (i =3D 0; i < ADT7475_PWM_COUNT; i++)
+			adt7475_invert_pwm(client, i);
+
=20	/* Start monitoring */
=20	switch (chip) {
=20	case adt7475:
--=20
2.19.1
