Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D05EEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8544B208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8544B208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966319AbeFNOSp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:18:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966176AbeFNONL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:13:11 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5EED8KO116699
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 10:13:10 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jkrx2cah9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 10:13:09 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 14 Jun 2018 10:12:30 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Jun 2018 10:12:27 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5EECQx46357488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Jun 2018 14:12:26 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B043EAC05E;
        Thu, 14 Jun 2018 10:13:47 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36D30AC062;
        Thu, 14 Jun 2018 10:13:47 -0400 (EDT)
Received: from [9.85.174.231] (unknown [9.85.174.231])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jun 2018 10:13:47 -0400 (EDT)
Subject: Re: [RFC PATCH 5/5] fsi/scom: Major overhaul
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        openbmc@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20180612051911.20690-1-benh@kernel.crashing.org>
 <20180612051911.20690-6-benh@kernel.crashing.org>
 <4581896b-3e24-a5ad-b37a-a0fbf61f99c9@linux.vnet.ibm.com>
 <a82fdc0cbb03daa09f459f576dc4510b27d495ac.camel@kernel.crashing.org>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Thu, 14 Jun 2018 09:12:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a82fdc0cbb03daa09f459f576dc4510b27d495ac.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18061414-0068-0000-0000-000003091F80
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009189; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01046865; UDB=6.00536185; IPR=6.00825839;
 MB=3.00021644; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-14 14:12:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061414-0069-0000-0000-000044AFA45C
Message-Id: <5003354d-75e1-3ef3-a641-28a128677783@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806140157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/13/2018 06:00 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2018-06-13 at 09:57 -0500, Eddie James wrote:
>> On 06/12/2018 12:19 AM, Benjamin Herrenschmidt wrote:
>>> This was too hard to split ... this adds a number of features
>>> to the SCOM user interface:
>>>
>>>    - Support for indirect SCOMs
>>>
>>>    - read()/write() interface now handle errors and retries
>>>
>>>    - New ioctl() "raw" interface for use by debuggers
>>>
>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> ---
>>>    drivers/fsi/fsi-scom.c   | 424 ++++++++++++++++++++++++++++++++++++---
>>>    include/uapi/linux/fsi.h |  56 ++++++
>>>    2 files changed, 450 insertions(+), 30 deletions(-)
>>>    create mode 100644 include/uapi/linux/fsi.h
>>>
>>> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
>>> index e98573ecdae1..39c74351f1bf 100644
>>> --- a/drivers/fsi/fsi-scom.c
>>> +++ b/drivers/fsi/fsi-scom.c
>>> @@ -24,6 +24,8 @@
>>>    #include <linux/list.h>
>>>    #include <linux/idr.h>
>>> +
>>> +static int scom_reset(struct scom_device *scom, void __user *argp)
>>> +{
>>> +	uint32_t flags, dummy = -1;
>>> +	int rc = 0;
>>> +
>>> +	if (get_user(flags, (__u32 __user *)argp))
>>> +		return -EFAULT;
>>> +	if (flags & SCOM_RESET_PIB)
>>> +		rc = fsi_device_write(scom->fsi_dev, SCOM_PIB_RESET_REG, &dummy,
>>> +				      sizeof(uint32_t));
>> I realize this is a user requested flag but I believe the BMC is never
>> supposed to issue this type of reset, due to the possibility of breaking
>> stuff on the host side. Not sure if it should even be available?
> It's for use by cronus or similar low level system debuggers.
>
> Cheers,
> Ben.

Cool, thanks.

Reviewed-by: Eddie James <eajames@linux.vnet.ibm.com>

>
>> Otherwise, looks good!
>> Thanks,
>> Eddie
>>
>>> +	if (!rc && (flags & (SCOM_RESET_PIB | SCOM_RESET_INTF)))
>>> +		rc = fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG, &dummy,
>>> +				      sizeof(uint32_t));
>>> +	return rc;
>>> +}
>>> +
>>> +static int scom_check(struct scom_device *scom, void __user *argp)
>>> +{
>>> +	/* Still need to find out how to get "protected" */
>>> +	return put_user(SCOM_CHECK_SUPPORTED, (__u32 __user *)argp);
>>> +}
>>> +
>>> +static long scom_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>> +{
>>> +	struct miscdevice *mdev = file->private_data;
>>> +	struct scom_device *scom = to_scom_dev(mdev);
>>> +	void __user *argp = (void __user *)arg;
>>> +	int rc = -ENOTTY;
>>> +
>>> +	mutex_lock(&scom->lock);
>>> +	switch(cmd) {
>>> +	case FSI_SCOM_CHECK:
>>> +		rc = scom_check(scom, argp);
>>> +		break;
>>> +	case FSI_SCOM_READ:
>>> +		rc = scom_raw_read(scom, argp);
>>> +		break;
>>> +	case FSI_SCOM_WRITE:
>>> +		rc = scom_raw_write(scom, argp);
>>> +		break;
>>> +	case FSI_SCOM_RESET:
>>> +		rc = scom_reset(scom, argp);
>>> +		break;
>>> +	}
>>> +	mutex_unlock(&scom->lock);
>>> +	return rc;
>>> +}
>>> +
>>>    static const struct file_operations scom_fops = {
>>> -	.owner	= THIS_MODULE,
>>> -	.llseek	= scom_llseek,
>>> -	.read	= scom_read,
>>> -	.write	= scom_write,
>>> +	.owner		= THIS_MODULE,
>>> +	.llseek		= scom_llseek,
>>> +	.read		= scom_read,
>>> +	.write		= scom_write,
>>> +	.unlocked_ioctl	= scom_ioctl,
>>>    };
>>>
>>>    static int scom_probe(struct device *dev)
>>> diff --git a/include/uapi/linux/fsi.h b/include/uapi/linux/fsi.h
>>> new file mode 100644
>>> index 000000000000..6008d93f2e48
>>> --- /dev/null
>>> +++ b/include/uapi/linux/fsi.h
>>> @@ -0,0 +1,56 @@
>>> +#ifndef _UAPI_LINUX_FSI_H
>>> +#define _UAPI_LINUX_FSI_H
>>> +
>>> +#include <linux/ioctl.h>
>>> +
>>> +/*
>>> + * /dev/scom "raw" ioctl interface
>>> + *
>>> + * The driver supports a high level "read/write" interface which
>>> + * handles retries and converts the status to Linux error codes,
>>> + * however low level tools an debugger need to access the "raw"
>>> + * HW status information and interpret it themselves, so this
>>> + * ioctl interface is also provided for their use case.
>>> + */
>>> +
>>> +/* Structure for SCOM read/write */
>>> +struct scom_access {
>>> +	__u64	addr;		/* SCOM address, supports indirect */
>>> +	__u64	data;		/* SCOM data (in for write, out for read) */
>>> +	__u64	mask;		/* Data mask for writes */
>>> +	__u32	intf_errors;	/* Interface error flags */
>>> +#define SCOM_INTF_ERR_PARITY		0x00000001 /* Parity error */
>>> +#define SCOM_INTF_ERR_PROTECTION	0x00000002 /* Blocked by secure boot */
>>> +#define SCOM_INTF_ERR_ABORT		0x00000004 /* PIB reset during access */
>>> +#define SCOM_INTF_ERR_UNKNOWN		0x80000000 /* Unknown error */
>>> +	/*
>>> +	 * Note: Any other bit set in intf_errors need to be considered as an
>>> +	 * error. Future implementations may define new error conditions. The
>>> +	 * pib_status below is only valid if intf_errors is 0.
>>> +	 */
>>> +	__u8	pib_status;	/* 3-bit PIB status */
>>> +#define SCOM_PIB_SUCCESS	0	/* Access successful */
>>> +#define SCOM_PIB_BLOCKED	1	/* PIB blocked, pls retry */
>>> +#define SCOM_PIB_OFFLINE	2	/* Chiplet offline */
>>> +#define SCOM_PIB_PARTIAL	3	/* Partial good */
>>> +#define SCOM_PIB_BAD_ADDR	4	/* Invalid address */
>>> +#define SCOM_PIB_CLK_ERR	5	/* Clock error */
>>> +#define SCOM_PIB_PARITY_ERR	6	/* Parity error on the PIB bus */
>>> +#define SCOM_PIB_TIMEOUT	7	/* Bus timeout */
>>> +	__u8	pad;
>>> +};
>>> +
>>> +/* Flags for SCOM check */
>>> +#define SCOM_CHECK_SUPPORTED	0x00000001	/* Interface supported */
>>> +#define SCOM_CHECK_PROTECTED	0x00000002	/* Interface blocked by secure boot */
>>> +
>>> +/* Flags for SCOM reset */
>>> +#define SCOM_RESET_INTF		0x00000001	/* Reset interface */
>>> +#define SCOM_RESET_PIB		0x00000002	/* Reset PIB */
>>> +
>>> +#define FSI_SCOM_CHECK	_IOR('s', 0x00, __u32)
>>> +#define FSI_SCOM_READ	_IOWR('s', 0x01, struct scom_access)
>>> +#define FSI_SCOM_WRITE	_IOWR('s', 0x02, struct scom_access)
>>> +#define FSI_SCOM_RESET	_IOW('s', 0x03, __u32)
>>> +
>>> +#endif /* _UAPI_LINUX_FSI_H */

