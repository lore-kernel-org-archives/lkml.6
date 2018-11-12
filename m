Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E768C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12590223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="MVg9XLri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12590223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeKLTXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:23:22 -0500
Received: from mail-eopbgr810053.outbound.protection.outlook.com ([40.107.81.53]:36512
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbeKLTXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG0QwHvlJdR7I4YtgZrwgKak4jPwYw1vswIEU7J6x60=;
 b=MVg9XLriB3YuTVfzNRemT3yCL06dC+H17GamH6tKxOFzq6iQIlV9bIHmn1TT7fpbDgkYudd+Y/TTp3V7RO4blkW9Us3/9VhzoiX9eFOpFUSx9oGr3yan0AJnI6R160RLCnKmqtqzBxRJ5A6ozowYP8Iy+VbIwEsVGMtjbDK3XfA=
Received: from DM6PR03CA0003.namprd03.prod.outlook.com (2603:10b6:5:40::16) by
 BLUPR03MB552.namprd03.prod.outlook.com (2a01:111:e400:883::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 12 Nov 2018 09:30:50 +0000
Received: from BY2FFO11FD029.protection.gbl (2a01:111:f400:7c0c::160) by
 DM6PR03CA0003.outlook.office365.com (2603:10b6:5:40::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.21 via Frontend Transport; Mon, 12 Nov 2018 09:30:49 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD029.mail.protection.outlook.com (10.1.14.212) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.12
 via Frontend Transport; Mon, 12 Nov 2018 09:30:49 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wAC9Ulqj008721
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 12 Nov 2018 01:30:48 -0800
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0301.000; Mon, 12 Nov 2018 04:30:47 -0500
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 4/4] dt-bindings: iio: adc: Add docs for ad7124
Thread-Topic: [PATCH v4 4/4] dt-bindings: iio: adc: Add docs for ad7124
Thread-Index: AQHUeELsgftMY1Wj7USvF7kJj5IknKVK1P8AgAFjFYA=
Date:   Mon, 12 Nov 2018 09:30:47 +0000
Message-ID: <1542015047.2091.16.camel@analog.com>
References: <1541778180-7862-1-git-send-email-stefan.popa@analog.com>
         <20181111121954.145cbd2f@archlinux>
In-Reply-To: <20181111121954.145cbd2f@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.118]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <77BBE33FC1776B46BB98ABF25C3777C8@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(2980300002)(438002)(189003)(199004)(186003)(126002)(6116002)(47776003)(36756003)(476003)(2616005)(316002)(2501003)(26005)(72206003)(103116003)(1720100001)(486006)(3846002)(478600001)(2900100001)(336012)(2351001)(305945005)(102836004)(7736002)(246002)(7636002)(446003)(11346002)(106466001)(426003)(436003)(6306002)(5660300001)(106002)(8676002)(23676004)(2486003)(4001150100001)(14454004)(356004)(76176011)(8936002)(7416002)(6916009)(7696005)(575784001)(86362001)(50466002)(6246003)(966005)(2906002)(54906003)(5640700003)(4326008)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB552;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD029;1:qjN3cmBWMLqyILj6qfsIxb8jogUHd+dkprhnrGkDd+xgbSDdVYSBYjD/O0izLcMQbIJhA1trJzypyn1Za1zXvKF6O9vIgYTkq13Gq94AIUUV28jl35UtC/3WpZSog7sy
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c04d84e1-6229-4599-ecd6-08d64881884d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BLUPR03MB552;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;3:KYRwPDMi/F17U2YOqU8nLoszQowwHOlEnv/+RbmAHK5OKhrgo+KzWeACj0P1/gFaau0fi5raito5e5ZEYuayMw5kXsJWmCSxSwALD0aQbRAtsNFjaJs93tg/e9YHfuf4Rgpm4pqREH5TbIrW1TuxxXeIbv6sW62yXefGUrDX+UPqQUgXL11yYs+SsXD9+irXtj0VR5TRPamTSs/nbGR6S+EJpJy5hDKGJi1ucE31E7iNTtyjQkRQ8q/pfFPA/GcyKX1tZ+L+1OD3Y0PvcG/VxV/AsTGXdx1X3+ehzcRg8KJXjKsA1ANCk1FzJzKEwuPDshKqYvbzvZtVQA5T47MQP8G/HoKAu+FfRjAxMPuYOxc=;25:HGMulzgC2VE3E/XDQFzfQI6bzncGIm5GKhup60wdsszp9GWBPb33rX/fAMvSfuOyCM9USf3kDBpu2AN7nh3ATsChQkCnVtt3VtG/Weje84LUD5qLbrDTz0V/4MhohCGhE4wiY5klJ0hPD7Y9oa6acDVY6kFvcJziqsTorPC+AiLU5Wbct1cYae6IbMpTPgX6/XZ0/DMlmBq6+zib5IvpEulVyN6jmPGgz2prQB5GQHi2xfkkDXvVoahkv8LmwoTQ/lPeI4jEkoEzFyMgmSrlJFUkw+ottBte74bSVyzqL+uSNsNc0PmhqmaHKVc6HB5FeHTEByKFgPilc9mVT2ZWTw==
X-MS-TrafficTypeDiagnostic: BLUPR03MB552:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;31:TfCE/M4PsM3eoE31kZ1H7RRrLr027SrPG3GI1hQCr7KXCpDoL6nF48ixp92FhNzQbme30kagbjgxkaKTHVpJcYXO4bEza0nl5HG/gfACjEbj6DKnNzn4x1BVXqDXIRvj5XNKfFCWo2aNG2F+bxiSEy3ekOkkfQ2fCAoZzXkQNHc3rTXB80rGDjMBnwlcON/MigR3EjKoBoFJgz6Lb4IGpn8PzNq4NpPLsEgjsKIYpT4=;20:DTQ9f+ziAXwTffEyCMZzRSwRVc2LbJiRjrVU8y7g/dF77jNWu3bzXBi05pbSYGyjJ3zBBC42fmT6Y5biLSIn/OeqViZ/LxZMcc4ZiYuV4DXRTIX7K1hYUTPBs/XTbuLDTHjoQdaOm70pEtUl7P60ASKhduCmusmwMIoB3B+ocxw3wmuoT9aaEWF4CReSXo2UES+WEoZIa0U6jY7yb3dJItvmKu93xEiXrV7Kl9NkeVOkWR5rwzlEpsP4raqjLz5H+oUZ7IcMXoWJ8VA3yb0rcVurlaP56hbSN8oouyTja5iCGn6+FZ4u43K4/32XBajTK8HUaWRplIgxzIkmrtbwv1oVK+0Ye8QL0s1CKWLG63pc/doBUbV3QbRyLJxuylrmdtKtzgZqoYbYnvhA00c2LNihDLCLs3cwwBFCU+PWmEsjupboDr93I/J4u0X48i8IapWpZGC7xlBfU+dPK/FG7uNXRega7TrdiU6Z4Clwe3li4tfXF6yELIlfA3/OsGho
X-Microsoft-Antispam-PRVS: <BLUPR03MB5527417EB9E91AD0916FC2D9DC10@BLUPR03MB552.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(9452136761055)(170811661138872)(95692535739014);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(4982022)(52105112)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BLUPR03MB552;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB552;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;4:AmgzbE/5MDHViAHXuI1sGVPVW/EwoX+e+nJCT/JHKV5bPCDu+cket/5oC2KJvv+31DbmwE/XMx5k3Cxz7LxE9ug3lCFPCFtL8EHXsgmcioanGqpDyEWBo+PFVpwXlN0m3KJeEQMLXWt+cjtRvU4OOIawyPUM8Ndbedu4d+Zv0rmy4VPgp3x+zdmN3h+gdzMR72Be4xhUjgFHt3afjmU9b8tP0DoxiHafI06QGqYtmRcVL2y+pGViderSmdqnrBpPL7yrUsL7HPoreRj1DHAtt+/vBik7dF4m31PZTWGsR8fCzAhHFMsUL4zRUTJNq16T0jG5KY+327dbIjYPN35b9vuiRNe0qdocx9uHshV0ifEy1LgoBBd/F4R3Ksy4l5z0aKosvAXo7gKDMzWVaiP5z1/s2kMK173iR/4xrh2R8L8=
X-Forefront-PRVS: 0854128AF0
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAzTUI1NTI7MjM6OVJHMEp4ZjFhU2VxNlJWd2NpWG9wTkZmOFpt?=
 =?utf-8?B?a2luaVFWMWNhT3hwUlRDSGVVT1dGbThhaWZUcUtZNUd0OEVaTW1OT0FTN2ZC?=
 =?utf-8?B?eWRtcHk4cEhjRCttSHV0N3BkYzFPUU5CNHhleHpjNlFWY2xkRDNxNUVJUlZH?=
 =?utf-8?B?TWd5d1VXZytNZktZYko1M28zVmIvbHZjdkdGSUJwOE53NVJ5ODVSb2JEQ1Yx?=
 =?utf-8?B?YUNQWEZxS2FGRGZtR2lMUVlZaHpRcURkYWNwRnZSVmFuN2ZGd3o1VXhiWklG?=
 =?utf-8?B?T1JXcGtHQ1pmOENUenRXZW9QSFhhZE1ZblUyRWROTmtnSjJZL3Y1TzB2dHl5?=
 =?utf-8?B?aS9tbS9nd2R4S2lSVjJnNmp5Yk1VZU5LdmREcCtOeE9KNDk4S2FadEdTTXFQ?=
 =?utf-8?B?V0U2K3lsei9jRnNqL3RpNTRybUkzY3dYWkxiMXBYNnUveVJqdUNHMTFGU1I5?=
 =?utf-8?B?dURMOFJQUXgrSVdRMy9lNzE2RENvNlFtUGdURndvL2NueFZFTERQeG9kV1Rk?=
 =?utf-8?B?N29TNlpRYTF5ZHF5NWdSNGkrTDl2WlZMSXc4SG5KYW5haGp0VHZCUFNkYWYx?=
 =?utf-8?B?WG4yb2k4KzYvc3N0N1ZVZHVjOUJkQTB0OXZOOWxrWUl1Wi9NUDY3NWRGang3?=
 =?utf-8?B?OFZ4dXBySCtLTWp5bFpDS1lhTVk1TnJFb2VDVWlJSkEwTW5ZUXhQcWY0ZHFS?=
 =?utf-8?B?ME9veTA5UUZtMXFJU2Y2QmVldFpNc1Z4bTY4dzVYeE5Qc2N6bE11M2srdVFR?=
 =?utf-8?B?cnZZWXlDRFZpSlJYaUhNVEhBVE5SSk1SMmNabGg5MC9wK0JlQWZ1N1l4Z01P?=
 =?utf-8?B?YlNKQmIyQ3Qvakd6RFJVOVNhQjk1U3c0SXV1emFDd09ORGkvUmZQRnBnbTNH?=
 =?utf-8?B?cGMxNG9JRjBTOXU4MEd0c0ZreEFrYm1vMU1vSHFCZ2dtcnNBZmFENjdpcUly?=
 =?utf-8?B?U0JDYzlNNHRQYkF5ZlZiQi9iWFJWQ3BaQ0NvamNpaisxbnRLZkcvVFk5L05r?=
 =?utf-8?B?T3FKeGN6cUlTRUtHYkZnUXdQVjVKY2tpVWs5ZFBYblNMYXI5UjgxNWx2RDZI?=
 =?utf-8?B?YTdWWURHU1RYUkVzbkR0Q1Q4bWJMM2ZURWdWMDJ0aVQ3SXY4eGhXS1c1Zkc1?=
 =?utf-8?B?djc2RVhBRUZ2UHpZMzRqMzA3b20yTzZJemhnTlh6azRHNlAzUUl1bm1VdG5Y?=
 =?utf-8?B?Qi9CRms0K0ZkSmhjWmY1QzU0TCszekYxcks3NzhkVjBoNndwYUlDR2JjRmx6?=
 =?utf-8?B?cEpXNFhTY3hZbDVuZHhudzhMMXR2WVNaMWJPMkxyRGU1T29MVHJEK3grNUlN?=
 =?utf-8?B?d0FiaVpIRGdGVDBVWGlOVlRVS0NwdmhUSzcxcVpJYlVFVTc1bElxZ3NVT2NQ?=
 =?utf-8?B?V0NhK3lXaHpJSnVRZ3lIQ1JFc0NiVlQwZ2pobk5vSUxuVHR0Z2FDdEVrUjBT?=
 =?utf-8?B?cmVkWHdUelU3REh1SXpqMHFHTWhWVG95QU92ckcvNHVXU3g3YWNkOXBrY0VK?=
 =?utf-8?B?M0c4cHMxT3J2VWpVb2ZQM01ocVhxV2FubVdPakpGVVh2b1JJaU56dWF4NllI?=
 =?utf-8?B?MEY0ZmhOYktpM0FYRkVEY1RmczFBcVdXdmdwTlZXZlJhT3YweWpqeUM4RStJ?=
 =?utf-8?B?OWgxcXpaeGYwMXFaa0pVQ09wZ3NpZi9MUWlPTjFPZVVscGFiUzNIbHNYcEw5?=
 =?utf-8?B?S282VlZiTXlXUmZhY3lZdStxKzRpRkZrQnNnazErZGRiTk95TUFKYW1tcUU3?=
 =?utf-8?B?MFptR0ZVRUZkNlhreFRQWVVUR1NHamZkWSsrV2FTSDBFRWZVN2ExK3RGV3dR?=
 =?utf-8?B?M3JHbS9GUk44eUhyRHo0bVF0cWV3eDkwZ3hydVYvZ015QT09?=
X-Microsoft-Antispam-Message-Info: GibvG69qDiekDWvur2hjaYwG1xf4NHluLQqmxzm+s+om1aDpVz+iFNiUsQAU2NZG2o0zl6duzPf7neC+3gygbQ6TTVGNQ1Cr4rjhFmjG3YR3/1XutMgRlo3n2vOn3vic3ahP7GcsxGzqZf3RKt6h4XRXq6q1L1jbx6m2GFKyJYd2ZruVwVx7m32FkErxcJZvQoTfdJAPFrIxVVKhJ2yM4bGV35mhGyhncQ0MBITr85o9FjJYpIzPVwskJWu68v/xBh3DwQeqkD/qw4RHRCZCMVUD1Ks26XX/OJgAeD0Xta2VT2yLGvG3CvAEn1tSYziabx1F9BnbqN24fnI3RmNKHpf7POuaA5FOLNE/bNlXEt8=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;6:arwtxxD3GF5KHl8RxToUwsma1HyfNnw7s5Nef62mk0KRmVyuCSYH/Y6nSEoe4z0BsrM+0ZwMQ1Fcgj262hd9q7PZqOrFvYkxJhVG4SSt+ajdzsogh06g/eO/P5+PWbeJKJduci6y0yo8NGZK0zQxVc8CO16wcs/yTiCF9DcJ4b8RLHfyLgTBj1b8FiDFqVlQ1wz9Xv2+bpxyHGsqes46m+IkAlzbaxrVOHEiIQrSI6h88dFxkwbvsXvDKZQmg86p7wSCa6LDeHvzlgreMbWiCWefdf3y4VTUvlbDC8EW4O5eb0L9I1oDXE2xDoz+a65TiP6+j0fpZljQ6HTOGgBZHNZmWgBi0pDa7wrRr8Meimds5l/dJB8JhtgjCoXnRRGMvRulhP198x5ASA+RanhIH1gQSf19dROa2LZt6q6ymDJfU/qgs75+PZJuhvxP+an33G+KaCNQZdERr2QlN2bjqg==;5:ag0Oj+7nndJvFyRQu0a4+4NpR6o0/ZGeRDwzsOrgE1TlzHyKmDMKPwGVgsBQIEn5pcNDp9ENQKI7r+kECrdYad2G1rJhvUjMAxMMzs451C1Em3bybWYz6ra40sLoOA3NkKFA7RrFu778d3dmjVK5vYAiNPt9qFxDItfzlDDKynw=;7:LYj0U5BCZFWsQh+XYqc9qw56VDl7YtPPkD4PPlySUTfwwIZQhqAZBpqPOQmikf5pSI80oxvZgWT1dV57ZWyfXOcXbwxyUh1fdfxF26gT8WeLcIhme4mKQuQIdZPJR157Mi7CHVh91iI8KCCN0zbERw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2018 09:30:49.1480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c04d84e1-6229-4599-ecd6-08d64881884d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRHUsIDIwMTgtMTEtMTEgYXQgMTI6MTkgKzAwMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6
DQo+IA0KPiBPbiBGcmksIDkgTm92IDIwMTggMTc6NDM6MDAgKzAyMDANCj4gU3RlZmFuIFBvcGEg
PHN0ZWZhbi5wb3BhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiANCj4gPiANCj4gPiBBZGQg
c3VwcG9ydCBmb3IgQW5hbG9nIERldmljZXMgQUQ3MTI0IDQtY2hhbm5lbHMgYW5kIDgtY2hhbm5l
bHMgQURDLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBQb3BhIDxzdGVmYW4ucG9w
YUBhbmFsb2cuY29tPg0KPiBZb3VyIGV4YW1wbGUgc3RpbGwgaW5jbHVkZXMgdGhlIG90aGVyIHRo
aW5ncyB0aGF0IEkgdGhpbmsgeW91IGhhdmUgbm93DQo+IGRyb3BwZWQuDQo+IGdhaW4gYW5kIG9k
ci4NCj4gDQpZb3UgYXJlIHJpZ2h0ISBJIGFtIHNvcnJ5IGFib3V0IHRoaXMuDQo+IA0KPiA+IA0K
PiA+IA0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gCS0gTm90aGluZyBjaGFuZ2Vk
Lg0KPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4gCS0gUmVtb3ZlZCB0aGUgImFkaSxjaGFubmVscyIg
cHJvcGVydHkuDQo+ID4gCS0gVXNlZCB0aGUgInJlZyIgcHJvcGVydHkgdG8gZ2V0IHRoZSBjaGFu
bmVsIG51bWJlciBhbmQgImFkaSxkaWZmLQ0KPiA+IGNoYW5uZWxzIg0KPiA+IAnCoMKgZm9yIHRo
ZSBkaWZmZXJlbnRpYWwgcGlucy4gVGhlICJhZGksY2hhbm5lbC1udW1iZXIiIHByb3BlcnR5IHdh
cw0KPiA+IHJlbW92ZWQuDQo+ID4gCS0gYWRpLGJpcG9sYXIgaXMgb2YgYm9vbGVhbiB0eXBlLg0K
PiA+IENoYW5nZXMgaW4gdjQ6DQo+ID4gCS0gVXNlZCB0aGUgYmlwb2xhciBhbmQgZGlmZi1jaGFu
bmVscyBwcm9wZXJ0aWVzIGRlZmluZWQgaW4gdGhlIG5ldw0KPiA+IGFkYy50eHQgZG9jLg0KPiA+
IA0KPiA+IMKgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9hZGksYWQ3MTI0LnR4dMKg
wqDCoMKgwqB8IDgxDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgTUFJTlRBSU5F
UlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgMSArDQo+ID4gwqAyIGZpbGVzIGNoYW5nZWQs
IDgyIGluc2VydGlvbnMoKykNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDcxMjQudHh0DQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRj
L2FkaSxhZDcxMjQudHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aWlvL2FkYy9hZGksYWQ3MTI0LnR4dA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5k
ZXggMDAwMDAwMC4uZmEwYzQzYg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9hZGksYWQ3MTI0LnR4dA0KPiA+IEBA
IC0wLDAgKzEsODEgQEANCj4gPiArQW5hbG9nIERldmljZXMgQUQ3MTI0IEFEQyBkZXZpY2UgZHJp
dmVyDQo+ID4gKw0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciB0aGUgQUQ3MTI0Og0KPiA+
ICsJLSBjb21wYXRpYmxlOiBNdXN0IGJlIG9uZSBvZiAiYWRpLGFkNzEyNC00IiBvciAiYWRpLGFk
NzEyNC04Ig0KPiA+ICsJLSByZWc6IFNQSSBjaGlwIHNlbGVjdCBudW1iZXIgZm9yIHRoZSBkZXZp
Y2UNCj4gPiArCS0gc3BpLW1heC1mcmVxdWVuY3k6IE1heCBTUEkgZnJlcXVlbmN5IHRvIHVzZQ0K
PiA+ICsJCXNlZTogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktYnVz
LnR4dA0KPiA+ICsJLSBjbG9ja3M6IHBoYW5kbGUgdG8gdGhlIG1hc3RlciBjbG9jayAobWNsaykN
Cj4gPiArCQlzZWU6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9jbG9j
ay0NCj4gPiBiaW5kaW5ncy50eHQNCj4gPiArCS0gY2xvY2stbmFtZXM6IE11c3QgYmUgIm1jbGsi
Lg0KPiA+ICsJLSBpbnRlcnJ1cHRzOiBJUlEgbGluZSBmb3IgdGhlIEFEQw0KPiA+ICsJCXNlZTog
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC0NCj4gPiBjb250cm9s
bGVyL2ludGVycnVwdHMudHh0DQo+IEdpdmVuIHRoZSBkcml2ZXIgZG9lc24ndCBjdXJyZW50bHkg
dXNlIGl0LCBzaG91bGQgcGVyaGFwcyBiZSBvcHRpb25hbD8NCj4gDQpUaGUgaW50ZXJydXB0IGlz
IGFjdHVhbGx5IHJlcXVpcmVkIGJ5IGFkX3NpZ21hX2RlbHRhLg0KPiANCj4gPiANCj4gPiANCj4g
PiArDQo+ID4gKwnCoMKgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiArCQkqICNhZGRyZXNzLWNl
bGxzOiBNdXN0IGJlIDEuDQo+ID4gKwkJKiAjc2l6ZS1jZWxsczogTXVzdCBiZSAwLg0KPiA+ICsN
Cj4gPiArCcKgwqBTdWJub2RlKHMpIHJlcHJlc2VudCB0aGUgZXh0ZXJuYWwgY2hhbm5lbHMgd2hp
Y2ggYXJlDQo+ID4gY29ubmVjdGVkIHRvIHRoZSBBREMuDQo+ID4gKwnCoMKgRWFjaCBzdWJub2Rl
IHJlcHJlc2VudHMgb25lIGNoYW5uZWwgYW5kIGhhcyB0aGUgZm9sbG93aW5nDQo+ID4gcHJvcGVy
dGllczoNCj4gPiArCQlSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICsJCQkqIHJlZzogVGhlIGNo
YW5uZWwgbnVtYmVyLiBJdCBjYW4gaGF2ZSB1cCB0byA0DQo+ID4gY2hhbm5lbHMgb24gYWQ3MTI0
LTQNCj4gPiArCQkJwqDCoGFuZCA4IGNoYW5uZWxzIG9uIGFkNzEyNC04LCBudW1iZXJlZCBmcm9t
IDANCj4gPiB0byAxNS4NCj4gPiArCQkJKiBkaWZmLWNoYW5uZWxzOiBzZWU6DQo+ID4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRjLnR4dA0KPiA+ICsNCj4gPiAr
CQlPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ICsJCQkqIGJpcG9sYXI6IHNlZToNCj4gPiBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9hZGMudHh0DQo+ID4gKwkJCSog
YWRpLHJlZmVyZW5jZS1zZWxlY3Q6IFNlbGVjdCB0aGUgcmVmZXJlbmNlDQo+ID4gc291cmNlIHRv
IHVzZSB3aGVuDQo+ID4gKwkJCcKgwqBjb252ZXJ0aW5nIG9uIHRoZSB0aGUgc3BlY2lmaWMgY2hh
bm5lbC4NCj4gPiBWYWxpZCB2YWx1ZXMgYXJlOg0KPiA+ICsJCQnCoMKgMDogUkVGSU4xKCspL1JF
RklOMSjiiJIpLg0KPiA+ICsJCQnCoMKgMTogUkVGSU4yKCspL1JFRklOMijiiJIpLg0KPiA+ICsJ
CQnCoMKgMzogQVZERA0KPiA+ICsJCQnCoMKgSWYgdGhpcyBmaWVsZCBpcyBsZWZ0IGVtcHR5LCBp
bnRlcm5hbA0KPiA+IHJlZmVyZW5jZSBpcyBzZWxlY3RlZC4NCj4gPiArDQo+ID4gK09wdGlvbmFs
IHByb3BlcnRpZXM6DQo+ID4gKwktIHJlZmluMS1zdXBwbHk6IHJlZmluMSBzdXBwbHkgY2FuIGJl
IHVzZWQgYXMgcmVmZXJlbmNlIGZvcg0KPiA+IGNvbnZlcnNpb24uDQo+ID4gKwktIHJlZmluMi1z
dXBwbHk6IHJlZmluMiBzdXBwbHkgY2FuIGJlIHVzZWQgYXMgcmVmZXJlbmNlIGZvcg0KPiA+IGNv
bnZlcnNpb24uDQo+ID4gKwktIGF2ZGQtc3VwcGx5OiBhdmRkIHN1cHBseSBjYW4gYmUgdXNlZCBh
cyByZWZlcmVuY2UgZm9yDQo+ID4gY29udmVyc2lvbi4NCj4gPiArDQo+ID4gK0V4YW1wbGU6DQo+
ID4gKwlhZGNAMCB7DQo+ID4gKwkJY29tcGF0aWJsZSA9ICJhZGksYWQ3MTI0LTQiOw0KPiA+ICsJ
CXJlZyA9IDwwPjsNCj4gPiArCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDw1MDAwMDAwPjsNCj4gPiAr
CQlpbnRlcnJ1cHRzID0gPDI1IDI+Ow0KPiA+ICsJCWludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8+
Ow0KPiA+ICsJCXJlZmluMS1zdXBwbHkgPSA8JmFkY192cmVmPjsNCj4gPiArCQljbG9ja3MgPSA8
JmFkNzEyNF9tY2xrPjsNCj4gPiArCQljbG9jay1uYW1lcyA9ICJtY2xrIjsNCj4gPiArDQo+ID4g
KwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKwkJI3NpemUtY2VsbHMgPSA8MD47DQo+ID4g
Kw0KPiA+ICsJCWNoYW5uZWxAMCB7DQo+ID4gKwkJCXJlZyA9IDwwPjsNCj4gPiArCQkJYWRpLGRp
ZmYtY2hhbm5lbHMgPSA8MCAxPjsNCj4gPiArCQkJYWRpLHJlZmVyZW5jZS1zZWxlY3QgPSA8MD47
DQo+ID4gKwkJCWFkaSxnYWluID0gPDI+Ow0KPiA+ICsJCQlhZGksb2RyLWh6ID0gPDEwPjsNCj4g
SSB0aGluayB5b3UgaGF2ZSBkcm9wcGVkIHRoZXNlIHR3by4uDQo+IA0KPiA+IA0KPiA+IA0KPiA+
ICsJCX07DQo+ID4gKw0KPiA+ICsJCWNoYW5uZWxAMSB7DQo+ID4gKwkJCXJlZyA9IDwxPjsNCj4g
PiArCQkJYWRpLGJpcG9sYXI7DQo+ID4gKwkJCWFkaSxkaWZmLWNoYW5uZWxzID0gPDIgMz47DQo+
ID4gKwkJCWFkaSxyZWZlcmVuY2Utc2VsZWN0ID0gPDA+Ow0KPiA+ICsJCQlhZGksZ2FpbiA9IDw0
PjsNCj4gPiArCQkJYWRpLG9kci1oeiA9IDw1MD47DQo+ID4gKwkJfTsNCj4gPiArDQo+ID4gKwkJ
Y2hhbm5lbEAyIHsNCj4gPiArCQkJcmVnID0gPDI+Ow0KPiA+ICsJCQlhZGksZGlmZi1jaGFubmVs
cyA9IDw0IDU+Ow0KPiA+ICsJCQlhZGksZ2FpbiA9IDwxMjg+Ow0KPiA+ICsJCQlhZGksb2RyLWh6
ID0gPDE5MjAwPjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiArCQljaGFubmVsQDMgew0KPiA+ICsJ
CQlyZWcgPSA8Mz47DQo+ID4gKwkJCWFkaSxkaWZmLWNoYW5uZWxzID0gPDYgNz47DQo+ID4gKwkJ
fTsNCj4gPiArCX07DQo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMN
Cj4gPiBpbmRleCAzYTFiZmNiLi5mMmZhNTA4IDEwMDY0NA0KPiA+IC0tLSBhL01BSU5UQUlORVJT
DQo+ID4gKysrIGIvTUFJTlRBSU5FUlMNCj4gPiBAQCAtODQ1LDYgKzg0NSw3IEBAIEw6CWxpbnV4
LWlpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiDCoFc6CWh0dHA6Ly9lei5hbmFsb2cuY29tL2NvbW11
bml0eS9saW51eC1kZXZpY2UtZHJpdmVycw0KPiA+IMKgUzoJU3VwcG9ydGVkDQo+ID4gwqBGOglk
cml2ZXJzL2lpby9hZGMvYWQ3MTI0LmMNCj4gPiArRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2lpby9hZGMvYWRpLGFkNzEyNC50eHQNCj4gPiDCoA0KPiA+IMKgQU5BTE9HIERF
VklDRVMgSU5DIEFEOTM4OUIgRFJJVkVSDQo+ID4gwqBNOglIYW5zIFZlcmt1aWwgPGhhbnMudmVy
a3VpbEBjaXNjby5jb20+
