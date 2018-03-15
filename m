Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtH/xXOHH2XfRPpNo/3W1MxvHX+s2XGlfh2Swla7YPNl7RjGGYe6qKtLakja6Xq7jxIZi5u
ARC-Seal: i=1; a=rsa-sha256; t=1521146596; cv=none;
        d=google.com; s=arc-20160816;
        b=MHB9cyWrW+JuvOF3h1wl9ZesXQo5Fm0vgc+hEbb/5CJDRkc8yozDpJdWQmIuyidDyi
         dzXchn041X5lleJu8bvZL7zU749ZKLp5eINgA+y2gbQxmXoxdv07+IS++V7WwJttM0Ao
         BCUlM6zTUKMjL4UZDiXKpT0yDJ5DObMEMnewhiglGjdZxG58a8rG2NK4TmZSm7IzMczZ
         KxwlgzPSilCRKcT84q7iWA20Pdu/jc0eIC8TFhBdM5486YScB0UYvicMVBrUTO/ynwuf
         MnBzE4e4LnYfvsKGkP4S991/NTl6gUTnJbTXzYOrEvsTDVVXlTzKcZKSvHzRbKGEH6yg
         dP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=fRVIjCByN7GbOTra7kuPkG8IfJxj0vQ0szIzVA9tQGM=;
        b=a4rwG6I4sdI5pZVyjfezSoOGsXY18Yn8u7CeWPgE4ykqtfTpkIBQU5W4PcMHX3hng8
         KfP5du/OIVxhGQqm6tTDTckf6xzDlqImUlFfcpMQxb4hD5z5ujVz1poZEymlXpxFsXUZ
         A5b99/x/XxuSo9jtHNdQIdAu5HHW8vmDu+vp7sVRSDx0Nt174X+bfWiRwvl9LkbGLibG
         dAoE0POLTBIs9+FFuDwpHXCMLd/0SpILw/IwX+GaOgSqNnabr+rIIza8+Of9Gl/0mLSC
         EhIrZdawYkpVZeLmhWP/QyerfxDjSm7dcG8U1xoiXT1IgDX2tPuaNlfh4NQamL+vs4hE
         xcGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=WMxqiU6E;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.110 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=WMxqiU6E;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.110 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
CC: "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mgorman@techsingularity.net" <mgorman@techsingularity.net>,
	"mhocko@suse.com" <mhocko@suse.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] mm: uninitialized struct page poisoning sanity
 checking
Thread-Topic: [PATCH v2 1/2] mm: uninitialized struct page poisoning sanity
 checking
Thread-Index: AQHTuyUZztiXFyklekiLx1gdTIcwnqPO42KAgAAEKACAAsMQAIAAG5MA
Date: Thu, 15 Mar 2018 20:43:14 +0000
Message-ID: <20180315204312.n7p4zzrftgg6m7zw@sasha-lappy>
References: <20180131210300.22963-1-pasha.tatashin@oracle.com>
 <20180131210300.22963-2-pasha.tatashin@oracle.com>
 <20180313234333.j3i43yxeawx5d67x@sasha-lappy>
 <CAGM2reaPK=ZcLBOnmBiC2-u86DZC6ukOhL1xxZofB2OTW3ozoA@mail.gmail.com>
 <20180314005350.6xdda2uqzuy4n3o6@sasha-lappy>
 <20180315190430.o3vs7uxlafzdwgzd@xakep.localdomain>
In-Reply-To: <20180315190430.o3vs7uxlafzdwgzd@xakep.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:LUV6MkVvoJYZkRNhlLS4AHWe7wkXBX0pq/JBDXUTOpopZGgj5FkEUmnKXYmW6VW3EnmjxU9OTo18cy1df3v4pfAdqTBeEOj+X+hNBs4y7TJeq7rWCoWKA6ArDy2vEmMpPlNHTPcfS44Fq+Qc+vS1C4ZRvDAaKtUqqUKBy2q4S1+Ot2VjiVLYvN1txHGF78q2D5W5gj5nPmh6PXQnSg4y/5eP2rXehj/1etU6QG4GB+0WecoUGnAWtiFrfoyLoO8l;20:u5tPo9eODGHqNs/1MUJylNTsAomWxfN8jiR2iJaNWszhpSPrgLSmHX/+c1jVp7de+KP+1ugRh2YI5hmfkKWNscawQAkPxj2IH/LHN9P9ZQiiaayOHE31PEtfw4L4H8vQOUii8Hgq0ac28uSyuILVAjo8FmrjKYgx1/T523BAdNI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e57a2d64-e224-4d93-17cd-08d58ab55fea
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
x-microsoft-antispam-prvs: <DM5PR2101MB09816949BDBEDBD9502B9EB1FBD00@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501274)(52105095)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(376002)(396003)(39380400002)(366004)(346002)(199004)(189003)(57704003)(72206003)(478600001)(6436002)(105586002)(10090500001)(316002)(5250100002)(5890100001)(229853002)(6916009)(54906003)(33716001)(66066001)(2950100002)(93886005)(7416002)(68736007)(59450400001)(6346003)(14454004)(102836004)(6486002)(22452003)(5660300001)(26005)(106356001)(6506007)(3660700001)(33896004)(186003)(7736002)(97736004)(3280700002)(25786009)(86612001)(6246003)(81156014)(8936002)(8676002)(2906002)(99286004)(2900100001)(4326008)(6116002)(76176011)(305945005)(10290500003)(3846002)(6512007)(81166006)(53936002)(86362001)(9686003)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: P5G8TfxuAtyGYeQG4oy5nMsnrSyKd+TUkgpTfMcdqHrkPMwAuzky63F72+OMi+GHAXTF8xX7Dw5WQCLwoTTCZiNdjZ3QDb6qrXJKW444+E6Sm3Liq1eMULG52KixMaPJPFwfaMySrMPEa3Puxq5NjbUNnoRGGDQGq8dv7qvxs+IXFA4hQGiLqMnnrOTjZif+abu4SpXao4muxzoTAYk+1NUfQnX+NdEPfqwBNE+yKfkvkHcmQ036lVZ1DjzEev6GUAVUWGSCBDidOO5Z27yUJ57HL+brFNk/K55I5zOATirwOGgq51VPq5yzTLwvcF7/U+s8TTdcWpnQUoCmY+OTAw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <698089C6C27CF943BDBEFE8F28446663@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57a2d64-e224-4d93-17cd-08d58ab55fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 20:43:14.4121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591143417186287050?=
X-GMAIL-MSGID: =?utf-8?q?1595037813030261289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 03:04:30PM -0400, Pavel Tatashin wrote:
>>
>> Attached the config. It just happens on boot.
>
>Hi Sasha,
>
>I have tried unsuccessfully to reproduce the bug in qemu with 20G RAM,
>and 8 CPUs.
>
>Patch "mm: uninitialized struct page poisoning sanity" should be improved
>to make dump_page() to detect poisoned struct page, and simply print hex
>in such case. I will send an updated patch later.
>
>How do you run this on Microsoft hypervisor? Do I need Windows 10 for
>that?

Booting a Linux VM on Azure would be the easiest, and free too :)

>BTW, I am going to be on vacation for the next two week (going to Israel),
>so I may not be able to response quickly.

Have fun!

We may need to hold off on getting this patch merged for the time being.

--=20

Thanks,
Sasha=
