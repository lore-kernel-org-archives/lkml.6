Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELvl1QP87bCADVDppByPyZhXp2I2h9r3Z2qkwWGaZy6DIyjfZdztUW308Xn6OFit6YlIa3IF
ARC-Seal: i=1; a=rsa-sha256; t=1522040101; cv=none;
        d=google.com; s=arc-20160816;
        b=BxeH/zlom/1jPdR2Au8LcPccQeK3aAIxwF4HPvCNbThghNgUbfdwne0bHUIGO2qlE9
         jiwYmDlTStBaH07kk7uCUAJlR3tHL+NZSgYBtNV8j7hL3RCWE9/W+2nbdAqBM9CxXJON
         f79q7eK9VDgdIXSByY/XLquHs2qqi/eX5qVfDh17vULgrVK6lmhnHH36axpXs924sS7/
         HWL19nr/sWrcaA68/bd26gPeqe9aOJarjctQSzSrIwsUKjPDgmclEsfBg9fNQV+ruJNJ
         cy4el6TJ+Ruhhkm3H8WMwhLV3bJc1UG7HJ2IGxIIIppjCF6Jp7wy+P9tgPTZE1v2youy
         jBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=fxGhdk3+nksxlG2sNYgLL4Pp373ynGtcaVzjiCEXopc=;
        b=aoi/9FLh6NrSKyTl3Gr/kU+4LT6NkyWR+Ydu878o11QCutIuPOFE4GivbLFr0bOnMC
         /kYR9FZp22JTwJ2qoVNG94CPbAFm+aaNOGD0DtrGABNEGEMG0yJrTsLj+uEW/iOWOwpy
         GkH1LOp8khN7NILaKD4vTdsHVh3g4+Vs7ifXMMtxWyQarxP9tC3LminbRmUHMs4fBLbG
         n46gEe8dkptXfhxF7pMooAZCH2YO2cXswfx1GSX94+5BBV1ObnXN3qVzuwcKdgaq6JhG
         KB9AXAM15YDWQ6Q3fO5nUTf2xNPyf7Nsc2Err2gCtZsnIQ06XoiALhec/E23rOurAKdU
         T1Dw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=dGYo/qMA;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.90 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=dGYo/qMA;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.90 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Luis R. Rodriguez"
	<mcgrof@kernel.org>, Christoph Hellwig <hch@lst.de>, xfs
	<linux-xfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh
 Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>, Michal Hocko
	<mhocko@kernel.org>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Topic: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Index: AQHTwtP9a8CoG3+qW0i20XM40DTMGKPfGSwAgACKZ4CAAlPwAA==
Date: Mon, 26 Mar 2018 04:54:59 +0000
Message-ID: <20180326045241.GA3394@sasha-vm>
References: <20171123060137.GL2135@magnolia>
 <20180323013037.GA9190@wotan.suse.de> <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de> <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de> <20180324090638.GB1170@kroah.com>
 <20180324172159.GR4818@magnolia>
In-Reply-To: <20180324172159.GR4818@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:lw1G1D3rzhJI/W1FqovZsmSFbKrZnZ6vjJ0VV/4AK2niDTjCO+CS5kxy5KEe/WVBiD0vcYHtYAUVm7j0PbZJirxJt/oXethAAPScT5ImbJRkBwnE+c1MBRzswFNyuJukfCT1zvvz92ugDWiGGnqILUGTb8OHdNozMLfawaEcaueLsrPiIN9mJNSIE8cV5lhKncEqaEg2dkP519oCc3jpDQuRrAmObAtrL45mtBN1QlpYAbxMGpqjFLE9v564T+/6;20:CZ1r4Yheemg9bpbtfQxrxhZlBCbJnzPNbiTx4AdPHH+0mBzsbsIeUt64GTWajypDBse/4BWoj0+wuFTquX+QiSwTEJGfgaKVJtS9sfaZqeDuUNIkbW7wS9wDqY3m6uxjKljyArYxne881aQLYNBMlQ+UKgqi1Ije3f0WxRddddg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b78a33a5-5854-4754-7f6f-08d592d5ba99
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
x-microsoft-antispam-prvs: <DM5PR2101MB10476C0AD306B25BDE0933A5FBAD0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 06237E4555
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(376002)(346002)(39380400002)(39860400002)(189003)(199004)(6346003)(5660300001)(26005)(6916009)(68736007)(229853002)(72206003)(2900100001)(186003)(33896004)(7416002)(2906002)(97736004)(316002)(106356001)(59450400001)(14454004)(22452003)(5250100002)(4326008)(10290500003)(478600001)(54906003)(3280700002)(102836004)(33656002)(105586002)(6506007)(93886005)(25786009)(7736002)(86362001)(8936002)(10090500001)(3660700001)(8676002)(66066001)(81166006)(81156014)(6246003)(76176011)(11346002)(53936002)(305945005)(86612001)(3846002)(6116002)(9686003)(33716001)(6512007)(6486002)(99286004)(1076002)(446003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: raXCDIhQTv4K5AYTBeKADYKQXGhyrIz4Zpl6eVGLWIzOe8KHtHDuBFp4YSg6ZiHHaAb/q6FrEsLexpdiqwLRZZu+h1xH8bFK4NClVrzbxX/zH6GS+QqsPPRMorAgP8x4vj0JnX4rKtBAK8Jq4FHGYgpu1JuXAYKP7DfvgKOQ6Ditsg2pGlku3pG2C8MKZCVpF6T0TvR3dZ7uYNh+J66i8OzAb3Al2obDl4gOkyGAmIHu2iMXXrWS+RxCIfTcAt7w3664U+1SnQH3SHPQj1f6KTCFmzCq4KZnsEAegTCPco/h7G3DW3X0leXq+IDHmfApvbO//GZjM+UN/RPOAUezjQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36B38F93D6B40B46B0965FAD4AFBA09D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78a33a5-5854-4754-7f6f-08d592d5ba99
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2018 04:54:59.6362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1595974721044846307?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 24, 2018 at 10:21:59AM -0700, Darrick J. Wong wrote:
>On Sat, Mar 24, 2018 at 10:06:38AM +0100, Greg Kroah-Hartman wrote:
>> On Fri, Mar 23, 2018 at 06:23:02PM +0000, Luis R. Rodriguez wrote:
>> > On Fri, Mar 23, 2018 at 10:26:20AM -0700, Darrick J. Wong wrote:
>> > > On Fri, Mar 23, 2018 at 05:08:13PM +0000, Luis R. Rodriguez wrote:
>> > > > On Thu, Mar 22, 2018 at 08:41:45PM -0700, Darrick J. Wong wrote:
>> > > > > On Fri, Mar 23, 2018 at 01:30:37AM +0000, Luis R. Rodriguez wrot=
e:
>> > > > > > On Wed, Nov 22, 2017 at 10:01:37PM -0800, Darrick J. Wong wrot=
e:
>> > > > > > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
>> > > > > > > index 61d1cb7..8012741 100644
>> > > > > > > --- a/fs/xfs/xfs_inode.c
>> > > > > > > +++ b/fs/xfs/xfs_inode.c
>> > > > > > > @@ -2401,6 +2401,24 @@ xfs_ifree_cluster(
>> > > > > > >  }
>> > > > > > >
>> > > > > > >  /*
>> > > > > > > + * Free any local-format buffers sitting around before we r=
eset to
>> > > > > > > + * extents format.
>> > > > > > > + */
>> > > > > > > +static inline void
>> > > > > > > +xfs_ifree_local_data(
>> > > > > > > +	struct xfs_inode	*ip,
>> > > > > > > +	int			whichfork)
>> > > > > > > +{
>> > > > > > > +	struct xfs_ifork	*ifp;
>> > > > > > > +
>> > > > > > > +	if (XFS_IFORK_FORMAT(ip, whichfork) !=3D XFS_DINODE_FMT_LO=
CAL)
>> > > > > > > +		return;
>> > > > > >
>> > > > > > I'm new to all this so this was a bit hard to follow. I'm conf=
used with how
>> > > > > > commit 43518812d2 ("xfs: remove support for inlining data/exte=
nts into the
>> > > > > > inode fork") exacerbated the leak, isn't that commit about
>> > > > > > XFS_DINODE_FMT_EXTENTS?
>> > > > >
>> > > > > Not specifically _EXTENTS, merely any fork (EXTENTS or LOCAL) wh=
ose
>> > > > > incore data was small enough to fit in if_inline_ata.
>> > > >
>> > > > Got it, I thought those were XFS_DINODE_FMT_EXTENTS by definition.
>> > > >
>> > > > > > Did we have cases where the format was XFS_DINODE_FMT_LOCAL an=
d yet
>> > > > > > ifp->if_u1.if_data =3D=3D ifp->if_u2.if_inline_data ?
>> > > > >
>> > > > > An empty directory is 6 bytes, which is what you get with a fres=
h mkdir
>> > > > > or after deleting everything in the directory.  Prior to the 435=
18812d2
>> > > > > patch we could get away with not even checking if we had to free=
 if_data
>> > > > > when deleting a directory because it fit within if_inline_data.
>> > > >
>> > > > Ah got it. So your fix *is* also applicable even prior to commit 4=
3518812d2.
>> > >
>> > > You'd have to modify the patch so that it doesn't try to kmem_free
>> > > if_data if if_data =3D=3D if_inline_data but otherwise (in theory) I=
 think
>> > > that the concept applies to pre-4.15 kernels.
>> > >
>> > > (YMMV, please do run this through QA/kmemleak just in case I'm wrong=
, etc...)
>> >
>> > Well... so we need a resolution and better get testing this already gi=
ven that
>> > *I believe* the new auto-selection algorithm used to cherry pick patch=
es onto
>> > stable for linux-4.14.y (covered on a paper [0] and when used, stable =
patches
>> > are prefixed with AUTOSEL, a recent discussion covered this in Novembe=
r 2017
>> > [1]) recommended to merge your commit 98c4f78dcdd8 ("xfs: always free =
inline
>> > data before resetting inode fork during ifree") as stable commit 1eccd=
bd4836a41
>> > on v4.14.17 *without* merging commit 43518812d2 ("xfs: remove support =
for
>> > inlining data/extents into the inode fork").
>> >
>> > Sasha, Greg,
>> >
>> > Can you confirm if the algorithm was used in this case?
>>
>> No idea.
>>
>> I think xfs should just be added to the "blacklist" so that it is not
>> even looked at for these types of auto-selected patches.  Much like the
>> i915 driver currently is handled (it too is ignored for these patches
>> due to objections from the maintainers of it.)
>
>Just out of curiosity, how does this autoselection mechanism work today?
>If it's smart enough to cherry pick patches, apply them to a kernel,
>build the kernel and run xfstests, and propose the patches if nothing
>weird happened, then I'd be interested in looking further.  I've nothing
>against algorithmic selection per se, but I'd want to know more about
>the data sets and parameters that feed the algorithm.

It won't go beyond build testing.

>I did receive the AUTOSEL tagged patches a few days ago, but I couldn't
>figure out what automated regression testing, if any, had been done; or
>whether the patch submission was asking if we wanted it put into 4.14
>or if it was a declaration that they were on their way in.  Excuse me

There would be (at least) 3 different mails involved in this process:

 1. You'd get a mail from me, proposing this patch for stable. We give
 at least 1 week (but usually closer to 2) to comment on whether this
 patch should or should not go in stable.

 2. If no objections were received, Greg would add it to his queue and
 you'd get another mail about that.

 3. A few more days later, Greg would release that stable tree and you'd
 get another mail.

>for being behind the times, but I'd gotten accustomed xfs patches only
>ending up in the stable kernels because we'd deliberately put them
>there. :)
>
>If blacklisting xfs is more convenient then I'm happy to continue things
>as they were.

No problem with blacklisting subsystems if maintainers prefer it that
way, but the i915 case was slightly different as their development
process was very quirky and testing was complex, so they asked to just
keep doing their own selection for stable.

However, looking at stable history, it seems that no patch from fs/xfs/
was proposed for stable for about half a year now, which is something
that the autoselection project is trying to help with.

A different flow I'm working on for this is to send an email as a reply
to the original patch submission to lkml if the patch is selected by the
network, including details about which trees it was applied to and build
results. I think it might work better for subsystems such as xfs.


--
Thanks,
Sasha=
