Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AIpwx49Lj9so2x60T8gw87vjJbgeVJRqYCwH5xAlglyBqCZcN35aDfHT3y4vrrHUB82IsP7TNYU+
ARC-Seal: i=1; a=rsa-sha256; t=1524147406; cv=none;
        d=google.com; s=arc-20160816;
        b=WhjtOkUDqomUiYQArhd+T1mPA9PnZpowDYjopiHQfVBhpDFVSCHEdrb6YNjEGZW7+b
         nu+gHHHnSGkxhHiGOh/rlp5DmNUzkJulp/oA4yqzCWBhmesIvycSqghp61cn9AlUktRK
         2P3LRvCg6VigHVl5dmTnIy5Sq1EJYrPe6thWTzt17mmLcF0BOGy/xu2ELvgULYF6N8g6
         jLKPNrpc/3gjG3sDKVWmPCziTqgiQswHmflROsd/hnmWFtVrkZYkGhTYlKQswbo0zNNG
         xHO7zIPm0ZaH/47acgS/QJCiNJ8KG5ioLYlJs8OltafdcwjRHcxBdKmXJGy6GzKuLYmW
         3lsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=mBSIvVnSSQM7xXZ0FMAI2PQPRgKaDLh7rkBHx19ytho=;
        b=ykmrltgRF7R5diay9v+Ehm8adkk5Rs/xx1Knkhr6DGyUjwmbbQx7HWm97GbwpJRYln
         Pcq3Adb9BorA+QciJczlmnzlsQaapY4V7/yF6MOsGmEoBSgq7DSiEERFwN7NitUQFVLC
         7dPsvDMYmEDg6uW3il6+IEvhnw+yudhypXWpA2C5Xo6095BVVd+pPJVmJbQQMdN8R78r
         QJ2oZ+mQ9dIhVMVt0sNCt7ioJuNVcWaMmiXL0tmgIuJm0ufXtLsoC60uNXFNBFsJlB5l
         l1oG9L3spfcIkx+n24XYUeZ4pDFa9gsaozwWu7Cnb54xWeqccm/GbkzWUqrB1TbZnzX0
         6zsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=john.garry@huawei.com
From: John Garry <john.garry@huawei.com>
To: <xuwei5@huawei.com>
CC: <arnd@arndb.de>, <geert+renesas@glider.be>, <horms+renesas@verge.net.au>,
	<gregkh@linuxfoundation.org>, <paul.gortmaker@windriver.com>,
	<robin.murphy@arm.com>, <sebastien.bourdelin@savoirfairelinux.com>,
	<bogdan.purcareata@nxp.com>, <tony@atomide.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>, <helgaas@kernel.org>,
	<olof@lixom.net>, <khilman@kernel.org>, <tanxiaojun@huawei.com>, John Garry
	<john.garry@huawei.com>
Subject: [PATCH v2] HISI LPC: Add Kconfig MFD_CORE dependency
Date: Thu, 19 Apr 2018 22:14:02 +0800
Message-ID: <1524147242-220936-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598175575431248949?=
X-GMAIL-MSGID: =?utf-8?q?1598184391566964657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For ACPI support of the HiSilicon LPC driver we depend
on MFD_CORE config.

Currently the HiSi LPC Kconfig entry does not define this
dependency, so add it.

The reason for depending on MFD_CORE in the driver is
that we model the LPC host as an MFD, in that a platform
device will be created for each device on the bus. 

We do this as we need to modify the resources of these
derived platform devices, something which we should not
do to the original devices created in the ACPI scan.
Details in e0aa1563f894 ("HISI LPC: Add ACPI support").

Fixes: e0aa1563f894 ("HISI LPC: Add ACPI support")
Reported-and-tested-by: Tan Xiaojun <tanxiaojun@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---

v1->v2 change:
- add details of reasong to use MFD to commit message

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index d1c0b60..6dc177b 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -33,6 +33,7 @@ config HISILICON_LPC
 	bool "Support for ISA I/O space on HiSilicon Hip06/7"
 	depends on ARM64 && (ARCH_HISI || COMPILE_TEST)
 	select INDIRECT_PIO
+	select MFD_CORE if ACPI
 	help
 	  Driver to enable I/O access to devices attached to the Low Pin
 	  Count bus on the HiSilicon Hip06/7 SoC.
-- 
1.9.1
