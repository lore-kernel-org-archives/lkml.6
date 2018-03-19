Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AG47ELu88dEziZKIMbIHQcxXkhAV4ZKm5OePlGtiqSG4EewcP8nBl1K48O66/gEFYBVtUwwJrdiO
ARC-Seal: i=1; a=rsa-sha256; t=1521455382; cv=none;
        d=google.com; s=arc-20160816;
        b=1CtB75/FgfWJtmuVe5Ll/tiALCTFL391nJAjx/J6+sBU+RmSeq0vf6CxS9mCiGrE1G
         RVexo9wDoKaPtIaDcooeJr8yeqQgnabS+HmTBDmDbK9TWe6J97wL0rxzS484bH+UJMpb
         c5n7XEsSHO+ZkwlbFrSzwTDKSUoehUSdgdECAP2Yn6LITPflAHnjC8zaLCPM7nCa0EtG
         Pj1o7Jw88jQWW/wYsMaDqOLu6fCPkNEUWnjBgjN67kG7Dim95Zd0jLctaRmZEimF7Suo
         V+eaINoSAq7EfMUbmiVmgSarGzk2c/8wIfqFbvGuwe69hmYfec5/3p1iaWj4WgXXmp2x
         7EHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=f+PbMYGJO0A+QnxldPaa9nGSWAhbQJ+7lcq+RDVkehc=;
        b=iUkebWqQ6YHstAh+YUWK0QVeWHApP3z4lEicEH3qFqKqrdxqhqk1FM7q+SP1JtXkN9
         94ln5qB66cdzAnjLSffwUN8p5p+I3LbGHHf4iWTKpbSaAyLNCscjddY/5Ycnfg5IOtfs
         tPEBDLJzjlrRpULfTdTE9PqoLSBTr3BVCVMY03YAPy1MsoKZBtoAaJUJ4cfjt8cbRGbX
         M2kHSce3IPyo8u+epLQARnWIkIdx61Bnqj3lPUqO7XkxM0yUuG1VF5+7QKtUFco0NkAK
         alPFz7NVzS7S3prDD4mSoPjr5mt3FVgGEnwBgK6ZZyR9rdG7f2p9huQHL/QMslh0ioZM
         /VBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: John Garry <john.garry@huawei.com>
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, robh+dt@kernel.org, bhelgaas@google.com, arnd@arndb.de, mark.rutland@arm.com, olof@lixom.net, dann.frazier@canonical.com, andy.shevchenko@gmail.com, robh@kernel.org, andriy.shevchenko@linux.intel.com, joe@perches.com, benh@kernel.crashing.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, minyard@acm.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, rdunlap@infradead.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, frowand.list@gmail.com, agraf@suse.de
Subject: Re: [PATCH v17 08/10] ACPI / scan: do not enumerate Indirect IO host children
Date: Mon, 19 Mar 2018 11:30:11 +0100
Message-ID: <2309217.pWfZsU88YQ@aspire.rjw.lan>
In-Reply-To: <1521051359-34473-9-git-send-email-john.garry@huawei.com>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com> <1521051359-34473-9-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594938018903038038?=
X-GMAIL-MSGID: =?utf-8?q?1595361598866434106?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday, March 14, 2018 7:15:57 PM CET John Garry wrote:
> Through the logical PIO framework systems which otherwise have
> no IO space access to legacy ISA/LPC devices may access these
> devices through so-called "indirect IO" method. In this, IO
> space accesses for non-PCI hosts are redirected to a host
> LLDD to manually generate the IO space (bus) accesses. Hosts
> are able to register a region in logical PIO space to map to
> its bus address range.
> 
> Indirect IO child devices have an associated host-specific bus
> address. Special translation is required to map between
> a logical PIO address for a device and it's host bus address.
> 
> Since in the ACPI tables the child device IO resources would
> be the host-specific values, it is required the ACPI scan code
> should not enumerate these devices, and that this should be
> the responsibility of the host driver so that it can "fixup"
> the resources so that they map to the appropriate logical PIO
> addresses.
> 
> To avoid enumerating these child devices, we add a check from
> acpi_device_enumeration_by_parent() as to whether the parent
> for a device is a member of a known list of "indirect IO" hosts.
> For now, the HiSilicon LPC host controller ID is added.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

You have my ACK here already.

Since I've ACKed the [7/10] too, I don't think there's anything more I can do
about this series and I'm assuming that it will be routed through other trees.

Thanks!

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Tested-by: dann frazier <dann.frazier@canonical.com>
> ---
>  drivers/acpi/scan.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index f9e7904..a4cbf3e 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1524,11 +1524,25 @@ static int acpi_check_serial_bus_slave(struct acpi_resource *ares, void *data)
>  	return -1;
>  }
>  
> +static bool acpi_is_indirect_io_slave(struct acpi_device *device)
> +{
> +	struct acpi_device *parent = device->parent;
> +	const struct acpi_device_id indirect_io_hosts[] = {
> +		{"HISI0191", 0},
> +		{}
> +	};
> +
> +	return parent && !acpi_match_device_ids(parent, indirect_io_hosts);
> +}
> +
>  static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>  {
>  	struct list_head resource_list;
>  	bool is_serial_bus_slave = false;
>  
> +	if (acpi_is_indirect_io_slave(device))
> +		return true;
> +
>  	/* Macs use device properties in lieu of _CRS resources */
>  	if (x86_apple_machine &&
>  	    (fwnode_property_present(&device->fwnode, "spiSclkPeriod") ||
> 
