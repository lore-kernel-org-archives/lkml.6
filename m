Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494B7C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9EF21EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="CYI1FVIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9EF21EB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbeHITMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:12:18 -0400
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:2710 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731198AbeHITMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1533833196; x=1565369196;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eRDMJv292NkwdBBQ0q2sKKJl97FmH/BZJkpQhFMdQqA=;
  b=CYI1FVInvsMaKyvttdWzaalOFFMoBtmrneKXofeKSvD466p1ODTXoSFR
   XgeOfsj8LvWU7ja6cEFVb53x/yP7qye/ABdJlmFOcA+ytp0z2XOaTW/UW
   h+kpnr+87bEdnYBYspSJ5dm1hy6ScZ6lg+LxKkpTw+Fk9ZVoBQpzaQZJh
   4=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2H2AAABb2xbhyeV50NcGgEBAQEBAgE?=
 =?us-ascii?q?BAQEIAQEBAYUwKAqMXotVgg2ISY00gXoLhGyDJCE2FgECAQECAQECAQECEAE?=
 =?us-ascii?q?BAQoLCQgpIwyCNSKCYQEBAQMBEhUTPwULAgEIGB4QITYCBAESCBqCfoFpAw0?=
 =?us-ascii?q?IoRKJVwEBAYFoM4cjDYMhiRSCF4ESgmQuglaCKIVWAoddkkMrCQWMPYMHjjq?=
 =?us-ascii?q?LVIcDAgQCBAUCFIFIAoICcIM5gjOHV4ZJbwGNAIEbAQE?=
X-IPAS-Result: =?us-ascii?q?A2H2AAABb2xbhyeV50NcGgEBAQEBAgEBAQEIAQEBAYUwK?=
 =?us-ascii?q?AqMXotVgg2ISY00gXoLhGyDJCE2FgECAQECAQECAQECEAEBAQoLCQgpIwyCN?=
 =?us-ascii?q?SKCYQEBAQMBEhUTPwULAgEIGB4QITYCBAESCBqCfoFpAw0IoRKJVwEBAYFoM?=
 =?us-ascii?q?4cjDYMhiRSCF4ESgmQuglaCKIVWAoddkkMrCQWMPYMHjjqLVIcDAgQCBAUCF?=
 =?us-ascii?q?IFIAoICcIM5gjOHV4ZJbwGNAIEbAQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa2.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2018 11:46:35 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w79GcPIn116697;
        Thu, 9 Aug 2018 12:46:35 -0400
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0b-00154901.pphosted.com with ESMTP id 2krje3jfd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 09 Aug 2018 12:46:35 -0400
Cc:     <bhelgaas@google.com>, <keith.busch@intel.com>,
        <Austin.Bolen@dell.com>, <Shyam.Iyer@dell.com>,
        <fred@fredlawl.com>, <poza@codeaurora.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Received: from ausxippc110.us.dell.com ([143.166.85.200])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Aug 2018 22:46:34 +0600
X-LoopCount0: from 10.166.134.88
X-IronPort-AV: E=Sophos;i="5.53,215,1531803600"; 
   d="scan'208";a="687914251"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <helgaas@kernel.org>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
Thread-Topic: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
Thread-Index: AQHUHeNOLgc3siGTskGFqoeCfUtgww==
Date:   Thu, 9 Aug 2018 16:46:32 +0000
Message-ID: <2cae6a5ac8324be18b8dcf3d7dfcc288@ausx13mps321.AMER.DELL.COM>
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <20180809141551.GH49411@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.90.70]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=519 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2018 09:16 AM, Bjorn Helgaas wrote:=0A=
> On Tue, Jul 17, 2018 at 10:31:23AM -0500, Alexandru Gagniuc wrote:=0A=
>> When we don't own AER, we shouldn't touch the AER error bits. This=0A=
>> happens unconditionally on device probe(). Clearing AER bits=0A=
>> willy-nilly might cause firmware to miss errors. Instead=0A=
>> these bits should get cleared by FFS, or via ACPI _HPX method.=0A=
>>=0A=
>> This race is mostly of theoretical significance, as it is not easy to=0A=
>> reasonably demonstrate it in testing.=0A=
>>=0A=
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>=0A=
>> ---=0A=
>>   drivers/pci/pcie/aer.c | 3 +++=0A=
>>   1 file changed, 3 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c=0A=
>> index a2e88386af28..18037a2a8231 100644=0A=
>> --- a/drivers/pci/pcie/aer.c=0A=
>> +++ b/drivers/pci/pcie/aer.c=0A=
>> @@ -383,6 +383,9 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev=
 *dev)=0A=
>>   	if (!pci_is_pcie(dev))=0A=
>>   		return -ENODEV;=0A=
>>   =0A=
>> +	if (pcie_aer_get_firmware_first(dev))=0A=
>> +		return -EIO;=0A=
> =0A=
> I like this patch.=0A=
> =0A=
> Do we need the same thing in the following places that also clear AER=0A=
> status bits or write AER control bits?=0A=
=0A=
In theory, every exported function would guard for this. I think the =0A=
idea a long long time ago was that the check happens during =0A=
initialization, and the others are not hit.=0A=
=0A=
>    enable_ecrc_checking()=0A=
>    disable_ecrc_checking()=0A=
=0A=
I don't immediately see how this would affect FFS, but the bits are part =
=0A=
of the AER capability structure. According to the FFS model, those would =
=0A=
be owned by FW, and we'd have to avoid touching them.=0A=
=0A=
>    pci_cleanup_aer_uncorrect_error_status()=0A=
=0A=
This probably should be guarded. It's only called from a few specific =0A=
drivers, so the impact is not as high as being called from the core.=0A=
=0A=
>    pci_aer_clear_fatal_status()=0A=
=0A=
This is only called when doing fatal_recovery, right?=0A=
For practical considerations this is not an issue today. The ACPI error =0A=
handling code currently crashes when it encounters any fatal error, so =0A=
we wouldn't hit this in the FFS case.=0A=
=0A=
If the ACPI code pulls its thinking appendage out of the other end of =0A=
the digestive tract, then we could be hitting this in the future. For =0A=
correctness, guarding makes sense.=0A=
=0A=
The PCIe standards contact I usually talk to about these PCIe subtleties =
=0A=
is currently on vacation. The number one issue was a FFS corner case =0A=
with OS clearing bits on probe. The other functions you mention are a =0A=
corner case of a corner case. The big fish is =0A=
pci_cleanup_aer_error_status_regs() on probe(), and it would be nice to =0A=
have that resolved.=0A=
=0A=
I'll sync up with Austin when he gets back to see about the other =0A=
functions though I suspect we'll end up fixing them as well.=0A=
=0A=
Alex=0A=
=0A=
>>   	pos =3D dev->aer_cap;=0A=
>>   	if (!pos)=0A=
>>   		return -EIO;=0A=
>> -- =0A=
>> 2.14.3=0A=
>>=0A=
> =0A=
=0A=
=0A=
