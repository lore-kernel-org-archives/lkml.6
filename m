Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83C6C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F7220841
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Uf4EMZF4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I5SZawci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F7220841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeHBFPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:15:14 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:9793 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeHBFPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533180374; x=1564716374;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JMBXTx08Ycek8BkE5WBlXwuO54uQTVUZ87SlVu+PcDw=;
  b=Uf4EMZF49rj0MmhJoGIEVDfv9SCoQyw7gBlMP+Ze2j1H664/rsRjkpkw
   wf4c0wFybe94Tp67errFeHtc7kiFMa6kO2YmID71J4IiovPqTB1nEY9eC
   DVdGEiwR4uc5xKAEzFgUTuI+sVSSES1tRmiq8cNn1PLeN0qPa6XaOG1AO
   lXIwbfFddV9P8B0slb2NDSf29o/Ea4xPGQUb9v02I6f0kDKpvRhoozZkk
   yek9/kB6tD0532Og5Yn+/eK7vHqjJ/LxolglTcwKQy4VL9RQ4QtnmT8wi
   zPdeTIA8RCSXPRKWW99xDvhKrikawcxKWJD/E3b/vPjhx03pbAw2sIsFT
   w==;
X-IronPort-AV: E=Sophos;i="5.51,434,1526313600"; 
   d="scan'208";a="87412286"
Received: from mail-sn1nam04lp0088.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([216.32.180.88])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2018 11:26:13 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB79RuAW2bs4dtKqhjBRoPZ2OqA9908rYempJ3QgZW8=;
 b=I5SZawci1nlTLrEqJ+AtM4BOm/uAO45lVmfC3ZUmypgN5HI3NLja1sMyp3PzOk69ZaooABksYdDwGE9/Xxf0U81Z7sm0/lXUERSkvlcZT2yiRTYvT+c1uBK7gcncGCx9oWCSI0A7XpRf2MDJpfF5m1L/DZYltD1Ff8fusdTcNxs=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB3776.namprd04.prod.outlook.com (10.172.169.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 03:26:10 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%8]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 03:26:09 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "zhongjiang@huawei.com" <zhongjiang@huawei.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>,
        "schmitzmic@gmail.com" <schmitzmic@gmail.com>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>
Subject: Re: [PATCH] scsi:NCR5380: remove same check condition in
 NCR5380_select
Thread-Topic: [PATCH] scsi:NCR5380: remove same check condition in
 NCR5380_select
Thread-Index: AQHUKg/8sM4iiOMyEEGz0MOO3scjyaSrzPoA
Date:   Thu, 2 Aug 2018 03:26:09 +0000
Message-ID: <c99a75a2905c1eef50f94ccc0871c36af431e21a.camel@wdc.com>
References: <1533179408-20631-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1533179408-20631-1-git-send-email-zhongjiang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB3776;20:uKizIJB/xouknosEeATOwnNfVDHav0Ikngjb1Ts5XTzFICeB2BTwN+OmdSxhx61r56WG93zavSnzwD53ZBKsRHHV0VQ8Jeo3V65ED8tVA+LNxvWtXV3S31o0f7UD+ppOmEng8jPQ5QHypYXILiBCQ/Ky27xEJbMjv28DB81nSkA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ff5e89b6-c53d-4af4-82fc-08d5f827b102
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB3776;
x-ms-traffictypediagnostic: MWHPR04MB3776:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB37766D0055DCFC2992E9BBA6982C0@MWHPR04MB3776.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB3776;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB3776;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(54906003)(99286004)(486006)(118296001)(14454004)(11346002)(14444005)(76176011)(39060400002)(478600001)(256004)(2616005)(446003)(68736007)(106356001)(66066001)(305945005)(25786009)(105586002)(110136005)(316002)(476003)(4326008)(36756003)(229853002)(8936002)(97736004)(6486002)(186003)(7736002)(8676002)(6116002)(3846002)(6512007)(6506007)(102836004)(5250100002)(53936002)(2906002)(81156014)(81166006)(26005)(575784001)(86362001)(2900100001)(2201001)(5660300001)(72206003)(6436002)(6246003)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB3776;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NwlO1TPz3nJqRs519lbZ7B0j9S5nUWv8CdHQArXhvvnlITDTFjWaiixG/cSOUh4Zw6Xx5XMVxuXfQgUDjidrUD9WqeQEtvE/QucZ5JGCl0iPaC6MlJgeUd1LXm8IvpfaP0+o/TgPVbrCjNVE7613biiPCOYsd2UTSags7aIOT+oPoZDsED1juv1Xu8URXYGvbn4K8EPqnpD3NIlr5UL54/obEfQwULWFu6asAgGg7pqjXt0wZclxuxFn4yNq4Ea3PplnlnO6J7BNuAFPR9N3bXT1sLCO3A00/8z9vla1bisf3xABeWjCOJP7KeFA4HcTRL2tBwjsh++VC4kTRftZmGUKGkkZuaDm/IKcXjRbQ6g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <5F69C00D377E604BABA0BE272B4F5C93@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5e89b6-c53d-4af4-82fc-08d5f827b102
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 03:26:09.7750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB3776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 11:10 +-0800, zhong jiang wrote:
+AD4- The same check condition is redundant, so remove one of them.
+AD4-=20
+AD4- Signed-off-by: zhong jiang +ADw-zhongjiang+AEA-huawei.com+AD4-
+AD4- ---
+AD4-  drivers/scsi/NCR5380.c +AHw- 3 +---
+AD4-  1 file changed, 1 insertion(+-), 2 deletions(-)
+AD4-=20
+AD4- diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
+AD4- index 90ea0f5..2ecaf3f 100644
+AD4- --- a/drivers/scsi/NCR5380.c
+AD4- +-+-+- b/drivers/scsi/NCR5380.c
+AD4- +AEAAQA- -999,8 +-999,7 +AEAAQA- static struct scsi+AF8-cmnd +ACo-NCR=
5380+AF8-select(struct Scsi+AF8-Host +ACo-instance,
+AD4- =20
+AD4-  	/+ACo- Check for lost arbitration +ACo-/
+AD4-  	if ((NCR5380+AF8-read(INITIATOR+AF8-COMMAND+AF8-REG) +ACY- ICR+AF8-=
ARBITRATION+AF8-LOST) +AHwAfA-
+AD4- -	    (NCR5380+AF8-read(CURRENT+AF8-SCSI+AF8-DATA+AF8-REG) +ACY- host=
data-+AD4-id+AF8-higher+AF8-mask) +AHwAfA-
+AD4- -	    (NCR5380+AF8-read(INITIATOR+AF8-COMMAND+AF8-REG) +ACY- ICR+AF8-=
ARBITRATION+AF8-LOST)) +AHs-
+AD4- +-	    (NCR5380+AF8-read(CURRENT+AF8-SCSI+AF8-DATA+AF8-REG) +ACY- hos=
tdata-+AD4-id+AF8-higher+AF8-mask)) +AHs-
+AD4-  		NCR5380+AF8-write(MODE+AF8-REG, MR+AF8-BASE)+ADs-
+AD4-  		dsprintk(NDEBUG+AF8-ARBITRATION, instance, +ACI-lost arbitration, =
deasserting MR+AF8-ARBITRATE+AFw-n+ACI-)+ADs-
+AD4-  		spin+AF8-lock+AF8-irq(+ACY-hostdata-+AD4-lock)+ADs-

Has this patch been tested?

Thanks,

Bart.

