Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AC3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A60F20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="WjSJ34Z7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A60F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeK3GdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:33:00 -0500
Received: from mail-eopbgr700071.outbound.protection.outlook.com ([40.107.70.71]:57072
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbeK3Gc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osi+9CcUsF+NZzBmVzI87YfS8q17YO1GMtz0X0ab6ck=;
 b=WjSJ34Z7cxEIWr4m7iCQqeVE8mRUgddQlUfhEdnh3g9117+LRZrNp9KR+yb9I+YRwJ3tMiLmnje3gK8Ye1hC5fsSoSXLpbN3v7ppj2QI6Lw1v2hg92QKo3Udhnh9GUFN7kAVLGKj0RZBpDsoSCuSQxyObv0nL1ge/marfGOzwzs=
Received: from BYAPR07MB4599.namprd07.prod.outlook.com (52.135.204.25) by
 BYAPR07MB4647.namprd07.prod.outlook.com (52.135.204.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Thu, 29 Nov 2018 19:25:48 +0000
Received: from BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::2423:5da9:8f12:aa65]) by BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::2423:5da9:8f12:aa65%3]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 19:25:48 +0000
From:   Jan Glauber <Jan.Glauber@cavium.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
Subject: Re: dcache_readdir NULL inode oops
Thread-Topic: dcache_readdir NULL inode oops
Thread-Index: AQHUeDnKfcShvdBH+0+6hZ8Ik/l9/A==
Date:   Thu, 29 Nov 2018 19:25:48 +0000
Message-ID: <20181129184950.GA7290@hc>
References: <20181109143744.GA12128@hc> <20181109155856.GC2091@brain-police>
 <20181110111656.GA16667@hc> <20181120182854.GC28838@arm.com>
 <20181120190317.GA29161@arm.com> <20181121131900.GA18931@hc>
 <20181123180525.GA21017@arm.com> <20181128200806.GC32668@arm.com>
In-Reply-To: <20181128200806.GC32668@arm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0008.eurprd05.prod.outlook.com
 (2603:10a6:203:91::18) To BYAPR07MB4599.namprd07.prod.outlook.com
 (2603:10b6:a02:f2::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [109.193.45.3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4647;6:8uMADR/t6FC3zYQaqjqL26g5/66P/nsLYzoS3UHEDHISWR2AN0mgR1BD3J6k02vS7fBqSRFEw0xqbAVEfhqwu6WEmyieWizWAPqmreLsg5L9AAxNPFkRvTREvta3Er7Z+HCKRVPyS3hY8iTkTZ99SRXUQKxQ6GMDagCVvx+6MI4BITm6Oo8C0KT34pVvDQ1/BAKZH8xTVPDN5v030s7mRGiep5bZM9zxbr+iTfJJ4j4yyhW9epuCcjsmMtoW/l2tFFgNTHx5tWlfRb7b2MIOYkj1ZVMDIf22BuuTKFzK3uZL4HxNQuL+AXb04KMOoq8S3hPp5NU2rJQ+GN5XJAVc7G98VsZBTDgKmf+vQiE03JyDA1jQFMNd8Vjyu4saYSnDqmGw/+q9pxF7Lm87wCAKEM7oloPmSxx7AcrKSlFV7jjzTkMuUE/yGtfOrV/QDX/QD+uSHLC6o9/XlkgA8jwB0A==;5:jHJwTCS5jP9rXLW4xhAmYkX495ZJZCpPVJf4L8Xj60BaE7mD2QUTlqkiw1hNWOu78hrAVWaMZvdeLdUa8jV+30YQXBkWBlBL7N9J+Ch/+FEuFQ8ax73De8nU9QADOj+HoFgZO3DIeERnSb059Ht+UUMcRvPC/zx8mlGaOIvNM4U=;7:VnZr9CrtbwWzyD9mdZduC1USOf0Oyic+LASPf1Mm9hVdbla8UuqynZN1yUiNvSWZJKM6Jb1bkJ+nJDvTvG/BjUpDDsIz8yrgAx4EA0AkCZyVEHrFCb5wdNGaXFDlA+cIqx81gs8oFH6IdaAD/6JX4g==
x-ms-office365-filtering-correlation-id: f6549322-c505-499a-baca-08d656307798
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4647;
x-ms-traffictypediagnostic: BYAPR07MB4647:
x-microsoft-antispam-prvs: <BYAPR07MB46470B23334785BEDE1D7EB691D20@BYAPR07MB4647.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4647;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4647;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(6246003)(386003)(86362001)(68736007)(316002)(71190400001)(2906002)(4326008)(6436002)(66066001)(53936002)(8676002)(71200400001)(5660300001)(6486002)(9686003)(93886005)(54906003)(6512007)(3846002)(1076002)(229853002)(6116002)(72206003)(256004)(102836004)(76176011)(33716001)(186003)(33896004)(44832011)(33656002)(81156014)(305945005)(476003)(14444005)(11346002)(25786009)(478600001)(446003)(97736004)(52116002)(14454004)(99286004)(486006)(106356001)(105586002)(26005)(7736002)(8936002)(6916009)(6506007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4647;H:BYAPR07MB4599.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HxENn4D5jcFyc4PF8n28sC6d2NKaMP6BMnNjC8SyyiwGTKyQ2/oPFmEx6iRMXuyp8+fWF8YuNQZ8PmjaS7K3dKNXWgHQath3lNXSmzCK7XkBq9QP0q3qpOglvCGMyKmtAivOQQN4YErwDPMT+005wf/QiYMhmrRnbDqSdeOIZNR2N8VyNqoFRvcCa1zq5RWPob82e/F7LGPWxGHYj6OgruIcYlm3X7zZWHVaC4tnbfCLLATcU1GVYE8cDi7TJX/MdO7y2238VslO42dC3e+e2uhZZiQE9T+R20b4+BhPbGTeC3AQhsCEY7Dd2e9xHju2Lgq46679xNZ28s1ulCWKUy3GWkYEwcDVhy+xN2VCawo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F8CEBC213D0DC4181E630E3BF425186@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6549322-c505-499a-baca-08d656307798
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 19:25:48.6764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 08:08:06PM +0000, Will Deacon wrote:
> I spent some more time looking at this today...
>=20
> On Fri, Nov 23, 2018 at 06:05:25PM +0000, Will Deacon wrote:
> > Doing some more debugging, it looks like the usual failure case is wher=
e
> > one CPU clears the inode field in the dentry via:
> >
> >       devpts_pty_kill()
> >               -> d_delete()   // dentry->d_lockref.count =3D=3D 1
> >                       -> dentry_unlink_inode()
> >
> > whilst another CPU gets a pointer to the dentry via:
> >
> >       sys_getdents64()
> >               -> iterate_dir()
> >                       -> dcache_readdir()
> >                               -> next_positive()
> >
> > and explodes on the subsequent inode dereference when trying to pass th=
e
> > inode number to dir_emit():
> >
> >       if (!dir_emit(..., d_inode(next)->i_ino, ...))
> >
> > Indeed, the hack below triggers a warning, indicating that the inode
> > is being cleared concurrently.
> >
> > I can't work out whether the getdents64() path should hold a refcount
> > to stop d_delete() in its tracks, or whether devpts_pty_kill() shouldn'=
t
> > be calling d_delete() like this at all.
>=20
> So the issue is that opening /dev/pts/ptmx creates a new pty in /dev/pts,
> which disappears when you close /dev/pts/ptmx. Consequently, when we tear
> down the dentry for the magic new file, we have to take the i_node rwsem =
of
> the *parent* so that concurrent path walkers don't trip over it whilst it=
s
> being freed. I wrote a simple concurrent program to getdents(/dev/pts/) i=
n
> one thread, whilst another opens and closes /dev/pts/ptmx: it crashes the
> kernel in seconds.

I also made a testcase and verified that your fix is fine. I also tried
replacing open-close on /dev/ptmx with mkdir-rmdir but that does not
trigger the error.

> Patch below, but I'd still like somebody else to look at this, please.

I wonder why no inode_lock on parent is needed for devpts_pty_new(), but
I'm obviously not a VFS expert... So your patch looks good to me and
clearly solves the issue.

thanks,
Jan

> Will
>=20
> --->8
>=20
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index c53814539070..50ddb95ff84c 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -619,11 +619,17 @@ void *devpts_get_priv(struct dentry *dentry)
>   */
>  void devpts_pty_kill(struct dentry *dentry)
>  {
> -       WARN_ON_ONCE(dentry->d_sb->s_magic !=3D DEVPTS_SUPER_MAGIC);
> +       struct super_block *sb =3D dentry->d_sb;
> +       struct dentry *parent =3D sb->s_root;
>=20
> +       WARN_ON_ONCE(sb->s_magic !=3D DEVPTS_SUPER_MAGIC);
> +
> +       inode_lock(parent->d_inode);
>         dentry->d_fsdata =3D NULL;
>         drop_nlink(dentry->d_inode);
>         d_delete(dentry);
> +       inode_unlock(parent->d_inode);
> +
>         dput(dentry);   /* d_alloc_name() in devpts_pty_new() */
>  }
