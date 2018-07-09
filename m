Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBBDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02F420844
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="d56XbwSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02F420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933552AbeGIQmy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:42:54 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:51122 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbeGIQmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:42:51 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9474624E248F;
        Mon,  9 Jul 2018 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531154570; bh=5BARG5cqYGna/Iiyzw0PXZ9J8iHOv3LVfoUJ8zw7gGI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=d56XbwSjRwPKQMQP/Xezr9K+VrKOZl6ZJH8Nhn5CNKyAZksjgD/7VveNVOwij92gc
         2UOhD35KbIcF5ZBftouA9npOkvMJHkAzhumqbPhnGZP2aS8CJfhga+r5w2g84JD8dZ
         YopfqzMEJR5wzd+Hdh7CKpshF2AY0RmgRwjb8NcZV5xTAa2cLkX44ZWUYZC+C9D7LN
         4rYGx4PSbCKw8kKHFGOZIJdZoX1hp2HuaADQAuWU/2FUNNjuQhjDVg3pVdclYnu1HP
         aQs8gEX019i/CFbsdYa+PoQGRlSxBcpORqH45ERjWOOXEyXbjsAxT/rvAwK0QoVmTg
         m4L6CwhnNxx5Q==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1CF3C3091;
        Mon,  9 Jul 2018 09:42:50 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 9 Jul 2018 09:42:49 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 9 Jul 2018 18:42:47 +0200
Received: from [10.107.25.102] (10.107.25.102) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 9 Jul 2018 18:42:47 +0200
Subject: Re: [PATCH v8 09/11] pci_endpoint_test: Add 2 ioctl commands
To:     Alan Douglas <adouglas@cadence.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1530891871.git.gustavo.pimentel@synopsys.com>
 <93f542ee1ec24d3a24150d8909074614536d6ce9.1530891871.git.gustavo.pimentel@synopsys.com>
 <MWHPR07MB350246B23FF90D27B60CF0B2D8440@MWHPR07MB3502.namprd07.prod.outlook.com>
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <8aba4644-60ea-cb08-c382-0bb75efe11a6@synopsys.com>
Date:   Mon, 9 Jul 2018 17:40:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <MWHPR07MB350246B23FF90D27B60CF0B2D8440@MWHPR07MB3502.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.102]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 09/07/2018 16:22, Alan Douglas wrote:
> Hi Gustavo,
> 
> On  06 July 2018 16:52 Gustavo Pimentel <gustavo.pimentel@synopsys.com> wrote:
>> Add MSI-X support and update driver documentation accordingly.
>>
>> Add 2 new IOCTL commands:
>>  - Allow to reconfigure driver IRQ type in runtime.
>>  - Allow to retrieve current driver IRQ type configured.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Change v2->v3:
>>  - New patch file created base on the previous patch
>> "misc: pci_endpoint_test: Add MSI-X support" patch file following
>> Kishon's suggestion.
>> Change v3->v4:
>>  - Rebased to Lorenzo's master branch v4.18-rc1.
>> Change v4->v5:
>>  - Nothing changed, just to follow the patch set version.
>> Change v5->v6:
>>  - Moved PCITEST_SET_IRQTYPE and PCITEST_GET_IRQTYPE ioctl entries
>> from patch #10 to here.
>>  - Increased ioctl parameters range associated to
>> drivers/misc/pci_endpoint_test.c driver.
>> Change v6->v7:
>>  - irq_type variable update just before returning the function.
>> Change v7->v8:
>>  - Re-sending the patch series.
>>
>>  Documentation/ioctl/ioctl-number.txt             |   2 +-
>>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>>  drivers/misc/pci_endpoint_test.c                 | 175 +++++++++++++++++------
>>  include/uapi/linux/pcitest.h                     |   2 +
>>  4 files changed, 135 insertions(+), 47 deletions(-)
>>
>> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
>> index 65259d4..c15c4f3 100644
>> --- a/Documentation/ioctl/ioctl-number.txt
>> +++ b/Documentation/ioctl/ioctl-number.txt
>> @@ -166,7 +166,7 @@ Code  Seq#(hex)	Include File		Comments
>>  'P'	all	linux/soundcard.h	conflict!
>>  'P'	60-6F	sound/sscape_ioctl.h	conflict!
>>  'P'	00-0F	drivers/usb/class/usblp.c	conflict!
>> -'P'	01-07	drivers/misc/pci_endpoint_test.c	conflict!
>> +'P'	01-09	drivers/misc/pci_endpoint_test.c	conflict!
>>  'Q'	all	linux/soundcard.h
>>  'R'	00-1F	linux/random.h		conflict!
>>  'R'	01	linux/rfkill.h		conflict!
>> diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
>> index fdfa0f6..58ccca4 100644
>> --- a/Documentation/misc-devices/pci-endpoint-test.txt
>> +++ b/Documentation/misc-devices/pci-endpoint-test.txt
>> @@ -28,6 +28,9 @@ ioctl
>>  	      to be tested should be passed as argument.
>>   PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
>>  	      to be tested should be passed as argument.
>> + PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ type
>> +	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
>> + PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
>>   PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
>>  		as argument.
>>   PCITEST_READ: Perform read tests. The size of the buffer should be passed
>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>> index f4fef10..97082e3 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -157,6 +157,87 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
>>  	return IRQ_HANDLED;
>>  }
>>
>> +static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
>> +{
>> +	int i;
>> +	struct pci_dev *pdev = test->pdev;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	for (i = 0; i < test->num_irqs; i++)
>> +		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
>> +
>> +	test->num_irqs = 0;
>> +}
>> +
>> +static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test)
>> +{
>> +	int irq = -1;
>> +	struct pci_dev *pdev = test->pdev;
>> +	struct device *dev = &pdev->dev;
>> +	bool res = true;
>> +
>> +	switch (irq_type) {
>> +	case IRQ_TYPE_LEGACY:
>> +		irq = 0;
>> +		break;
>> +	case IRQ_TYPE_MSI:
>> +		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
>> +		if (irq < 0)
>> +			dev_err(dev, "Failed to get MSI interrupts\n");
>> +		break;
>> +	case IRQ_TYPE_MSIX:
>> +		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
>> +		if (irq < 0)
>> +			dev_err(dev, "Failed to get MSI-X interrupts\n");
>> +		break;
>> +	default:
>> +		dev_err(dev, "Invalid IRQ type selected\n");
>> +	}
>> +
>> +	if (irq < 0) {
>> +		irq = 0;
>> +		res = false;
>> +	}
>> +	test->num_irqs = irq;
>> +
>> +	return res;
>> +}
>> +
>> +static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
>> +{
>> +	struct pci_dev *pdev = test->pdev;
>> +
>> +	pci_disable_msi(pdev);
>> +	pci_disable_msix(pdev);
>> +}
>> +
>> +static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>> +{
>> +	int i;
>> +	int err;
>> +	struct pci_dev *pdev = test->pdev;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
>> +			       IRQF_SHARED, DRV_MODULE_NAME, test);
>> +	if (err) {
>> +		dev_err(dev, "Failed to request IRQ %d\n", pdev->irq);
>> +		return false;
>> +	}
>> +
>> +	for (i = 1; i < test->num_irqs; i++) {
>> +		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
>> +				       pci_endpoint_test_irqhandler,
>> +				       IRQF_SHARED, DRV_MODULE_NAME, test);
>> +		if (err)
>> +			dev_err(dev, "Failed to request IRQ %d for MSI%s %d\n",
>> +				pci_irq_vector(pdev, i),
>> +				irq_type == IRQ_TYPE_MSIX ? "-X" : "", i + 1);
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>>  				  enum pci_barno barno)
>>  {
>> @@ -440,6 +521,38 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
>>  	return ret;
>>  }
>>
>> +static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>> +				      int req_irq_type)
>> +{
>> +	struct pci_dev *pdev = test->pdev;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	if (req_irq_type < IRQ_TYPE_LEGACY || req_irq_type > IRQ_TYPE_MSIX) {
>> +		dev_err(dev, "Invalid IRQ type option\n");
>> +		return false;
>> +	}
>> +
>> +	if (irq_type == req_irq_type)
>> +		return true;
>> +
>> +	pci_endpoint_test_free_irq_vectors(test);
>> +	pci_endpoint_test_release_irq(test);
>> +
>> +	if (!pci_endpoint_test_alloc_irq_vectors(test)) {
>> +		pci_endpoint_test_release_irq(test);
>> +		return false;
>> +	}
> I am testing the latest patch set with the cadence driver, and find this step is not working correctly.
> pci_endpoint_test_alloc_irq_vectors relies on the value of static irq_type to request the appropriate IRQ.
> However, you don't set this value until a few lines later, so the first attempt to set the IRQ type fails.  (A
> second attempt to set it will succeed however.)  I suggest setting irq_type before the call, or even adding
> a parameter to pci_endpoint_test_alloc_irq_vectors() with the requested IRQ type to avoid having to set it
> back again after a failed call.

Thank you for testing the code. This bug appeared on the patch version 6 after
the Kishon's good suggestion of moving the irq type variable update immediately
before function returning. Unfortunately I forgot the
pci_endpoint_test_alloc_irq_vectors() dependency.
Once again, thanks!

Regards,
Gustavo

>> +
>> +	if (!pci_endpoint_test_request_irq(test)) {
>> +		pci_endpoint_test_release_irq(test);
>> +		return false;
>> +	}
> 
>> +
>> +	irq_type = req_irq_type;
>> +
>> +	return true;
>> +}

