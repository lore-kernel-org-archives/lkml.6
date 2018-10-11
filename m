Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81570C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7D520659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="Irw3J6nU";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="PzRu/T6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7D520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ericsson.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeJKVMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:12:44 -0400
Received: from sesbmg22.ericsson.net ([193.180.251.48]:42170 "EHLO
        sesbmg22.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeJKVMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:12:44 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2018 17:12:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/simple;
        q=dns/txt; i=@ericsson.com; t=1539264622; x=1541856622;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oKHPUDSNSGy3FrqbLBgEOhVsfLAJbg+JvgrNR/yEGKM=;
        b=Irw3J6nUo4mKc3GgaFt48SSme7igIFpxvOc67V35JOxcphmfKqlIEV+X9PJ6U9Er
        cWjHMvipkmN25QABtHzMuEmpsqDqXDRNcsmObWAHI4gQfiZEEynJaBsh5KeXewZV
        QtqSsictn3cxFSlzfRB+5WJ3Gilfvnj+PwbtpJUeNUE=;
X-AuditID: c1b4fb30-776849e0000047d2-96-5bbf506ed610
Received: from ESESSMB502.ericsson.se (Unknown_Domain [153.88.183.120])
        by sesbmg22.ericsson.net (Symantec Mail Security) with SMTP id 43.EC.18386.E605FBB5; Thu, 11 Oct 2018 15:30:22 +0200 (CEST)
Received: from ESESSMR503.ericsson.se (153.88.183.112) by
 ESESSMB502.ericsson.se (153.88.183.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3; Thu, 11 Oct 2018 15:30:13 +0200
Received: from ESESBMB505.ericsson.se (153.88.183.172) by
 ESESSMR503.ericsson.se (153.88.183.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3; Thu, 11 Oct 2018 15:30:12 +0200
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESBMB505.ericsson.se (153.88.183.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1466.3 via Frontend Transport; Thu, 11 Oct 2018 15:30:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXLDbS9EPE+7L8mFM5uzCJByCDypEBvdvTo+XuB3+fI=;
 b=PzRu/T6XTS1Gm134omH9uYEv9lLKSQRICaKGt1/Ob+REA01BfKVNZAghmpKHRpo4LOoXc5xLFU0uGySaX1EsD74lOw6P2MEOvyl3oW/nk+ZgMXRQBxWt7zLA8lDbtBaGP+/ZFw17yf2zPv740HTgaw7FPjNBCCD7Twv9o4HYmVc=
Received: from BN6PR15MB1506.namprd15.prod.outlook.com (10.172.151.146) by
 BN6PR15MB1220.namprd15.prod.outlook.com (10.172.205.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Thu, 11 Oct 2018 13:30:09 +0000
Received: from BN6PR15MB1506.namprd15.prod.outlook.com
 ([fe80::a152:3084:171d:5540]) by BN6PR15MB1506.namprd15.prod.outlook.com
 ([fe80::a152:3084:171d:5540%7]) with mapi id 15.20.1207.029; Thu, 11 Oct 2018
 13:30:09 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     Ying Xue <ying.xue@windriver.com>,
        "dvyukov@google.com" <dvyukov@google.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "parthasarathy.bhuvaragan@ericsson.com" 
        <parthasarathy.bhuvaragan@ericsson.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>
Subject: RE: [PATCH net] tipc: eliminate possible recursive locking detected
 by LOCKDEP
Thread-Topic: [PATCH net] tipc: eliminate possible recursive locking detected
 by LOCKDEP
Thread-Index: AQHUYVqpPhlpQDofhUe3cmdRqVx8uqUaBE5g
Date:   Thu, 11 Oct 2018 13:30:09 +0000
Message-ID: <BN6PR15MB1506DF62FF6856794B109C4A9AE10@BN6PR15MB1506.namprd15.prod.outlook.com>
References: <1539259076-8562-1-git-send-email-ying.xue@windriver.com>
In-Reply-To: <1539259076-8562-1-git-send-email-ying.xue@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [198.24.6.220]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR15MB1220;6:0Z4Dh2C0YvuxfUkpH5WulSrf7fv1SBygyhaVwgCG1jgbpNBBJK7a/KSux0H9+DyYx2V1M8KTdNdd66T5aW+/uw798xZmLFtj2f2G9ADrw7wHcXR3NtP5CFZcAgC8ZjHbsN+/A7/FuETk+E+6Fz/CLS3y5hUcl+ho62jValViTN+C7snuzBRSzJJcF5fn89L3MO8EQapao0uPq+TYJDPCoOgH/mxehgnp5UTdG71LggnkvtFL+jL/1kDAZa618tqhwflqzlGGaKtmIOHIC/sgl6OJ21jQQU+ZJy6C7e145Ox9wh9mHl/4zFfmdUv+oSvPC2fgtp7ho4owoHGl+BH2mPi/1rqzDP85Zr7dNcYR8XRIMCDjeT/I8NRilBoVZeUx/ljDHaAe7InpPGdZHOdWOeqGl44epCdxVoLLIni7iXc+Lst4mNq92QX9djHewvW5mtVQEsdHtMnhGQuF4w2V6w==;5:eaY3MsyDR7A/ax/xg5gpA0HPxAIqJZQ3JYToNUFDTUv8I2wZJjQhpU/W9QSYsRCuzDvvsUcoT6LivUwN1P97Hc7HP57JuwZqqpGftltzAm9M+oTRkdT8r/RGS+eaxQx3maki9ZkBfi3eVv+ScpmdJaCpgC83Oql2flEiEPC1890=;7:LCTc68oP/Pgd/G+jUaezXIOtSzJZShC6Um5hQp6xd+Q2Zwbw5qotDEi+nez4b0Ea0NMCqk5ZryCXwqZeA4F6zflOJDywWK+OejAJD0HPefctwbsnBmFamUoQXrTIZEQWWZnsy/yhTVWK/DXkGspPtqdpktEjKlnrOkyDziitLFD9OgzFPAOBcli/oD9ty/4UIuNMHNDuEfD9WRJ3lqRY8JXCVGC472lD4o/0kqAtrNH8RqbNO3D5ePVHTSH+bWIo
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6b441e1f-15aa-482b-bd16-08d62f7daa56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1220;
x-ms-traffictypediagnostic: BN6PR15MB1220:
x-microsoft-antispam-prvs: <BN6PR15MB1220A9DCF488301E958BA4EB9AE10@BN6PR15MB1220.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(248295561703944)(37575265505322)(9452136761055)(143289334528602)(42262312472803)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:BN6PR15MB1220;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1220;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(376002)(346002)(189003)(199004)(13464003)(3846002)(486006)(476003)(2906002)(25786009)(11346002)(68736007)(8676002)(8936002)(5250100002)(55016002)(2900100001)(305945005)(110136005)(446003)(54906003)(2501003)(186003)(478600001)(4326008)(6116002)(14454004)(44832011)(256004)(26005)(14444005)(105586002)(76176011)(7696005)(66066001)(97736004)(99286004)(6506007)(53936002)(102836004)(5660300001)(7736002)(81166006)(106356001)(74316002)(81156014)(316002)(6246003)(71200400001)(86362001)(575784001)(9686003)(229853002)(6436002)(33656002)(53546011)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR15MB1220;H:BN6PR15MB1506.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aSQe1zANvutMSv9Da1vqpXAMTlNo63da3NWf6OQ2x5S4aKQW0fPiIcMDwPAqvmKS+/BBpbGmtJRUxcb6UatOtneEbxwGVtliv6O7B6qdwF51BaTC3zPQVspf6OF6O0RLvIfuUZJqyJMTbrQ2gJ3yESp5xWA5WbJQW30+oyq58RMVYTr3CsLGIYUd0+bBuIM7XxQVXbOxPWKKXLx1GAJiEAMfHvJnYLKJj4xmH+AEzeJmJ66ZyiUpBBoWxT6vP/gBjg60Y7mRYHGXzWPr2Pm+p0ECj9edMLumuQfqvWf1N/2/edMbcL9UhlMk2e/Y/Xxbi/i9PtJn0OmaJHnCC2lDGr8F8hO4OuI3zMsykIJ6488=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b441e1f-15aa-482b-bd16-08d62f7daa56
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 13:30:09.2230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1220
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHOffe3V2txWn5+GEpMZRk5XwQMeiBEdoIShECX1gzb2rqlE1N
        k2KUlBnWhBQ1xSnDUoLh2kzcUrbIZzHN1IoMzUear8qoLJXcrkX/fb7n+z2/x+EwpLCB58Wk
        KrJZpUKeLqJdqcrox3kBisiOuKCa9wJptb2QkmrGr/Olg23VtLRT6yE12i9IJ0ZGyFBaZmx8
        Q8i0hhyZWbtMyJYNPjK90URE8mJdDyWx6am5rDLwyFnXlKnFGTrrrn/e7Cc9oUZWUTFyYQDv
        h4WVHqoYuTJC/AxBi9VOcOI7goHxOv4/cfNaBY8TOgJGu/qdgsIaEnQddxDnlBHwzTZNc+ID
        guZ3jbSjDY39Yba8CDnYDUdBy2on6QiR+AUBSzWthMPYgWNgwrrC40KxYG2e4HMcAvM1S6SD
        KewHhuZSysECHA/2G93Ou0IcBguL/c4GLjgcSueGnHUQ9oAfvQ+dGRJ7wtvJWoLbG4POYic5
        dofZifWNPLORj4G+qRjueDf0DqkRx97wsvbWJrfz4V5lMscB8LmsbLPMSVgcXHc+C+AuBGOD
        fZuGGNZ0JTyO06DiiZnmuAbBqEmiQSFV/43H8T7Qmr/SHO+Fhro5ssq58nboqZyktIhqQu4q
        VpWYkRwSImGVqedUqkyFRMFmG9DG77Eafwe1otmPR20IM0i0VUAe74gT8uS5qvwMGwKGFLkJ
        Aiva44SCJHn+JVaZeUaZk86qbGgnQ4k8BdJTj2KFOFmezaaxbBar/OsSjIuXGt03XQ0a5vvq
        b+MmzXiqpT7hfIFu1BS92HJxmy1+UHPg2IMrMYHDGQUH1eqxiMTQwrBfsY1mbwKSw3v7fCL0
        c6Gv2mQNrwvchm3j5hJfy9qu4pmnwcGmWgu5RXpY9NwSPyBejSrfIxGXnNB3m62Seubn6fnL
        XwyNDQm5wdN+RSJKlSIPFpNKlfwPtu4SwTkDAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Jon Maloy <jon.maloy@ericsson.com>

///jon


> -----Original Message-----
> From: Ying Xue <ying.xue@windriver.com>
> Sent: October 11, 2018 7:58 AM
> To: Jon Maloy <jon.maloy@ericsson.com>; dvyukov@google.com
> Cc: davem@davemloft.net; parthasarathy.bhuvaragan@ericsson.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; tipc-
> discussion@lists.sourceforge.net
> Subject: [PATCH net] tipc: eliminate possible recursive locking detected =
by
> LOCKDEP
>=20
> When booting kernel with LOCKDEP option, below warning info was found:
>=20
> WARNING: possible recursive locking detected 4.19.0-rc7+ #14 Not tainted
> --------------------------------------------
> swapper/0/1 is trying to acquire lock:
> 00000000dcfc0fc8 (&(&list->lock)->rlock#4){+...}, at: spin_lock_bh
> include/linux/spinlock.h:334 [inline]
> 00000000dcfc0fc8 (&(&list->lock)->rlock#4){+...}, at:
> tipc_link_reset+0x125/0xdf0 net/tipc/link.c:850
>=20
> but task is already holding lock:
> 00000000cbb9b036 (&(&list->lock)->rlock#4){+...}, at: spin_lock_bh
> include/linux/spinlock.h:334 [inline]
> 00000000cbb9b036 (&(&list->lock)->rlock#4){+...}, at:
> tipc_link_reset+0xfa/0xdf0 net/tipc/link.c:849
>=20
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>=20
>        CPU0
>        ----
>   lock(&(&list->lock)->rlock#4);
>   lock(&(&list->lock)->rlock#4);
>=20
>  *** DEADLOCK ***
>=20
>  May be due to missing lock nesting notation
>=20
> 2 locks held by swapper/0/1:
>  #0: 00000000f7539d34 (pernet_ops_rwsem){+.+.}, at:
> register_pernet_subsys+0x19/0x40 net/core/net_namespace.c:1051
>  #1: 00000000cbb9b036 (&(&list->lock)->rlock#4){+...}, at:
> spin_lock_bh include/linux/spinlock.h:334 [inline]
>  #1: 00000000cbb9b036 (&(&list->lock)->rlock#4){+...}, at:
> tipc_link_reset+0xfa/0xdf0 net/tipc/link.c:849
>=20
> stack backtrace:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7+ #14 Hardware name:
> QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014 Call Tra=
ce:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1af/0x295 lib/dump_stack.c:113  print_deadlock_bug
> kernel/locking/lockdep.c:1759 [inline]  check_deadlock
> kernel/locking/lockdep.c:1803 [inline]  validate_chain
> kernel/locking/lockdep.c:2399 [inline]
>  __lock_acquire+0xf1e/0x3c60 kernel/locking/lockdep.c:3411
>  lock_acquire+0x1db/0x520 kernel/locking/lockdep.c:3900
> __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
>  _raw_spin_lock_bh+0x31/0x40 kernel/locking/spinlock.c:168  spin_lock_bh
> include/linux/spinlock.h:334 [inline]
>  tipc_link_reset+0x125/0xdf0 net/tipc/link.c:850
>  tipc_link_bc_create+0xb5/0x1f0 net/tipc/link.c:526
>  tipc_bcast_init+0x59b/0xab0 net/tipc/bcast.c:521
>  tipc_init_net+0x472/0x610 net/tipc/core.c:82
>  ops_init+0xf7/0x520 net/core/net_namespace.c:129
> __register_pernet_operations net/core/net_namespace.c:940 [inline]
>  register_pernet_operations+0x453/0xac0 net/core/net_namespace.c:1011
>  register_pernet_subsys+0x28/0x40 net/core/net_namespace.c:1052
>  tipc_init+0x83/0x104 net/tipc/core.c:140  do_one_initcall+0x109/0x70a
> init/main.c:885  do_initcall_level init/main.c:953 [inline]  do_initcalls
> init/main.c:961 [inline]  do_basic_setup init/main.c:979 [inline]
> kernel_init_freeable+0x4bd/0x57f init/main.c:1144
>  kernel_init+0x13/0x180 init/main.c:1063
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
>=20
> The reason why the noise above was complained by LOCKDEP is because we
> nested to hold l->wakeupq.lock and l->inputq->lock in tipc_link_reset
> function. In fact it's unnecessary to move skb buffer from l->wakeupq que=
ue
> to l->inputq queue while holding the two locks at the same time.
> Instead, we can move skb buffers in l->wakeupq queue to a temporary list
> first and then move the buffers of the temporary list to l->inputq queue,
> which is also safe for us.
>=20
> Fixes: 3f32d0be6c16 ("tipc: lock wakeup & inputq at tipc_link_reset()")
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Ying Xue <ying.xue@windriver.com>
> ---
>  net/tipc/link.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/tipc/link.c b/net/tipc/link.c index fb886b5..1d21ae4 100=
644
> --- a/net/tipc/link.c
> +++ b/net/tipc/link.c
> @@ -843,14 +843,21 @@ static void link_prepare_wakeup(struct tipc_link *l=
)
>=20
>  void tipc_link_reset(struct tipc_link *l)  {
> +	struct sk_buff_head list;
> +
> +	__skb_queue_head_init(&list);
> +
>  	l->in_session =3D false;
>  	l->session++;
>  	l->mtu =3D l->advertised_mtu;
> +
>  	spin_lock_bh(&l->wakeupq.lock);
> +	skb_queue_splice_init(&l->wakeupq, &list);
> +	spin_unlock_bh(&l->wakeupq.lock);
> +
>  	spin_lock_bh(&l->inputq->lock);
> -	skb_queue_splice_init(&l->wakeupq, l->inputq);
> +	skb_queue_splice_init(&list, l->inputq);
>  	spin_unlock_bh(&l->inputq->lock);
> -	spin_unlock_bh(&l->wakeupq.lock);
>=20
>  	__skb_queue_purge(&l->transmq);
>  	__skb_queue_purge(&l->deferdq);
> --
> 2.7.4

