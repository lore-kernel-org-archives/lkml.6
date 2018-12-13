Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A525C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F6620870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="r7cGmVvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F6620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeLMTAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:00:20 -0500
Received: from mail-eopbgr750095.outbound.protection.outlook.com ([40.107.75.95]:13874
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbeLMTAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lsj33vFQdYj5aPxKXeyYZxA+ND3cmBOzKO9LrnSwmI=;
 b=r7cGmVvEb010fxOZUOGbM6nQCCiKlWHk8aPNKofmYSUJkqSke6fUxMDblEEQEp3XEU9hbDYHVG2cqvpAf1O8eKBDXqKsPvOwZyKHppqvUqEfEQ4lVq7p7iUXRKOiRDekRezTHQNB8C53mXtkl3YIdfmi61kCgnkgpkqHoV3KlTE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1358.namprd22.prod.outlook.com (10.174.162.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Thu, 13 Dec 2018 19:00:16 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 19:00:16 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 16/27] mips: define syscall_get_error()
Thread-Topic: [PATCH v6 16/27] mips: define syscall_get_error()
Thread-Index: AQHUkwiCMnDgH17LcEa/2ulDTss1d6V9BhiA
Date:   Thu, 13 Dec 2018 19:00:16 +0000
Message-ID: <20181213190015.olf6vhuimjl4jixs@pburton-laptop>
References: <20181213171833.GA5240@altlinux.org>
 <20181213172302.GP6024@altlinux.org>
In-Reply-To: <20181213172302.GP6024@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0054.namprd14.prod.outlook.com
 (2603:10b6:300:81::16) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1358;6:Tdb6FIURQVkTaOMUGZvi4AYNY9cCm7UmC2c1smY0hnzlBxZ/UuZ3QyZARcblqmZ5velg22WVqPt0aTT4E3jYDBFnd/qpZO/pX5eEAMp/AtlfbMocAOpZumJAe1UMxdQJ1wJMyJZNT55gXML0XTqXieG3lg1C49KZlFZvI5BrYaRJcYJZ9j9sjVSNwm2h0vxsaMhXNxQBCMRWGYscpjIUTPou4/1vpZzDMD+DxW4ea0vSIfsG6VYHwjkFn1iBrXO7RS4ffiPiiHhyQFxpTEeUmmTRQiY4A07QfuLBldpOGus4agWmtzueAQAe4/w/HwfTAmH4um+JMS8rOGSpyg6sOX+lgmW9NDJW9zkWS7cK39FgNcaHmKBLyTexpijV9SzIfkm7kofI6LQ0P/d5ZpSJxAPWMCfZy8WMGg+p/wDaOaRqiT+D4mpY6l3MMoOZ0c/Rmrr+WEytAwod/W4J6bLGqw==;5:kCYRXPAzrBDYMbhQW2u1vi3vs63NhFTPzt/9czvndCON7tUTP0DOsKP7pEvu6oJbsqT6HrevY516viHqTsUqALIz5jvO7jDMrlYLxTnK1caUD2wlZhbd2HIrN/21x727sS93T1HkdC/Mh1dOMG5o73TIs69tL33/aA8HViMoSjY=;7:8szzUSOIrg5LkcY+pjD0Oyt81m3B4HRBh95U7fOQEg1f9NH+JWEJ5lOLZtI5vezrr6nB5j9C/itLdRfMGLrfmvKMinwKSD5IjiyGahqe5v9ahfo7NFvavEKCPcWUYuX71iBlhV2WkGD2RJU6GHKsEg==
x-ms-office365-filtering-correlation-id: 1748eecc-ab9c-41a5-ca12-08d6612d37ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1358;
x-ms-traffictypediagnostic: MWHPR2201MB1358:
x-microsoft-antispam-prvs: <MWHPR2201MB1358E873C94C1110B51884A6C1A00@MWHPR2201MB1358.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(148016)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1358;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1358;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(39850400004)(136003)(346002)(376002)(199004)(189003)(316002)(6116002)(68736007)(446003)(305945005)(53936002)(6512007)(11346002)(9686003)(1076002)(66066001)(58126008)(33716001)(6246003)(105586002)(102836004)(4326008)(3846002)(99286004)(54906003)(106356001)(26005)(52116002)(386003)(5660300001)(186003)(33896004)(7736002)(76176011)(6436002)(6916009)(71200400001)(71190400001)(42882007)(81156014)(14454004)(81166006)(14444005)(8936002)(476003)(256004)(97736004)(8676002)(44832011)(508600001)(229853002)(25786009)(2906002)(6506007)(6486002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1358;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qgLJ9ODYlgmO6e8syJa4MXWpidyfywi9eZdbQMdzuCbRgG/37Lxkf4im2+MQg3UjOHO9g/JCoOkyxmQcnRiIl7o5gq+Dr4HUmO9EF0aSTfvYfQ0Qn+rduTqFAqko7MBxmJOmXwc706qhI1cJKBp/xQCa2NgDVbl65XFQbCMxWzrt9exZPI99Vj8xYf3cuRe9au5eNoEf6po95PxeGRJ53zeuEskTUWIgu14c7PPrRCs1/PReqVk7cnU8wS7PbIPafh4quiQ7AWODWRUfy2pvglDg14R2ZQgcSTifsew0V+BvKyy5eW6NsHrN7/cBfSuV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3EAF7152C6D1FF4FB79B95DEBDC01690@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1748eecc-ab9c-41a5-ca12-08d6612d37ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 19:00:16.5622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Thu, Dec 13, 2018 at 08:23:02PM +0300, Dmitry V. Levin wrote:
> syscall_get_error() is required to be implemented on all
> architectures in addition to already implemented syscall_get_nr(),
> syscall_get_arguments(), syscall_get_return_value(), and
> syscall_get_arch() functions in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
>=20
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
