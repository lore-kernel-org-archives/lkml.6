Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAAFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE2F2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRDz19kC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE2F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389970AbeIUT3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43745 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389684AbeIUT3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:31 -0400
Received: by mail-io1-f66.google.com with SMTP id y10-v6so12199260ioa.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ffxcvDmJo9Kkl+XpYMWfI5FmARAz2amVWdHtbL6Meeo=;
        b=GRDz19kC2mfxx+5F0MrrPB5pQX1+uTk89M1juFRb3hiqg0FzNO67jQ7Zd/f8YzkNWy
         chAh775EGNJGmOJv+rfwdKQ9apc3WHbEfpfYqgRm/oGe8Yib5UIPFjYOjaJiCkQ5QqVV
         +IsdMfl7L7ds6fp49/1CQxNBaDqlXgr4+KPZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ffxcvDmJo9Kkl+XpYMWfI5FmARAz2amVWdHtbL6Meeo=;
        b=dpWqMa7YWX7eOUcdQepMTdKfIC1oPy+er88zzgRAkp4V4s91Eq+HqJueaFJtj+urXa
         EXdPS1V3zhnyip+FhTYW4Pd5s83c7VcxCJKADRpgxGL+8PhYihN7xa2V6VHSLaQjum3s
         zmKpBg3TqXYWUqhxtIvPMZgwqeSUOwImJ/StKz9I+WaV7LEMr2wzcg8pxXh3yPhbTvEP
         q+IPr9qDo1Ic7MZOvZCYlLBeXAr2TT5ATwLoAx8KCkgAJn6Pb6qRpgVmjKN6Fck3Zsm+
         CCW7ugULqwakqx2ZwAyC+Iub8Lr9GEgkNHgoNmU9wLIv7vx60nm09QjgWgLjGuE4PCJU
         Iwiw==
X-Gm-Message-State: APzg51Dnc+8BHBMtQYZLKTzQcocoMC3NTyP4V9QE0mZrkB9F8k6Gjds7
        K0aSQzlK7Ts+njmM7VJaTRqrfg==
X-Google-Smtp-Source: ANB0VdbmyfteoyoxvhpDwY2zilhDS55H866XT158G9GrVmU08LDu/NrmsUPExJjc2EQVSukSCUgO/Q==
X-Received: by 2002:a02:b459:: with SMTP id w25-v6mr38749681jaj.32.1537537235369;
        Fri, 21 Sep 2018 06:40:35 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:34 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/26] nvmem: patches for 4.20
Date:   Fri, 21 Sep 2018 06:40:00 -0700
Message-Id: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are some cleanup patches and some non device tree support reworked
by Bartosz. I also included 2 minor changes in to misc/eeprom drivers.

Can you please pick them up for 4.20.

thanks,
srini


Bartosz Golaszewski (24):
  eeprom: eeprom_93xx46: use resource management
  eeprom: at25: use devm_nvmem_register()
  nvmem: provide nvmem_dev_name()
  nvmem: remove the name field from struct nvmem_device
  nvmem: use list_for_each_entry_safe in nvmem_device_remove_all_cells()
  nvmem: remove a stray newline
  nvmem: check the return value of nvmem_add_cells()
  nvmem: use kref
  nvmem: sunxi_sid: return -ENOMEM if kzalloc() fails
  nvmem: sunxi_sid: use devm_nvmem_register()
  nvmem: lpc18xx_eeprom: use devm_nvmem_register()
  nvmem: mxs-ocotp: use devm_nvmem_register()
  nvmem: change the signature of nvmem_unregister()
  nvmem: remove the global cell list
  nvmem: add support for cell info
  nvmem: resolve cells from DT at registration time
  nvmem: add support for cell lookups from machine code
  Documentation: nvmem: document cell tables and lookup entries
  nvmem: add a notifier chain
  nvmem: use SPDX license identifiers
  nvmem: make the naming of arguments in nvmem_cell_get() consistent
  nvmem: use EOPNOTSUPP instead of ENOSYS
  nvmem: fix commenting style
  nvmem: use octal permissions instead of constants

Srinivas Kandagatla (2):
  nvmem: sunxi_sid: remove unused variable in probe
  nvmem: make nvmem_add_cells() static

 Documentation/nvmem/nvmem.txt       |  31 ++
 drivers/misc/eeprom/at25.c          |   3 +-
 drivers/misc/eeprom/eeprom_93xx46.c |  19 +-
 drivers/nvmem/core.c                | 530 +++++++++++++++++++---------
 drivers/nvmem/lpc18xx_eeprom.c      |   6 +-
 drivers/nvmem/mxs-ocotp.c           |   4 +-
 drivers/nvmem/sunxi_sid.c           |  22 +-
 include/linux/nvmem-consumer.h      | 100 ++++--
 include/linux/nvmem-provider.h      |  50 +--
 9 files changed, 505 insertions(+), 260 deletions(-)

-- 
2.19.0

