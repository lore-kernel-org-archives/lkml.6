Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186E3C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE52F2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqrQbOTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbeLUE2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 23:28:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37203 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732806AbeLUE2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 23:28:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so3788316oia.4;
        Thu, 20 Dec 2018 20:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKweS4GW1BIp+RvifjPjdoyhvxRXzKsBjTo78PoyZuM=;
        b=MqrQbOThobGtz3zLvdy52CYxtoObtqdBoyApu3bjs0eGdzIPAY9KGLHhbGUI5rgRrd
         MkiBirsYPutEDjeapKjrtHZzd8i/6w7iVKMOvPVZG7t5jpjAquNR75G2ld5bSkJWj9HQ
         Z5l+EjTx8IuPWqxTCRC+B0iwSrVcORvXPwhlEBWJMYv8kpCgnk6NiWnzTQjaogvdf80q
         CMkvHZs0aYgvoZ8WTEOWk5DkBmH3w+thxIUCX4v8LlzncvnmHTudYjW2MLJ3VlgQLVj2
         UDRDjb8CbVumHkoFrPTCt8iplPjRTjO8rWIT27v88R13gLir59AFmGFOyhR+im19/Kpk
         +WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKweS4GW1BIp+RvifjPjdoyhvxRXzKsBjTo78PoyZuM=;
        b=TibzIn9aqXNkUUi0/fldVf/OQrlce8n9tppgyvNil/GPwRoGuiWV9rGTqH4oF0hdIB
         zO/x37L353x8T4S5gZoxGr8JkMCvbR2+HXavlHZXou5xRJGscNYOW6YbkHcPQNUohV3/
         5sIk4bhaOA/vGM4RKLqV69S3mIFwmeOVTJ3SC2r0rK+bTTzhU7Nz8NXAUzyfoUPp9rG4
         xBNx2WOntGDKKJnPyIXo1NuV7N4dWsrZlaFdfh713vl0tquKDfYIAQW9MgAH8Yk6yq5a
         SrGbz4XfgybzGSZnUfYVtc56dnPRgqcpzFpE7qWW2it/VsicNQhYjEimrCUUhsD1Rctq
         d+hQ==
X-Gm-Message-State: AJcUuke3td4V5+mV0cJUHJUPApSf79W14877b7kuXFH2bLDY3yj125FX
        TcSMR8v+70IUhmC4gY/PmU0=
X-Google-Smtp-Source: AFSGD/XXCjzD7Q9TlsZmRc5xxIb83Qi4Xw3zxilJX9iEBNavgHkjZdK9xtNvrLwsQ8xTzAStxl8LJg==
X-Received: by 2002:aca:5946:: with SMTP id n67mr385623oib.268.1545366498569;
        Thu, 20 Dec 2018 20:28:18 -0800 (PST)
Received: from bender.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id t12sm12501429otk.61.2018.12.20.20.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 20:28:17 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-vger@kernel.org
Cc:     linux-serial@vger.kernel.org, mpe@ellerman.id.au, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux@roeck-us.net,
        benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Michael Moese <mmoese@suse.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250"
Date:   Thu, 20 Dec 2018 20:27:16 -0800
Message-Id: <20181221042719.29954-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220173844.GA5838@roeck-us.net>
References: <20181220173844.GA5838@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6d11023c345e369bcb9d5a68b271764e362c1f6e ("serial:
8250: Default SERIAL_OF_PLATFORM to SERIAL_8250") since that breaks at
least mpc8544ds (PowerPC) using arch/powerpc/kernel/legacy_serial.c.

See https://lkml.org/lkml/2018/12/5/1491 for discussion and analysis

Fixes: 6d11023c345e ("serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/8250/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index d7737dca0e48..15c2c5463835 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -484,7 +484,6 @@ config SERIAL_8250_PXA
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
-	default SERIAL_8250
 	help
 	  This option is used for all 8250 compatible serial ports that
 	  are probed through devicetree, including Open Firmware based
-- 
2.19.1

