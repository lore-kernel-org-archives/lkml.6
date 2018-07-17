Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B73ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E7620693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iW2Fl/d5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OhvHJ25+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E7620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbeGQVlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:41:08 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36933 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbeGQVlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531861599; x=1563397599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=977EyK1MEJMb/FiZme4dC3HIbxN0U/mFS1NWlfnfKtc=;
  b=iW2Fl/d5StUF93WhuXAPM9Cuz7/yC187zAob4XlGdbuiWrHDtnRU/PTD
   HWrq831ISAZpVKrzwTFswGkY/gCxJ5hXnM6XgmAhZAgUe8eNnyhqWOW14
   XUaZY/GFJKJXxc2X96uuux1o0YvTmZQVyIsHBsrGP36q4waOuhqCwOl+t
   I+SIfYJkwANe1WETqe7lCieeV7aZBasmIHJGE8gfCSFZAhyiyS3TTDuXs
   YRoplbOwW248pxDZedN8GQCo18bh8PNh5LRE5zJvZrBWTdLmhwcdEXqL4
   o2RxYaGJAK8nQge0+nMjZ5RXslup1RFHhbp3kKrA6bVekeblqcQQ1JiqL
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,367,1526313600"; 
   d="scan'208";a="187795536"
Received: from mail-sn1nam02lp0015.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([216.32.180.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2018 05:06:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=977EyK1MEJMb/FiZme4dC3HIbxN0U/mFS1NWlfnfKtc=;
 b=OhvHJ25+IBzQQLMdCEQsDpQysVDlIqOovkVRZc2bjnjD/A6PrREw3z6Zj0j0O5GQ/3ueQqNyhhQSkZfnvU4uDUeCO1XY0t4gpXNA46ZtweKi2LHFIbUOLJp6s23uPXl+ywohflGlzjn7PlOSFu3LTrOAlj7zT/9llCO6H2K0hX0=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB1039.namprd04.prod.outlook.com (10.174.250.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Tue, 17 Jul 2018 21:06:35 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0930.022; Tue, 17 Jul 2018
 21:06:35 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "evgreen@chromium.org" <evgreen@chromium.org>
CC:     "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs
 provisioning
Thread-Topic: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs
 provisioning
Thread-Index: AQHUFPGUXhOvLaP+Fk+rdyg77FCdGqSHMD2AgApewYCAAQWrAIAABPAAgAFUl4CAAAwCAA==
Date:   Tue, 17 Jul 2018 21:06:35 +0000
Message-ID: <aa697186c00937c18519fe5eb1355d3fc458cfb6.camel@wdc.com>
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
         <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
         <CAE=gft5U1-Jo-GvTF7sNAV3Q565AmuUrHpmBdxUL+UwkKxesqA@mail.gmail.com>
         <0dce9e9c-4f93-9857-72ee-f65ff195c41a@codeaurora.org>
         <CAE=gft6_=SQjgv7_kHXKJKa8_45NKKFwwE7UaXsijPpMd35LOg@mail.gmail.com>
         <4cb931e199599314829f5ff750797c88fc123f1f.camel@wdc.com>
         <CAE=gft6zm2mw3rnNuktDe0NWs-NM1CFQw1BUeGhaBi3eoEDXBg@mail.gmail.com>
In-Reply-To: <CAE=gft6zm2mw3rnNuktDe0NWs-NM1CFQw1BUeGhaBi3eoEDXBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1039;7:nRggDUn2f3Jvn5WFZjRYEQNfzjEBHxfy+hPuwddNXtmTHYxb5MhBXq4Lj3cgVviduGYvWbpVNPhj6t0IcpcTVVZDYSP4R5N8m+GTgZSP2RTnIdDNFCV+L28AfgZl82kqxM5Db6omVgPjRyd5fVFJSPmqRHdJ+vZn1AL9uNvul5dvmB9SMkKlkkRSxhS+bb1SDKG/eWIfDl8qma1MiVQ9UOsi/Zqr3pbKdvDg21qi82VgV8gqzLyjz2E/z6fEuWlc;20:CwJ0rnTeaq3MUyZGQ9322/PCOQPvxpuqRr7y55vChoeNhlqX03agh2aOcoJmIrUk5hcGSP4Q6zXmStleHRb9zlFEzqwh+rGJSSV+wVSSGYiY7zbI4sYqHHiijf4feB0BeNZaHTbA44IHubwzvaOMWn5yxqfSnMFzf+mN8kiniSQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 006e1a6f-1b4c-41a8-4265-08d5ec292e5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1039;
x-ms-traffictypediagnostic: MWHPR04MB1039:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB10392A96AF7496862A237B19985C0@MWHPR04MB1039.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1039;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1039;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(396003)(366004)(376002)(189003)(199004)(51444003)(2616005)(76176011)(316002)(86362001)(14454004)(6486002)(229853002)(6512007)(11346002)(26005)(97736004)(36756003)(66066001)(486006)(446003)(476003)(5640700003)(186003)(6506007)(6916009)(6246003)(53546011)(6436002)(102836004)(118296001)(39060400002)(4326008)(6116002)(54906003)(3846002)(25786009)(256004)(8676002)(2906002)(2351001)(93886005)(1730700003)(7736002)(8936002)(5660300001)(2501003)(5250100002)(106356001)(53936002)(478600001)(2900100001)(7416002)(72206003)(305945005)(105586002)(99286004)(68736007)(81156014)(81166006)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1039;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 984yTlDgReHDKlrqCv17p+wJxJ5q9bSh1UT/aq6DCVOm6r2ya8oOKZcak62TZLANV5zB/oiEGixfsThTt7JAf2CdKz9AoxT2BDKRGkKhofi8A/glmTAkfYCj4pk6RrCdPmz5DhyWsUXqO4ppBnGPrh7OMWuAdGQPh42X5EMhxOH7aCbdjB3kVVj7K5KySX9EyO9Q9Uufwi1v6h30tdKC7CA2+9VEUPbrlOmxxMN7Zed+Qk1U+bXUPFo6ZtWOIgpl6Wj1AbRXx/NX637etamJ39qdUKc8ztsBMe8xZGAkUiAS4I63LaVrMO7/QKhmzohS15TGmw54gHPyPmOhu0Va7REFGJulvLxzh5t40ZqUSrE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <3B7F1202B91B544A8F3C950A9A38DADB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006e1a6f-1b4c-41a8-4265-08d5ec292e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 21:06:35.6618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 13:23 -0700, Evan Green wrote:
+AD4- On Mon, Jul 16, 2018 at 5:04 PM Bart Van Assche +ADw-Bart.VanAssche+A=
EA-wdc.com+AD4- wrote:
+AD4- +AD4-=20
+AD4- +AD4- On Mon, 2018-07-16 at 16:46 -0700, Evan Green wrote:
+AD4- +AD4- +AD4- I see Bart has chimed in on the next series with a sugges=
tion to break
+AD4- +AD4- +AD4- out each field into individual files within configfs. Bar=
t, what are
+AD4- +AD4- +AD4- your feelings about converting to a binary attribute? I r=
emember when
+AD4- +AD4- +AD4- I did my sysfs equivalent of this patch, somebody chimed =
in indicating
+AD4- +AD4- +AD4- a +ACI-commit+ACI- file might be needed so that the new c=
onfiguration could be
+AD4- +AD4- +AD4- written in one fell swoop. One advantage of the binary at=
tribute is
+AD4- +AD4- +AD4- that it writes the configuration atomically.
+AD4- +AD4-=20
+AD4- +AD4- Hello Evan,
+AD4- +AD4-=20
+AD4- +AD4- I may be missing some UFS background information. But since a c=
onfigfs interface
+AD4- +AD4- is being added I think the same rule applies as to all Linux ke=
rnel user space
+AD4- +AD4- interfaces, namely that it should be backwards compatible. Addi=
tionally, if
+AD4- +AD4- anyone ever will want to use this interface from a shell script=
, I think that
+AD4- +AD4- it will be much easier to write multiple ASCII attributes than =
a single binary
+AD4- +AD4- attribute.
+AD4- +AD4-=20
+AD4-=20
+AD4- Hi Bart,
+AD4- I'm unsure about the compatibility aspect for binary attributes that
+AD4- essentially represent direct windows into hardware. I suppose this
+AD4- comes down to who this interface is most useful to. Hypothetically
+AD4- lets say a future revision of UFS adds fields to the configuration
+AD4- descriptor, but is otherwise backwards compatible. If this interface
+AD4- is primarily for OEMs initializing their devices in the factory, then
+AD4- I'd argue they'd want the most direct window to the configuration
+AD4- descriptor. These folks probably just have a configuration they want
+AD4- to plunk into the hardware, and would prefer being able to write all
+AD4- fields over having some sort of compatibility restriction. If, on the
+AD4- other hand, this is used by long-running scripts that stick around fo=
r
+AD4- years without modification, then yes, it seems like it would be more
+AD4- important to stay compatible, and have smarts in the kernel to make
+AD4- writes of old descriptors work in new devices.
+AD4-=20
+AD4- At least for myself, I fall into the category of someone who just
+AD4- needs to plunk a configuration descriptor in once, and would prefer
+AD4- not to have to submit kernel changes if the descriptor evolves
+AD4- slightly. It also seemed a little odd that this patch now spends a
+AD4- bunch of energy converting ASCII into bytes, just to write it without
+AD4- modification into the hardware, and convert back again to ASCII for
+AD4- reads.
+AD4-=20
+AD4- We plan to use a script for provisioning, and could easily handle
+AD4- ASCII or rawbytes:
+AD4-=20
+AD4- +ACM- Some bytes, ready to go with the interface today...
+AD4- some+AF8-bytes+AD0AIg-00 01 02 03+ACI-
+AD4-=20
+AD4- +ACM- Same bytes, now in binary format
+AD4- bytes+AF8-fmt+AD0AJA-(echo +ACI- +ACQ-some+AF8-bytes+ACI- +AHw- sed '=
s/ /+AFwAXA-x/g')
+AD4- /usr/bin/printf +ACIAJA-bytes+AF8-fmt+ACI- +AD4- /configfs/ufs+AF8-pr=
ovision
+AD4-=20
+AD4- I'm not dead set on binary, since as above I could do it either way,
+AD4- but it seemed worth at least talking through. Let me know what you
+AD4- think.

The configfs documentation (Documentation/filesystems/configfs/configfs.txt=
)
is clear about this: +ACI-Preferably only one value per file should be used=
.+ACI- So
I would like to hear the opinion of someone who has more authority than I
with regard to configfs.

Bart.=
