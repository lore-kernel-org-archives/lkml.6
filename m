Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeCPF0y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 01:26:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:6887 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeCPF0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 01:26:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,313,1517904000";
   d="gz'50?scan'50,208,50";a="39405326"
Date: Fri, 16 Mar 2018 13:26:21 +0800
From: kbuild test robot <lkp@intel.com>
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        joel@jms.id.au, Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] hwmon: (ucd9000) Add gpio chip interface
Message-ID: <201803161348.WU2PDShJ%fengguang.wu@intel.com>
References: <1520974749-5372-2-git-send-email-eajames@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <1520974749-5372-2-git-send-email-eajames@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christopher,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc5 next-20180315]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Eddie-James/hwmon-ucd9000-Add-gpio-and-debugfs-interfaces/20180316-125048
config: x86_64-randconfig-x019-201810 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

>> drivers/hwmon/pmbus/ucd9000.c:69:19: error: field 'gpio' has incomplete type
     struct gpio_chip gpio;
                      ^~~~
   drivers/hwmon/pmbus/ucd9000.c: In function 'ucd9000_gpio_get':
>> drivers/hwmon/pmbus/ucd9000.c:184:31: error: implicit declaration of function 'gpiochip_get_data'; did you mean 'gpio_get_value'? [-Werror=implicit-function-declaration]
     struct i2c_client *client  = gpiochip_get_data(gc);
                                  ^~~~~~~~~~~~~~~~~
                                  gpio_get_value
>> drivers/hwmon/pmbus/ucd9000.c:184:31: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   drivers/hwmon/pmbus/ucd9000.c: In function 'ucd9000_gpio_set':
   drivers/hwmon/pmbus/ucd9000.c:197:30: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct i2c_client *client = gpiochip_get_data(gc);
                                 ^~~~~~~~~~~~~~~~~
   drivers/hwmon/pmbus/ucd9000.c: In function 'ucd9000_gpio_get_direction':
   drivers/hwmon/pmbus/ucd9000.c:240:30: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct i2c_client *client = gpiochip_get_data(gc);
                                 ^~~~~~~~~~~~~~~~~
   drivers/hwmon/pmbus/ucd9000.c: In function 'ucd9000_gpio_set_direction':
   drivers/hwmon/pmbus/ucd9000.c:254:30: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct i2c_client *client = gpiochip_get_data(gc);
                                 ^~~~~~~~~~~~~~~~~
   drivers/hwmon/pmbus/ucd9000.c: In function 'ucd9000_probe':
>> drivers/hwmon/pmbus/ucd9000.c:460:9: error: implicit declaration of function 'devm_gpiochip_add_data'; did you mean 'devm_gpio_request'? [-Werror=implicit-function-declaration]
      ret = devm_gpiochip_add_data(&client->dev, &data->gpio,
            ^~~~~~~~~~~~~~~~~~~~~~
            devm_gpio_request
   cc1: some warnings being treated as errors

vim +/gpio +69 drivers/hwmon/pmbus/ucd9000.c

    65	
    66	struct ucd9000_data {
    67		u8 fan_data[UCD9000_NUM_FAN][I2C_SMBUS_BLOCK_MAX];
    68		struct pmbus_driver_info info;
  > 69		struct gpio_chip gpio;
    70	};
    71	#define to_ucd9000_data(_info) container_of(_info, struct ucd9000_data, info)
    72	
    73	static int ucd9000_get_fan_config(struct i2c_client *client, int fan)
    74	{
    75		int fan_config = 0;
    76		struct ucd9000_data *data
    77		  = to_ucd9000_data(pmbus_get_driver_info(client));
    78	
    79		if (data->fan_data[fan][3] & 1)
    80			fan_config |= PB_FAN_2_INSTALLED;   /* Use lower bit position */
    81	
    82		/* Pulses/revolution */
    83		fan_config |= (data->fan_data[fan][3] & 0x06) >> 1;
    84	
    85		return fan_config;
    86	}
    87	
    88	static int ucd9000_read_byte_data(struct i2c_client *client, int page, int reg)
    89	{
    90		int ret = 0;
    91		int fan_config;
    92	
    93		switch (reg) {
    94		case PMBUS_FAN_CONFIG_12:
    95			if (page > 0)
    96				return -ENXIO;
    97	
    98			ret = ucd9000_get_fan_config(client, 0);
    99			if (ret < 0)
   100				return ret;
   101			fan_config = ret << 4;
   102			ret = ucd9000_get_fan_config(client, 1);
   103			if (ret < 0)
   104				return ret;
   105			fan_config |= ret;
   106			ret = fan_config;
   107			break;
   108		case PMBUS_FAN_CONFIG_34:
   109			if (page > 0)
   110				return -ENXIO;
   111	
   112			ret = ucd9000_get_fan_config(client, 2);
   113			if (ret < 0)
   114				return ret;
   115			fan_config = ret << 4;
   116			ret = ucd9000_get_fan_config(client, 3);
   117			if (ret < 0)
   118				return ret;
   119			fan_config |= ret;
   120			ret = fan_config;
   121			break;
   122		default:
   123			ret = -ENODATA;
   124			break;
   125		}
   126		return ret;
   127	}
   128	
   129	static const struct i2c_device_id ucd9000_id[] = {
   130		{"ucd9000", ucd9000},
   131		{"ucd90120", ucd90120},
   132		{"ucd90124", ucd90124},
   133		{"ucd90160", ucd90160},
   134		{"ucd9090", ucd9090},
   135		{"ucd90910", ucd90910},
   136		{}
   137	};
   138	MODULE_DEVICE_TABLE(i2c, ucd9000_id);
   139	
   140	static const struct of_device_id ucd9000_of_match[] = {
   141		{
   142			.compatible = "ti,ucd9000",
   143			.data = (void *)ucd9000
   144		},
   145		{
   146			.compatible = "ti,ucd90120",
   147			.data = (void *)ucd90120
   148		},
   149		{
   150			.compatible = "ti,ucd90124",
   151			.data = (void *)ucd90124
   152		},
   153		{
   154			.compatible = "ti,ucd90160",
   155			.data = (void *)ucd90160
   156		},
   157		{
   158			.compatible = "ti,ucd9090",
   159			.data = (void *)ucd9090
   160		},
   161		{
   162			.compatible = "ti,ucd90910",
   163			.data = (void *)ucd90910
   164		},
   165		{ },
   166	};
   167	MODULE_DEVICE_TABLE(of, ucd9000_of_match);
   168	
   169	static int ucd9000_gpio_read_config(struct i2c_client *client,
   170					    unsigned int offset)
   171	{
   172		int ret;
   173	
   174		/* No page set required */
   175		ret = i2c_smbus_write_byte_data(client, UCD9000_GPIO_SELECT, offset);
   176		if (ret < 0)
   177			return ret;
   178	
   179		return i2c_smbus_read_byte_data(client, UCD9000_GPIO_CONFIG);
   180	}
   181	
   182	static int ucd9000_gpio_get(struct gpio_chip *gc, unsigned int offset)
   183	{
 > 184		struct i2c_client *client  = gpiochip_get_data(gc);
   185		int ret;
   186	
   187		ret = ucd9000_gpio_read_config(client, offset);
   188		if (ret < 0)
   189			return ret;
   190	
   191		return !!(ret & UCD9000_GPIO_CONFIG_STATUS);
   192	}
   193	
   194	static void ucd9000_gpio_set(struct gpio_chip *gc, unsigned int offset,
   195				     int value)
   196	{
   197		struct i2c_client *client = gpiochip_get_data(gc);
   198		int ret;
   199	
   200		ret = ucd9000_gpio_read_config(client, offset);
   201		if (ret < 0) {
   202			dev_dbg(&client->dev, "failed to read GPIO %d config: %d\n",
   203				offset, ret);
   204			return;
   205		}
   206	
   207		if (value) {
   208			if (ret & UCD9000_GPIO_CONFIG_STATUS)
   209				return;
   210	
   211			ret |= UCD9000_GPIO_CONFIG_STATUS;
   212		} else {
   213			if (!(ret & UCD9000_GPIO_CONFIG_STATUS))
   214				return;
   215	
   216			ret &= ~UCD9000_GPIO_CONFIG_STATUS;
   217		}
   218	
   219		ret |= UCD9000_GPIO_CONFIG_ENABLE;
   220	
   221		/* Page set not required */
   222		ret = i2c_smbus_write_byte_data(client, UCD9000_GPIO_CONFIG, ret);
   223		if (ret < 0) {
   224			dev_dbg(&client->dev, "Failed to write GPIO %d config: %d\n",
   225				offset, ret);
   226			return;
   227		}
   228	
   229		ret &= ~UCD9000_GPIO_CONFIG_ENABLE;
   230	
   231		ret = i2c_smbus_write_byte_data(client, UCD9000_GPIO_CONFIG, ret);
   232		if (ret < 0)
   233			dev_dbg(&client->dev, "Failed to write GPIO %d config: %d\n",
   234				offset, ret);
   235	}
   236	
   237	static int ucd9000_gpio_get_direction(struct gpio_chip *gc,
   238					      unsigned int offset)
   239	{
 > 240		struct i2c_client *client = gpiochip_get_data(gc);
   241		int ret;
   242	
   243		ret = ucd9000_gpio_read_config(client, offset);
   244		if (ret < 0)
   245			return ret;
   246	
   247		return !(ret & UCD9000_GPIO_CONFIG_OUT_ENABLE);
   248	}
   249	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--Kj7319i9nmIyA2yE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Kj7319i9nmIyA2yE--
