Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeCNTrF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:47:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932122AbeCNTrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:47:02 -0400
Subject: Re: [PATCH v2 2/2] hwmon: (ucd9000) Add debugfs attributes to provide
 mfr_status
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, joel@jms.id.au,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>
References: <1520974749-5372-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1520974749-5372-3-git-send-email-eajames@linux.vnet.ibm.com>
 <20180314191927.GA25390@roeck-us.net>
From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 14:46:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314191927.GA25390@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031419-0004-0000-0000-000013CD678F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003052; UDB=6.00510440; IPR=6.00782382;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 19:46:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031419-0005-0000-0000-00008676D5A2
Message-Id: <3ee769ea-03b9-f614-1423-bfd2ec840c2e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140214
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/14/2018 02:19 PM, Guenter Roeck wrote:
> On Tue, Mar 13, 2018 at 03:59:09PM -0500, Eddie James wrote:
>> From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>>
>> Expose the gpiN_fault fields of mfr_status as individual debugfs
>> attributes. This provides a way for users to be easily notified of gpi
>> faults. Also provide the whole mfr_status register in debugfs.
>>
>> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
>> ---
>>   drivers/hwmon/pmbus/ucd9000.c | 140 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 139 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
>> index 023fb9e..b073d8e 100644
>> --- a/drivers/hwmon/pmbus/ucd9000.c
>> +++ b/drivers/hwmon/pmbus/ucd9000.c
>> @@ -19,6 +19,7 @@
>>    * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>>    */
>>   
>> +#include <linux/debugfs.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/of_device.h>
>> @@ -36,6 +37,7 @@
>>   #define UCD9000_NUM_PAGES		0xd6
>>   #define UCD9000_FAN_CONFIG_INDEX	0xe7
>>   #define UCD9000_FAN_CONFIG		0xe8
>> +#define UCD9000_MFR_STATUS		0xf3
>>   #define UCD9000_GPIO_SELECT		0xfa
>>   #define UCD9000_GPIO_CONFIG		0xfb
>>   #define UCD9000_DEVICE_ID		0xfd
>> @@ -63,13 +65,22 @@
>>   #define UCD901XX_NUM_GPIOS	26
>>   #define UCD90910_NUM_GPIOS	26
>>   
>> +#define UCD9000_DEBUGFS_NAME_LEN	24
>> +#define UCD9000_GPI_COUNT		8
>> +
>>   struct ucd9000_data {
>>   	u8 fan_data[UCD9000_NUM_FAN][I2C_SMBUS_BLOCK_MAX];
>>   	struct pmbus_driver_info info;
>>   	struct gpio_chip gpio;
>> +	struct dentry *debugfs;
>>   };
>>   #define to_ucd9000_data(_info) container_of(_info, struct ucd9000_data, info)
>>   
>> +struct ucd9000_debugfs_entry {
>> +	struct i2c_client *client;
>> +	u8 index;
>> +};
>> +
>>   static int ucd9000_get_fan_config(struct i2c_client *client, int fan)
>>   {
>>   	int fan_config = 0;
>> @@ -306,6 +317,124 @@ static int ucd9000_gpio_direction_output(struct gpio_chip *gc,
>>   					  val);
>>   }
>>   
>> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> DEBUG_FS is bool, so #ifdef CONFIG_DEBUG_FS is fine here.

Ok.

>
>> +static int ucd9000_get_mfr_status(struct i2c_client *client, u8 *buffer)
>> +{
>> +	int ret = pmbus_set_page(client, 0);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/*
>> +	 * With the ucd90120 and ucd90124 devices, this command [MFR_STATUS]
>> +	 * is 2 bytes long (bits 0-15).  With the ucd90240 this command is 5
>> +	 * bytes long.  With all other devices, it is 4 bytes long.
>> +	 */
>> +	return i2c_smbus_read_block_data(client, UCD9000_MFR_STATUS, buffer);
>> +}
>> +
>> +static int ucd9000_debugfs_show_mfr_status_bit(void *data, u64 *val)
>> +{
>> +	struct ucd9000_debugfs_entry *entry = data;
>> +	struct i2c_client *client = entry->client;
>> +	u8 buffer[4];
>> +	int ret;
>> +
>> +	/*
>> +	 * This attribute is only created for devices that return 4 bytes for
>> +	 * status_mfr, so it's safe to call with 4-byte buffer.
>> +	 */
>> +	ret = ucd9000_get_mfr_status(client, buffer);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/*
>> +	 * Attribute only created for devices with gpi fault bits at bits
>> +	 * 16-23, which is the second byte of the response.
>> +	 */
>> +	*val = !!(buffer[1] & BIT(entry->index));
>> +
>> +	return 0;
>> +}
>> +DEFINE_DEBUGFS_ATTRIBUTE(ucd9000_debugfs_mfr_status_bit,
>> +			 ucd9000_debugfs_show_mfr_status_bit, NULL, "%1lld\n");
>> +
>> +static ssize_t ucd9000_debugfs_read_mfr_status(struct file *file,
>> +					       char __user *buf, size_t count,
>> +					       loff_t *ppos)
>> +{
>> +	struct i2c_client *client = file->private_data;
>> +	u8 buffer[5] = { 0 };	/* Need max 5 bytes for any ucd9000 chip. */
>> +	int ret;
>> +
>> +	ret = ucd9000_get_mfr_status(client, buffer);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return simple_read_from_buffer(buf, count, ppos, buffer, ret);
> Doesn't this report the raw binary data to userspace ? The output
> should be human-readable.

Yes, sorry I thought that was your suggestion when you mentioned hexdump 
earlier... Will fix.

Thanks,
Eddie

>
>> +}
>> +
>> +static const struct file_operations ucd9000_debugfs_show_mfr_status_fops = {
>> +	.llseek = noop_llseek,
>> +	.read = ucd9000_debugfs_read_mfr_status,
>> +	.open = simple_open,
>> +};
>> +
>> +static int ucd9000_init_debugfs(struct i2c_client *client,
>> +				const struct i2c_device_id *mid,
>> +				struct ucd9000_data *data)
>> +{
>> +	struct dentry *debugfs;
>> +	struct ucd9000_debugfs_entry *entries;
>> +	int i;
>> +	char name[UCD9000_DEBUGFS_NAME_LEN];
>> +
>> +	debugfs = pmbus_get_debugfs_dir(client);
>> +	if (!debugfs)
>> +		return -ENOENT;
>> +
>> +	data->debugfs = debugfs_create_dir(client->name, debugfs);
>> +	if (!data->debugfs)
>> +		return -ENOENT;
>> +
>> +	/*
>> +	 * Of the chips this driver supports, only the UCD9090, UCD90160,
>> +	 * and UCD90910 report GPI faults in their MFR_STATUS register, so only
>> +	 * create the GPI fault debugfs attributes for those chips.
>> +	 */
>> +	if (mid->driver_data == ucd9090 || mid->driver_data == ucd90160 ||
>> +	    mid->driver_data == ucd90910) {
>> +		entries = devm_kzalloc(&client->dev,
>> +				       sizeof(*entries) * UCD9000_GPI_COUNT,
>> +				       GFP_KERNEL);
>> +		if (!entries)
>> +			return -ENOMEM;
>> +
>> +		for (i = 0; i < UCD9000_GPI_COUNT; i++) {
>> +			entries[i].client = client;
>> +			entries[i].index = i;
>> +			scnprintf(name, UCD9000_DEBUGFS_NAME_LEN,
>> +				  "gpi%d_alarm", i + 1);
>> +			debugfs_create_file(name, 0444, data->debugfs,
>> +					    &entries[i],
>> +					    &ucd9000_debugfs_mfr_status_bit);
>> +		}
>> +	}
>> +
>> +	scnprintf(name, UCD9000_DEBUGFS_NAME_LEN, "mfr_status");
>> +	debugfs_create_file(name, 0444, data->debugfs, client,
>> +			    &ucd9000_debugfs_show_mfr_status_fops);
>> +
>> +	return 0;
>> +}
>> +#else
>> +static int ucd9000_init_debugfs(struct i2c_client *client,
>> +				struct ucd9000_data *data)
>> +{
>> +	return 0;
>> +}
>> +#endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
>> +
>>   static int ucd9000_probe(struct i2c_client *client,
>>   			 const struct i2c_device_id *id)
>>   {
>> @@ -464,7 +593,16 @@ static int ucd9000_probe(struct i2c_client *client,
>>   				 ret);
>>   	}
>>   
>> -	return pmbus_do_probe(client, mid, info);
>> +	ret = pmbus_do_probe(client, mid, info);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ucd9000_init_debugfs(client, mid, data);
>> +	if (ret)
>> +		dev_warn(&client->dev, "Failed to register debugfs: %d\n",
>> +			 ret);
>> +
>> +	return 0;
>>   }
>>   
>>   /* This is the driver that will be inserted */
>> -- 
>> 1.8.3.1
>>
