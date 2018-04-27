Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932786AbeD0Now (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:44:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:41777 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932387AbeD0Nov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:44:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,335,1520924400";
   d="gz'50?scan'50,208,50";a="35731511"
Date: Fri, 27 Apr 2018 21:43:59 +0800
From: kbuild test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        "Darren Hart (VMware)" <dvhart@infradead.org>
Subject: drivers/platform/x86/dell-smbios-wmi.c:66: undefined reference to
 `wmidev_evaluate_method'
Message-ID: <201804272139.CYzGSbEr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0644f186fc9d77bb5bd198369e59fb28927a3692
commit: 25d47027e1003546bfd8964b4423cb39bc2d53e9 platform/x86: dell-smbios: Link all dell-smbios-* modules together
date:   7 weeks ago
config: x86_64-randconfig-b0-04271930 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 25d47027e1003546bfd8964b4423cb39bc2d53e9
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/platform/x86/dell-smbios-wmi.o: In function `run_smbios_call':
>> drivers/platform/x86/dell-smbios-wmi.c:66: undefined reference to `wmidev_evaluate_method'
   drivers/platform/x86/dell-smbios-wmi.o: In function `dell_smbios_wmi_probe':
>> drivers/platform/x86/dell-smbios-wmi.c:157: undefined reference to `dell_wmi_get_descriptor_valid'
>> drivers/platform/x86/dell-smbios-wmi.c:167: undefined reference to `dell_wmi_get_size'
>> drivers/platform/x86/dell-smbios-wmi.c:171: undefined reference to `dell_wmi_get_hotfix'
>> drivers/platform/x86/dell-smbios-wmi.c:182: undefined reference to `set_required_buffer_size'
   drivers/platform/x86/dell-smbios-wmi.o: In function `init_dell_smbios_wmi':
>> drivers/platform/x86/dell-smbios-wmi.c:271: undefined reference to `__wmi_driver_register'
   drivers/platform/x86/dell-smbios-wmi.o: In function `exit_dell_smbios_wmi':
>> drivers/platform/x86/dell-smbios-wmi.c:276: undefined reference to `wmi_driver_unregister'

vim +66 drivers/platform/x86/dell-smbios-wmi.c

1a258e67 Mario Limonciello 2017-11-01   48  
1a258e67 Mario Limonciello 2017-11-01   49  static int run_smbios_call(struct wmi_device *wdev)
1a258e67 Mario Limonciello 2017-11-01   50  {
1a258e67 Mario Limonciello 2017-11-01   51  	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
1a258e67 Mario Limonciello 2017-11-01   52  	struct wmi_smbios_priv *priv;
1a258e67 Mario Limonciello 2017-11-01   53  	struct acpi_buffer input;
1a258e67 Mario Limonciello 2017-11-01   54  	union acpi_object *obj;
1a258e67 Mario Limonciello 2017-11-01   55  	acpi_status status;
1a258e67 Mario Limonciello 2017-11-01   56  
1a258e67 Mario Limonciello 2017-11-01   57  	priv = dev_get_drvdata(&wdev->dev);
1a258e67 Mario Limonciello 2017-11-01   58  	input.length = priv->req_buf_size - sizeof(u64);
1a258e67 Mario Limonciello 2017-11-01   59  	input.pointer = &priv->buf->std;
1a258e67 Mario Limonciello 2017-11-01   60  
1a258e67 Mario Limonciello 2017-11-01   61  	dev_dbg(&wdev->dev, "evaluating: %u/%u [%x,%x,%x,%x]\n",
1a258e67 Mario Limonciello 2017-11-01   62  		priv->buf->std.cmd_class, priv->buf->std.cmd_select,
1a258e67 Mario Limonciello 2017-11-01   63  		priv->buf->std.input[0], priv->buf->std.input[1],
1a258e67 Mario Limonciello 2017-11-01   64  		priv->buf->std.input[2], priv->buf->std.input[3]);
1a258e67 Mario Limonciello 2017-11-01   65  
1a258e67 Mario Limonciello 2017-11-01  @66  	status = wmidev_evaluate_method(wdev, 0, 1, &input, &output);
1a258e67 Mario Limonciello 2017-11-01   67  	if (ACPI_FAILURE(status))
1a258e67 Mario Limonciello 2017-11-01   68  		return -EIO;
1a258e67 Mario Limonciello 2017-11-01   69  	obj = (union acpi_object *)output.pointer;
1a258e67 Mario Limonciello 2017-11-01   70  	if (obj->type != ACPI_TYPE_BUFFER) {
1a258e67 Mario Limonciello 2017-11-01   71  		dev_dbg(&wdev->dev, "received type: %d\n", obj->type);
1a258e67 Mario Limonciello 2017-11-01   72  		if (obj->type == ACPI_TYPE_INTEGER)
1a258e67 Mario Limonciello 2017-11-01   73  			dev_dbg(&wdev->dev, "SMBIOS call failed: %llu\n",
1a258e67 Mario Limonciello 2017-11-01   74  				obj->integer.value);
1a258e67 Mario Limonciello 2017-11-01   75  		return -EIO;
1a258e67 Mario Limonciello 2017-11-01   76  	}
1a258e67 Mario Limonciello 2017-11-01   77  	memcpy(&priv->buf->std, obj->buffer.pointer, obj->buffer.length);
1a258e67 Mario Limonciello 2017-11-01   78  	dev_dbg(&wdev->dev, "result: [%08x,%08x,%08x,%08x]\n",
1a258e67 Mario Limonciello 2017-11-01   79  		priv->buf->std.output[0], priv->buf->std.output[1],
1a258e67 Mario Limonciello 2017-11-01   80  		priv->buf->std.output[2], priv->buf->std.output[3]);
1a258e67 Mario Limonciello 2017-11-01   81  
1a258e67 Mario Limonciello 2017-11-01   82  	return 0;
1a258e67 Mario Limonciello 2017-11-01   83  }
1a258e67 Mario Limonciello 2017-11-01   84  
1a258e67 Mario Limonciello 2017-11-01   85  int dell_smbios_wmi_call(struct calling_interface_buffer *buffer)
1a258e67 Mario Limonciello 2017-11-01   86  {
1a258e67 Mario Limonciello 2017-11-01   87  	struct wmi_smbios_priv *priv;
1a258e67 Mario Limonciello 2017-11-01   88  	size_t difference;
1a258e67 Mario Limonciello 2017-11-01   89  	size_t size;
1a258e67 Mario Limonciello 2017-11-01   90  	int ret;
1a258e67 Mario Limonciello 2017-11-01   91  
1a258e67 Mario Limonciello 2017-11-01   92  	mutex_lock(&call_mutex);
1a258e67 Mario Limonciello 2017-11-01   93  	priv = get_first_smbios_priv();
307ab2a9 Mario Limonciello 2017-11-05   94  	if (!priv) {
307ab2a9 Mario Limonciello 2017-11-05   95  		ret = -ENODEV;
307ab2a9 Mario Limonciello 2017-11-05   96  		goto out_wmi_call;
307ab2a9 Mario Limonciello 2017-11-05   97  	}
1a258e67 Mario Limonciello 2017-11-01   98  
1a258e67 Mario Limonciello 2017-11-01   99  	size = sizeof(struct calling_interface_buffer);
1a258e67 Mario Limonciello 2017-11-01  100  	difference = priv->req_buf_size - sizeof(u64) - size;
1a258e67 Mario Limonciello 2017-11-01  101  
1a258e67 Mario Limonciello 2017-11-01  102  	memset(&priv->buf->ext, 0, difference);
1a258e67 Mario Limonciello 2017-11-01  103  	memcpy(&priv->buf->std, buffer, size);
1a258e67 Mario Limonciello 2017-11-01  104  	ret = run_smbios_call(priv->wdev);
1a258e67 Mario Limonciello 2017-11-01  105  	memcpy(buffer, &priv->buf->std, size);
307ab2a9 Mario Limonciello 2017-11-05  106  out_wmi_call:
1a258e67 Mario Limonciello 2017-11-01  107  	mutex_unlock(&call_mutex);
1a258e67 Mario Limonciello 2017-11-01  108  
1a258e67 Mario Limonciello 2017-11-01  109  	return ret;
1a258e67 Mario Limonciello 2017-11-01  110  }
1a258e67 Mario Limonciello 2017-11-01  111  
f2645fa3 Mario Limonciello 2017-11-01  112  static long dell_smbios_wmi_filter(struct wmi_device *wdev, unsigned int cmd,
f2645fa3 Mario Limonciello 2017-11-01  113  				   struct wmi_ioctl_buffer *arg)
f2645fa3 Mario Limonciello 2017-11-01  114  {
f2645fa3 Mario Limonciello 2017-11-01  115  	struct wmi_smbios_priv *priv;
f2645fa3 Mario Limonciello 2017-11-01  116  	int ret = 0;
f2645fa3 Mario Limonciello 2017-11-01  117  
f2645fa3 Mario Limonciello 2017-11-01  118  	switch (cmd) {
f2645fa3 Mario Limonciello 2017-11-01  119  	case DELL_WMI_SMBIOS_CMD:
f2645fa3 Mario Limonciello 2017-11-01  120  		mutex_lock(&call_mutex);
f2645fa3 Mario Limonciello 2017-11-01  121  		priv = dev_get_drvdata(&wdev->dev);
f2645fa3 Mario Limonciello 2017-11-01  122  		if (!priv) {
f2645fa3 Mario Limonciello 2017-11-01  123  			ret = -ENODEV;
f2645fa3 Mario Limonciello 2017-11-01  124  			goto fail_smbios_cmd;
f2645fa3 Mario Limonciello 2017-11-01  125  		}
f2645fa3 Mario Limonciello 2017-11-01  126  		memcpy(priv->buf, arg, priv->req_buf_size);
f2645fa3 Mario Limonciello 2017-11-01  127  		if (dell_smbios_call_filter(&wdev->dev, &priv->buf->std)) {
f2645fa3 Mario Limonciello 2017-11-01  128  			dev_err(&wdev->dev, "Invalid call %d/%d:%8x\n",
f2645fa3 Mario Limonciello 2017-11-01  129  				priv->buf->std.cmd_class,
f2645fa3 Mario Limonciello 2017-11-01  130  				priv->buf->std.cmd_select,
f2645fa3 Mario Limonciello 2017-11-01  131  				priv->buf->std.input[0]);
f2645fa3 Mario Limonciello 2017-11-01  132  			ret = -EFAULT;
f2645fa3 Mario Limonciello 2017-11-01  133  			goto fail_smbios_cmd;
f2645fa3 Mario Limonciello 2017-11-01  134  		}
f2645fa3 Mario Limonciello 2017-11-01  135  		ret = run_smbios_call(priv->wdev);
f2645fa3 Mario Limonciello 2017-11-01  136  		if (ret)
f2645fa3 Mario Limonciello 2017-11-01  137  			goto fail_smbios_cmd;
f2645fa3 Mario Limonciello 2017-11-01  138  		memcpy(arg, priv->buf, priv->req_buf_size);
f2645fa3 Mario Limonciello 2017-11-01  139  fail_smbios_cmd:
f2645fa3 Mario Limonciello 2017-11-01  140  		mutex_unlock(&call_mutex);
f2645fa3 Mario Limonciello 2017-11-01  141  		break;
f2645fa3 Mario Limonciello 2017-11-01  142  	default:
f2645fa3 Mario Limonciello 2017-11-01  143  		ret = -ENOIOCTLCMD;
f2645fa3 Mario Limonciello 2017-11-01  144  	}
f2645fa3 Mario Limonciello 2017-11-01  145  	return ret;
f2645fa3 Mario Limonciello 2017-11-01  146  }
f2645fa3 Mario Limonciello 2017-11-01  147  
1a258e67 Mario Limonciello 2017-11-01  148  static int dell_smbios_wmi_probe(struct wmi_device *wdev)
1a258e67 Mario Limonciello 2017-11-01  149  {
4255c30f Mario Limonciello 2017-11-16  150  	struct wmi_driver *wdriver =
4255c30f Mario Limonciello 2017-11-16  151  		container_of(wdev->dev.driver, struct wmi_driver, driver);
1a258e67 Mario Limonciello 2017-11-01  152  	struct wmi_smbios_priv *priv;
4255c30f Mario Limonciello 2017-11-16  153  	u32 hotfix;
1a258e67 Mario Limonciello 2017-11-01  154  	int count;
1a258e67 Mario Limonciello 2017-11-01  155  	int ret;
1a258e67 Mario Limonciello 2017-11-01  156  
868b8d33 Mario Limonciello 2017-11-09 @157  	ret = dell_wmi_get_descriptor_valid();
868b8d33 Mario Limonciello 2017-11-09  158  	if (ret)
868b8d33 Mario Limonciello 2017-11-09  159  		return ret;
1a258e67 Mario Limonciello 2017-11-01  160  
1a258e67 Mario Limonciello 2017-11-01  161  	priv = devm_kzalloc(&wdev->dev, sizeof(struct wmi_smbios_priv),
1a258e67 Mario Limonciello 2017-11-01  162  			    GFP_KERNEL);
1a258e67 Mario Limonciello 2017-11-01  163  	if (!priv)
1a258e67 Mario Limonciello 2017-11-01  164  		return -ENOMEM;
1a258e67 Mario Limonciello 2017-11-01  165  
1a258e67 Mario Limonciello 2017-11-01  166  	/* WMI buffer size will be either 4k or 32k depending on machine */
1a258e67 Mario Limonciello 2017-11-01 @167  	if (!dell_wmi_get_size(&priv->req_buf_size))
1a258e67 Mario Limonciello 2017-11-01  168  		return -EPROBE_DEFER;
1a258e67 Mario Limonciello 2017-11-01  169  
4255c30f Mario Limonciello 2017-11-16  170  	/* some SMBIOS calls fail unless BIOS contains hotfix */
4255c30f Mario Limonciello 2017-11-16 @171  	if (!dell_wmi_get_hotfix(&hotfix))
4255c30f Mario Limonciello 2017-11-16  172  		return -EPROBE_DEFER;
4255c30f Mario Limonciello 2017-11-16  173  	if (!hotfix) {
4255c30f Mario Limonciello 2017-11-16  174  		dev_warn(&wdev->dev,
4255c30f Mario Limonciello 2017-11-16  175  			"WMI SMBIOS userspace interface not supported(%u), try upgrading to a newer BIOS\n",
4255c30f Mario Limonciello 2017-11-16  176  			hotfix);
4255c30f Mario Limonciello 2017-11-16  177  		wdriver->filter_callback = NULL;
4255c30f Mario Limonciello 2017-11-16  178  	}
4255c30f Mario Limonciello 2017-11-16  179  
f2645fa3 Mario Limonciello 2017-11-01  180  	/* add in the length object we will use internally with ioctl */
f2645fa3 Mario Limonciello 2017-11-01  181  	priv->req_buf_size += sizeof(u64);
f2645fa3 Mario Limonciello 2017-11-01 @182  	ret = set_required_buffer_size(wdev, priv->req_buf_size);
f2645fa3 Mario Limonciello 2017-11-01  183  	if (ret)
f2645fa3 Mario Limonciello 2017-11-01  184  		return ret;
f2645fa3 Mario Limonciello 2017-11-01  185  
1a258e67 Mario Limonciello 2017-11-01  186  	count = get_order(priv->req_buf_size);
1a258e67 Mario Limonciello 2017-11-01  187  	priv->buf = (void *)__get_free_pages(GFP_KERNEL, count);
1a258e67 Mario Limonciello 2017-11-01  188  	if (!priv->buf)
1a258e67 Mario Limonciello 2017-11-01  189  		return -ENOMEM;
1a258e67 Mario Limonciello 2017-11-01  190  
1a258e67 Mario Limonciello 2017-11-01  191  	/* ID is used by dell-smbios to set priority of drivers */
1a258e67 Mario Limonciello 2017-11-01  192  	wdev->dev.id = 1;
1a258e67 Mario Limonciello 2017-11-01  193  	ret = dell_smbios_register_device(&wdev->dev, &dell_smbios_wmi_call);
1a258e67 Mario Limonciello 2017-11-01  194  	if (ret)
1a258e67 Mario Limonciello 2017-11-01  195  		goto fail_register;
1a258e67 Mario Limonciello 2017-11-01  196  
1a258e67 Mario Limonciello 2017-11-01  197  	priv->wdev = wdev;
1a258e67 Mario Limonciello 2017-11-01  198  	dev_set_drvdata(&wdev->dev, priv);
1a258e67 Mario Limonciello 2017-11-01  199  	mutex_lock(&list_mutex);
1a258e67 Mario Limonciello 2017-11-01  200  	list_add_tail(&priv->list, &wmi_list);
1a258e67 Mario Limonciello 2017-11-01  201  	mutex_unlock(&list_mutex);
1a258e67 Mario Limonciello 2017-11-01  202  
1a258e67 Mario Limonciello 2017-11-01  203  	return 0;
1a258e67 Mario Limonciello 2017-11-01  204  
1a258e67 Mario Limonciello 2017-11-01  205  fail_register:
1a258e67 Mario Limonciello 2017-11-01  206  	free_pages((unsigned long)priv->buf, count);
1a258e67 Mario Limonciello 2017-11-01  207  	return ret;
1a258e67 Mario Limonciello 2017-11-01  208  }
1a258e67 Mario Limonciello 2017-11-01  209  

:::::: The code at line 66 was first introduced by commit
:::::: 1a258e670434f404a4500b65ba1afea2c2b29bba platform/x86: dell-smbios-wmi: Add new WMI dispatcher driver

:::::: TO: Mario Limonciello <mario.limonciello@dell.com>
:::::: CC: Darren Hart (VMware) <dvhart@infradead.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--HcAYCG3uE/tztfnV
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--HcAYCG3uE/tztfnV--
