Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeCPNqm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:46:42 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41492 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeCPNqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:46:40 -0400
X-Google-Smtp-Source: AG47ELu434D3XYWSyAudYIhbwfd582OrrK20vjjXCmzibmjol0CUjcyq6LwgZBS3MlFCKDAytDz05A==
Subject: Re: [PATCH v5 2/2] hwmon: (ucd9000) Add debugfs attributes to provide
 mfr_status
To: Eddie James <eajames@linux.vnet.ibm.com>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jdelvare@suse.com, joel@jms.id.au,
        andy.shevchenko@gmail.com,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>
References: <1521152516-10829-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1521152516-10829-3-git-send-email-eajames@linux.vnet.ibm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <70919183-34cd-b02c-2348-7439a67305ad@roeck-us.net>
Date: Fri, 16 Mar 2018 06:46:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521152516-10829-3-git-send-email-eajames@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 03:21 PM, Eddie James wrote:
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
>   drivers/hwmon/pmbus/ucd9000.c | 137 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 136 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
> index a34ffc4..c1a1560 100644
> --- a/drivers/hwmon/pmbus/ucd9000.c
> +++ b/drivers/hwmon/pmbus/ucd9000.c
> @@ -19,6 +19,7 @@
>    * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>    */
>   
> +#include <linux/debugfs.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/of_device.h>
> @@ -36,6 +37,7 @@
>   #define UCD9000_NUM_PAGES		0xd6
>   #define UCD9000_FAN_CONFIG_INDEX	0xe7
>   #define UCD9000_FAN_CONFIG		0xe8
> +#define UCD9000_MFR_STATUS		0xf3
>   #define UCD9000_GPIO_SELECT		0xfa
>   #define UCD9000_GPIO_CONFIG		0xfb
>   #define UCD9000_DEVICE_ID		0xfd
> @@ -63,13 +65,22 @@
>   #define UCD901XX_NUM_GPIOS	26
>   #define UCD90910_NUM_GPIOS	26
>   
> +#define UCD9000_DEBUGFS_NAME_LEN	24
> +#define UCD9000_GPI_COUNT		8
> +
>   struct ucd9000_data {
>   	u8 fan_data[UCD9000_NUM_FAN][I2C_SMBUS_BLOCK_MAX];
>   	struct pmbus_driver_info info;
>   	struct gpio_chip gpio;
> +	struct dentry *debugfs;
>   };
>   #define to_ucd9000_data(_info) container_of(_info, struct ucd9000_data, info)
>   
> +struct ucd9000_debugfs_entry {
> +	struct i2c_client *client;
> +	u8 index;
> +};
> +
>   static int ucd9000_get_fan_config(struct i2c_client *client, int fan)
>   {
>   	int fan_config = 0;
> @@ -306,6 +317,121 @@ static int ucd9000_gpio_direction_output(struct gpio_chip *gc,
>   					  val);
>   }
>   
> +#ifdef CONFIG_DEBUG_FS
> +static int ucd9000_get_mfr_status(struct i2c_client *client, u8 *buffer)
> +{
> +	int ret = pmbus_set_page(client, 0);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return i2c_smbus_read_block_data(client, UCD9000_MFR_STATUS, buffer);
> +}
> +
> +static int ucd9000_debugfs_show_mfr_status_bit(void *data, u64 *val)
> +{
> +	struct ucd9000_debugfs_entry *entry = data;
> +	struct i2c_client *client = entry->client;
> +	u8 buffer[I2C_SMBUS_BLOCK_MAX];
> +	int ret;
> +
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
> +	u8 buffer[I2C_SMBUS_BLOCK_MAX] = { 0 };
> +	char str[(I2C_SMBUS_BLOCK_MAX * 2) + 2] = { 0 };

Is it still necessary to initialize these variables ?

> +	char *res;
> +	int rc;
> +
> +	rc = ucd9000_get_mfr_status(client, buffer);
> +	if (rc < 0)
> +		return rc;
> +
> +	res = bin2hex(str, buffer, rc);

Please add some limit here, such as
	res = bin2hex(str, buffer, min(rc, I2C_SMBUS_BLOCK_MAX));

> +	*res++ = '\n';
> +
> +	return simple_read_from_buffer(buf, count, ppos, str, (res - str) + 1);
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
>   static void ucd9000_probe_gpio(struct i2c_client *client,
>   			       const struct i2c_device_id *mid,
>   			       struct ucd9000_data *data)
> @@ -464,7 +590,16 @@ static int ucd9000_probe(struct i2c_client *client,
>   
>   	ucd9000_probe_gpio(client, mid, data);
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
>   }
>   
>   /* This is the driver that will be inserted */
> 
