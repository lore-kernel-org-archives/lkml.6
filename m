Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8FFC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C269208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JUBWd8un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfADMxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:53:03 -0500
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:36322
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbfADMxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTBHS+XNX7sVRQCV6rYehTPjt8RuzNGUvBp02DKufPQ=;
 b=JUBWd8unQhI5u2xziPbbL3EbGPglxewHTjCQ1KQKPJ4++XovHKQG3xrnflfeAEETdj4Q9Gk33OBduwO6tvWE7Les7HsEgqdNmEaYy/+HXfgC61xStLqjc7wSB+xjayPHygFdbd9C4hnj/b39XRfQCVj7aD2WU+yWltf3zHIqZVg=
Received: from VI1PR04MB5567.eurprd04.prod.outlook.com (20.178.123.21) by
 VI1PR04MB1614.eurprd04.prod.outlook.com (10.164.84.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 4 Jan 2019 12:52:56 +0000
Received: from VI1PR04MB5567.eurprd04.prod.outlook.com
 ([fe80::4982:5d2d:5e69:f502]) by VI1PR04MB5567.eurprd04.prod.outlook.com
 ([fe80::4982:5d2d:5e69:f502%2]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 12:52:56 +0000
From:   Madalin-cristian Bucur <madalin.bucur@nxp.com>
To:     Yi Wang <wang.yi59@zte.com.cn>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xue.zhihong@zte.com.cn" <xue.zhihong@zte.com.cn>,
        "huang.junhua@zte.com.cn" <huang.junhua@zte.com.cn>,
        Junhua Huang <huangjunhua@zte.com.cn>
Subject: RE: [PATCH] fsl/fman: avoid sleeping in atomic context while adding
 an address
Thread-Topic: [PATCH] fsl/fman: avoid sleeping in atomic context while adding
 an address
Thread-Index: AQHUo/FzF7mNl5dSC0yYo3tIMbNfaaWfEBOg
Date:   Fri, 4 Jan 2019 12:52:56 +0000
Message-ID: <VI1PR04MB5567B65C73553524AA3774FFEC8E0@VI1PR04MB5567.eurprd04.prod.outlook.com>
References: <1546581001-38798-1-git-send-email-wang.yi59@zte.com.cn>
In-Reply-To: <1546581001-38798-1-git-send-email-wang.yi59@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com; 
x-originating-ip: [82.77.160.108]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1614;6:9uqYElI33pxJQzON5mMCNgcDbDDBC74GMQsEIIIuekMhWPGAL/x+jBeewfDOddY6zxCo3HnmXysFeXipwdhlsHMTqBGTrkrqzaLYKydDfl5K6672F9IIKIh4OkjowpV/1546Af7NoZXRFS6JgBPwR1nnF4MHBqobyd0AUvIvwKFBT5c503zMjgc+WGOVxJQnWBmVLv6gBkF2YthezZGOHfwQIiVxI10tFd54ogoTDEgr/qENbNx7xuuOLcYXqhgZIunNCvTUo0S3XWIL391VSIv/PvrYEP3kl+iLfcaiMuI3+9RgM+eiUp4thzq/X4D+JWb4CTC0qsjfnnUC7E/ZqElZ1kYbUXT5a/rf38ehZj+d/EPRLMYxQP0tIB3cjyUT9YP4ZZSkmfUTeESL9dAcYNipcxmStYJOKztfnPmlYqdDX2gyFMgUuNWlRcpR+pQF2n+YQTyp9LVL6hIfGJlO7w==;5:W9h5wWX+TNwhZgMt9YkHGuI+hECzIza5cNhma4GtkxI3iCWz+XDt3SFyYWoHxQoQHQ1FV/5olItzGJDHNzU2FEsVj/JM5R8Oglz2yl+vKECZYWBoqsB6IFd1cd3MnAYJ5Y4SQYDFYbVgE6h9rE4UXnFrVX7wD+eH1kek1E/5diw=;7:a+9qEtaieeN1MsDlhLQA2pq7hVyaq0p6t8+Fwix5f2ZRL06+80WaxopYgC7at7MpueHNLQuzFOBok4bde9xDe0pNKAKe264cV5v4gC3SPjHbIcVRXWYWRoiN+hQdSaxRBo9DIHg+GVe0frXZKyFx7Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e8d3fe6f-4d31-4bdf-0cfc-08d672438ca3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1614;
x-ms-traffictypediagnostic: VI1PR04MB1614:
x-microsoft-antispam-prvs: <VI1PR04MB16147047E95B76D07F2D07DEEC8E0@VI1PR04MB1614.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1614;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1614;
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(366004)(136003)(13464003)(189003)(199004)(9686003)(102836004)(316002)(99286004)(53936002)(446003)(6246003)(3846002)(2906002)(106356001)(105586002)(5660300001)(8676002)(81156014)(81166006)(7736002)(305945005)(476003)(486006)(97736004)(68736007)(7696005)(26005)(55016002)(4326008)(256004)(14444005)(25786009)(54906003)(186003)(11346002)(53546011)(6116002)(76176011)(6506007)(66066001)(478600001)(14454004)(71200400001)(71190400001)(6916009)(86362001)(229853002)(6436002)(8936002)(33656002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1614;H:VI1PR04MB5567.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pbq/p46ORR7mS9Sd5vMmId6zaoJzOSunXxIde/ESw5rOTw9XESWuahCfxePm/+ay61S7F6Bb0+Gt6O9Yoyzi9qsX0Bg/qD2vt8e7rkJXHmEYvHpHsnv5yqCwKFnwYVRYSDn+Qq2rOnf0JfezittPaz3V0NXcsXjHmPXl2zKjGGgRHILVxh7nzo6YAIcaUQzcGSDbNGn51WnZo28FYQbGZEi8Vd/ADO/513vgM6UczYGmIQHJOKAFDsxkQ6HGzEVemTzr4ZzwpminHFCog15wpsQ7N/hMea9Jb6DeJVJ1oF/q5vtCdLhS1TBQfAg8DLJm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d3fe6f-4d31-4bdf-0cfc-08d672438ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 12:52:56.6244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a duplicate of this other patch addressing the issue:

	commit 0d9c9a238faf925823bde866182c663b6d734f2e
	Author: Scott Wood <oss@buserror.net>
	Date:   Thu Dec 27 18:29:09 2018 -0600

	    fsl/fman: Use GFP_ATOMIC in {memac,tgec}_add_hash_mac_address()

Thank you,
Madalin

> -----Original Message-----
> From: Yi Wang <wang.yi59@zte.com.cn>
> Sent: Friday, January 4, 2019 7:50 AM
> To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
> Cc: davem@davemloft.net; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; xue.zhihong@zte.com.cn; wang.yi59@zte.com.cn;
> huang.junhua@zte.com.cn; Junhua Huang <huangjunhua@zte.com.cn>
> Subject: [PATCH] fsl/fman: avoid sleeping in atomic context while adding
> an address
>=20
> From: Junhua Huang <huang.junhua@zte.com.cn>
>=20
> dev_set_rx_mode will call function pointer mac_dev->add_hash_mac_addr
> while holding spin_lock_bh. The function pointer points to
> memac_add_hash_mac_address when ethernet type is fman-memac,
> which will kmalloc use GFP_KERNEL flag.
>=20
> / # ifconfig eth2 192.168.1.168
> [  576.604544] BUG: sleeping function called from invalid context at
> mm/slab.h:393
> [  576.610587] in_atomic(): 1, irqs_disabled(): 0, pid: 2751, name:
> ifconfig
> [  576.616105] 2 locks held by ifconfig/2751:
> [  576.618916] #0:(rtnl_mutex)at: [<c00000000080ba60>]
> .rtnl_lock+0x1c/0x30
> [  576.625523] #1:(_xmit_ETHER)at: [<c0000000007f9430>]
> .dev_set_rx_mode+0x24/0x54
> [  576.632745] CPU: 5 PID: 2751 Comm: ifconfig Tainted: G   W 4.9.115-
> rt93-EMBSYS-@332 #3
> [  576.642942] Call Trace:
> [  576.644085] [c00000007499b440] [c000000000a09eb4]
> .dump_stack+0xe0/0x14c (unreliable)
> [  576.650642] [c00000007499b4d0] [c000000000076f3c]
> .___might_sleep+0x1ac/0x278
> [  576.656493] [c00000007499b560] [c0000000001aad6c]
> .kmem_cache_alloc+0x144/0x28c
> [  576.662518] [c00000007499b620] [c000000000634c18]
> .memac_add_hash_mac_address+0x100/0x194
> [  576.669416] [c00000007499b6b0] [c000000000630b54]
> .set_multi+0x1bc/0x20c
> [  576.674829] [c00000007499b760] [c00000000063718c]
> .dpaa_set_rx_mode+0x84/0x104
> [  576.680765] [c00000007499b7e0] [c0000000007f9394]
> .__dev_set_rx_mode+0x64/0xdc
> [  576.686701] [c00000007499b870] [c0000000007f943c]
> .dev_set_rx_mode+0x30/0x54
> [  576.692464] [c00000007499b8f0] [c0000000007f98f4]
> .__dev_change_flags+0x98/0x1c4
> [  576.698573] [c00000007499b980] [c0000000007f9a4c]
> .dev_change_flags+0x2c/0x80
> [  576.704429] [c00000007499ba10] [c0000000008cde28]
> .devinet_ioctl+0x624/0x8e0
> [  576.710191] [c00000007499bb00] [c0000000008d1678]
> .inet_ioctl+0x1f4/0x250
> [  576.715697] [c00000007499bb70] [c0000000007c89d8]
> .sock_do_ioctl+0x50/0xa8
> [  576.721284] [c00000007499bc00] [c0000000007c94e8]
> .sock_ioctl+0x2b8/0x39c
> [  576.726786] [c00000007499bca0] [c0000000001e2500]
> .do_vfs_ioctl+0xc8/0x8b4
> [  576.732373] [c00000007499bd90] [c0000000001e2d44] .SyS_ioctl+0x58/0xa4
> [  576.737612] [c00000007499be30] [c0000000000007a4]
> system_call+0x38/0x108
>=20
> Signed-off-by: Junhua Huang <huangjunhua@zte.com.cn>
> ---
>  drivers/net/ethernet/freescale/fman/fman_memac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c
> b/drivers/net/ethernet/freescale/fman/fman_memac.c
> index 71a5ded..21dd557 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
> @@ -923,7 +923,7 @@ int memac_add_hash_mac_address(struct fman_mac *memac=
,
> enet_addr_t *eth_addr)
>  	hash =3D get_mac_addr_hash_code(addr) & HASH_CTRL_ADDR_MASK;
>=20
>  	/* Create element to be added to the driver hash table */
> -	hash_entry =3D kmalloc(sizeof(*hash_entry), GFP_KERNEL);
> +	hash_entry =3D kmalloc(sizeof(*hash_entry), GFP_ATOMIC);
>  	if (!hash_entry)
>  		return -ENOMEM;
>  	hash_entry->addr =3D addr;
> --
> 2.15.2

