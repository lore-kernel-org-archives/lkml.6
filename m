Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107E4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0CA20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="kl0cduJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfANWUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:20:44 -0500
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:45952
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726653AbfANWUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8yBm63o+XOjDTtiO1Ps3fhn6OA9hooFAIP5On75y8U=;
 b=kl0cduJj0HaNHLhpmdv7gg/HqRA7BuTjvn/jf5QTIa33hzZFbKzSvE2j8IbJEQ81Ftgj2zKUh7c6Bn0t+eKT3BuL9c/sZP4bz5seeKraFY2ab7HiXJjcL20RbSaVnNkDO0NAU/7vVRf0/VQ4nDPCPPOmdtA99JTg2OmW5SNZxtU=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2815.eurprd05.prod.outlook.com (10.172.11.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Mon, 14 Jan 2019 22:20:38 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::d0e:3a7b:424e:9a71]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::d0e:3a7b:424e:9a71%5]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 22:20:38 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Myungho Jung <mhjungk@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] RDMA/cma: Rollback source IP address if failing to
 acquire device
Thread-Topic: [PATCH v2] RDMA/cma: Rollback source IP address if failing to
 acquire device
Thread-Index: AQHUqK2U9FbHYp9drUuzX3yy++zFrqWvXU3A
Date:   Mon, 14 Jan 2019 22:20:38 +0000
Message-ID: <VI1PR0501MB2271F66D02209FA0327904A1D1800@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <20190110062727.GA25844@myunghoj-Precision-5530>
In-Reply-To: <20190110062727.GA25844@myunghoj-Precision-5530>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2815;6:C4E/ejEA1zLU3+algfEaXqE3regFp0wNPnxPJWqAC3d9pdI8YapapJXbL4NbgiTpjK5Cy8nWynQ2PBtKU5ufqjXPpKdfc+IGyEofeykbNzOwJkUtVHVdiB8X6mds30J8KhHtSrk8z1hnbcKPdhfq+8QgioOwpjNRvgpP3Exe8jLtuKTYAoHfOG19sIR9vq0IeFfl93Cd7FjKGAXtrv+hptlaA0FFNpuc61WYBVHsaQgkYpGg2CZWDa12CTGXAVfiqNzg/iBf1rFOrQf+lMPYQJwyb3fOyhxG65HCZpi7urwyjZxdE8jiwRkg2wB59A1NQeqsHIO6jwHXaBOVRkI3j1ctUaffA2SbW4j42/0HLbO9ONytJHglqEP9ctkOzjjqBNqerhW9JsOCIZ8+qPw2sossWwHHJpYXCbDqs/YZY9SIMmX/FQUDHO/+ZM1R1dACUbahveiJO8IFT3ZW3jld8A==;5:/tjS2xRnkvQq6Grrgo9VSxolgO/3iVPLMNuwl2ZZIjvYaf//jypOANL+tN468tKSWg5W1ZhXK77/ObZHz5+KVgUP1GsmX7SZc83W9D6RKqcsjJZsAf5wKxQtlJ5qxF/I5NjlQqSoLLzDOq8tuiNWtGJICf5DaWoGGyKOhMlrB46MDEiN8SX0mx+Uv7pMxInbAd59s/QmZ4iWuhGT+uxYog==;7:oZ0ik7LejbWw0bYnoxzHQEp5GEbWIOsq2GOMc0l4sKDUt9QaO1rP52l+ZIJuuQJaQD3PrAv9aNPOP1ixFTBOFPyhAL0G4RJ549mq2Ep4T99WHYgxOqV6RKDRmU7caPlytFgh7buCFGanLH6dsEJpWw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 99858782-e359-488e-66c3-08d67a6e8371
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2815;
x-ms-traffictypediagnostic: VI1PR0501MB2815:
x-microsoft-antispam-prvs: <VI1PR0501MB281514506B45F54F05939AB3D1800@VI1PR0501MB2815.eurprd05.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(13464003)(7696005)(486006)(2906002)(9686003)(7736002)(54906003)(33656002)(76176011)(26005)(305945005)(66066001)(186003)(53546011)(99286004)(102836004)(6506007)(6246003)(55016002)(53936002)(4326008)(25786009)(39060400002)(6436002)(316002)(110136005)(97736004)(14454004)(478600001)(3846002)(6116002)(11346002)(5660300001)(229853002)(8936002)(8676002)(81156014)(81166006)(105586002)(74316002)(71190400001)(71200400001)(256004)(446003)(476003)(86362001)(68736007)(14444005)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2815;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: udvmPUvxHWobf19jXeZY/vFE1E9xH4LSqxkKVjynyWHYQNEgGcsLBSUAfiaRVDf00zN+bPS5M8B5ipvftQ0Ob+D4wk4AgtkU5SioOKbl65eHoQO13L95yr2bjJ7AK3LIcqshfxAj2VbrN4eyGsFORZqgAPffT0BzFSLZixPFkzonwbVHCj09bNM8mDQ/IKvoaH414IRg0nhUzLEUAUv6adDTpbHjk67E/rVHgvW0PZ+SJvpCv87SH1ooDefo0LQHduB9gv0uV410oIVtNAlY4VRiK64kmz7Z9BbeUpk9YQPJEhV149lkZSbHHSLi84WN7udBGPkTF6LAGkRnwKE6x+EeqtxX4/GL9byuNGqS5mzOAQ96wl8eavuAsTIa36XeTlu9Y4DbuaW1lhDcHzCQjMGKcM/ARnV6MXXAidLB+50=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99858782-e359-488e-66c3-08d67a6e8371
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 22:20:38.8441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Myungho Jung <mhjungk@gmail.com>
> Sent: Thursday, January 10, 2019 12:28 AM
> To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>;
> Parav Pandit <parav@mellanox.com>
> Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v2] RDMA/cma: Rollback source IP address if failing to
> acquire device
>=20
> If cma_acquire_dev_by_src_ip() returns error in addr_handler(), the devic=
e
> state changes back to RDMA_CM_ADDR_BOUND but the resolved source IP
> address is still left. After that, if rdma_destroy_id() is called after
> rdma_listen(), the device is freed without removed from listen_any_list i=
n
> cma_cancel_operation(). Revert to the previous IP address if acquiring de=
vice
> fails.
>=20
> Reported-by: syzbot+f3ce716af730c8f96637@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> ---
>  drivers/infiniband/core/cma.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.=
c
> index 63a7cc00bae0..8cd113b0ddfb 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -2963,13 +2963,22 @@ static void addr_handler(int status, struct
> sockaddr *src_addr,  {
>  	struct rdma_id_private *id_priv =3D context;
>  	struct rdma_cm_event event =3D {};
> +	struct sockaddr *addr;
> +	struct sockaddr_storage old_addr;
>=20
>  	mutex_lock(&id_priv->handler_mutex);
>  	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY,
>  			   RDMA_CM_ADDR_RESOLVED))
>  		goto out;
>=20
> -	memcpy(cma_src_addr(id_priv), src_addr,
> rdma_addr_size(src_addr));
> +	/*
> +	 * Store the previous src address, so that if we fail to acquire
> +	 * matching rdma device, old address can be restored back, which
> helps
> +	 * to cancel the cma listen operation correctly.
> +	 */
> +	addr =3D cma_src_addr(id_priv);
> +	memcpy(&old_addr, addr, rdma_addr_size(addr));
> +	memcpy(addr, src_addr, rdma_addr_size(src_addr));
>  	if (!status && !id_priv->cma_dev) {
>  		status =3D cma_acquire_dev_by_src_ip(id_priv);
>  		if (status)
> @@ -2980,6 +2989,8 @@ static void addr_handler(int status, struct sockadd=
r
> *src_addr,
>  	}
>=20
>  	if (status) {
> +		memcpy(addr, &old_addr,
> +		       rdma_addr_size((struct sockaddr *)&old_addr));
>  		if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_RESOLVED,
>  				   RDMA_CM_ADDR_BOUND))
>  			goto out;
> --
> 2.17.1
Reviewed-by: Parav Pandit <parav@mellanox.com>
