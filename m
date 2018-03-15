Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeCOEQy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 00:16:54 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33666 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeCOEQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 00:16:51 -0400
X-Google-Smtp-Source: AG47ELvrx38C3V6rrRMHuReCmyUmMTRXrjV+ls8hv/34g6SYiLIa+NI6EA8rvSX79bwEN4wHkc1kbg==
Date: Wed, 14 Mar 2018 21:16:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, joel@jms.id.au, andy.shevchenko@gmail.com,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH v4 2/2] hwmon: (ucd9000) Add debugfs attributes to
 provide mfr_status
Message-ID: <20180315041648.GA17763@roeck-us.net>
References: <1521066734-7985-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1521066734-7985-3-git-send-email-eajames@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521066734-7985-3-git-send-email-eajames@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 05:32:14PM -0500, Eddie James wrote:
> From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> 
> Expose the gpiN_fault fields of mfr_status as individual debugfs
> attributes. This provides a way for users to be easily notified of gpi
> faults. Also provide the whole mfr_status register in debugfs.
> 
> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  drivers/hwmon/pmbus/ucd9000.c | 153 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 152 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
> index a34ffc4..f03c404 100644
> --- a/drivers/hwmon/pmbus/ucd9000.c
> +++ b/drivers/hwmon/pmbus/ucd9000.c
> @@ -19,6 +19,7 @@
>   * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
> +#include <linux/debugfs.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> @@ -36,6 +37,7 @@
>  #define UCD9000_NUM_PAGES		0xd6
>  #define UCD9000_FAN_CONFIG_INDEX	0xe7
>  #define UCD9000_FAN_CONFIG		0xe8
> +#define UCD9000_MFR_STATUS		0xf3
>  #define UCD9000_GPIO_SELECT		0xfa
>  #define UCD9000_GPIO_CONFIG		0xfb
>  #define UCD9000_DEVICE_ID		0xfd
> @@ -63,13 +65,22 @@
>  #define UCD901XX_NUM_GPIOS	26
>  #define UCD90910_NUM_GPIOS	26
>  
> +#define UCD9000_DEBUGFS_NAME_LEN	24
> +#define UCD9000_GPI_COUNT		8
> +
>  struct ucd9000_data {
>  	u8 fan_data[UCD9000_NUM_FAN][I2C_SMBUS_BLOCK_MAX];
>  	struct pmbus_driver_info info;
>  	struct gpio_chip gpio;
> +	struct dentry *debugfs;
>  };
>  #define to_ucd9000_data(_info) container_of(_info, struct ucd9000_data, info)
>  
> +struct ucd9000_debugfs_entry {
> +	struct i2c_client *client;
> +	u8 index;
> +};
> +
>  static int ucd9000_get_fan_config(struct i2c_client *client, int fan)
>  {
>  	int fan_config = 0;
> @@ -306,6 +317,137 @@ static int ucd9000_gpio_direction_output(struct gpio_chip *gc,
>  					  val);
>  }
>  
> +#ifdef CONFIG_DEBUG_FS
> +static int ucd9000_get_mfr_status(struct i2c_client *client, u8 *buffer)
> +{
> +	int ret = pmbus_set_page(client, 0);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * With the ucd90120 and ucd90124 devices, this command [MFR_STATUS]
> +	 * is 2 bytes long (bits 0-15).  With the ucd90240 this command is 5
> +	 * bytes long.  With all other devices, it is 4 bytes long.
> +	 */

I am really uneasy about the limited buffer sizes.

The limited transfer size isn't guaranteed by the protocol. You are making 
assumptions about chip operation which adds risk. It would be much safer if
you would just use the maximum smbus block transfer size for all buffers.
It is not as if the few extra bytes on the stack would hurt, or am I missing
something ? As a bonus, all the comments about the transfers presumably being
safe would no longer be needed.

> +	return i2c_smbus_read_block_data(client, UCD9000_MFR_STATUS, buffer);
> +}
> +
> +static int ucd9000_debugfs_show_mfr_status_bit(void *data, u64 *val)
> +{
> +	struct ucd9000_debugfs_entry *entry = data;
> +	struct i2c_client *client = entry->client;
> +	u8 buffer[4];
> +	int ret;
> +
> +	/*
> +	 * This attribute is only created for devices that return 4 bytes for
> +	 * status_mfr, so it's safe to call with 4-byte buffer.
> +	 */
> +	ret = ucd9000_get_mfr_status(client, buffer);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Attribute only created for devices with gpi fault bits at bits
> +	 * 16-23, which is the second byte of the response.
> +	 */
> +	*val = !!(buffer[1] & BIT(entry->index));
> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(ucd9000_debugfs_mfr_status_bit,
> +			 ucd9000_debugfs_show_mfr_status_bit, NULL, "%1lld\n");
> +
> +static ssize_t ucd9000_debugfs_read_mfr_status(struct file *file,
> +					       char __user *buf, size_t count,
> +					       loff_t *ppos)
> +{
> +	struct i2c_client *client = file->private_data;
> +	u8 buffer[5] = { 0 };	/* Need max 5 bytes for any ucd9000 chip. */
> +	char str[12] = { 0 };	/* Two chars per byte plus \n and \0. */
> +	int i, num_bytes, num_chars = 0, rc;
> +
> +	num_bytes = ucd9000_get_mfr_status(client, buffer);
> +	if (num_bytes < 0)
> +		return num_bytes;
> +
> +	for (i = 0; i < num_bytes; ++i) {
> +		rc = snprintf(&str[num_chars], (sizeof(str) - 1) - num_chars,
> +			      "%02x", buffer[i]);
> +		if (rc <= 0)
> +			break;
> +
> +		num_chars += rc;
> +	}
> +
> +	str[num_chars] = '\n';

Sorry for being annoying, but have you considered using hex_dump_to_buffer() ?

Thanks,
Guenter

> +
> +	return simple_read_from_buffer(buf, count, ppos, str, num_chars + 2);
> +}
> +
> +static const struct file_operations ucd9000_debugfs_show_mfr_status_fops = {
> +	.llseek = noop_llseek,
> +	.read = ucd9000_debugfs_read_mfr_status,
> +	.open = simple_open,
> +};
> +
> +static int ucd9000_init_debugfs(struct i2c_client *client,
> +				const struct i2c_device_id *mid,
> +				struct ucd9000_data *data)
> +{
> +	struct dentry *debugfs;
> +	struct ucd9000_debugfs_entry *entries;
> +	int i;
> +	char name[UCD9000_DEBUGFS_NAME_LEN];
> +
> +	debugfs = pmbus_get_debugfs_dir(client);
> +	if (!debugfs)
> +		return -ENOENT;
> +
> +	data->debugfs = debugfs_create_dir(client->name, debugfs);
> +	if (!data->debugfs)
> +		return -ENOENT;
> +
> +	/*
> +	 * Of the chips this driver supports, only the UCD9090, UCD90160,
> +	 * and UCD90910 report GPI faults in their MFR_STATUS register, so only
> +	 * create the GPI fault debugfs attributes for those chips.
> +	 */
> +	if (mid->driver_data == ucd9090 || mid->driver_data == ucd90160 ||
> +	    mid->driver_data == ucd90910) {
> +		entries = devm_kzalloc(&client->dev,
> +				       sizeof(*entries) * UCD9000_GPI_COUNT,
> +				       GFP_KERNEL);
> +		if (!entries)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < UCD9000_GPI_COUNT; i++) {
> +			entries[i].client = client;
> +			entries[i].index = i;
> +			scnprintf(name, UCD9000_DEBUGFS_NAME_LEN,
> +				  "gpi%d_alarm", i + 1);
> +			debugfs_create_file(name, 0444, data->debugfs,
> +					    &entries[i],
> +					    &ucd9000_debugfs_mfr_status_bit);
> +		}
> +	}
> +
> +	scnprintf(name, UCD9000_DEBUGFS_NAME_LEN, "mfr_status");
> +	debugfs_create_file(name, 0444, data->debugfs, client,
> +			    &ucd9000_debugfs_show_mfr_status_fops);
> +
> +	return 0;
> +}
> +#else
> +static int ucd9000_init_debugfs(struct i2c_client *client,
> +				const struct i2c_device_id *mid,
> +				struct ucd9000_data *data)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_DEBUG_FS */
> +
>  static void ucd9000_probe_gpio(struct i2c_client *client,
>  			       const struct i2c_device_id *mid,
>  			       struct ucd9000_data *data)
> @@ -464,7 +606,16 @@ static int ucd9000_probe(struct i2c_client *client,
>  
>  	ucd9000_probe_gpio(client, mid, data);
>  
> -	return pmbus_do_probe(client, mid, info);
> +	ret = pmbus_do_probe(client, mid, info);
> +	if (ret)
> +		return ret;
> +
> +	ret = ucd9000_init_debugfs(client, mid, data);
> +	if (ret)
> +		dev_warn(&client->dev, "Failed to register debugfs: %d\n",
> +			 ret);
> +
> +	return 0;
>  }
>  
>  /* This is the driver that will be inserted */
> -- 
> 1.8.3.1
> 
