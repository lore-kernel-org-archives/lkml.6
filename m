Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C2FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547672083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ki7NQbNv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ayVErOBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547672083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJPRdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:33:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23467 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJPRdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1539683038; x=1571219038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x7iYzoYLrBUeoBGVS2Yup4OQ/h0/gjkeCO2KoEj3ADA=;
  b=Ki7NQbNv3mDpv0vIMccejlunvJTldD7aJb9j064rnSQpqRdYk1mxgu0m
   /LeihJGx2FSVjNbseHvZNfAg7km63Kkg7HT4OX01nwoiBCpc6jtVhFC9T
   O0hmieVLOqQ0UYCeN9MLdvjJGHJyCE9J9Dt2HSy/QpJa+5cbIKaOlZnm4
   Ovqq9ZxLxG2JzbkqAv08ISyzYq7Gu9d5PPDRO+TpkONe2zQsIl9WMxkYd
   JfIleOUzsdJq9HV2XYzx8oTN0sdV+2ayIV5g24iCJc/TgLtlXdSFJjzyd
   GECUmqMjT6WmMhrwTGxNz2qEit/dlSAyJHJh+i5Q4p7B8qFyJDLwRGexU
   w==;
X-IronPort-AV: E=Sophos;i="5.54,388,1534780800"; 
   d="scan'208";a="189736082"
Received: from mail-dm3nam03lp0024.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([207.46.163.24])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2018 17:43:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m7BQzAv3qbT7/zYBLFVHh6j+hrRXsCF0KnjlvF9oaA=;
 b=ayVErOBn/QkBXcyd8U8VRbe6mg5AjCg6DfjbbQcl/10pDVYpCg7rcWRb9bMBmf1dIv88t6rJvpYNb+HiP8yOS2+SFxo1OWULm5nRAkAkjQbDJiYkG4yz3My5TVPWKpGtldr0KjBdwcCExP5tfJeYhvhl6e++hpTreSWv7ZQppHE=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB3887.namprd04.prod.outlook.com (52.135.81.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Tue, 16 Oct 2018 09:43:22 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b%2]) with mapi id 15.20.1207.029; Tue, 16 Oct 2018
 09:43:22 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Sayali Lokhande <sayalil@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>
CC:     "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V15 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
Thread-Topic: [PATCH V15 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
Thread-Index: AQHUZS6yWdXtF8Xv/EKOPhITRBmlpaUhm2pA
Date:   Tue, 16 Oct 2018 09:43:22 +0000
Message-ID: <SN6PR04MB4925BBEF6D9360B64DCF7F88FCFE0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1539680382-31136-1-git-send-email-sayalil@codeaurora.org>
 <1539680382-31136-3-git-send-email-sayalil@codeaurora.org>
In-Reply-To: <1539680382-31136-3-git-send-email-sayalil@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB3887;6:HhvMzLp9ojpoGGZzUgEniwiBlVRe7UET5qaMZGQdD/5Pj7KxSujjY7R3rN6QFZji07Y7xX/VNHPwuHdfCyQAEps1UVR3TwkuDhV6FFY1KurvKW4miH6Arddl9bUwgAGnVHLjkMJM3aDUg5zi/XKoImvNGior6SB7maKzG0T+N8K4oOjTHJEmgB37qIZonTBjOLjv5vMhbldV3uwJbgw8GEDxqPAw2oKJ7VI8ap+sYOIn3+wLtsHfHK+iR+NtnUmtJD0ul2vobP53x9PzOZG9Djje4LDfhcNwQXld8yIQKati5uIfzIaUy9c+0wSWu5S60144T8o+eYPQRmLirXX782MUVua4TUv5v/Pee6ZAYivto0XelfzLrbdX+qfSMSMlNQdvtrpbWtItu5f8KkUyJik9L2fvsq+atVM52+cAyqoFTHQC8FC4OLcwijcGYaXMnbGp38QTzupH2rjoOiitXQ==;5:LvrFouR1KANmBy73g6wO56oE2lkyV+11D2isrMEIJEF6gSu/vmlHruorX4qh8ttKYIA8voPrmbKZJsds2PhVBj1vC9SF0kNXdvRA1kOKroG80amop4X+6RPRLrd2THChRR9ckawbKzwvp8pyiJknEaktSLEp6qeUQUWWLYwBuZs=;7:VdBDvwaXk4eBxazSeMCa0zUnDIXuJyY0J/iEnr7hKD9LZw7qUdK5JdmIWzVJrlonupsM6ykVmvsEfoWXSvisSeFz3VokuGKtLm/RsT+nQvuOOCtyCNatS01NubhsZ5i8NgLtvVRg4ly/K0sV19cCqUrSqUcGZttfN+ibAErkxUFxv8M4mPL62QKaB4IxYFEwE7G/iUZycOLNjZ0le9l4lxezHdsMc1ebKcbGZ1YyHjNqP9ACMUBeo72cX+Si+WIb
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 46daa4c7-fad1-446a-f9f8-08d6334bd01f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB3887;
x-ms-traffictypediagnostic: SN6PR04MB3887:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB38876DA93C8890E54D34D1E1FCFE0@SN6PR04MB3887.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:SN6PR04MB3887;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB3887;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(316002)(71200400001)(68736007)(71190400001)(66066001)(5660300001)(256004)(25786009)(6246003)(7736002)(4326008)(39060400002)(97736004)(305945005)(5250100002)(81156014)(2201001)(2501003)(86362001)(8676002)(81166006)(8936002)(74316002)(14454004)(72206003)(2906002)(6346003)(26005)(186003)(102836004)(478600001)(7416002)(2900100001)(6436002)(9686003)(55016002)(53936002)(476003)(486006)(446003)(11346002)(229853002)(3846002)(6116002)(54906003)(33656002)(99286004)(6506007)(110136005)(7696005)(76176011)(106356001)(105586002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3887;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-microsoft-antispam-message-info: 9RLN4lrMP98Yz3qIGdKvRn3qRnL8eMBObrrbsQNhZAI8+OFf4Hu+JqXdhIK9qVVOsqe3WveFFyfOo9Xfg1fyDq6SoNpo+UOO4ICcbusPN7ku8Fpcy0LjUnCTkJJqmjtucvMFBvuv9AQQh5uDP4wZUqQdsqruaumbl2xUEObShmY3BGsPLWyZGMcSILDY/cA6x5y1jDvI0Qz2GmRoCBR25HCdlw/HKE7fJXLxRd8rOgUIXYkN/6+6vWQMkMHFbQWD3PTn5FSwQ0yhfXeQNnhrc9rwMU0NM68bZeBsVQbd+x796D1qk1036rNI/OKhV3PxostUE8KVfZ4MqEvmbQbtyoTN26cnsg2+QRbN7bgB+Ww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46daa4c7-fad1-446a-f9f8-08d6334bd01f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 09:43:22.5693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3887
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> +++ b/drivers/scsi/ufs/Makefile
> @@ -4,6 +4,8 @@ obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) +=3D tc-dwc-g210-
> pci.o ufshcd-dwc.o tc-dwc-g210.
>  obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) +=3D tc-dwc-g210-pltfrm.o
> ufshcd-dwc.o tc-dwc-g210.o
>  obj-$(CONFIG_SCSI_UFS_QCOM) +=3D ufs-qcom.o
>  obj-$(CONFIG_SCSI_UFSHCD) +=3D ufshcd-core.o
> -ufshcd-core-objs :=3D ufshcd.o ufs-sysfs.o
> +ufshcd-core-objs-y :=3D ufshcd.o ufs-sysfs.o
> +ufshcd-core-objs-$(CONFIG_SCSI_UFS_PROVISION) +=3D ufs-configfs.o
> +ufshcd-core-objs :=3D $(ufshcd-core-objs-y)
This will work, but I think it should be:
ufshcd-core-y                          +=3D ufshcd.o ufs-sysfs.o
ufshcd-core-$( CONFIG_SCSI_UFS_PROVISION) +=3D ufs-configfs.o

Also, you may want to rebase your patches with Martin's 4.20/scsi-queue

Thanks,
Avri
