Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6D1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE8A20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2PJPX3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfAHSyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:54:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45017 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfAHSyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:54:37 -0500
Received: by mail-lf1-f66.google.com with SMTP id z13so3718216lfe.11;
        Tue, 08 Jan 2019 10:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iIyMFrKKnJtCr4+UG3XDWbJIrUHHBxWAs0IWQlXyGCY=;
        b=P2PJPX3AlloznB2GOMvGpEQq6iC53nNOcuB2QQjEOq90PVbnIo09a6sZIeIjfZ0/g2
         bs8Fy2MAKjDJVtOi83KCWMmlT8Kw0K4tiBoZCV0dDmFuBR72nOreF4uJCWkIRRrsuGXj
         JN0E9q9CiaKPC8GOPKbAchXReZwufVunp94IVn5BSec7HmTngCEm4WK9RhfW3rZmcUiI
         nYwJW3xroFpHqPcGmOE99jnSuoiwQ3sqSq1ioDo30C5+JVwqzJjIxduNvFap1c60enyk
         RXfqgo66smBsneqDs+pPX1LwedLGfkngWSK7jUPzV4uuxH8X9xvOMJihEaZ/UMe+eibH
         vgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=iIyMFrKKnJtCr4+UG3XDWbJIrUHHBxWAs0IWQlXyGCY=;
        b=eUeRItD+ePwzfisOIqNmhAlXb80lXg8fmUL/aAoXVczzND7H8jRrP9iSZ1LVVtJU/t
         C6pgDl7uQkWDkbgcY16XEooAd3QBSwi3pP7ey/Dh2dSdTSfzhjcK73j6crDPWOlr49ZA
         VFOZytmBa2ZMiikju9UWnYuIP4sZSJXYynnSeEGXyjS3VYgM922riu8mwcbMqn2HeMJA
         cnU7XE/SdEQ2RzAfOHAlk9lOCcmfEmQCPJEBwinAsu8WXFe9nFr0TVjR0KQ5v8SqDF5u
         YIEQ5xWUdpeuhAp3YMqY3DNxlpzNZvVLS38q2gNzSwlQZ//LAd+EoQUG1ztjjAyjjcsW
         vauw==
X-Gm-Message-State: AJcUukeig0KXszPqU+aSqoBwTaGjw/GdOu06nKb4xSO4baePp9kMfegq
        u3ZbI94DrYq5jv1hNKOFsckM49m3hgU=
X-Google-Smtp-Source: ALg8bN536E3Jo5RQwHMV/owTX235e3MaK9eeEhW38FftR6GGBNEy44RuclwHG2AqRBXJMGd8T2/emQ==
X-Received: by 2002:a19:3b9c:: with SMTP id d28mr1817178lfl.30.1546973675098;
        Tue, 08 Jan 2019 10:54:35 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id a11sm13321648lff.68.2019.01.08.10.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:54:33 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bbv.ch>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 0/5] add quartz load support to NXP rtc drivers 
Date:   Tue,  8 Jan 2019 19:54:09 +0100
Message-Id: <20190108185414.26922-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcf8523 hardcode the quartz load to 12.5pF
pcf85063 uses the reset default of 7pF

Introduce a new generic property "quartz-load-femtofarad"
to specify the quartz load.
The default value is selected to match the current Linux
drivers, so there are no behavior changes if a binding do not
specify the quarts-load.
The unit is femtofarads because several RTC's define the quarts load
in steps of 0.5 pF.

The two drivers rtc-pcf8523 and rtc-pcf85063 are both
updated to use the new binding.
The fix is tested on a proprietary board for both
RTC variants.

v2:
- Introduce a generic property "quartz-load-femtofarads"
- Add femtofarads to property-units.txt
- Make the changes backward compatible
- Reduced logging
- Warn, when we continue with a default value
- Tested, by Søren Andersen, on real HW
- Rebased on top of v5.0-rc1

	Sam

Sam Ravnborg (5):
      devicetree: property-units: Add femtofarads unit
      dt-binding: pcf8523: add xtal load capacitance
      dt-binding: pcf85063: add xtal load capacitance
      rtc: pcf8523: set xtal load capacitance from DT
      rtc: pcf85063: set xtal load capacitance from DT

 .../devicetree/bindings/property-units.txt         |  1 +
 .../devicetree/bindings/rtc/nxp,pcf85063.txt       | 18 ++++++++++
 .../devicetree/bindings/rtc/nxp,pcf8523.txt        | 18 ++++++++++
 Documentation/devicetree/bindings/rtc/rtc.txt      |  2 --
 drivers/rtc/rtc-pcf85063.c                         | 39 ++++++++++++++++++++++
 drivers/rtc/rtc-pcf8523.c                          | 28 +++++++++++-----
 6 files changed, 96 insertions(+), 10 deletions(-)
