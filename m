Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1637C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920F9241AA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="XiIpGr2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920F9241AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932509AbeFZRN5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:13:57 -0400
Received: from mail-cys01nam02on0067.outbound.protection.outlook.com ([104.47.37.67]:4160
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932261AbeFZRNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxL9BbJ6GfouLnQpGrchPxC5BglieKPri6FfMVsiaYw=;
 b=XiIpGr2rIzwmpMHn7YrT06vyFetOmmftXheHlfuTTjcY7bIbkiM6xt1/k+wuPlesHk746GjFBLZcxmKXhi/9XM7MQ8Fs3ZIIsO/CDsAUWdkybc+53rtG5JB/G5s+28G4mrt13m0eoDfUm7T2s70mXfBGiOs71Lu59uEIMJaRLL0=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4520.namprd05.prod.outlook.com (52.135.203.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.15; Tue, 26 Jun 2018 17:13:52 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c5f:4dd5:fff8:3333]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c5f:4dd5:fff8:3333%5]) with mapi id 15.20.0906.018; Tue, 26 Jun 2018
 17:13:52 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] vmw_balloon: addressing bugs and issues
Thread-Topic: [PATCH v3 0/7] vmw_balloon: addressing bugs and issues
Thread-Index: AQHUCF4RPLZ5XvTYjEOWPKcXf+lKpaRy0V0A
Date:   Tue, 26 Jun 2018 17:13:52 +0000
Message-ID: <09F9289C-9709-49CF-8592-48F1B4A2EF8E@vmware.com>
References: <20180619230030.112906-1-namit@vmware.com>
In-Reply-To: <20180619230030.112906-1-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4520;7:7WvaKLIxdwpvRkdP9sFfVbfY6mkakQ1wmpc8ojLaQhVRYu9iFxbhDNXRWunXsWwWwGEdCLL/3dlcyl70s3Ox3DK3RPn3KZbMg73EYvI94rNQoGQOkrSUm37+0xjoKh8FgAaqtACZmt0g60M9+QGzsajpd5QXlAQ6aykdEwxhcn4PbvKQ566kr/PuKaaiyMeT95yNeL7zndMb8ZWfuSjVzYAdUCYNkqYgs5/uJeOXOhEdJebidhlfC3ETd0d20qU0;20:gXSv6TQJ9DIiquCVnB3Vb4biIS4Yc5rN0KTGHei9WzqZMXBlpZi5jHfHbiTE4eCSLKLdXbS+qq36hgfi4p1KcwIxuUvlNbWN41Ih/gIX7ZGIq41J7ap4N3X9z6qWDrrBhHSYtrYldDgMuTvsW0++LaBCMU9eLZ8vxFxhH5ObVxA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9bd500c7-1470-46a3-5454-08d5db8830fb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4520;
x-ms-traffictypediagnostic: BYAPR05MB4520:
x-microsoft-antispam-prvs: <BYAPR05MB45202DE51BEFF0043C124621D0490@BYAPR05MB4520.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4520;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4520;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(346002)(376002)(189003)(199004)(316002)(6486002)(81156014)(7736002)(33656002)(54906003)(6512007)(6116002)(2900100001)(86362001)(99286004)(8936002)(81166006)(4326008)(25786009)(256004)(6436002)(3846002)(229853002)(305945005)(8676002)(5250100002)(36756003)(102836004)(106356001)(476003)(26005)(53936002)(486006)(478600001)(14454004)(186003)(2616005)(5660300001)(11346002)(446003)(82746002)(6506007)(2906002)(6246003)(83716003)(68736007)(66066001)(105586002)(76176011)(6916009)(97736004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4520;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: go0OH2kPu5dcZT/CP/50JqUEmy0gUKsJKsYij+Dqg9TiLgigBdpUIdB321evZVE4FOKBdpz7mH6jGcm1pNnLp78DdmP/3spO1esfV4boGYjKh4wWMMphg9Fby7zRL71coEwpHzs6Tq/dl692n4oaZZncDHCjM9pECHaE51AK2pr8LPGx6+Ofdvh9vhJp1DQdYXsLLHaJou3uD1p6i0bSRPRJ5vBaJ/r5HBPlDYyHLU3XRjKpYR7rT9CVpGiv0QR5/guc+J82qmDzOtayj8i5su3X0/F6566xbYPy5+cNqQ5xt8AH5lH12CIHbCv4mqxmxVkNV+qbFk/hUguA7sqQlvGeydblBaaEprVwwoS2VIo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <490E21FFE9A3FA42A52319D0AA62FE2F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd500c7-1470-46a3-5454-08d5db8830fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 17:13:52.4887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4520
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 4:00 PM, Nadav Amit <namit@vmware.com> wrote:

> All of these patches are intended for 4.18:
>=20
> - Patches 1-5 are bug fixes.
> - Patch 6 changes the GPL comment. It is actually required just to
>  remove the maintainers list from the source file (since it has
>  changed).
> - Patch 7 is an update to the maintainer list.
>=20
>=20
> This patch-set addresses minor issues and bugs in the VMware balloon
> driver. Patches 1-5 address bugs that were *not* reported by customers,
> but we would like to get them to 4.18 if possible.
>=20
> Patches 1-4 are cc'd to stable. Patch 5 might be too big to be
> considered for stable.
>=20
> We will send separately later a patch-set with new features to be set on
> top of this set, which will be intended for 4.19.
>=20
> v2->v3:	* Removing empty lines (Greg)
> 	* Removing the GPL message entirely (Greg)
>=20
> v1->v2:	* Reordering patches to have bug fixes first (Greg)
> 	* Fixing SPDX tag
> 	* Cc'ing stable when appropriate
>=20
> Nadav Amit (7):
>  vmw_balloon: fix inflation of 64-bit GFNs
>  vmw_balloon: do not use 2MB without batching
>  vmw_balloon: VMCI_DOORBELL_SET does not check status
>  vmw_balloon: fix VMCI use when balloon built into kernel
>  vmw_balloon: remove inflation rate limiting
>  vmw_balloon: update copyright message
>  vmw_balloon: update maintainers list
>=20
> MAINTAINERS                |   2 +-
> drivers/misc/vmw_balloon.c | 181 +++++++++++--------------------------
> 2 files changed, 55 insertions(+), 128 deletions(-)
>=20

Greg,

Any reservations regarding this version?

Thanks,
Nadav


