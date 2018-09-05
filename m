Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A12C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC8920659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="hfQMAXRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC8920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeIFBh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:37:57 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:52206 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727303AbeIFBh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:37:57 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85L1Ckx011488;
        Wed, 5 Sep 2018 16:05:51 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp0116.outbound.protection.outlook.com [216.32.181.116])
        by mx0a-00010702.pphosted.com with ESMTP id 2ma40jb5s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 05 Sep 2018 16:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh4sXYzYbQOx0lfLipYQDQ9ieUGhU1vNS+39GXHbOus=;
 b=hfQMAXRp+mKuuh92+92D9lR+ObkQhj5SFQXGDZhHjK9Y5/rvj7YNSgKbySK7BbJPEGY3OsUl7bj3N/7z8EPEbXpNpMMBR7eBgdUZYv8KeJVWq04vVPOpj8xvFuPTcWd4XXCn/Utow6smMrlNXXJYfwAN6qZnY9xP039lMQOqDDo=
Received: from CY4PR04MB0296.namprd04.prod.outlook.com (10.168.167.141) by
 CY4PR04MB3752.namprd04.prod.outlook.com (10.172.138.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Wed, 5 Sep 2018 21:05:48 +0000
Received: from CY4PR04MB0296.namprd04.prod.outlook.com
 ([fe80::d4b:e9a2:5d0d:b2df]) by CY4PR04MB0296.namprd04.prod.outlook.com
 ([fe80::d4b:e9a2:5d0d:b2df%6]) with mapi id 15.20.1101.016; Wed, 5 Sep 2018
 21:05:47 +0000
From:   Rick Ratzel <rick.ratzel@ni.com>
To:     "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "udknight@gmail.com" <udknight@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julia Cartwright <julia.cartwright@ni.com>
Subject: Ensuring wall_to_monotonic is not positive breaks use case
Thread-Topic: Ensuring wall_to_monotonic is not positive breaks use case
Thread-Index: AdRFXC1b5gYoTSP1Rmmvagh9VXThfQ==
Date:   Wed, 5 Sep 2018 21:05:47 +0000
Message-ID: <CY4PR04MB0296FED0A64321B49AA527C69B020@CY4PR04MB0296.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.62.233]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR04MB3752;6:OANY991L0o8nX8ZHwQvEnzXJcfV4UEgtyfnuEiSjPHr2NcawYu0dpMe3l/7pG34wxuo3KXXs4GQ9IVAyKPjzbfKVQSgzpafMNxHrKwfB95ZLFzbRF/oTtbVpS5SuymjcFPAn8UIrDxvkcjRx8yjyZWLNnmNfM1zOJR6J8twPhY10bbL/vCqH0HhA4AXVhrkTBbABmQB7KIJ8BEBprByKGn1c9jomZ19+WjBPVLKxMM3YZk7gGPVQG9ditdjB7Rw19MYRu/0f02sPjTOFIeDXBszK7lQ5PUXjF7ApT38vDTiUJ7086iOPbTFy66sWKh8QyGQH4J5+mA0pAV2uui+2ruZCxYNngDmF5rE9oFBDXdmKv3XOZIu3SmpSSKars8h0FM0cuLO6eNYlWscs/4zMVVK4b1TUpqwzCZ2s/aG81qSyHH953qJ1dtW3jxd938eLxcdBu15kaIjevGlN14YyRQ==;5:S27IP5zUIYpinCUUJ6ERnuGCg24nygSQJj7l7OFoxa+byrxn6IqwvtqoMhq/d8T2O+mEE9LVRmvZv2VA0unOybyVcEP53lZqp53CGNTzeK2cx6hlxi44/KYLRHjBQ8ZPlX5GCvIUVOrsHod3hw+mlgLrOiopbupjE8KtglKm5Lw=;7:KwTdV2pQGtTla5v3vlfCZ1oVZ5aGuuE3hQJydfi9aE79VVa7+cPvS4F17IlN/nW7mBGL2EoqMdsfqag8luxBmpiB28Wt4Kk0lT/bXHlB4F14FDlB+puxB6Jj3giPZEX1xdCenFn/rZozSr6fqTjjvYmv7JqCqX1Awg2dWGJiWRQKgPudJ+6j3o5pI1qcLQajr9JMHvg4FkuQRLteli4uhjuRmQBNPzHecWGSi1lL5AvnzwSpz2TFU/uw6d3oq+QN
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(478694002)(2906002)(66066001)(966005)(6436002)(2900100001)(44832011)(5660300001)(486006)(53936002)(476003)(6306002)(68736007)(9686003)(55016002)(33656002)(81156014)(81166006)(74316002)(86362001)(305945005)(14454004)(106356001)(7696005)(2201001)(8936002)(105586002)(478600001)(99286004)(102836004)(186003)(6506007)(3846002)(6116002)(316002)(8676002)(7736002)(26005)(110136005)(54906003)(2501003)(39060400002)(97736004)(4326008)(256004)(25786009)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB3752;H:CY4PR04MB0296.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 791f53d4-efd7-4e87-a008-08d613735a61
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB3752;
x-ms-traffictypediagnostic: CY4PR04MB3752:
x-microsoft-antispam-prvs: <CY4PR04MB375275B2032463CD91D01E4B9B020@CY4PR04MB3752.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:CY4PR04MB3752;BCL:0;PCL:0;RULEID:;SRVR:CY4PR04MB3752;
x-forefront-prvs: 078693968A
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r0N6VOmQG6P76sxuMHwNFjnmiv8k4Ko+8yLsUJ5cWiOJ/ePVUnaRv3lI+RuDH4OYClip7E/GQ1ADmiehLma60NoCuDHfA7/w87dwmpvBCeGRxYW3Er0XyMMZey9vFcZbVSp++RKJQBE9qgHTGtFADpd9nCZs/C4XqF7hO1bh1gT+dOA6e/rVqzMbrjy/EK1W+WRa11+vt8FilJjwZPXfgahhnHCNDu5gfD2nH8RteYNLI7X362uuPmt7qVIwDhTKJXDbKGDFcsXmZ75hyGRjRC1ucf1lpKPmXLDY3OB1CkvtSWaBg5a+znJLjxn/1FzDpTpsrQsJlHdHkVYMZorjQda2K+wifHdSdGpeK3c4P1M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791f53d4-efd7-4e87-a008-08d613735a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 21:05:47.7236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB3752
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have a use case that was broken by the commit e1d7ba873555 (time: Always=
 make sure wall_to_monotonic isn't positive).  We've been reverting the com=
mit in our builds, but we'd greatly prefer a solution consistent with the m=
ainline.  We also think our use case isn't unique to us, and may become mor=
e common in the near future.

Our use case is as follows: we have devices that have no notion of traceabl=
e time and often boot up with a time value of 0 (the Epoch).  These devices=
 are networked and share time using protocols such as IEEE 1588 (PTP) or IE=
EE 802.1AS.  These protocols involve automatically electing a device to act=
 as the source of time for all other devices on the network (the "grandmast=
er" in PTP speak) to transmit its time to the other "slave" devices.  This =
common shared time is used as a means to synchronize I/O operations across =
all devices to create a distributed measurement or control system.  The dev=
ices often interoperate with other 3rd party devices that also share time u=
sing the same protocol, and may also boot up with a time very near the Epoc=
h.  We have no control over the 3rd party devices and cannot change the tim=
e that they boot up with, or the standardized algorithm they use to elect a=
 common grandmaster.

In this case, time is used only as a means to synchronize periodic operatio=
ns, where stable monotonically-increasing counts (this also implies no leap=
 seconds!) are all that's needed and traceability to a standardized timesca=
le is not necessary.

The problem arises when a device that's been elected grandmaster is sending=
 out time at or very near (maybe only a few seconds past) the Epoch, and a =
slave device has an uptime of, say, several minutes past the Epoch.  The sl=
ave device will never be able to synchronize to the master in this situatio=
n, since the master is sending out time values lower than the slave's Epoch=
+uptime lower bound.

The presence of an RTC helps mitigate this situation, but only if the RTC h=
as been set accordingly and its batteries have not failed.  We cannot guara=
ntee these conditions, and many of the networked devices participating will=
 not even have RTCs.

We're looking for suggestions on how best to proceed with a new change that=
 ideally both supports the use case described above, as well as addresses t=
he symptoms brought up in the initial commit (negative boot time causes get=
_expiry() to overflow time_t, and show_stat() uses "unsigned long" to print=
 negative btime).  Any thoughts on this would be greatly appreciated.

Link to initial commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3De1d7ba8735551ed79c7a0463a042353574b96da3

Thanks,
Rick Ratzel - National Instruments

