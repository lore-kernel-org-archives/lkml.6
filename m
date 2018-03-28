Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx485+UN4KWSJPkZXHFA24UidaivZ7G8ur238EGQal27IS3LoIf9dAkpVGDoTIK6B9FTSDs4l
ARC-Seal: i=1; a=rsa-sha256; t=1522199518; cv=none;
        d=google.com; s=arc-20160816;
        b=dfatCtNgX2oVVw++pnhGkZrYNcl0zX4untCXn3A4iDLknsFiyJPAZyssZkY2DrN4Ap
         TRNTTsLP4wSOPyUyod0DwFJ7r+bU/S3J4g5JTuz5oeS/zgBqs7fCmLpbzGvoi6ZFVzC3
         B9zogukrCEwC6NMzwcSISOvSm4U4bL/Cqu4jh3OCt2AjclyZ1n4k5gj/OAUwyDp5u7zT
         sJDKDiDqTACeZuCKOTeD4cnqmwI/ygqaTqGP47OIEGWwQsMd1AkVMhiJ3aBRRP5/f/bg
         ffyb1b9UKRwf3Nk1SsOQJcsuDHtSm4jVsfQAEXu36gykfIamzMf2JO07OktPd69C9aMz
         SAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=dYZM+b1Iwft/juo0aBpB06erQgvSxWcfzuEeLZCtzO8=;
        b=IjIh1zFhMEJHtrufWcskXcHlrC3Kl9YRCd/Rlj5nBtGy6/ZTFgKgbGh9NsfMK6Aazc
         81O/2Q1z71o2Mf1YFhBeU2obQYwYnMxU4QQG7ZSf5Ofv3CP/tpiFqlXsc/6LzS/DRcb4
         bgvtuq45vagbNtrH7bJ339bhMiC5/+NwzkZ3TyRasKl0dIsuLjwhasgI9usRKJ3zT8yI
         dq0vu5sxu1/h2RuSJpHV9C6JChadyWncL+gMCFDepiLwywlSL0K2/PUzuQXYUbt+WoMp
         ftcSbi2BVt/xXKF9JqFRjWYp4dwJa+3Y/3Vc2tgl9jcpIEpj6YFmq9FmM9OYz4tVATx8
         nucA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=exnSCdvN;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.91 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=exnSCdvN;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.91 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Michal Hocko <mhocko@kernel.org>
CC: Sasha Levin <levinsasha928@gmail.com>, Dave Chinner <david@fromorbit.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>, "Darrick J. Wong"
	<darrick.wong@oracle.com>, Christoph Hellwig <hch@lst.de>, xfs
	<linux-xfs@vger.kernel.org>, "linux-kernel@vger.kernel.org List"
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh
 Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>, Joerg Roedel
	<joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Topic: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Index: AQHTwtP9a8CoG3+qW0i20XM40DTMGKPhjRGAgAGo14CAAHi7gIABLzcA
Date: Wed, 28 Mar 2018 01:11:55 +0000
Message-ID: <20180328011152.GA7561@sasha-vm>
References: <20171123060137.GL2135@magnolia>
 <20180323013037.GA9190@wotan.suse.de> <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de> <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de> <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180327070637.GX5652@dhcp22.suse.cz>
In-Reply-To: <20180327070637.GX5652@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:nt8WUqFoz8Veh+MvePN+hJLpfD9Ip8JNFGQ6MdORF0/s2lmg9hzBj278j0aLGkC4e9a577TvdNwcnw5LBzfZOHfGGfRTU66Ek2BQmlADuwODBCZg03fkC/y2IsDmKSDfN+bfb6xeGP7SfZNWVvjaPIsD+v1jP0YPJh9mILf1kuqBqHUxfNXLHCEoZQGMzXIFSCZQ0lmDQdntWGd1l45W5l9IwPV1vYNkS+1QG/Wb7NyzJ12TengMTsNn9sjH5wtj;20:lkY/lkM5FafAXJk/WNk1eBVdEyOPxsErs2uhJLsGRiJazwqMkp/yZsVlODYKbIGJgjEJwGznVRdVbp7qdAou7HljwVb2suYf1V3ldUWYuLXLIVJz80yDWtTBK3DEVSy++wo5CxZwRmjKE/dQMO+zI8/GquiTs3ZFMBqLjrgsfwk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6d5426e-fcf1-4fb9-2d72-08d59448e599
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
x-microsoft-antispam-prvs: <DM5PR2101MB09025207C306883095925480FBA30@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39380400002)(39860400002)(366004)(396003)(376002)(346002)(377424004)(189003)(199004)(305945005)(99286004)(72206003)(2906002)(7736002)(9686003)(478600001)(14454004)(3280700002)(6512007)(53936002)(93886005)(105586002)(6246003)(26005)(6346003)(6486002)(6436002)(6506007)(33716001)(186003)(68736007)(66066001)(10290500003)(102836004)(76176011)(7416002)(81166006)(33896004)(22452003)(5660300001)(81156014)(33656002)(6916009)(39060400002)(106356001)(5250100002)(316002)(229853002)(10090500001)(25786009)(1076002)(3846002)(97736004)(11346002)(486005)(54906003)(4326008)(575784001)(86362001)(486005)(476003)(3660700001)(446003)(2900100001)(86612001)(6116002)(8676002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 2Tv9io3NPZyKrYtypxKXVepkGVu7x95ws9sEN2IOhNxeyuvvgTfeufVW3wJHEq0UtdZM1vdnFi9gICBogbCAaRyxz028UwPglqu5bKOaDMAPg+aw5w+LwvDpyJceXuKU0Ob8cMH0kzhWqhOrs6kpzy/VEcQll18ZgSyrgEqp/XBRqZkc1224Eaa/r3po0qZyWiHNbzmNY5dHB7Z80LtL5n87S5XOUZcZ1AMoHSeaN6gxIhL9J/wlp66LxIY0eLXEMHxW5A6tBV3CU3xpKRcMkyILUzOUbqpvd80zbYRXCQlpIgeft8xrZepNM85QN/Sdc4b8jhGMFxxJaKEPtJDLBQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B03628C6FB3BF4084DBE7795852B767@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d5426e-fcf1-4fb9-2d72-08d59448e599
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 01:11:55.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596141882183585528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 09:06:37AM +0200, Michal Hocko wrote:
>On Mon 26-03-18 19:54:31, Sasha Levin wrote:
>[...]
>> About half a year ago. I'm not sure about the no visibility part -
>> maintainers and authors would receive at least 3 mails for each patch
>> that got in this way, and would have at least a week (usually a lot
>> more) to object to the inclusion. Did you not receive any mails from
>> me?
>
>Well, I was aware of your emails yet my free time didn't really allow me
>to follow those patch bombs. I responded only when some email subject
>hit my eyes as being non-stable candidate. So by no means the MM
>backports were reviewed by me. And considering how hard it is to get any
>review for MM patches in general I strongly suspect that others didn't
>review either.

Being aware is different than saying it was snuck in without anyone
knowing.

>In general I am quite skeptical about the automagic backports
>selections, to be honest. MM patches should be reasonably good at
>selecting stable backports and adding more patches on top just risks
>regressions.

Okay, let's take mm/ as a subsystem that is doing a good job with
submitting stuff to -stable.

There were 40 patches in total going into the 4.14 LTS tree that touched
mm/. Out of those, 5 were selected via the "automagic" process:

> 647a37ec1a17 mm/frame_vector.c: release a semaphore in 'get_vaddr_frames(=
)'
> d91c3f2e540f mm/early_ioremap: Fix boot hang with earlyprintk=3Defi,keep
> b2ba0bd34695 kmemleak: add scheduling point to kmemleak_scan()
> 5ca94e03675a slub: fix sysfs duplicate filename creation when slub_debug=
=3DO
> 342ee8775800 mm, x86/mm: Fix performance regression in get_user_pages_fas=
t()

The only "questionable" one here I see is the performance regression
one, which I decided to keep in because it's a rather severe one in a
common code path.

Even good subsystems might sometimes miss a patch or two.

But yes, I've received less response from maintainers than I expected,
so I'll switch it to an opt-in model for new patches that go upstream.


--
Thanks,
Sasha=
