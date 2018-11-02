Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C682AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACB62082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="SuofkqUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACB62082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeKBXUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:20:01 -0400
Received: from mail-ve1eur01on0070.outbound.protection.outlook.com ([104.47.1.70]:42416
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbeKBXUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRzNb5T6O235mfDEfwBiIRsxyZYrQMQAec+T2FOA+TU=;
 b=SuofkqUXXzvao9twdSYN6jvgMSSfWx0/GvPwxumtm4XHDKHtwr7WLIwXTtKQ4I71VR8JytN3J4mnxDyHObQdNMtUYRmtIB8yrgaT2oHcSHfPX0Rq9BUpKUVhUgeRnqJUql/kfFqBuUv+TlX0i5W5p6SCTtbjDkY/9CjhatxhNFs=
Received: from AM6PR08MB3686.eurprd08.prod.outlook.com (20.177.199.159) by
 AM6PR08MB2998.eurprd08.prod.outlook.com (52.135.163.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Fri, 2 Nov 2018 14:12:28 +0000
Received: from AM6PR08MB3686.eurprd08.prod.outlook.com
 ([fe80::2cbd:c62d:7b33:6d84]) by AM6PR08MB3686.eurprd08.prod.outlook.com
 ([fe80::2cbd:c62d:7b33:6d84%6]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 14:12:28 +0000
From:   Al Grant <Al.Grant@arm.com>
To:     "leo.yan@linaro.org" <leo.yan@linaro.org>
CC:     "acme@redhat.com" <acme@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Question: perf dso support for /proc/kallsyms
Thread-Topic: Question: perf dso support for /proc/kallsyms
Thread-Index: AQHUcleHgK1sdrL48kCD7i8o9dowk6U8YImAgAAfyYCAAAPWgA==
Date:   Fri, 2 Nov 2018 14:12:28 +0000
Message-ID: <AM6PR08MB3686181290347EC355AEDCF986CF0@AM6PR08MB3686.eurprd08.prod.outlook.com>
References: <20181102025516.GA25374@leoy-ThinkPad-X240s>
 <AM6PR08MB3686A4DD9B75B551885C790386CF0@AM6PR08MB3686.eurprd08.prod.outlook.com>
 <20181102134649.GB3983@leoy-ThinkPad-X240s>
In-Reply-To: <20181102134649.GB3983@leoy-ThinkPad-X240s>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Al.Grant@arm.com; 
x-originating-ip: [217.140.106.49]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB2998;6:DG7fcOsHUoGYs7D+0wOEZ6r+s/rPyKMoyyef65kUXX1+e9jlZg+b5YOv/0wTLjp3MNOrh4RZz3wuL1Px9KeYv1VMg6QyB5TLS7QtERIY0PkTQuaRH+rGzesF/Z7WoNsSlPTCfrhXHZwlrj0qx63TyAHX1HZYf9bTtbp8K8Q+gJcJCwXUSyx0b+LpqipxfYVPE541qIwRSNAlcUrnB3nKZ1TFuzz9sgCGACtSllTuzQCOa4MizZ33GxRBfdJNpg6yfS5z38rbXjagGKYbttglkdyoJBgr6gqkInZ4qblq6FRLvz+G8DHnTrDCA7rq97PtxsIRw6otsauXi+CJIcqSBpovxKIuPTtI8kgS9KQmMfEPVr/W1ABh0Fu0d1jXNov+tTEkvzPXxPeLjce1jql0xb1QlSg/G98JbgEgOeJ/tI1VSVXBbZKu+ivyWCaz4llg2XJnbmd9VVBjVemiZwYRHA==;5:FTX7sKK32hwpfAJhbf0tnJ7Hv20hIMJtB2ovq5u58F+0LwQfSw7OUydh0NEtY4XQmJiC5/FZYzrKjHU/Sf1DaSRZW6GwX+az2Ys427oa57Kbyux62XPRjpGkF+Cqr1cVBGrh6GrYu/URSUTrbOh305JydFUWj8k/wDGaNAkONPk=;7:0PEeMrDZqqVFMXLu72RaRrHU1ejELyLa7aZKoXI0nUjD/hOD6tYvkgqo6rmqqsDLQqyyoQPmVrj6gud23nI9QpUXyzAmFbO3TD0y9XdsiZtE+bQZEK+1R8TyVsPRXkR9cB3eaoQLHP4fL496iXgePQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 262c1159-abeb-43d7-0455-08d640cd3908
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB2998;
x-ms-traffictypediagnostic: AM6PR08MB2998:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-microsoft-antispam-prvs: <AM6PR08MB299808ABAF63F6AEA326F90486CF0@AM6PR08MB2998.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231382)(944501410)(52105095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR08MB2998;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB2998;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(40434004)(14444005)(97736004)(2501003)(6246003)(53936002)(486006)(105586002)(7736002)(71190400001)(71200400001)(305945005)(316002)(54906003)(446003)(86362001)(5640700003)(9686003)(55016002)(11346002)(26005)(476003)(6436002)(186003)(102836004)(3846002)(6116002)(66066001)(5024004)(256004)(76176011)(99286004)(2906002)(6506007)(25786009)(4326008)(2900100001)(72206003)(8676002)(5660300001)(106356001)(74316002)(2351001)(6916009)(68736007)(14454004)(81166006)(478600001)(8936002)(81156014)(229853002)(7696005)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB2998;H:AM6PR08MB3686.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UbMSHXHZohc2rcQ3SIlUtEVNamZtoOmvC2vYqQNDWI7sDS1R9NLAhLX33yur57qov0xCWILfWl0zJiyWhOHAQXI2KEdg0U+st5EmpnifKgrkfreg92AG2cVkEBRp+fz6XXa/1lhEiN2Ajtbx3pTHTEI5A/YwlnFubH0dUrfPWf4p/okV/dMAmXCUVxVFkQb0UB5Vt/xEAsDpmBdIwO+O0RN0UPRQ0PhOzuu6Up0/tNk6h86RIVzq3De0NvC1s/oK5q8XA2iNaJwvuOGNjXSKKewJv3PdDMYSZ2c8X8P54Hbc3RqshSDjUDdhH1buurVGaCDw6ZqZg+sFPP2TDO5UaRUbXYmDSVlRQZlOGzASpEU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262c1159-abeb-43d7-0455-08d640cd3908
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 14:12:28.7673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2998
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> root@debian:~/coresight_test# perf buildid-list
> 0242d9154c78df1d8fe1d0512c36a236d0861a18 [kernel.kallsyms]
> b8c89e8ba41a2ea486c66a50c29c60d38c34a759 /root/coresight_test/main
> 26b12a9d1a54ed2b0478cb0203435b76aabab3fb /usr/lib/aarch64-linux-gnu/ld-
> 2.27.so
> 8fca7ed524c9469b065af83bc8a529fe72858f53 [vdso]
> 25829a59e21012cfde7850b30a310cd3a58f531c
> /root/coresight_test/libcstest.so
> 70512527439ef76c8802a7a2a546bde6a5a6e967 /usr/lib/aarch64-linux-
> gnu/libc-2.27.so
> root@debian:~/coresight_test# ls
> ~/.debug/\[kernel.kallsyms\]/0242d9154c78df1d8fe1d0512c36a236d0861a18/
> kallsyms

What's in that last file? I've seen it happen that the copy of kallsyms
in ~/.debug has the symbol addresses as zeroes - possibly because it
was created when you didn't have permissions. That's really a bug
in perf, as cacheing a copy of this file with the addresses zeroed out
is kind of pointless. Again, this happens on Intel too.

Then, you can give yourself permissions - but perf's already cached
the file and won't update it!

If you delete it, and then rerun perf record (either as sudo or now
that you've got kptr_restrict=3D0) you should see it reappear, with
correct kernel addresses.

Perhaps nobody spotted this on Intel because perf report goes directly
to /proc/kallsyms. But it would be an issue if you ran a perf report
on a perf.data from an older kernel and it had to go to ~/.debug.
At that point the fact that ~/.debug/[kernel.kallsyms] had zeroes would
mean you couldn't symbolicate any addresses.

Al



>
> > Does it all work if you run perf record as sudo? Or if you do
> >
> >    sudo sysctl kernel.kptr_restrict=3D0
> >
> > before you run perf record?
>
> Yes, tested this on Juno board with Debian rootFS and logined in with 'ro=
ot' user.
> I suspected the pointer permission issue so checked with below command:
>
> root@debian:~/coresight_test# cat /proc/sys/kernel/kptr_restrict
> 0
>
> Thanks,
> Leo Yan
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
