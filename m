Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C4DC46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C79921A16
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="pMn2H4vM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C79921A16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbeHFUuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:50:15 -0400
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:30902 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728936AbeHFUuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1533580793; x=1565116793;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HxuhUsJ5++ysxdpkn3i5qvTGKQtXDjVKhqzxbqVoYlA=;
  b=pMn2H4vMrpB7u39TFO2mbMdhilxh0YFF7rQQxt+B8zjXcG7982gDimea
   M1YaR/rct1u1vYMFDKN0SmD/gQL6jsIr37A4eR+Bri+dwc62Cyx6DVcne
   viqGuQA7YPjYfQJYlwyiUHxvlivnBfDR4kSyEXwlmkl8H1ju4aLX+kLSn
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GQAAA8lWhbhyWd50NcGwEBAQEDAQE?=
 =?us-ascii?q?BCQEBAYUwMot+X4togg2VZ4F6C4RsgyohNBgBAgEBAgEBAgEBAhABAQEKCwk?=
 =?us-ascii?q?IKS+CNSKCYgEBAQMSFVIQAgEIGC5XAgQBGhqCfoIAoiOJVgEBAYFoM4pNiQm?=
 =?us-ascii?q?CF4QkhH6FVgKNL40ECQWPOIFVhCGIMpI3AgQCBAUCFIFBggtwgzqCJA4Jjhe?=
 =?us-ascii?q?PYIEbAQE?=
X-IPAS-Result: =?us-ascii?q?A2GQAAA8lWhbhyWd50NcGwEBAQEDAQEBCQEBAYUwMot+X?=
 =?us-ascii?q?4togg2VZ4F6C4RsgyohNBgBAgEBAgEBAgEBAhABAQEKCwkIKS+CNSKCYgEBA?=
 =?us-ascii?q?QMSFVIQAgEIGC5XAgQBGhqCfoIAoiOJVgEBAYFoM4pNiQmCF4QkhH6FVgKNL?=
 =?us-ascii?q?40ECQWPOIFVhCGIMpI3AgQCBAUCFIFBggtwgzqCJA4JjhePYIEbAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa2.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Aug 2018 13:39:52 -0500
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76IbwOU048364;
        Mon, 6 Aug 2018 14:39:52 -0400
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0b-00154901.pphosted.com with ESMTP id 2kppm720tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 06 Aug 2018 14:39:52 -0400
Cc:     <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <keith.busch@intel.com>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <jeffrey.t.kirsher@intel.com>,
        <ariel.elior@cavium.com>, <michael.chan@broadcom.com>,
        <ganeshgr@chelsio.com>, <tariqt@mellanox.com>, <airlied@gmail.com>,
        <alexander.deucher@amd.com>, <mike.marciniszyn@intel.com>,
        <linux-kernel@vger.kernel.org>
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Aug 2018 00:39:38 +0600
X-LoopCount0: from 10.166.134.83
X-IronPort-AV: E=Sophos;i="5.51,452,1526360400"; 
   d="scan'208";a="277404338"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <talgi@mellanox.com>, <mr.nuke.me@gmail.com>,
        <jakub.kicinski@netronome.com>
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
Thread-Topic: [PATCH v5] PCI: Check for PCIe downtraining conditions
Thread-Index: AQHUIsBJEgoOQgRprEe8nLwocH1DnQ==
Date:   Mon, 6 Aug 2018 18:39:48 +0000
Message-ID: <c0f2f79b1fe1491287b35e70ba76902a@ausx13mps321.AMER.DELL.COM>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
 <20180723200339.23943-1-mr.nuke.me@gmail.com>
 <20180723140143.1a46902f@cakuba.netronome.com>
 <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
 <fc04618a-3b3b-58bd-edd5-cbde11638d7b@mellanox.com>
 <1b914780-e342-6aee-ffb2-ef81ac3ddd29@gmail.com>
 <7424c5ba-ae44-3d8d-9dd5-360e17b6e3b9@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.90.70]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2018 02:06 AM, Tal Gilboa wrote:=0A=
> On 7/31/2018 6:10 PM, Alex G. wrote:=0A=
>> On 07/31/2018 01:40 AM, Tal Gilboa wrote:=0A=
>> [snip]=0A=
>>>>>> @@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct=0A=
>>>>>> pci_dev *dev)=0A=
>>>>>>  =A0=A0=A0=A0=A0 /* Advanced Error Reporting */=0A=
>>>>>>  =A0=A0=A0=A0=A0 pci_aer_init(dev);=0A=
>>>>>> +=A0=A0=A0 /* Check link and detect downtrain errors */=0A=
>>>>>> +=A0=A0=A0 pcie_check_upstream_link(dev);=0A=
>>>>=0A=
>>>> This is called for every PCIe device right? Won't there be a=0A=
>>>> duplicated print in case a device loads with lower PCIe bandwidth=0A=
>>>> than needed?=0A=
>>>=0A=
>>> Alex, can you comment on this please?=0A=
>>=0A=
>> Of course I can.=0A=
>>=0A=
>> There's one print at probe() time, which happens if bandwidth < max. I=
=0A=
>> would think that's fine. There is a way to duplicate it, and that is if=
=0A=
>> the driver also calls print_link_status(). A few driver maintainers who=
=0A=
>> call it have indicated they'd be fine with removing it from the driver,=
=0A=
>> and leaving it in the core PCI.=0A=
> =0A=
> We would be fine with that as well. Please include the removal in your=0A=
> patches.=0A=
=0A=
What's the proper procedure? Do I wait for confirmation from Bjorn =0A=
before knocking on maintainer's doors, or do I William Wallace into =0A=
their trees and demand they merge the removal (pending Bjorn's approval =0A=
on the other side) ?=0A=
=0A=
Alex=0A=
=0A=
>>=0A=
>> Should the device come back at low speed, go away, then come back at=0A=
>> full speed we'd still only see one print from the first probe. Again, if=
=0A=
>> driver doesn't also call the function.=0A=
>> There's the corner case where the device come up at < max, goes away,=0A=
>> then comes back faster, but still < max. There will be two prints, but=
=0A=
>> they won't be true duplicates -- each one will indicate different BW.=0A=
> =0A=
> This is fine.=0A=
> =0A=
>>=0A=
>> Alex=0A=
>>=0A=
>>>>>> +=0A=
>>>>>>  =A0=A0=A0=A0=A0 if (pci_probe_reset_function(dev) =3D=3D 0)=0A=
>>>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 dev->reset_fn =3D 1;=0A=
>>>>>>  =A0 }=0A=
>>>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h=0A=
>>>>>> index abd5d5e17aee..15bfab8f7a1b 100644=0A=
>>>>>> --- a/include/linux/pci.h=0A=
>>>>>> +++ b/include/linux/pci.h=0A=
>>>>>> @@ -1088,6 +1088,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps)=
;=0A=
>>>>>>  =A0 u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_de=
v=0A=
>>>>>> **limiting_dev,=0A=
>>>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum pci_bus=
_speed *speed,=0A=
>>>>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enum pcie_li=
nk_width *width);=0A=
>>>>>> +void __pcie_print_link_status(struct pci_dev *dev, bool verbose);=
=0A=
>>>>>>  =A0 void pcie_print_link_status(struct pci_dev *dev);=0A=
>>>>>>  =A0 int pcie_flr(struct pci_dev *dev);=0A=
>>>>>>  =A0 int __pci_reset_function_locked(struct pci_dev *dev);=0A=
>>>>>=0A=
> =0A=
=0A=
