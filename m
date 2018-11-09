Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAF5C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FA72081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9cw0aDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FA72081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbeKJIqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:46:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41666 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbeKJIqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:46:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id p16-v6so1572118plr.8;
        Fri, 09 Nov 2018 15:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1KHa9FEM+C0nJ9FiDRagU71AKdQSw1kawizngfVg6SQ=;
        b=U9cw0aDFS8L7by7nDYSuG1whUunjyJSZcxtiYo7xl2jYCftilr5IRneGE0If3RCfLy
         GhSZ3UBsM4LOu15SmEq2HATx8SXAwCigl0YpBpL1QQspuBWg59Vi8IJKtpYg5vH2DLNZ
         OSCmcY5tkfHstAKPvMvLIjgBpDtZxQtCI44VXImOgtCGMppbkDIMnW/Aw31s1Yo6uEOR
         H3BnzD8E36yC52PNsDcAVPltop6H6qMkAQdwWCjjTpS+XUMZkk4PloPSqcJomRWyGalr
         nM14VOdIl2VcYXOiWkURPyDzZFzIJyGwba0MkE1wHOBt8ortemskH2rA9F8juUrBDcOr
         aOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1KHa9FEM+C0nJ9FiDRagU71AKdQSw1kawizngfVg6SQ=;
        b=QSsZ4N9g932+vnCmIwrW7ENRlrsH4Cn1Psz5ey1cN8p6of4u31Sq/mjOlvifJnXDqx
         c0WflbduxImUw08bDqGsGGyEusgpxHntgsm7BbJ/DRFUa+BESUXCc/i+IM8MK+zqjM6B
         zzqX3wpO95+k2sRfIL96yZ++HSh1GJag0ylOK/MK+Ctb3GP2pxndmAfp8s2mLYoPl3/z
         OXeHflje4Yu49ggT4BsFP89vrdQBwHWwvvjGwo0YZUGEsh7C98HN8000+4u0Kp9zYasj
         X00wXcLjUw2tvcptuvZ2fRD7w8OZMGvZcosA61yQRkzDHVZgVo+EGp/ay94gqNZcKjYY
         68EQ==
X-Gm-Message-State: AGRZ1gKyUPDupSf+hrz77ChP8Z2Gid6K9auj+YOUYECeseSPwwrq2agS
        gDgD2ftbwPTaRN2i3PLsexlHR+qw
X-Google-Smtp-Source: AJdET5csB80xm0MDuX4s8pVmNxA4e/OJTZWbXu+wnoRatOeo9bV7hxxaMNRLzohFadf+e2+O9oq3vw==
X-Received: by 2002:a17:902:7882:: with SMTP id q2-v6mr10923835pll.188.1541804635789;
        Fri, 09 Nov 2018 15:03:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 18sm6976022pgl.50.2018.11.09.15.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 15:03:55 -0800 (PST)
Date:   Fri, 9 Nov 2018 15:03:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, jdelvare@suse.com,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rdunlap@infradead.org,
        benh@kernel.crashing.org, Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 00/10] hwmon and fsi: Add On-Chip Controller Driver
Message-ID: <20181109230354.GA31326@roeck-us.net>
References: <1541711129-26631-1-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541711129-26631-1-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:05:19PM -0600, Eddie James wrote:
> From: Eddie James <eajames@linux.vnet.ibm.com>
> 
> This series adds a hwmon driver to support the OCC on POWER8 and POWER9
> processors. The OCC is an embedded processor that provides realtime power and
> thermal monitoring and management.
> 
> The series also adds a "bus" driver to handle atomic communication between the
> service processor and the OCC on a POWER9 chip. This communication takes place
> over FSI bus to the SBE (Self-Boot engine) FIFO, which in turn communicates
> with the OCC. The driver for the SBEFIFO is already available as an FSI client
> driver.
> 
> For POWER8 OCCs, communication between the service processor and the OCC is
> achieved over I2C bus.
> 
I am not entirely happy with the series - there are still lots of proprietary
attributes, and I would have preferred the use of the _info API at this point -
but this has taken long enough. Series applied to hwmon-next. Please send any
fixes as follow-up patches.

Thanks,
Guenter

> Changes since v5:
>  * Makefile fix when compiling both P8 and P9 versions
>  * Spelling fix in hwmon doc
>  * Added an additional sentence for P9 binding doc to explain that OCC isn't
>    an FSI slave device.
> 
> Changes since v4:
>  * Make the hwmon attributes conform almost completely to standard names and
>    values. The only exception is powerX_cap_user and powerX_cap_user_source.
>  * Improve hwmon documentation.
>  * Add ibm,p9-occ dt documentation.
> 
> Changes since v3:
>  * Add the FSI OCC driver.
>  * Pull the sysfs attribute code into it's own file for cleanliness.
>  * Various fixes for attribute creation and integer overflow.
> 
> Changes since v2:
>  * Add sysfs_notify for the error and throttling attributes when change is
>    detected.
>  * Removed occs_present counting of devices bound.
>  * Improved remove() of P9 driver to avoid bad behavior with relation to OCC
>    driver when unbound.
>  * Added default cases (return EINVAL) for all sensor show functions.
>  * Added temperature fault sensor.
>  * Added back dt binding documentation for P9 to address checkpatch warning.
>  * Added occs_present attribute from the poll response.
> 
> Changes since v1:
>  * Remove wait loop in P9 code, as that is now handled by FSI OCC driver.
>  * Removed dt binding documentation for P9, FSI OCC driver will probe OCC hwmon
>    driver automatically.
>  * Moved OCC response code definitions to the OCC include file.
>  * Fixed includes.
>  * Changed some structure fields to __beXX as that is what they are.
>  * Changed some errnos.
>  * Removed some dev_err().
>  * Refactored P8 code a bit to use #defined addresses and magic values, and
>    changed "goto retry" to a loop.
>  * Refactored error handling a bit.
> 
> Eddie James (10):
>   dt-bindings: fsi: Add P9 OCC device documentation
>   fsi: Add On-Chip Controller (OCC) driver
>   Documentation: hwmon: Add OCC documentation
>   dt-bindings: i2c: Add P8 OCC hwmon device documentation
>   hwmon: Add On-Chip Controller (OCC) hwmon driver
>   hwmon (occ): Add command transport method for P8 and P9
>   hwmon (occ): Parse OCC poll response
>   hwmon (occ): Add sensor types and versions
>   hwmon (occ): Add sensor attributes and register hwmon device
>   hwmon (occ): Add sysfs attributes for additional OCC data
> 
>  .../devicetree/bindings/fsi/ibm,p9-occ.txt         |   16 +
>  .../devicetree/bindings/i2c/ibm,p8-occ-hwmon.txt   |   25 +
>  Documentation/hwmon/occ                            |  112 ++
>  drivers/fsi/Kconfig                                |   10 +
>  drivers/fsi/Makefile                               |    1 +
>  drivers/fsi/fsi-occ.c                              |  599 +++++++++++
>  drivers/hwmon/Kconfig                              |    2 +
>  drivers/hwmon/Makefile                             |    1 +
>  drivers/hwmon/occ/Kconfig                          |   31 +
>  drivers/hwmon/occ/Makefile                         |    5 +
>  drivers/hwmon/occ/common.c                         | 1098 ++++++++++++++++++++
>  drivers/hwmon/occ/common.h                         |  128 +++
>  drivers/hwmon/occ/p8_i2c.c                         |  255 +++++
>  drivers/hwmon/occ/p9_sbe.c                         |  106 ++
>  drivers/hwmon/occ/sysfs.c                          |  188 ++++
>  include/linux/fsi-occ.h                            |   25 +
>  16 files changed, 2602 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/ibm,p8-occ-hwmon.txt
>  create mode 100644 Documentation/hwmon/occ
>  create mode 100644 drivers/fsi/fsi-occ.c
>  create mode 100644 drivers/hwmon/occ/Kconfig
>  create mode 100644 drivers/hwmon/occ/Makefile
>  create mode 100644 drivers/hwmon/occ/common.c
>  create mode 100644 drivers/hwmon/occ/common.h
>  create mode 100644 drivers/hwmon/occ/p8_i2c.c
>  create mode 100644 drivers/hwmon/occ/p9_sbe.c
>  create mode 100644 drivers/hwmon/occ/sysfs.c
>  create mode 100644 include/linux/fsi-occ.h
> 
> -- 
> 1.8.3.1
> 
