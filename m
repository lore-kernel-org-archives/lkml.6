Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELsztUVWO4VOh9vbTTWPunj1km5N/obfSEtJAV3P6Pv3MeD0JBhn4stTIz9OGcHi3OYwWWwE
ARC-Seal: i=1; a=rsa-sha256; t=1519660215; cv=none;
        d=google.com; s=arc-20160816;
        b=H0BxlGKyjDeLaq3dwj6ZLKa4VnVErTG0O72iO2P7gLjxBU3MnDPvpvl64MVazQOnfE
         boKD/A6ZR09GRsdr8K0VkbdQAU6tMOJfTUZfG759djrtfP4Y1CWqJDPvNDS/wdfsF28R
         Id+3Dt8DPW22evVud71W4zVZPeRGXODbVPT5afNY1aJLy19v8Yd1R2tCgS2Rl6r4e9xQ
         JixRKHP94Po3C2ZsbfQ5m5W+iddAT65q7cVuUJe3xi9IhazeIWG91l2lhQHlSp9Cq6rv
         FYlQeEsWKtGE9V3UGlBa6bjDaSTYvbc+K1lo/sc+p2EnXI53HlnUTtn56SDXdaWUEiNw
         zwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=nvhWHZCipRIdJIkl7+hQmKOw1hwhNHiP712hSO7D/40=;
        b=o5sxcl1ekYWjBzK8riulht5N8he6OgWjuGv6K/3XX+kjFK4CrduCr25R865zJKXH+T
         o94voHdTMJzl/ziNQz+hoGfQXbuEDJAKfqb0sP3ZBOWrk8pqx7LtyUIyYLKTIcY4oX0N
         49EMroIxgVFu3ULYxYfAg6vteR7M3d9zgfL9bDEx3laufCStwe6GVjsdHwUv9CdzZXDp
         N3AkEdWxhIqTjjBmekNzoAEGDVWyDI1Gyuh/1nWoxA9f/iU6LuMvYqZZzM9iuU8+jUeD
         sizEMhwe3lN9hv+bpmkkfx/liLaIp4bZZglJN09TvFwkvn6kXOrzCoZIpQ9pClS7HyLz
         Rm8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=john.garry@huawei.com
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
	<lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>, <hanjun.guo@linaro.org>,
	<robh+dt@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<mark.rutland@arm.com>, <olof@lixom.net>, <dann.frazier@canonical.com>,
	<andy.shevchenko@gmail.com>, <robh@kernel.org>,
	<andriy.shevchenko@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>, <minyard@acm.org>,
	<devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<rdunlap@infradead.org>, <gregkh@linuxfoundation.org>,
	<akpm@linux-foundation.org>, <frowand.list@gmail.com>, <agraf@suse.de>
Subject: [PATCH v15 7/9] ACPI / scan: do not enumerate Indirect IO host children
Date: Tue, 27 Feb 2018 00:40:47 +0800
Message-ID: <1519663249-9850-8-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593479230959869754?=
X-GMAIL-MSGID: =?utf-8?q?1593479230959869754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Through the logical PIO framework systems which otherwise have
no IO space access to legacy ISA/LPC devices may access these
devices through so-called "indirect IO" method. In this, IO
space accesses for non-PCI hosts are redirected to a host
LLDD to manually generate the IO space (bus) accesses. Hosts
are able to register a region in logical PIO space to map to
its bus address range.

Indirect IO child devices have an associated host-specific bus
address. Special translation is required to map between
a logical PIO address for a device and it's host bus address.

Since in the ACPI tables the child device IO resources would
be the host-specific values, it is required the ACPI scan code
should not enumerate these devices, and that this should be
the responsibility of the host driver so that it can "fixup"
the resources so that they map to the appropriate logical PIO
addresses.

To avoid enumerating these child devices, we check whether
the parent for a device is a member of a known list of
"indirect IO" hosts. For now, the HiSilicon LPC host
controller ID is added.

To flag a device to not be enumerated, we reuse the existing
serial bus slave flag.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: dann frazier <dann.frazier@canonical.com>
---
 drivers/acpi/scan.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8e63d93..c1a60852 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1524,11 +1524,25 @@ static int acpi_check_serial_bus_slave(struct acpi_resource *ares, void *data)
 	return -1;
 }
 
+static bool acpi_is_indirect_io_slave(struct acpi_device *device)
+{
+	struct acpi_device *parent = device->parent;
+	const struct acpi_device_id indirect_io_hosts[] = {
+		{"HISI0191", 0},
+		{}
+	};
+
+	return parent && !acpi_match_device_ids(parent, indirect_io_hosts);
+}
+
 static bool acpi_is_serial_bus_slave(struct acpi_device *device)
 {
 	struct list_head resource_list;
 	bool is_serial_bus_slave = false;
 
+	if (acpi_is_indirect_io_slave(device))
+		return true;
+
 	/* Macs use device properties in lieu of _CRS resources */
 	if (x86_apple_machine &&
 	    (fwnode_property_present(&device->fwnode, "spiSclkPeriod") ||
-- 
1.9.1
