Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758962AbeD0TYx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:24:53 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:2417 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757562AbeD0TYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:24:50 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GUAADFd+Nah2Oa6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYUeKAqDYYgCjHmBdIEPhnKMIhSBZAuBd4J1AhqCNSE0GAECAQE?=
 =?us-ascii?q?BAQEBAgEBAhABAQEKCwkIKC9XAYFdIoJTAQEBBCMEDUUMBAIBCBEEAQEDAiMDA?=
 =?us-ascii?q?gICHyUBCAgCBAESCIRvAxWoeYFpM4cLDYErgjeBCYcLghOBD4JdLoJPgWhTgmm?=
 =?us-ascii?q?CVAKHKoYCijUsCItNgnWBPYNgh0CKAYY5gSUcggtwgxOCHQMOCY4XbwGMMoNwg?=
 =?us-ascii?q?RgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GUAADFd+Nah2Oa6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYU?=
 =?us-ascii?q?eKAqDYYgCjHmBdIEPhnKMIhSBZAuBd4J1AhqCNSE0GAECAQEBAQEBAgEBAhABA?=
 =?us-ascii?q?QEKCwkIKC9XAYFdIoJTAQEBBCMEDUUMBAIBCBEEAQEDAiMDAgICHyUBCAgCBAE?=
 =?us-ascii?q?SCIRvAxWoeYFpM4cLDYErgjeBCYcLghOBD4JdLoJPgWhTgmmCVAKHKoYCijUsC?=
 =?us-ascii?q?ItNgnWBPYNgh0CKAYY5gSUcggtwgxOCHQMOCY4XbwGMMoNwgRgBAQ?=
From: <Mario.Limonciello@dell.com>
To: <stuart.w.hayes@gmail.com>, <Douglas.Warzecha@dell.com>
Cc: <Jared.Dominguez@dell.com>, <linux-kernel@vger.kernel.org>,
        <Stuart.Hayes@dell.com>
X-LoopCount0: from 10.166.132.189
X-IronPort-AV: E=Sophos;i="5.49,336,1520917200";
   d="scan'208";a="176502403"
X-DLP: DLP_GlobalPCIDSS
Subject: RE: [PATCH] dcdbas: Add support for WSMT ACPI table
Thread-Topic: [PATCH] dcdbas: Add support for WSMT ACPI table
Thread-Index: AQHT1ZS3f7UuYTJ3HEScBO2LE6QaEKQVD0Hw
Date: Fri, 27 Apr 2018 19:24:48 +0000
Message-ID: <9096dcb73b5a418b92cd0216a26d7480@ausx13mpc120.AMER.DELL.COM>
References: <7f8c79d0-849d-cd15-abe4-3ac2987d79c1@gmail.com>
In-Reply-To: <7f8c79d0-849d-cd15-abe4-3ac2987d79c1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3RJOxYP015041

 -----Original Message-----
> From: Stuart Hayes [mailto:stuart.w.hayes@gmail.com]
> Sent: Monday, April 16, 2018 10:08 AM
> To: Warzecha, Douglas
> Cc: Limonciello, Mario; Dominguez, Jared; linux-kernel@vger.kernel.org
> Subject: [PATCH] dcdbas: Add support for WSMT ACPI table
> 
> 
> If the WSMT ACPI table is present and indicates that a fixed communication
> buffer should be used, use the firmware-specified buffer instead of
> allocating a buffer in memory for communications between the dcdbas driver
> and firmware.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/firmware/Kconfig  |   2 +-
>  drivers/firmware/dcdbas.c | 100
> ++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/firmware/dcdbas.h |  11 +++++
>  3 files changed, 108 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b7c748248e53..a2bd6092bfa1 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -125,7 +125,7 @@ config DELL_RBU
> 
>  config DCDBAS
>  	tristate "Dell Systems Management Base Driver"
> -	depends on X86
> +	depends on X86 && ACPI
>  	help
>  	  The Dell Systems Management Base Driver provides a sysfs interface
>  	  for systems management software to perform System Management
> diff --git a/drivers/firmware/dcdbas.c b/drivers/firmware/dcdbas.c
> index 0bdea60c65dd..cdcc10d5f04b 100644
> --- a/drivers/firmware/dcdbas.c
> +++ b/drivers/firmware/dcdbas.c
> @@ -36,6 +36,7 @@
>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/mutex.h>
> +#include <linux/acpi.h>
>  #include <asm/io.h>
> 
>  #include "dcdbas.h"
> @@ -49,19 +50,23 @@ static struct platform_device *dcdbas_pdev;
>  static u8 *smi_data_buf;
>  static dma_addr_t smi_data_buf_handle;
>  static unsigned long smi_data_buf_size;
> +static unsigned long max_smi_data_buf_size = MAX_SMI_DATA_BUF_SIZE;
>  static u32 smi_data_buf_phys_addr;
>  static DEFINE_MUTEX(smi_data_lock);
> +static u8 *eps_buffer;
> 
>  static unsigned int host_control_action;
>  static unsigned int host_control_smi_type;
>  static unsigned int host_control_on_shutdown;
> 
> +static bool wsmt_enabled;
> +
>  /**
>   * smi_data_buf_free: free SMI data buffer
>   */
>  static void smi_data_buf_free(void)
>  {
> -	if (!smi_data_buf)
> +	if (!smi_data_buf || wsmt_enabled)
>  		return;
> 
>  	dev_dbg(&dcdbas_pdev->dev, "%s: phys: %x size: %lu\n",
> @@ -86,7 +91,7 @@ static int smi_data_buf_realloc(unsigned long size)
>  	if (smi_data_buf_size >= size)
>  		return 0;
> 
> -	if (size > MAX_SMI_DATA_BUF_SIZE)
> +	if (size > max_smi_data_buf_size)
>  		return -EINVAL;
> 
>  	/* new buffer is needed */
> @@ -169,7 +174,7 @@ static ssize_t smi_data_write(struct file *filp, struct kobject
> *kobj,
>  {
>  	ssize_t ret;
> 
> -	if ((pos + count) > MAX_SMI_DATA_BUF_SIZE)
> +	if ((pos + count) > max_smi_data_buf_size)
>  		return -EINVAL;
> 
>  	mutex_lock(&smi_data_lock);
> @@ -323,7 +328,8 @@ static ssize_t smi_request_store(struct device *dev,
>  		break;
>  	case 1:
>  		/* Calling Interface SMI */
> -		smi_cmd->ebx = (u32) virt_to_phys(smi_cmd->command_buffer);
> +		smi_cmd->ebx = smi_data_buf_phys_addr
> +				+ offsetof(struct smi_cmd, command_buffer);
>  		ret = dcdbas_smi_request(smi_cmd);
>  		if (!ret)
>  			ret = count;
> @@ -482,6 +488,85 @@ static void dcdbas_host_control(void)
>  	}
>  }
> 
> +/* WSMT */
> +
> +static u8 checksum(u8 *buffer, u8 length)
> +{
> +	u8 sum = 0;
> +	u8 *end = buffer + length;
> +
> +	while (buffer < end)
> +		sum = (u8)(sum + *(buffer++));
> +	return sum;
> +}
> +
> +static inline struct smm_eps_table *check_eps_table(u8 *addr)
> +{
> +	struct smm_eps_table *eps = (struct smm_eps_table *)addr;
> +
> +	if (strncmp(SMM_EPS_SIG, eps->smm_comm_buff_anchor, 4) != 0)
> +		return NULL;
> +
> +	if (checksum(addr, eps->length) != 0)
> +		return NULL;
> +
> +	return eps;
> +}
> +
> +static int dcdbas_check_wsmt(void)
> +{
> +	struct acpi_table_wsmt *wsmt = NULL;
> +	struct smm_eps_table *eps = NULL;
> +	u8 *addr;
> +
> +	acpi_get_table(ACPI_SIG_WSMT, 0, (struct acpi_table_header **)&wsmt);
> +	if (!wsmt)
> +		return 0;
> +
> +	/* Check if WSMT ACPI table shows that protection is enabled */
> +	if (!(wsmt->protection_flags & ACPI_WSMT_FIXED_COMM_BUFFERS)
> +	    || !(wsmt->protection_flags
> +		 & ACPI_WSMT_COMM_BUFFER_NESTED_PTR_PROTECTION))
> +		return 0;
> +
> +	/* Scan for EPS (entry point structure) */
> +	for (addr = (u8 *)__va(0xf0000);
> +	     addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table)) && !eps;
> +	     addr += 1)
> +		eps = check_eps_table(addr);
> +
> +	if (!eps) {
> +		dev_dbg(&dcdbas_pdev->dev, "found WSMT, but no EPS
> found\n");
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Get physical address of buffer and map to virtual address.
> +	 * Table gives size in 4K pages, regardless of actual system page size.
> +	 */
> +	if (eps->smm_comm_buff_addr + 8 > U32_MAX) {
> +		dev_warn(&dcdbas_pdev->dev, "found WSMT, but EPS buffer
> address is above 4GB\n");
> +		return -EINVAL;
> +	}
> +	eps_buffer = (u8 *)memremap(eps->smm_comm_buff_addr,
> +				     eps->num_of_4k_pages * 4096,
> MEMREMAP_WB);
> +	if (!eps_buffer) {
> +		dev_warn(&dcdbas_pdev->dev, "found WSMT, but failed to map
> EPS buffer\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* First 8 bytes of buffer is for semaphore */
> +	smi_data_buf_phys_addr = (u32) eps->smm_comm_buff_addr + 8;
> +	smi_data_buf = eps_buffer + 8;
> +	smi_data_buf_size = (unsigned long) min(eps->num_of_4k_pages * 4096 -
> 8,
> +			    (u64) ULONG_MAX);
> +	max_smi_data_buf_size = smi_data_buf_size;
> +	wsmt_enabled = true;
> +	dev_info(&dcdbas_pdev->dev,
> +		 "WSMT found, using firmware-provided SMI buffer.\n");
> +	return 1;
> +}
> +
>  /**
>   * dcdbas_reboot_notify: handle reboot notification for host control
>   */
> @@ -548,6 +633,11 @@ static int dcdbas_probe(struct platform_device *dev)
> 
>  	dcdbas_pdev = dev;
> 
> +	/* Check if ACPI WSMT table specifies protected SMI buffer address */
> +	error = dcdbas_check_wsmt();
> +	if (error < 0)
> +		return error;
> +
>  	/*
>  	 * BIOS SMI calls require buffer addresses be in 32-bit address space.
>  	 * This is done by setting the DMA mask below.
> @@ -635,6 +725,8 @@ static void __exit dcdbas_exit(void)
>  	 */
>  	if (dcdbas_pdev)
>  		smi_data_buf_free();
> +	if (eps_buffer)
> +		memunmap(eps_buffer);
>  	platform_device_unregister(dcdbas_pdev_reg);
>  	platform_driver_unregister(&dcdbas_driver);
>  }
> diff --git a/drivers/firmware/dcdbas.h b/drivers/firmware/dcdbas.h
> index ca3cb0a54ab6..7ea5b3e070b9 100644
> --- a/drivers/firmware/dcdbas.h
> +++ b/drivers/firmware/dcdbas.h
> @@ -54,6 +54,8 @@
> 
>  #define SMI_CMD_MAGIC				(0x534D4931)
> 
> +#define SMM_EPS_SIG				"$SCB"
> +
>  #define DCDBAS_DEV_ATTR_RW(_name) \
>  	DEVICE_ATTR(_name,0600,_name##_show,_name##_store);
> 
> @@ -103,5 +105,14 @@ struct apm_cmd {
> 
>  int dcdbas_smi_request(struct smi_cmd *smi_cmd);
> 
> +struct smm_eps_table {
> +	char smm_comm_buff_anchor[4];
> +	u8 length;
> +	u8 checksum;
> +	u8 version;
> +	u64 smm_comm_buff_addr;
> +	u64 num_of_4k_pages;
> +} __packed;
> +
>  #endif /* _DCDBAS_H_ */
> 
> --
> 2.14.2

Hi Doug,

Can you please review and comment on this change by Stuart?
This is going to be very important for DellEMC.

Thanks,
