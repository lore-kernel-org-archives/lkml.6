Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBB2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D8D20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zzB/WU5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D8D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeIEL6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:58:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53838 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIEL6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:58:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w857OHNB095893;
        Wed, 5 Sep 2018 07:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=EJ4xa5Mc1bCJRm+LMS2r0t0TcJepwzVH3zjTLl3QT/A=;
 b=zzB/WU5vMeFREpvAm+FkJC2MPj3fVV8NRx48d8sMjpo9TJiYhTvKQedS0rroE10Ymiax
 4zpMhmyF1xLIsFByEZgSqT1OygNJPsGJMFJ63iPQr8OcxjBhnpwPVuu0Tb/tMchzBdFo
 y+1fYnjrQo89usvn5Zu93igOtgKvxICES8PWRNIF04A7WzUggjMeGGjbRsY2xd2mwBHW
 ZUU3qcNQd2qntdJdQpj29ejcFR4p8y9hOh/9p55KEZIdjl23fjulQL5RMqf0BfiWsvXq
 cHWjdhcY9i7gMxJ+1PY+Mo3ealjn/18DZbJ9jehZhnLkbjZnPzF8Kg6u4ZpEuImkW53i BA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2m7jqphx7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 07:27:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w857RvGf006941
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 07:27:57 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w857RrZX008556;
        Wed, 5 Sep 2018 07:27:53 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 00:27:52 -0700
Date:   Wed, 5 Sep 2018 10:27:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Kenneth Lee <nek.in.cn@gmail.com>
Cc:     kbuild-all@01.org, Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>, linuxarm@huawei.com
Subject: Re: [PATCH 3/7] vfio: add sdmdev support
Message-ID: <20180905072737.figussnuhdtlbnee@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903005204.26041-4-nek.in.cn@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kenneth,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on cryptodev/master]
[also build test WARNING on v4.19-rc2 next-20180905]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kenneth-Lee/A-General-Accelerator-Framework-WarpDrive/20180903-162733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master

smatch warnings:
drivers/vfio/sdmdev/vfio_sdmdev.c:78 iommu_type_show() error: 'sdmdev' dereferencing possible ERR_PTR()
drivers/vfio/sdmdev/vfio_sdmdev.c:91 dma_flag_show() error: 'sdmdev' dereferencing possible ERR_PTR()
drivers/vfio/sdmdev/vfio_sdmdev.c:127 flags_show() error: 'sdmdev' dereferencing possible ERR_PTR()
drivers/vfio/sdmdev/vfio_sdmdev.c:128 name_show() error: 'sdmdev' dereferencing possible ERR_PTR()
drivers/vfio/sdmdev/vfio_sdmdev.c:130 device_api_show() error: 'sdmdev' dereferencing possible ERR_PTR()
drivers/vfio/sdmdev/vfio_sdmdev.c:138 available_instances_show() error: 'sdmdev' dereferencing possible ERR_PTR()
drivers/vfio/sdmdev/vfio_sdmdev.c:178 vfio_sdmdev_mdev_remove() warn: if();

# https://github.com/0day-ci/linux/commit/1e47d5e608652b4a2c813dbeaf5aa6811f6ceaf7
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 1e47d5e608652b4a2c813dbeaf5aa6811f6ceaf7
vim +/sdmdev +78 drivers/vfio/sdmdev/vfio_sdmdev.c

1e47d5e6 Kenneth Lee 2018-09-03   69  
1e47d5e6 Kenneth Lee 2018-09-03   70  static ssize_t iommu_type_show(struct device *dev,
1e47d5e6 Kenneth Lee 2018-09-03   71  			       struct device_attribute *attr, char *buf)
1e47d5e6 Kenneth Lee 2018-09-03   72  {
1e47d5e6 Kenneth Lee 2018-09-03   73  	struct vfio_sdmdev *sdmdev = vfio_sdmdev_pdev_sdmdev(dev);
                                                                     ^^^^^^^^^^^^^^^^^^^^^^^
Presumably this returns error pointers instead of NULL?

1e47d5e6 Kenneth Lee 2018-09-03   74  
1e47d5e6 Kenneth Lee 2018-09-03   75  	if (!sdmdev)
1e47d5e6 Kenneth Lee 2018-09-03   76  		return -ENODEV;
1e47d5e6 Kenneth Lee 2018-09-03   77  
1e47d5e6 Kenneth Lee 2018-09-03  @78  	return sprintf(buf, "%d\n", sdmdev->iommu_type);
1e47d5e6 Kenneth Lee 2018-09-03   79  }
1e47d5e6 Kenneth Lee 2018-09-03   80  
1e47d5e6 Kenneth Lee 2018-09-03   81  static DEVICE_ATTR_RO(iommu_type);
1e47d5e6 Kenneth Lee 2018-09-03   82  
1e47d5e6 Kenneth Lee 2018-09-03   83  static ssize_t dma_flag_show(struct device *dev,
1e47d5e6 Kenneth Lee 2018-09-03   84  			     struct device_attribute *attr, char *buf)
1e47d5e6 Kenneth Lee 2018-09-03   85  {
1e47d5e6 Kenneth Lee 2018-09-03   86  	struct vfio_sdmdev *sdmdev = vfio_sdmdev_pdev_sdmdev(dev);
1e47d5e6 Kenneth Lee 2018-09-03   87  
1e47d5e6 Kenneth Lee 2018-09-03   88  	if (!sdmdev)
1e47d5e6 Kenneth Lee 2018-09-03   89  		return -ENODEV;
1e47d5e6 Kenneth Lee 2018-09-03   90  
1e47d5e6 Kenneth Lee 2018-09-03  @91  	return sprintf(buf, "%d\n", sdmdev->dma_flag);
1e47d5e6 Kenneth Lee 2018-09-03   92  }
1e47d5e6 Kenneth Lee 2018-09-03   93  
1e47d5e6 Kenneth Lee 2018-09-03   94  static DEVICE_ATTR_RO(dma_flag);
1e47d5e6 Kenneth Lee 2018-09-03   95  
1e47d5e6 Kenneth Lee 2018-09-03   96  /* mdev->dev_attr_groups */
1e47d5e6 Kenneth Lee 2018-09-03   97  static struct attribute *vfio_sdmdev_attrs[] = {
1e47d5e6 Kenneth Lee 2018-09-03   98  	&dev_attr_iommu_type.attr,
1e47d5e6 Kenneth Lee 2018-09-03   99  	&dev_attr_dma_flag.attr,
1e47d5e6 Kenneth Lee 2018-09-03  100  	NULL,
1e47d5e6 Kenneth Lee 2018-09-03  101  };
1e47d5e6 Kenneth Lee 2018-09-03  102  static const struct attribute_group vfio_sdmdev_group = {
1e47d5e6 Kenneth Lee 2018-09-03  103  	.name  = VFIO_SDMDEV_PDEV_ATTRS_GRP_NAME,
1e47d5e6 Kenneth Lee 2018-09-03  104  	.attrs = vfio_sdmdev_attrs,
1e47d5e6 Kenneth Lee 2018-09-03  105  };
1e47d5e6 Kenneth Lee 2018-09-03  106  const struct attribute_group *vfio_sdmdev_groups[] = {
1e47d5e6 Kenneth Lee 2018-09-03  107  	&vfio_sdmdev_group,
1e47d5e6 Kenneth Lee 2018-09-03  108  	NULL,
1e47d5e6 Kenneth Lee 2018-09-03  109  };
1e47d5e6 Kenneth Lee 2018-09-03  110  
1e47d5e6 Kenneth Lee 2018-09-03  111  /* default attributes for mdev->supported_type_groups, used by registerer*/
1e47d5e6 Kenneth Lee 2018-09-03  112  #define MDEV_TYPE_ATTR_RO_EXPORT(name) \
1e47d5e6 Kenneth Lee 2018-09-03  113  		MDEV_TYPE_ATTR_RO(name); \
1e47d5e6 Kenneth Lee 2018-09-03  114  		EXPORT_SYMBOL_GPL(mdev_type_attr_##name);
1e47d5e6 Kenneth Lee 2018-09-03  115  
1e47d5e6 Kenneth Lee 2018-09-03  116  #define DEF_SIMPLE_SDMDEV_ATTR(_name, sdmdev_member, format) \
1e47d5e6 Kenneth Lee 2018-09-03  117  static ssize_t _name##_show(struct kobject *kobj, struct device *dev, \
1e47d5e6 Kenneth Lee 2018-09-03  118  			    char *buf) \
1e47d5e6 Kenneth Lee 2018-09-03  119  { \
1e47d5e6 Kenneth Lee 2018-09-03  120  	struct vfio_sdmdev *sdmdev = vfio_sdmdev_pdev_sdmdev(dev); \
1e47d5e6 Kenneth Lee 2018-09-03  121  	if (!sdmdev) \
1e47d5e6 Kenneth Lee 2018-09-03  122  		return -ENODEV; \
1e47d5e6 Kenneth Lee 2018-09-03  123  	return sprintf(buf, format, sdmdev->sdmdev_member); \
1e47d5e6 Kenneth Lee 2018-09-03  124  } \
1e47d5e6 Kenneth Lee 2018-09-03  125  MDEV_TYPE_ATTR_RO_EXPORT(_name)
1e47d5e6 Kenneth Lee 2018-09-03  126  
1e47d5e6 Kenneth Lee 2018-09-03 @127  DEF_SIMPLE_SDMDEV_ATTR(flags, flags, "%d");
1e47d5e6 Kenneth Lee 2018-09-03 @128  DEF_SIMPLE_SDMDEV_ATTR(name, name, "%s"); /* this should be algorithm name, */
1e47d5e6 Kenneth Lee 2018-09-03  129  		/* but you would not care if you have only one algorithm */
1e47d5e6 Kenneth Lee 2018-09-03 @130  DEF_SIMPLE_SDMDEV_ATTR(device_api, api_ver, "%s");
1e47d5e6 Kenneth Lee 2018-09-03  131  
1e47d5e6 Kenneth Lee 2018-09-03  132  static ssize_t
1e47d5e6 Kenneth Lee 2018-09-03  133  available_instances_show(struct kobject *kobj, struct device *dev, char *buf)
1e47d5e6 Kenneth Lee 2018-09-03  134  {
1e47d5e6 Kenneth Lee 2018-09-03  135  	struct vfio_sdmdev *sdmdev = vfio_sdmdev_pdev_sdmdev(dev);
1e47d5e6 Kenneth Lee 2018-09-03  136  	int nr_inst = 0;
1e47d5e6 Kenneth Lee 2018-09-03  137  
1e47d5e6 Kenneth Lee 2018-09-03 @138  	nr_inst = sdmdev->ops->get_available_instances ?
1e47d5e6 Kenneth Lee 2018-09-03  139  		sdmdev->ops->get_available_instances(sdmdev) : 0;
1e47d5e6 Kenneth Lee 2018-09-03  140  	return sprintf(buf, "%d", nr_inst);
1e47d5e6 Kenneth Lee 2018-09-03  141  }
1e47d5e6 Kenneth Lee 2018-09-03  142  MDEV_TYPE_ATTR_RO_EXPORT(available_instances);
1e47d5e6 Kenneth Lee 2018-09-03  143  
1e47d5e6 Kenneth Lee 2018-09-03  144  static int vfio_sdmdev_mdev_create(struct kobject *kobj,
1e47d5e6 Kenneth Lee 2018-09-03  145  	struct mdev_device *mdev)
1e47d5e6 Kenneth Lee 2018-09-03  146  {
1e47d5e6 Kenneth Lee 2018-09-03  147  	struct device *pdev = mdev_parent_dev(mdev);
1e47d5e6 Kenneth Lee 2018-09-03  148  	struct vfio_sdmdev_queue *q;
1e47d5e6 Kenneth Lee 2018-09-03  149  	struct vfio_sdmdev *sdmdev = mdev_sdmdev(mdev);
1e47d5e6 Kenneth Lee 2018-09-03  150  	int ret;
1e47d5e6 Kenneth Lee 2018-09-03  151  
1e47d5e6 Kenneth Lee 2018-09-03  152  	if (!sdmdev->ops->get_queue)
1e47d5e6 Kenneth Lee 2018-09-03  153  		return -ENODEV;
1e47d5e6 Kenneth Lee 2018-09-03  154  
1e47d5e6 Kenneth Lee 2018-09-03  155  	ret = sdmdev->ops->get_queue(sdmdev, &q);
1e47d5e6 Kenneth Lee 2018-09-03  156  	if (ret)
1e47d5e6 Kenneth Lee 2018-09-03  157  		return ret;
1e47d5e6 Kenneth Lee 2018-09-03  158  
1e47d5e6 Kenneth Lee 2018-09-03  159  	q->sdmdev = sdmdev;
1e47d5e6 Kenneth Lee 2018-09-03  160  	q->mdev = mdev;
1e47d5e6 Kenneth Lee 2018-09-03  161  	init_waitqueue_head(&q->wait);
1e47d5e6 Kenneth Lee 2018-09-03  162  
1e47d5e6 Kenneth Lee 2018-09-03  163  	mdev_set_drvdata(mdev, q);
1e47d5e6 Kenneth Lee 2018-09-03  164  	get_device(pdev);
1e47d5e6 Kenneth Lee 2018-09-03  165  
1e47d5e6 Kenneth Lee 2018-09-03  166  	return 0;
1e47d5e6 Kenneth Lee 2018-09-03  167  }
1e47d5e6 Kenneth Lee 2018-09-03  168  
1e47d5e6 Kenneth Lee 2018-09-03  169  static int vfio_sdmdev_mdev_remove(struct mdev_device *mdev)
1e47d5e6 Kenneth Lee 2018-09-03  170  {
1e47d5e6 Kenneth Lee 2018-09-03  171  	struct vfio_sdmdev_queue *q =
1e47d5e6 Kenneth Lee 2018-09-03  172  		(struct vfio_sdmdev_queue *)mdev_get_drvdata(mdev);
1e47d5e6 Kenneth Lee 2018-09-03  173  	struct vfio_sdmdev *sdmdev = q->sdmdev;
1e47d5e6 Kenneth Lee 2018-09-03  174  	struct device *pdev = mdev_parent_dev(mdev);
1e47d5e6 Kenneth Lee 2018-09-03  175  
1e47d5e6 Kenneth Lee 2018-09-03  176  	put_device(pdev);
1e47d5e6 Kenneth Lee 2018-09-03  177  
1e47d5e6 Kenneth Lee 2018-09-03 @178  	if (sdmdev->ops->put_queue);
                                                                   ^
Extra semicolon breaks the code.

1e47d5e6 Kenneth Lee 2018-09-03  179  		sdmdev->ops->put_queue(q);
1e47d5e6 Kenneth Lee 2018-09-03  180  
1e47d5e6 Kenneth Lee 2018-09-03  181  	return 0;
1e47d5e6 Kenneth Lee 2018-09-03  182  }
1e47d5e6 Kenneth Lee 2018-09-03  183  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
