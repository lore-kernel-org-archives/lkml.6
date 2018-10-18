Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DABC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4742F208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Q0gfUxS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4742F208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJSHM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:12:29 -0400
Received: from mail-eopbgr690139.outbound.protection.outlook.com ([40.107.69.139]:40352
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725751AbeJSHM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlkR57KhLRS8H7YDud4phNCQSH6422rLl/c0kPSATHA=;
 b=Q0gfUxS/4+abdeDNu+4L+VMgBcVo90FTpTTu/LVNEeHKcXYjPUCK056txiqgKz9jJEft/FWOCIh2IJTFBzMKGBZLaopvHlh6yJcRmjdvorBqOvQwoBpczDS9Pim6tz3/IrcCgX2Tx6yV9srFEKioELtjmHlgOjV/CEvQq5xd4Zo=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1040.namprd22.prod.outlook.com (10.174.169.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Thu, 18 Oct 2018 23:09:11 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%12]) with mapi id 15.20.1250.022; Thu, 18 Oct 2018
 23:09:11 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
CC:     "Hongzhi, Song" <hongzhi.song@windriver.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Question about mmap syscall and POSIX standard on mips arch
Thread-Topic: Question about mmap syscall and POSIX standard on mips arch
Thread-Index: AQHUZpuSly8s3XkRr0+u/PPo/AMS1qUloe+A
Date:   Thu, 18 Oct 2018 23:09:11 +0000
Message-ID: <20181018230909.nze5ws5ro2r3kvw6@pburton-laptop>
References: <e897b11f-1577-9298-7c82-7bbdea56e7e5@windriver.com>
 <20181018043200.GE32577@ZenIV.linux.org.uk>
In-Reply-To: <20181018043200.GE32577@ZenIV.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:300:ae::33) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1040;6:VDxJk9ve2LD+IenGzTrmgHn79Lq9R1AnYAkMlldhKwFaIgVGY/i9eNR/TpbAD2UfClRFwG740OaT3d1Xdb2oHrwOGWsXluCjDSHRoXe8vPtROIU0YeceNE9+eYvNk3A24JojwpzkjeAYJW5urp8Ady6wmZ+QsyQ6FWgfhU7rtc8VhgdqaFDlRbhwmCgJMZ6I7SrMXd6rUOdmd3cnEDkkZLcdB5Q7F9kGe1vxRVzHzpJ46imZ48n/PodRQAgB+/MLOOekpl0DgrhMBIYkXCR4+DwQGZ28ByMKp4xPLyZN7PC2s9VKkpzyroldl6RAuHNnUtUXfTYEbaGpfV7P+n6xJnPZ4vLYNUDEZaYLhuQNzgeAojNNzNlrR5UCuuQhFI1epVauDov+REXhoMfzGBmVcVJhCuwMzZbgKusdxoYuRbCmFR0BYFVOf+dCuGxg45eOcDoY1En9FVRN2vvWfGckyg==;5:P+wzjdspUTMDc1aZWGQ5tN1HVxrFcjepldMtBHn0qnMaNZ2+PP1wLe4X/mTumkJems0EEIst/AHpHTItNM+GObIi0xlbnOPTdvVsWZaVjKH8mzMotqiJ++9jpmaiFfrL/ADodCkSWZ/yGof0tfAyhH5jgxccQkNj5D42EHL3Jkg=;7:+df2EOX/FYYSPekto8BrKYM6YyEUptaS2pn57mdpfOLPMvUp8s5Z+2EcLT6lAb53aNbIJWFWComZdPVQ0FiPQrmBTZ4AQGZfFUY8XAAdHoIazxG/x0kOMLmJFQm/fWzNiGoRI3GZt73ceYbJqx1XWt0Z2okX8+y3vXaVUFMPWstt3wVYkkG48jvAjew2Kbd8W54GUuYwLnnnTlzsnw4PBx1WcCpc2Qk6QW2ts0AfPHeDuD54upOz2joPsdcLZNS1
x-ms-office365-filtering-correlation-id: 07d3de75-fd35-40d9-ee94-08d6354eb6a9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1040;
x-ms-traffictypediagnostic: MWHPR2201MB1040:
x-microsoft-antispam-prvs: <MWHPR2201MB1040527A0C5D1A2D9DDC7C37C1F80@MWHPR2201MB1040.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3231355)(944501410)(52105095)(10201501046)(3002001)(149066)(150057)(6041310)(20161123564045)(2016111802025)(20161123562045)(20161123560045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1040;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1040;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(136003)(376002)(396003)(346002)(366004)(199004)(53754006)(189003)(51914003)(54906003)(446003)(6916009)(66066001)(25786009)(81166006)(58126008)(53936002)(6436002)(33716001)(6512007)(106356001)(8676002)(81156014)(5250100002)(2906002)(6506007)(8936002)(33896004)(6116002)(386003)(6246003)(3846002)(99286004)(76176011)(14454004)(52116002)(105586002)(97736004)(5660300001)(11346002)(1076002)(508600001)(316002)(256004)(44832011)(42882007)(6486002)(68736007)(305945005)(71190400001)(71200400001)(476003)(966005)(9686003)(7736002)(486006)(229853002)(6306002)(4326008)(26005)(2900100001)(186003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1040;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CIgDRRWmKasiwW2rqLH2XDOXvdyyG2Rjd+1NWc92oQqJi6CrWEpNfAWHeNF7KAqMt9UsusvnOyYMT2xgUcm/wPR8k4t176DCm2PRaO54QOgF9YWJIRZBy80SU1QSab4AC9jKXd4msfZMwZ8qXpS0IcT3sU184IVZ9q7W7ex46ducJMtbqQuE1MogYcv5KgBTBfnc3RaQry4x2/dd42oGGyI4DF6QB9AGmLv8bSBRMjbI3IiORMB8NvuxygNG1Z+I+/mo41B8mGwvovxja5GsbM/IZTwnrSImoTOsBwIlABaLpa5tFppteGK3tOmSK0SE4oEvilRWgdzEXN8ohn+QqWsFLvuEHdlVHWiQEO1C9uY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04DE8EAA7DDC9046A1C2FC7C51D0C0BA@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d3de75-fd35-40d9-ee94-08d6354eb6a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 23:09:11.4650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On Thu, Oct 18, 2018 at 05:32:00AM +0100, Al Viro wrote:
> [mips folks Cc'd]
>=20
> On Thu, Oct 18, 2018 at 11:26:02AM +0800, Hongzhi, Song wrote:
> > Hi all,
> >=20
> > Ltp has a POSIX teatcase about mmap, 24-2.c.
> >=20
> > https://github.com/linux-test-project/ltp/blob/e816127e5d8efbff5ae53e9c=
2292fae22f36838b/testcases/open_posix_testsuite/conformance/interfaces/mmap=
/24-2.c#L94
>=20
> [basically, MAP_FIXED mmap with addr + len > TASK_SIZE fails with
> -EINVAL on mips and -ENOMEM elsewhere]
> =20
> > Under POSIX standard, the expected errno should be ENOMEM
> >=20
> > when the specific [addr+len] exceeds the bound of memory.
>=20
> The mmap() function may fail if:
>=20
> [EINVAL]
> The addr argument (if MAP_FIXED was specified) or off is not a multiple
> of the page size as returned by sysconf(), or is considered invalid by
>                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> the implementation.
> ^^^^^^^^^^^^^^^^^^^
>=20
> So that behaviour gets past POSIX.  That part is mostly about the
> things like cache aliasing constraints, etc., but it leaves enough
> space to weasel out.  Said that, this
>=20
> [ENOMEM]
> MAP_FIXED was specified, and the range [addr,addr+len) exceeds that allow=
ed
> for the address space of a process; or, if MAP_FIXED was not specified an=
d
> there is insufficient room in the address space to effect the mapping.
>=20
> is a lot more specific, so switching to -ENOMEM there might be a good ide=
a,
> especially since on other architectures we do get -ENOMEM in that case,
> AFAICS.

Thanks for the heads up - that does sound like reasonably clear
non-compliance. I'll make a note to put together a patch & test it out,
likely next week, if nobody submits one first.

Thanks,
    Paul
