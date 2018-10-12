Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A684C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2778920835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoAT3v0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2778920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeJLPHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:07:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41525 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeJLPHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:07:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id m77-v6so5746426pfi.8;
        Fri, 12 Oct 2018 00:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KNR0kiUhu536Shye4rQf9xf+jwFBZ3Zx/+wAFZQ8y+I=;
        b=KoAT3v0LqOKMPZH1A+iMod1ILN+0twAtdURMwL5vUoeCzmxZIdn2rYaOvFL520wx4u
         yZ9DfwAEmPIPhwAVnoPMgakioQljHA3vKWcJISL86pIOvBtKUNXxiDxoifvTL+PbWY/v
         1k3urBzH3jyv+LcsLpLS5OUrY/IadWI6g5pq8w0RJHZLq68JjUv7RH9idVMDblc/1cJc
         b698PXB26ATlNAKI+lgGmqMfSOnooYjMZsDsezsw77QG3FnHCAAaT6qllK5GYcCVtnHH
         COPPfUF4b5WwaPwKjpTNhESw+CpIAKnQM+HwcyiAanKM5YuQO5Q4rdECCI0FaVZWO6NG
         Z0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KNR0kiUhu536Shye4rQf9xf+jwFBZ3Zx/+wAFZQ8y+I=;
        b=NaaKVDhavPVZ5RSKy8hDqVcgw6Kgvie7jZ8yIyRdk6XwjMPMzKBCZZvMEpL/vtDKwU
         lHrxR6H6aWPVO+M1INIPKAfQKmw15jx0KNz/1DK3M1Oe+9UVqtzgSmHILz+IILJU+ULr
         RAOcHo8exdYHtloKJwxw0UGvc5wiWdLaT+qsJiD1SopM8NIcx4/FZPAsEM6YXqrurF/q
         rC03MtJ9Q/s3QH/Bg2AohA9JZjsLd0pQhZHi3tpL31jHmkeJhm+Y5gGp8krXnFRhwGZr
         C6tuG8ilTSowG/Zd5tYb+ycA6EAPHmSKEDsxAdWimVE83aIBST+3+yIaURygIamfeMoy
         sReg==
X-Gm-Message-State: ABuFfohH4BO94vSr+KQWv8CNxKXNTCeTMHJOPRJcKlZTc1eB2pFiNmO5
        OBL/ae3I3duSzP4qgCgjtQ4=
X-Google-Smtp-Source: ACcGV63w3xPsc+3RycR6EWS5dftmwTtTqx9Sk5cijvzgdNqy6ePwO8mwQjlQ1acJMNZHrSt8LrmRCA==
X-Received: by 2002:a63:df4f:: with SMTP id h15-v6mr4332787pgj.94.1539329775263;
        Fri, 12 Oct 2018 00:36:15 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id s78-v6sm2120409pfd.138.2018.10.12.00.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 00:36:14 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v4 0/3] Add support for PNI RM3100 magnetometer
Date:   Fri, 12 Oct 2018 15:35:33 +0800
Message-Id: <20181012073536.20339-1-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002143812.3661-1-songqiang1304521@gmail.com>
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The next 3 patches do the following:
 - The first patch adds PNI Sensor Corporation to the vendor prefix list.
 - The second patch adds devicetree binding for RM3100 magnetometer.
 - The third patch adds the driver for RM3100 magnetometer.

 -- Song Qiang

Changes in v4:
 - Fix a bug about regmap_range configurations.
 - Add DRDY trigger support.
 - Change DRDY interrupt trigger source from RISING to HIGH.
 - Add a thread function to clear the interrupt.
 - Change the logic of one-shot read from waiting next continuous ends to
   writing to POLL register and waiting conversion ends.
 - Add iio_buffer_setup_ops to enable continuous conversion only when
   buffer is enabled.
 - Add active_scan_mask check in continuous conversions.
 - Remove *wait_measurement() in *trigger_handler().

Changes in v3:
 - Change PNI to PNI Sensor Corporation in vendor-prefix.txt.
 - Sort header files in alpabetical order.
 - Add more specific doc for the mutex.
 - Fix the bug in the rm3100_set_cycle_count() where we always set the
   cycle count value to 100 no matter what val is.
 - Change some multiple else if to switch.
 - Remove iio_device_release_direct_mode() in the case claim direct mode
   fails.
 - Use the same buffer in rm3100_trigger_handler().
 - Add space around some operators.
 - Add manually unwind functions in case devm_add_action() fails.
 - Move devm_add_action before the devm_iio_device_register().
 - Move register defines and rm3100_data struct to *-core.c. 
 - Change some storage variable type of regmap from int to unsigned int.
 - Change 10e4 to 10^4.
 - Remove explicit cast of data pointer in rm3100_remove().
 - Remve dev in rm3100_data and use regmap_get_device() to obtain device
   pointer instead.
 - Change register bits alignment in defines.
 - Move RM3100_SCAN_BYTES to the top.
 - Change Channel endieness from LE to BE.
 - Adjust the place of comment about the 3 second wait time.
 - Some spell check.

Changes in v2:
	- Add scale channel.
	- Add EXPORT_SYMBOL_GPL() to export regmap confuguration structures.
	- Add sampling frequency available attribute.
	- Clean up headers and License declarations.
	- Change axis number to 3.
	- Remove bus specific part in compatible string.
	- Remove le32_to_cpu().
	- Check cycle count registers at *_probe().
	- Format comments.
	- Spell check.
	- Change prefix from RM_* to RM3100_*.
	- Check all error return paths.
	- Add devm_add_action() to avoid race condition when remove.

Song Qiang (3):
  dt-bindings: Add PNI to the vendor prefixes.
  iio: magnetometer: Add DT support for PNI RM3100
  iio: magnetometer: Add driver support for PNI RM3100

 .../bindings/iio/magnetometer/pni,rm3100.txt  |  20 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  29 +
 drivers/iio/magnetometer/Makefile             |   4 +
 drivers/iio/magnetometer/rm3100-core.c        | 627 ++++++++++++++++++
 drivers/iio/magnetometer/rm3100-i2c.c         |  58 ++
 drivers/iio/magnetometer/rm3100-spi.c         |  64 ++
 drivers/iio/magnetometer/rm3100.h             |  17 +
 9 files changed, 827 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
 create mode 100644 drivers/iio/magnetometer/rm3100-core.c
 create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
 create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
 create mode 100644 drivers/iio/magnetometer/rm3100.h

-- 
2.17.1

