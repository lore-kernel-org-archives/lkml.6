Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF49C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC59420868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wqt5pzyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC59420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeLGQfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:35:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36028 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeLGQfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:35:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id u3so4405898wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hDmi7dOsrT7Ls8ZplnW9Bia+hVR0nA2HPS973FGJUuQ=;
        b=Wqt5pzyVek2bYy/i6/ZNz1C+LtsCHdt2Ud4zrBF54cIGOcETO1ykgd7c24PEikSSKp
         /LfVaPydgXv5HSNpcJyP1+zth3ByoCZPx2BNlMn2CI3wlQ4gesuvttSOslwrxJ67SFd9
         XBbmQElENCUVvnKvD6+15TJXCQFf136mUodpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hDmi7dOsrT7Ls8ZplnW9Bia+hVR0nA2HPS973FGJUuQ=;
        b=N4df9ap4CS5qf2HaWtgcsxQX4ftE7LikgJ66WeCrR8ZoSByAGQgarCHd9UDtHr2SNO
         wuVFn4/u6Bz6UykhOTGz811sFgf6+aFOGuS7mALYsUL6UtPi6hgeBoX8X2rRt4cMhJr+
         qPLXcArRHqjdXeTx0I00NiAF3npGK7iFP+f4XPnuyD9TS7qpy/qmKyj1qNrfU4fT35jv
         owOZ6RJeU4f7GffkCkWeRLkn919xTGXyiB36IuhG3BaENA69PT9dUhxesGUKQtzHdpPE
         MbX5QjTw9QSeolejYEg4jOJU5RQnE9NwTZPYNG9GAk0y+cmxh8fNCQocIRc2ZmmzR+8q
         DgXg==
X-Gm-Message-State: AA+aEWYa1z5SVb7zvjyL/Pfn+z/YRk4TexOsAdfeJJBymbuaY/TpoYXD
        0hLU47maXgeZhCViLMukheV00g==
X-Google-Smtp-Source: AFSGD/UKo4JiTBPNsc86IYxJyHkDbyuap+MgwHyXsAnejIU0AZnbYwDzSzdDV6365CNbxZtGIZJSNQ==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr2506240wro.262.1544200517571;
        Fri, 07 Dec 2018 08:35:17 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w6sm4268752wme.46.2018.12.07.08.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Dec 2018 08:35:16 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/6] misc: Add support to Qualcomm FastRPC driver
Date:   Fri,  7 Dec 2018 16:35:07 +0000
Message-Id: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the RFC, here is new version addressing the
comments from RFC.
This patchset adds support to Qualcomm FastRPC driver which implements
an IPC (Inter-Processor Communication) mechanism that allows for clients
to transparently make remote method invocations across processor boundaries.

The below diagram depicts invocation of a single method where the client
and objects reside on different processors. An object could expose
multiple methods which can be grouped together and referred to as an
interface.

: ,--------,        ,------,  ,-----------,  ,------,        ,--------,
: |        | method |      |  |           |  |      | method |        |
: | Client |------->| Stub |->| Transport |->| Skel |------->| Object |
: |        |        |      |  |           |  |      |        |        |
: `--------`        `------`  `-----------`  `------`        `--------`

Client:    Linux user mode process that initiates the remote invocation
Stub:      Auto generated code linked in with the user mode process that
           takes care of marshaling parameters

Transport: Involved in carrying an invocation from a client to an
           object. This involves two portions: 1) FastRPC Linux
           kernel driver that receives the remote invocation, queues
           them up and then waits for the response after signaling the
           remote side. 2) Service running on the remote side that
           dequeues the messages from the queue and dispatches them for
           processing.
Skel:      Auto generated code that takes care of un-marshaling
           parameters
Object:    Method implementation

Most of the work is derived from various downstream Qualcomm kernels.
Credits to various Qualcomm authors who have contributed to this code.
Specially Tharun Kumar Merugu <mtharu@codeaurora.org>

TODO:
 - Support INIT_STATIC process
 - Support remote mmap/unmap methods.
 - Handling secure compute context banks.
 - Add secure buffer support

This patchset has been tested on DB410c(msm8916), DB820c (msm8996), SDM845
Qualcomm SoCs with sample apps like matrix multiply, calculator
from Hexagon SDK. You can find more info on how to test this at:
https://github.com/96boards/documentation/wiki/Dragonboard-Hexagon-DSP

Changes since RFC:
- moved from char to misc driver as suggested by Greg KH
- updated ioctl data structures as suggested by Arnd.
- cleaned up and reorganized most of the code from RFC review comments.


Srinivas Kandagatla (6):
  misc: dt-bindings: Add Qualcomm Fastrpc bindings
  misc: fastrpc: Add Qualcomm fastrpc basic driver model
  misc: fastrpc: Add support for context Invoke method
  misc: fastrpc: Add support for create remote init process
  misc: fastrpc: Add support for dmabuf exporter
  misc: fastrpc: Add support for compat ioctls

 .../devicetree/bindings/misc/qcom,fastrpc.txt |   73 +
 drivers/misc/Kconfig                          |   10 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/fastrpc.c                        | 1422 +++++++++++++++++
 include/uapi/misc/fastrpc.h                   |   42 +
 5 files changed, 1548 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
 create mode 100644 drivers/misc/fastrpc.c
 create mode 100644 include/uapi/misc/fastrpc.h

-- 
2.19.2

