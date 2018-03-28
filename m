Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4/UwtMNjpJEMqvRoqNhRFGWOjJ/1TxjTYs9YrwnuWB28iZ1cf+inbe5buFY+rKV5SF0yasX
ARC-Seal: i=1; a=rsa-sha256; t=1522265588; cv=none;
        d=google.com; s=arc-20160816;
        b=C0z1wzZLNPpDQV11QVxTXGOdiRigVYkHWlhyZANeaR7oTderwgiX1/wBioUOU5mOGA
         ar6WuFrSz+uWfTyQnSy5BJoLV418Kq0E7UXInc2WvbT+pHNKnfxn7Qfg87VnV0benYMG
         JhVcJg7n1vKVDMtMUueMhwEtRha7dKU8SpRY5w6kOYbC3pmR7dlhvIwbpJShD/GUt5pM
         P03au6l6fgVM18UkV7aOdhBPYQYnomsRQNXB5VmuIPyqVu6t3HUc5SJiroDoqxHqPZqC
         y02Ce0KjnIccfOsQwnSm0i1wLNg+J31XU8D2W4ksXjyKZgGE+nSQq39YLAF3nYoZMw6J
         eOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=bwp4eK/9pe0Zs71r1qmZwFink9G5NMRPsXovV6KeAmU=;
        b=03WJ0nncooZqvcNBfCGkV6UaQClN4gocDGDS0MI7ziKd4LfFEiWfOOPa9/vDYiGBgR
         BIRQ8jJVXskzJQ2+NvtMpfcHFGIhM11uHJ31MpAnrw6QQC+O64hBalAnCQ7ylb1hpB/I
         sW54CCN9RSVaMDLHaXBpy3FMmuxR2OxsXrKzJDtPTFnSHZLZ1dVtefMgtQzMr5zITnYe
         Pa5dDCUaLq7RDyDHFzAjjsO8qw7IyMr3zZyz43XkskJRly95SKrlgeNd8qmL+kmJd9hi
         JHxpjQ09HqWjxYQIdzlcYckrFyF0utdkdY17RwsuxEkUucSCefF/QPA+c13ut7K/hFiA
         oIbw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=oLV1E/qr;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.107 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=oLV1E/qr;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.107 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>, Sasha Levin
	<levinsasha928@gmail.com>, Dave Chinner <david@fromorbit.com>, "Darrick J.
 Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@lst.de>, xfs
	<linux-xfs@vger.kernel.org>, "linux-kernel@vger.kernel.org List"
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh
 Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>, Joerg Roedel
	<joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Topic: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Index: AQHTwtP9a8CoG3+qW0i20XM40DTMGKPhjRGAgAGo14CAAHi7gIAA1pGAgAEklwCAAGe7AA==
Date: Wed, 28 Mar 2018 19:33:06 +0000
Message-ID: <20180328193304.GC7561@sasha-vm>
References: <20180323013037.GA9190@wotan.suse.de>
 <20180323034145.GH4818@magnolia> <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia> <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180327070637.GX5652@dhcp22.suse.cz> <20180327195435.GE9190@wotan.suse.de>
 <20180328132148.GN9275@dhcp22.suse.cz>
In-Reply-To: <20180328132148.GN9275@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0904;7:+DRebUuNZdQzL/WWBRpfhKvRq+P3TNElChl8fYA8DWq9lptXGWZ7671HkUUThesum4g/yMJsnVk6zjnlEdfaViQvIA1dJEw1SxgN+ZYZYvhIc/jb8r5ZH1FXPuD3jJtktXJK6Xm/z3P6sSHnYKGTCZtDOs7ow62UqT5MK4UzYH/SqlCmT5/GIHbnyxW1CqVRNWi0tqEhzrgrWI2hG7Ax+R1gEszW3VYCxkOSpQjFTkux7tJ8hc5fq+UJidNuOn87;20:pvshzAvnfBERzxm57+5WV7lDVhE/P6gQCTJiGI8tipQcW1o4aSs5xKTL3v/mpr0GQp2APEi6dGu61f0RtD+WtJQ/Ab1H7N04FewEOtmoCleMzKI5+bl2Azfpi7bqHdWOA5H5ehIjoWi2qb0FEkoGkEOF3/2aVCovnmuU0wON4gY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f883b7b4-4315-4e19-5120-08d594e2bb8d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0904;
x-ms-traffictypediagnostic: DM5PR2101MB0904:
x-microsoft-antispam-prvs: <DM5PR2101MB09049A0908EA06B00CB7624DFBA30@DM5PR2101MB0904.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0904;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0904;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(377424004)(2900100001)(3660700001)(72206003)(81156014)(486005)(81166006)(486005)(476003)(229853002)(6486002)(6916009)(6436002)(25786009)(11346002)(10290500003)(54906003)(446003)(39060400002)(8936002)(76176011)(86362001)(68736007)(8676002)(2906002)(14454004)(86612001)(4326008)(99286004)(3280700002)(478600001)(22452003)(5250100002)(106356001)(33656002)(305945005)(1076002)(6512007)(5660300001)(7736002)(10090500001)(186003)(53936002)(7416002)(33896004)(105586002)(316002)(93886005)(9686003)(6246003)(26005)(102836004)(6116002)(3846002)(33716001)(66066001)(97736004)(6506007)(6346003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0904;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: HPBiLXBM+yYWygzG7rVleflumO0IEEAsThocdpZyBZKlhBRbWeT7vCBP6Xg2UUK7kq9FpC0Up3mTPLsjQztXzwwTu3x0NdxvVLGLj8Drc3nznBW/LaEd793AWxuDbKqgqaNjUb30Aa0XzP188gZ12LTHrkPPohsUiiAhYdVreqMr+sL9sK6bz5+5PYED4mQJD82aGwqV4uKfeI1FJ3d9aPBy/Gs2REEBfnbg7UYCDwfx3Bdxk2wD/XQxQgMyY026Ap6V0/Uyoj4kWQPDq1k7Y9EITcgPjV1JzdlL1NJucw++gqD76jsavOzi0g3EPlyjULnsnzs5lXV7vt9G53mv1A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B5140F3BB2D1E4CB24230C00239FFE4@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f883b7b4-4315-4e19-5120-08d594e2bb8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 19:33:06.6989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0904
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596211162447532781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 03:21:48PM +0200, Michal Hocko wrote:
>On Tue 27-03-18 19:54:35, Luis R. Rodriguez wrote:
>> On Tue, Mar 27, 2018 at 09:06:37AM +0200, Michal Hocko wrote:
>> > So by no means the MM backports were reviewed by me. And considering h=
ow hard
>> > it is to get any review for MM patches in general I strongly suspect t=
hat
>> > others didn't review either.
>> >
>> > In general I am quite skeptical about the automagic backports
>> > selections, to be honest. MM patches should be reasonably good at
>> > selecting stable backports and adding more patches on top just risks
>> > regressions.
>>
>> BTW other than suggesting we needing *actual review* of the MM patches, =
are
>> there known unit tests which could be run as well? Thinking long term.
>
>There are some in selftests but most fixes are quite hard to get a
>specialized testcase for. Rememeber the MM is a pile of heuristics to
>handle large scale of workloads.

Would running mmtests for each patch help here at all?

--
Thanks,
Sasha=
