Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CFDC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6F720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039546;
	bh=QpSSSS46jOV4pBcX30PB3sx5Ekr4YQ/buwkC7AAVRmA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QzkLPgmbq/wcilcItpCJvIPnRLzsxc0jsl5heE4m3kX4XG5r5EhTq078V65MbbAYa
	 ue5wnKPTVKbNjqEaXHXj9cIlp8BJoJpX+0KvhGHLoFGnYbQH348xp3ieMpKUbfCZ4b
	 srLOj7zoJEwa2DtR0xnBVK0HfsxjXMCT0SktKLNk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6F720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbeLETwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:52:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33916 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbeLETvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:20 -0500
Received: by mail-oi1-f196.google.com with SMTP id h25so18672694oig.1;
        Wed, 05 Dec 2018 11:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6eIG0/5LHUZfO4VXf+cpIcy6s1WeTN8+4j6CIdmGr8=;
        b=GTkUikNvdSd+pnZclrNqPR+iFT/iria7kAt7VMmQ+PIMKltr2maZPp8t7RH3TFFIts
         QO0i/gVDywlHz1t2Jz8AlSa6B3D1zRtxZB0XRCFeaSORJnMkFqNbTO3jotWeGAYySB2K
         2PZhdFUJUPNL44BigfAhFAXlgjaWP01FxEP5NUMYEaiTiyNfy5xv8x+J/PGMPEd+ojLk
         wtGwFplrhmBvsS9KbZOi+dtfmoETn8X3HOwfgITI8vA1Z5IJS+jggTDMJ3TAjgujn2fT
         QHGoEmd8sL8VDwq1CxQuJC7dvi2DTKqPEPPLWltzSo3q2mkb3Mqtbzpe2aINxSaicr9+
         ioeA==
X-Gm-Message-State: AA+aEWbrZvoMCf+HaefUU1ddjOBy1m6RAAHvsh0jLL/Hth3jy5sVU8P4
        8QDTqg1Wr5g0D7XE+yEuWAxwaX4=
X-Google-Smtp-Source: AFSGD/V22DIg0leC4I1ensmRkeVqbXA3yhry+TAIgeb25Z6bHsJj+GonYZdJvZdPIEscjWxAW5WU6w==
X-Received: by 2002:aca:d09d:: with SMTP id j29mr14590108oiy.262.1544039479527;
        Wed, 05 Dec 2018 11:51:19 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:18 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH] SPI: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:41 -0600
Message-Id: <20181205195050.4759-25-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6ca59406b0b7..d27b6b0dee43 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1644,7 +1644,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	}
 
 	if (spi_controller_is_slave(ctlr)) {
-		if (strcmp(nc->name, "slave")) {
+		if (!of_node_name_eq(nc, "slave")) {
 			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
 				nc);
 			return -EINVAL;
-- 
2.19.1

