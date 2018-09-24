Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69EBECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E032145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="iziwvxJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E032145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbeIYABd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:01:33 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:58674 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728468AbeIYABd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:01:33 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OHpUv8024751;
        Mon, 24 Sep 2018 12:58:06 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp0082.outbound.protection.outlook.com [216.32.181.82])
        by mx0b-00010702.pphosted.com with ESMTP id 2mnmasdn9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Sep 2018 12:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvidT6bEaDyE7FDPreIhvmHWy/ihZAhqggsniPQKAAo=;
 b=iziwvxJQJ2iG0Yg9N3tt9Eu8tT9/j5COM8SaPm2DszN3I+jgx/rE6YNdMS5hNnvNZ8uiWmKaOaql96iaqgid10KAEGwiVcMVa80PKsyn0YqmKQlf4Bh6jXFywrBFu6FcifR5xxDTSCTVVUR8sMWwMH184a+AqkeGQa9SrLuo9o4=
Received: from BL0PR04MB4803.namprd04.prod.outlook.com (10.167.181.152) by
 BL0PR04MB4484.namprd04.prod.outlook.com (10.167.179.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Mon, 24 Sep 2018 17:58:04 +0000
Received: from BL0PR04MB4803.namprd04.prod.outlook.com
 ([fe80::1877:65af:118e:dccc]) by BL0PR04MB4803.namprd04.prod.outlook.com
 ([fe80::1877:65af:118e:dccc%5]) with mapi id 15.20.1143.017; Mon, 24 Sep 2018
 17:58:03 +0000
From:   Rick Ratzel <rick.ratzel@ni.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "udknight@gmail.com" <udknight@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julia Cartwright <julia.cartwright@ni.com>,
        Gratian Crisan <gratian.crisan@ni.com>
Subject: RE: Ensuring wall_to_monotonic is not positive breaks use case
Thread-Topic: Ensuring wall_to_monotonic is not positive breaks use case
Thread-Index: AdRFXC1b5gYoTSP1Rmmvagh9VXThfQAo12OAAcGKtgABynIDIA==
Date:   Mon, 24 Sep 2018 17:58:02 +0000
Message-ID: <BL0PR04MB480344DC24C9BD54C3F7F9629B170@BL0PR04MB4803.namprd04.prod.outlook.com>
References: <CY4PR04MB0296FED0A64321B49AA527C69B020@CY4PR04MB0296.namprd04.prod.outlook.com>
 <alpine.DEB.2.21.1809061605570.1570@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809151651290.1650@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809151651290.1650@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.62.233]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR04MB4484;6:/OFhQ5xIMWQmn4rRYuqAPoAR/g7w1E6m/lNjbEMWe9Yd0GOVpYPw0Xlq+7ixNEgOk5KAJFCv+1GKJm2SOU9vCYEpO9mH43QngZSTU52ReYYasxkzzm7lBnJw8mh5IOpjMVDTdX2lR68CrZBwrSSwAVilXBdKfd17DMZUtmj4Mqk7fLKRjxtUp9L6vlMBSsiTEj3DJsrBCNIPiuiNdzGtCa0bd8nfSsdGh9oAbZ2UCNYsb1pZ9qMCOveqkH3Vj6w1iSxiwtF89k/jVdeQwJIJhMMEgLum91gatj56JMI9HrltTaYmTuIqt3ruf6KD7/Fd81qIupKOLTE26QkkT35szVC1/y17NmjtN2ILH5pMaE1SIzk3UQbJcM7ZWs33EwzgB0femqzC7YOGz18FCRiqbGnYVm+DJ/1PmAVM+17rd0O5VXJR8OW9rx4XHRPmJLr27k/0pFWtHUJGlbz0gk7lzA==;5:qkPmgl58YBDgL0mhif1gRGI8XYLBnwe+Mk9aEsVS5tU9e4LCoFrdyR92k3mdMNhgsaTZSxPrxJrjwZxCTMCx18JA66EF2B/wAeHs3vQl+1n2K5bU0e8YxN71w95q5QNhLtQNlJCYCcy/bjvhVMF6yqU/rBw4HKltJJa/e3B1HfI=;7:/7hduV5CZadvOvAaQTRYfXctBl5JGss5LZomfuAVaqIoo9Pewd4oRllOtqpn1VaiUH4hTjYd63VCo+ZHbl2WAO2UHRM7ixuP6Prl2HJR9LtPE5fUh5LJRr8q4o+/3K4j1hcenZKfC4IPsZcbDtU/j7Mjjaa+3DKU2qjpsuKbhD0G0NnnDFVWJBE6NEzuiwadolW/1F3hYZLNrcukte37o0CXfIkyGkMXQ7lt7n9/5hN0Wvc9FAFKhMEBGMn8l+qo
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(366004)(346002)(396003)(51444003)(189003)(199004)(55016002)(4326008)(7696005)(99286004)(9686003)(71190400001)(446003)(76176011)(6246003)(478600001)(6506007)(74316002)(6436002)(8936002)(2906002)(97736004)(26005)(8676002)(6916009)(186003)(316002)(476003)(2900100001)(102836004)(86362001)(71200400001)(11346002)(305945005)(81166006)(6116002)(3846002)(33656002)(229853002)(54906003)(44832011)(81156014)(66066001)(25786009)(39060400002)(53936002)(14454004)(561944003)(5660300001)(105586002)(486006)(14444005)(68736007)(256004)(5250100002)(7736002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR04MB4484;H:BL0PR04MB4803.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: d951069f-72cd-44d4-0fe6-08d622474607
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR04MB4484;
x-ms-traffictypediagnostic: BL0PR04MB4484:
x-microsoft-antispam-prvs: <BL0PR04MB448418CFA15C0735D45FC4A59B170@BL0PR04MB4484.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(149066)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BL0PR04MB4484;BCL:0;PCL:0;RULEID:;SRVR:BL0PR04MB4484;
x-forefront-prvs: 0805EC9467
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4BteBAiW0WBAiKcnHXmMsfJXN9HBKtGkeNr8Snx3ycSUGBob5ACT9pWBGGHSflqpkbZTCZDP1l7QB5vTp+3LCeZSBsXSsVtr2OOV2tnGcWj1c1hXLD/2XAPMqE0N3xVBxaQ6IgsFrHczM09rd43i52GDPkS9KFlNbD0vXjSKyckd6A3rai3EWNMTj/o7Z7fABFoI7A2xX9W5keyHw6iJQrlvHvXfWgN0IKRG1iqikQmuRnQ63+UJ8D/5fpInuG+Ga/hq3RxyV+0hJ/BsGPGp4MB9dCqxc8F0pT0OBDoO/6iyx1aIjG9MQkAvV3F6Y2MgoC9bYYGGT93B5hQWFlQk83RO016sEGVncrDCiMiM8gg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d951069f-72cd-44d4-0fe6-08d622474607
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 17:58:03.1423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4484
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809240172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2018, Thomas Gleixner wrote:
> >=20
> > So reverting this is not really an option.

> Maybe we can :)

Thanks for checking into this more.  We've been looking at the uses you des=
cribed, and hopefully we can have something to submit for review (or at lea=
st discuss) relatively soon.

>
> We have 3 users in tree:
>
> 1) /proc/stat btime
>
>    It's trivial enough to clamp that value to 0, though it might be
>    surprising for some users as uptime will tell something different.
>

Agreed.

> 2) sunrpc
>
>    I think that can be converted to actually use CLOCK_BOOTTIME. This nee=
ds
>    a bit of trickery to preserve the user space interfaces which are
>    CLOCK_REALTIME based, but it should be doable.
>

It looks like this can use CLOCK_BOOTTIME as you describe, but "properly" c=
onverting to the REALTIME timescale might be hard, as you noticed. One prop=
osal is to floor the conversion to the Epoch, just like your proposal to fl=
oor /proc/stat btime to 0, but we're not sure how that'll impact users yet.

> 3) x86/kvm
>
>    That's actually the trickiest part of all and I haven't yet fully
>    analyzed it, whether there is an issue that time can go negative.
>
>    Actually there shouldn't be one as this is about wall time and that
>    cannot go before the epoch. Needs some close inspection and while it
>    might be trivial to adapt the code in question, it could be tricky or
>    even impossible to fix it without breaking existing guests.

We're still looking at this one as well...

-Rick


