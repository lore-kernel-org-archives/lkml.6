Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeCPGCG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 02:02:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:45355 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeCPGCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 02:02:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,313,1517904000";
   d="gz'50?scan'50,208,50";a="38458524"
Date: Fri, 16 Mar 2018 14:01:45 +0800
From: kbuild test robot <lkp@intel.com>
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        joel@jms.id.au, Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] hwmon: (ucd9000) Add gpio chip interface
Message-ID: <201803161355.FDNO2kDt%fengguang.wu@intel.com>
References: <1520974749-5372-2-git-send-email-eajames@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <1520974749-5372-2-git-send-email-eajames@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christopher,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc5 next-20180315]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Eddie-James/hwmon-ucd9000-Add-gpio-and-debugfs-interfaces/20180316-125048
config: x86_64-randconfig-x017-201810 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/hwmon/pmbus/ucd9000.c: In function 'ucd9000_probe':
>> drivers/hwmon/pmbus/ucd9000.c:457:12: error: 'struct gpio_chip' has no member named 'of_node'
     data->gpio.of_node = client->dev.of_node;
               ^

vim +457 drivers/hwmon/pmbus/ucd9000.c

   308	
   309	static int ucd9000_probe(struct i2c_client *client,
   310				 const struct i2c_device_id *id)
   311	{
   312		u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
   313		struct ucd9000_data *data;
   314		struct pmbus_driver_info *info;
   315		const struct i2c_device_id *mid;
   316		enum chips chip;
   317		int i, ret;
   318	
   319		if (!i2c_check_functionality(client->adapter,
   320					     I2C_FUNC_SMBUS_BYTE_DATA |
   321					     I2C_FUNC_SMBUS_BLOCK_DATA))
   322			return -ENODEV;
   323	
   324		ret = i2c_smbus_read_block_data(client, UCD9000_DEVICE_ID,
   325						block_buffer);
   326		if (ret < 0) {
   327			dev_err(&client->dev, "Failed to read device ID\n");
   328			return ret;
   329		}
   330		block_buffer[ret] = '\0';
   331		dev_info(&client->dev, "Device ID %s\n", block_buffer);
   332	
   333		for (mid = ucd9000_id; mid->name[0]; mid++) {
   334			if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
   335				break;
   336		}
   337		if (!mid->name[0]) {
   338			dev_err(&client->dev, "Unsupported device\n");
   339			return -ENODEV;
   340		}
   341	
   342		if (client->dev.of_node)
   343			chip = (enum chips)of_device_get_match_data(&client->dev);
   344		else
   345			chip = id->driver_data;
   346	
   347		if (chip != ucd9000 && chip != mid->driver_data)
   348			dev_notice(&client->dev,
   349				   "Device mismatch: Configured %s, detected %s\n",
   350				   id->name, mid->name);
   351	
   352		data = devm_kzalloc(&client->dev, sizeof(struct ucd9000_data),
   353				    GFP_KERNEL);
   354		if (!data)
   355			return -ENOMEM;
   356		info = &data->info;
   357	
   358		ret = i2c_smbus_read_byte_data(client, UCD9000_NUM_PAGES);
   359		if (ret < 0) {
   360			dev_err(&client->dev,
   361				"Failed to read number of active pages\n");
   362			return ret;
   363		}
   364		info->pages = ret;
   365		if (!info->pages) {
   366			dev_err(&client->dev, "No pages configured\n");
   367			return -ENODEV;
   368		}
   369	
   370		/* The internal temperature sensor is always active */
   371		info->func[0] = PMBUS_HAVE_TEMP;
   372	
   373		/* Everything else is configurable */
   374		ret = i2c_smbus_read_block_data(client, UCD9000_MONITOR_CONFIG,
   375						block_buffer);
   376		if (ret <= 0) {
   377			dev_err(&client->dev, "Failed to read configuration data\n");
   378			return -ENODEV;
   379		}
   380		for (i = 0; i < ret; i++) {
   381			int page = UCD9000_MON_PAGE(block_buffer[i]);
   382	
   383			if (page >= info->pages)
   384				continue;
   385	
   386			switch (UCD9000_MON_TYPE(block_buffer[i])) {
   387			case UCD9000_MON_VOLTAGE:
   388			case UCD9000_MON_VOLTAGE_HW:
   389				info->func[page] |= PMBUS_HAVE_VOUT
   390				  | PMBUS_HAVE_STATUS_VOUT;
   391				break;
   392			case UCD9000_MON_TEMPERATURE:
   393				info->func[page] |= PMBUS_HAVE_TEMP2
   394				  | PMBUS_HAVE_STATUS_TEMP;
   395				break;
   396			case UCD9000_MON_CURRENT:
   397				info->func[page] |= PMBUS_HAVE_IOUT
   398				  | PMBUS_HAVE_STATUS_IOUT;
   399				break;
   400			default:
   401				break;
   402			}
   403		}
   404	
   405		/* Fan configuration */
   406		if (mid->driver_data == ucd90124) {
   407			for (i = 0; i < UCD9000_NUM_FAN; i++) {
   408				i2c_smbus_write_byte_data(client,
   409							  UCD9000_FAN_CONFIG_INDEX, i);
   410				ret = i2c_smbus_read_block_data(client,
   411								UCD9000_FAN_CONFIG,
   412								data->fan_data[i]);
   413				if (ret < 0)
   414					return ret;
   415			}
   416			i2c_smbus_write_byte_data(client, UCD9000_FAN_CONFIG_INDEX, 0);
   417	
   418			info->read_byte_data = ucd9000_read_byte_data;
   419			info->func[0] |= PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12
   420			  | PMBUS_HAVE_FAN34 | PMBUS_HAVE_STATUS_FAN34;
   421		}
   422	
   423		/*
   424		 * Note:
   425		 *
   426		 * Pinmux support has not been added to the new gpio_chip.
   427		 * This support should be added when possible given the mux
   428		 * behavior of these IO devices.
   429		 */
   430		data->gpio.label = (const char *)&client->name;
   431		data->gpio.get_direction = ucd9000_gpio_get_direction;
   432		data->gpio.direction_input = ucd9000_gpio_direction_input;
   433		data->gpio.direction_output = ucd9000_gpio_direction_output;
   434		data->gpio.get = ucd9000_gpio_get;
   435		data->gpio.set = ucd9000_gpio_set;
   436		data->gpio.can_sleep = 1;
   437		data->gpio.base = -1;
   438	
   439		switch (mid->driver_data) {
   440		case ucd9090:
   441			data->gpio.ngpio = UCD9090_NUM_GPIOS;
   442			break;
   443		case ucd90120:
   444		case ucd90124:
   445		case ucd90160:
   446			data->gpio.ngpio = UCD901XX_NUM_GPIOS;
   447			break;
   448		case ucd90910:
   449			data->gpio.ngpio = UCD90910_NUM_GPIOS;
   450			break;
   451		default:
   452			break;
   453		}
   454	
   455		data->gpio.parent = &client->dev;
   456		data->gpio.owner = THIS_MODULE;
 > 457		data->gpio.of_node = client->dev.of_node;
   458	
   459		if (data->gpio.ngpio) {
   460			ret = devm_gpiochip_add_data(&client->dev, &data->gpio,
   461						     client);
   462			if (ret)
   463				dev_warn(&client->dev, "Could not add gpiochip: %d\n",
   464					 ret);
   465		}
   466	
   467		return pmbus_do_probe(client, mid, info);
   468	}
   469	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--45Z9DzgjV8m4Oswq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
SqKNAQA=

--45Z9DzgjV8m4Oswq--
