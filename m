Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 53E9DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22B5208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="RPyJDSf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22B5208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeFNFlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:41:04 -0400
Received: from mail-eopbgr710063.outbound.protection.outlook.com ([40.107.71.63]:51200
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752176AbeFNFlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mya6TDLdY9wpTIaBQ6+RgfmFU5imEB6QQuffY+A3bm8=;
 b=RPyJDSf3lz0Ix9S23PSK/rVVlLYy4ujvahkGpfWD5TNE+9VkUFjGGmjojYtztp/ECt0AMk5Q4GGKWO0hNdeHe8IrOom+QE0vAn7BMXJ6oQCr0AGyEME6RkHoN+O5/GWJBOPws+ZPocEetCDw0uf4nPlulUKUdebf6Db2dFuEg08=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4565.namprd05.prod.outlook.com (52.135.204.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.12; Thu, 14 Jun 2018 05:41:01 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7%3]) with mapi id 15.20.0884.010; Thu, 14 Jun 2018
 05:41:01 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] vmw_balloon: fix inflation of 64-bit GFNs
Thread-Topic: [PATCH v2 1/7] vmw_balloon: fix inflation of 64-bit GFNs
Thread-Index: AQHUA1rKRrCKY1+zA0yfk4OBeCrKzqRfOPoAgAAE24A=
Date:   Thu, 14 Jun 2018 05:41:01 +0000
Message-ID: <485C5DF2-52FB-487C-AF65-096D74E9416B@vmware.com>
References: <20180613135412.81660-1-namit@vmware.com>
 <20180613135412.81660-2-namit@vmware.com> <20180614052336.GA29739@kroah.com>
In-Reply-To: <20180614052336.GA29739@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4565;7:PxQ/2iwDocK5jqo5atX3FGJ14v8EED02iX2mFAByQ7gFXzVWaRRprVc2RKTqpOV+FeH0f56OBE7x3SepHS66M7D+YAKCojsAGdd3qdr0yGDAOiBPsp1o9A9oeXkMJxNKOIqViuixQJXyF8KH/mUfP0akIktdQlnRx3yHnrN+u7FTin3w6BQkqhDt/muWJ6ffuYfh0Et2FyvkNqjNCsGkJFFmbl/QANQxxKSW9pCrXgjPLNgnAYs9sS2w9IcAnDnU;20:zbr6KHVI3km+Y3Z2pRF/1MxbuXnAO+42yVJ+m6+WMa1w+X55B1GjAoN39rLfLVL5iqkEJICjRWjebOQn2MALDMxTdHIcLMQ0Pq4mFqgbHqzmsF7C54qA/+QnVue4efx1iN5b7kN2aPbojmOeSbudd7VCU7tjABfW2GZ4FE0c38o=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9561e181-bcb6-4a83-d9be-08d5d1b969ae
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4565;
x-ms-traffictypediagnostic: BYAPR05MB4565:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB45651FD17A4304A0F2749CCCD07D0@BYAPR05MB4565.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4565;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4565;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39380400002)(376002)(346002)(39860400002)(366004)(396003)(189003)(199004)(97736004)(8936002)(36756003)(8676002)(5250100002)(66066001)(2900100001)(3846002)(6116002)(446003)(99286004)(11346002)(68736007)(82746002)(476003)(83716003)(2616005)(5660300001)(486006)(86362001)(81156014)(575784001)(81166006)(26005)(6506007)(59450400001)(3280700002)(186003)(76176011)(102836004)(478600001)(6486002)(6916009)(14454004)(33656002)(3660700001)(229853002)(4326008)(6246003)(2906002)(305945005)(7736002)(106356001)(6512007)(316002)(53936002)(25786009)(6436002)(105586002)(54906003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4565;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JIRiMQCi5dqYOVc7RoSegAV+U4s47fmjkFZY4B0Wtz44hBOggqxgQIq7UaINNy73LjywHwIY79p7MivnrHoA+NyuWc17nOWaM/NoyqXlx8ufz6wLVUJDCcUtRLz482yqGZhgrsHYRKiDuIeESzsP46db0CwTzQ2agTZo6vHhcOJomwni0IFdEuq4ZrZ00Ta+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A7BD22A9339304FA901D22B3129BC1C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9561e181-bcb6-4a83-d9be-08d5d1b969ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 05:41:01.2973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4565
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 10:23 PM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Jun 13, 2018 at 06:54:06AM -0700, Nadav Amit wrote:
>> When balloon batching is not supported by the hypervisor, the guest
>> frame number (GFN) must fit in 32-bit. However, due to a bug, this check
>> was mistakenly ignored. In practice, when total RAM is greater than
>> 16TB, the balloon does not work currently, making this bug unlikely to
>> happen.
>>=20
>> Fixes: ef0f8f112984 ("VMware balloon: partially inline vmballoon_reserve=
_page.")
>>=20
>> Cc: stable@vger.kernel.org
>=20
> Again, no blank line between these things.
>=20
> Also, please break this up into two different patch series.  One for
> 4.18-final and one for 4.19-rc1.  You should always split up bugfixes
> from new features/cleanups as that is what I have to do when sending
> them to Linus.

I have only sent what I thought is appropriate for 4.18 (cleanup/features=20
will be sent separately):

* 5 bug fixes (1-5/7)
* 1 update the maintainer list (7/7)
* 1 update to the comment to prevent checkpatch from complaining (6/7)

If you think any patch is unsuitable to 4.18 - please say which.

Thanks,
Nadav=
