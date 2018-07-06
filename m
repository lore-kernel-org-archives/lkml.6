Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A38FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED0823FAD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wSweh9rG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED0823FAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbeGFJbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:31:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51824 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbeGFJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:31:40 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w669VRl3119551;
        Fri, 6 Jul 2018 04:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530869487;
        bh=WuQBGwKhJVWVJnEFkK0vHiHT+SH//QsytdFQS5H5wCg=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=wSweh9rGYF94nSzxjyZFyIE7zD8iXmuW2urw8EWl54cVmgf7SZruISafua8PAGWEr
         w5R5LcMpa9zGR+SJMK252bW6Dm8hW+hI1w9yTBjqS3w9yVcvBwKTfLGPnD0Q8dzwyf
         NLYOuiJlm3LYOwl2n42jshv1TteNxs8J71vlblAY=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w669VQpQ026861;
        Fri, 6 Jul 2018 04:31:26 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 6 Jul
 2018 04:31:26 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 6 Jul 2018 04:31:26 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w669VMsT009715;
        Fri, 6 Jul 2018 04:31:23 -0500
Subject: Re: [PATCH v6 10/11] tools: PCI: Add MSI-X support
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>,
        <shawn.lin@rock-chips.com>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
 <67e6549e9d872b53406aeec86bdd78d6d29e036d.1529595907.git.gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c3f06ed5-f118-bd21-29a4-9f585d6007a2@ti.com>
Date:   Fri, 6 Jul 2018 15:01:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <67e6549e9d872b53406aeec86bdd78d6d29e036d.1529595907.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 21 June 2018 09:31 PM, Gustavo Pimentel wrote:
> Add MSI-X support to pcitest tool.
> 
> Modify pcitest.sh script to accommodate MSI-X interrupt tests.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Change v1->v2:
>  - Allow IRQ type driver reconfiguring in runtime, follwing Kishon's
> suggestion.
> Change v2->v3:
>  - Nothing changed, just to follow the patch set version.
> Change v3->v4:
>  - Rebased to Lorenzo's master branch v4.18-rc1.
> Change v4->v5:
>  - Nothing changed, just to follow the patch set version.
> Change v5->v6:
>  - Moved PCITEST_MSIX ioctl entry to patch #8.
>  - Moved PCITEST_SET_IRQTYPE and PCITEST_GET_IRQTYPE ioctl entries
> to patch #9.
> 
>  tools/pci/pcitest.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  tools/pci/pcitest.sh | 15 +++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 9074b47..af146bb 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -31,12 +31,17 @@
>  #define BILLION 1E9
>  
>  static char *result[] = { "NOT OKAY", "OKAY" };
> +static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
>  
>  struct pci_test {
>  	char		*device;
>  	char		barnum;
>  	bool		legacyirq;
>  	unsigned int	msinum;
> +	unsigned int	msixnum;
> +	int		irqtype;
> +	bool		set_irqtype;
> +	bool		get_irqtype;
>  	bool		read;
>  	bool		write;
>  	bool		copy;
> @@ -65,6 +70,24 @@ static int run_test(struct pci_test *test)
>  			fprintf(stdout, "%s\n", result[ret]);
>  	}
>  
> +	if (test->set_irqtype) {
> +		ret = ioctl(fd, PCITEST_SET_IRQTYPE, test->irqtype);
> +		fprintf(stdout, "SET IRQ TYPE TO %s:\t\t", irq[test->irqtype]);
> +		if (ret < 0)
> +			fprintf(stdout, "FAILED\n");
> +		else
> +			fprintf(stdout, "%s\n", result[ret]);
> +	}
> +
> +	if (test->get_irqtype) {
> +		ret = ioctl(fd, PCITEST_GET_IRQTYPE);
> +		fprintf(stdout, "GET IRQ TYPE:\t\t");
> +		if (ret < 0)
> +			fprintf(stdout, "FAILED\n");
> +		else
> +			fprintf(stdout, "%s\n", irq[ret]);
> +	}
> +
>  	if (test->legacyirq) {
>  		ret = ioctl(fd, PCITEST_LEGACY_IRQ, 0);
>  		fprintf(stdout, "LEGACY IRQ:\t");
> @@ -83,6 +106,15 @@ static int run_test(struct pci_test *test)
>  			fprintf(stdout, "%s\n", result[ret]);
>  	}
>  
> +	if (test->msixnum > 0 && test->msixnum <= 2048) {
> +		ret = ioctl(fd, PCITEST_MSIX, test->msixnum);
> +		fprintf(stdout, "MSI-X%d:\t\t", test->msixnum);
> +		if (ret < 0)
> +			fprintf(stdout, "TEST FAILED\n");
> +		else
> +			fprintf(stdout, "%s\n", result[ret]);
> +	}
> +
>  	if (test->write) {
>  		ret = ioctl(fd, PCITEST_WRITE, test->size);
>  		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
> @@ -133,7 +165,7 @@ int main(int argc, char **argv)
>  	/* set default endpoint device */
>  	test->device = "/dev/pci-endpoint-test.0";
>  
> -	while ((c = getopt(argc, argv, "D:b:m:lrwcs:")) != EOF)
> +	while ((c = getopt(argc, argv, "D:b:m:x:i:Ilrwcs:")) != EOF)
>  	switch (c) {
>  	case 'D':
>  		test->device = optarg;
> @@ -151,6 +183,20 @@ int main(int argc, char **argv)
>  		if (test->msinum < 1 || test->msinum > 32)
>  			goto usage;
>  		continue;
> +	case 'x':
> +		test->msixnum = atoi(optarg);
> +		if (test->msixnum < 1 || test->msixnum > 2048)
> +			goto usage;
> +		continue;
> +	case 'i':
> +		test->irqtype = atoi(optarg);
> +		if (test->irqtype < 0 || test->irqtype > 2)
> +			goto usage;
> +		test->set_irqtype = true;
> +		continue;
> +	case 'I':
> +		test->get_irqtype = true;
> +		continue;
>  	case 'r':
>  		test->read = true;
>  		continue;
> @@ -173,6 +219,9 @@ int main(int argc, char **argv)
>  			"\t-D <dev>		PCI endpoint test device {default: /dev/pci-endpoint-test.0}\n"
>  			"\t-b <bar num>		BAR test (bar number between 0..5)\n"
>  			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
> +			"\t-x <msix num>	\tMSI-X test (msix number between 1..2048)\n"
> +			"\t-i <irq type>	\tSet IRQ type (0 - Legacy, 1 - MSI, 2 - MSI-X)\n"
> +			"\t-I			Get current IRQ type configured\n"
>  			"\t-l			Legacy IRQ test\n"
>  			"\t-r			Read buffer test\n"
>  			"\t-w			Write buffer test\n"
> diff --git a/tools/pci/pcitest.sh b/tools/pci/pcitest.sh
> index 77e8c85..75ed48f 100644
> --- a/tools/pci/pcitest.sh
> +++ b/tools/pci/pcitest.sh
> @@ -16,7 +16,10 @@ echo
>  echo "Interrupt tests"
>  echo
>  
> +pcitest -i 0
>  pcitest -l
> +
> +pcitest -i 1
>  msi=1
>  
>  while [ $msi -lt 33 ]
> @@ -26,9 +29,21 @@ do
>  done
>  echo
>  
> +pcitest -i 2
> +msix=1
> +
> +while [ $msix -lt 2049 ]
> +do
> +        pcitest -x $msix
> +        msix=`expr $msix + 1`
> +done
> +echo
> +
>  echo "Read Tests"
>  echo
>  
> +pcitest -i 1
> +
>  pcitest -r -s 1
>  pcitest -r -s 1024
>  pcitest -r -s 1025
> 
