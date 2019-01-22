Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E12C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4904C21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfAVJUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:20:15 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:35932 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727208AbfAVJUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:20:14 -0500
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0M9BB1h008122;
        Tue, 22 Jan 2019 03:19:58 -0600
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 2q429x84jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jan 2019 03:19:58 -0600
Received: from us-aus-exch1.ni.corp.natinst.com (us-aus-exch1.ni.corp.natinst.com [130.164.68.11])
        by us-aus-skprod3.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x0M9JvaC011874
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Jan 2019 03:19:57 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) by
 us-aus-exch1.ni.corp.natinst.com (130.164.68.11) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 22 Jan 2019 03:19:57 -0600
Received: from my-pen-rd24.apac.corp.natinst.com (130.164.49.7) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Tue, 22 Jan 2019 03:19:55 -0600
From:   Guan Yung Tseng <guan.yung.tseng@ni.com>
To:     <gregkh@linuxfoundation.org>, <hch@infradead.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Guan Yung Tseng" <guan.yung.tseng@ni.com>
Subject: [PATCH v2] 8250_pci.c: Update NI specific devices class to multi serial
Date:   Tue, 22 Jan 2019 17:19:42 +0800
Message-ID: <1548148782-3414-1-git-send-email-guan.yung.tseng@ni.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On, Jan 14, 2019 at 10:10:05PM +0800, Guan Yung Tseng wrote:
>> Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
>> The reason of doing this is because all NI multi port serial cards
>> use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
>> serial_pci_is_class_communication test added in the commit 7d8905d06405
>> ("serial: 8250_pci: Enable device after we check black list").
>> 
>> Signed-off-by: Guan Yung Tseng <guan.yung.tseng@ni.com>
>> ---
>>  drivers/tty/serial/8250/8250_pci.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>> 
>> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
>> index 4986b4a..0949db1 100644
>> --- a/drivers/tty/serial/8250/8250_pci.c
>> +++ b/drivers/tty/serial/8250/8250_pci.c
>> @@ -663,6 +663,13 @@ static int pci_xircom_init(struct pci_dev *dev)
>>  	return 0;
>>  }
>>  
>> +static int pci_ni_probe(struct pci_dev *dev)
>> +{
>> +	dev->class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8 |
>> +			(dev->class & 0xff);

>
> As Christoph said, this looks really odd.  This field comes from the
> PCI structure on the device, it should not be modified by the kernel.
> 
> Unless the device is broken and needs to be fixed up in the kernel?
> 
> Also, you have sent 2 different patches here for this type of issue, are
> both needed?  If so, please resend both of them as a patch series, with
> more explainations in this one as to why you are modifying this field.
> 
> I've dropped all pending patches from you from my queue now.
> 

Hi Christoph and Greg,

Sorry for the confusion sending 2 different patches to solve the same
issue. I should have wait for your response before sending antoher
patch to solve the similar issue.

For some historical reason, NI serial devices use
PCI_CLASS_COMMUNICATION_OTHER class code. Yes, I understand that
the class code should read from config space instead modified from
kernel. But these devices are shipped to the market for many years.
That's why I am trying to fix the problem in the kernel.

I will send another simple patch again to fix the problem.
