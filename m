Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BBBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BF920817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="KWOR5Nmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BF920817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeK0At7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:49:59 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:13568
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbeK0At7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xg7wkn1WJsO0HH/9EBlHnC7RB0uywTwiWPOeKxLqAAU=;
 b=KWOR5NmpXKoLuzdgucCPhTHKHzIqnv7s0ilHFm2H3TGoY7itj4Z9nmEEulH8yQxR2wZwZ1r3dIjbm7J51X8OUaVOqH72yWlRPN8yg+ZAsE38JxSbsYX8aW7oIKYjgCldCqodN/4+V4I0Ppjck8u285kSlV6YxMYtM+44S02j8WA=
Received: from AM4PR0501MB2769.eurprd05.prod.outlook.com (10.172.216.13) by
 AM4PR0501MB2161.eurprd05.prod.outlook.com (10.165.45.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 13:55:38 +0000
Received: from AM4PR0501MB2769.eurprd05.prod.outlook.com
 ([fe80::c8e7:b496:3494:9455]) by AM4PR0501MB2769.eurprd05.prod.outlook.com
 ([fe80::c8e7:b496:3494:9455%10]) with mapi id 15.20.1361.019; Mon, 26 Nov
 2018 13:55:37 +0000
From:   Ran Rozenstein <ranro@mellanox.com>
To:     "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "dipankar@in.ibm.com" <dipankar@in.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: RE: [PATCH tip/core/rcu 02/19] rcu: Defer reporting RCU-preempt
 quiescent states when disabled
Thread-Topic: [PATCH tip/core/rcu 02/19] rcu: Defer reporting RCU-preempt
 quiescent states when disabled
Thread-Index: AQHUb27SVlgbygUSaE+GPdWo3UdIVqU2Ei+ggAA2BYCAAXlekoAAnViAgAFPuYCAAztHAIAlVdDA
Date:   Mon, 26 Nov 2018 13:55:37 +0000
Message-ID: <AM4PR0501MB27690D8721451EEE5082E593C5D70@AM4PR0501MB2769.eurprd05.prod.outlook.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
 <20180829222047.319-2-paulmck@linux.vnet.ibm.com>
 <AM4PR0501MB27691ECD1B0ECB0531B16F20C5F30@AM4PR0501MB2769.eurprd05.prod.outlook.com>
 <20181029142735.GZ4170@linux.ibm.com> <20181030034452.GA224709@google.com>
 <20181030125800.GE4170@linux.ibm.com>
 <20181030222123.GB44036@joelaf.mtv.corp.google.com>
 <20181031182259.GH4170@linux.ibm.com> <20181102194356.GA8378@linux.ibm.com>
In-Reply-To: <20181102194356.GA8378@linux.ibm.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ranro@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0501MB2161;6:gAoZ7tegwrbUvyefSTGKVm6l547UZfbQoVpL3mLfIubKFDJru0pPNnAgWmB8EtY3BsdeUMJtZwGfmphWCg8uBFcVck5v5A1NTclnxGJTe8JPmwbkQ0EcZU7BE7babDW8Klmr2YKr5NbV+V8xfElfMuTt6rrpv5+B7drQCSTv+wyTtISTjB2mryOAzSXAp2yxW36HBOqny9zJyj6YXNqI+5MP33EmizPlB49q99AnaOWJqIABcWuktiCvfv06lhGKJlkdjDyYdfwKVwTqqO5ry53GcDFxNpLWTS9GFbGDkcPENj6W+0nS+Yy6Y5RLbvN3EbY5wTveumlL9rJOiZJ9n6pxl50LA9LidVoQAUc+yX/lK0miNWY32DGIyrXIiioT1BZfKc1csznojDrVjZX4wIoxBFy70bjaax6Rm1469F8Ncd9EuG6uLFm4/W+epFFkzGk5J3Dbvi6aeCyJ36OPDw==;5:ddi6+JoFHTuoaLO6QGreP0lP9we/9D1jHUDE8N5ZW0yxvhuwEpOKIw47emaNynATYvWoiED6XLnwBiY0j1WqPhheBd/3JzUUijFYZrIrpy5GZhVO+3mXwXDDsiAj2bHhPrWGvkSYjidjjYr8I2DEYuTm+Fix92fW+tnWF0lQ4kA=;7:RiXi57qjUBDDbQ5MhPMIN+LF3Qa5uogjgczLtfZXCxrPhS/MbYHqFMw8c29J0qXeOhwNHoSdx9WTp56ABYipV8udKOzuJEUaA1C6YptDobcYoJxbO0vHJMgW1kEQbYvgyMdrJfPdRop3xOhHStXwNw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8f97b8ab-b50e-4559-306b-08d653a6d856
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2161;
x-ms-traffictypediagnostic: AM4PR0501MB2161:
x-microsoft-antispam-prvs: <AM4PR0501MB2161E05657E1D014DA6CD6CEC5D70@AM4PR0501MB2161.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM4PR0501MB2161;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0501MB2161;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(39860400002)(346002)(189003)(199004)(2906002)(478600001)(7416002)(86362001)(93886005)(25786009)(316002)(5660300001)(74316002)(54906003)(305945005)(7736002)(33656002)(14454004)(68736007)(476003)(97736004)(110136005)(3846002)(6116002)(8676002)(81166006)(81156014)(8936002)(99286004)(9686003)(71190400001)(26005)(186003)(71200400001)(53936002)(55016002)(7696005)(102836004)(76176011)(6506007)(106356001)(229853002)(4326008)(66066001)(105586002)(107886003)(2501003)(14444005)(11346002)(446003)(39060400002)(6246003)(486006)(256004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2161;H:AM4PR0501MB2769.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NL7A2fLOKXqpU3qE/MEVPgKr3TBUDKpMKjEIxFa/ylTUDV15PWolIMkSOV5qj3MgXl6ehISgQe2TOOF7VLBA2dAp+OE+qMvtQmksxunQE7xmZqd3FmPqLGlCkpKgFU8NFPHlCzCcIU7itZjFAoZYgkmW/1NBmY/v50c1omjJNVLPvw1xOe6Zg6s4skXr5qaBFs2PIBjDZtf60zJEJDCCvCK+xsbRrJ+9P/lbkPOLwFC34lHt8ThfGNf+bOehTHVrLpm5+0pbhi1F2/uh5lRyPjp/haf8BzmO1RnWXcatFtqSao4tRx2yJ56LfEREBw12Mz9okqHQoC7GK80MbRE61llxi+cdUZOeMuEmPXKbUjI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f97b8ab-b50e-4559-306b-08d653a6d856
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 13:55:37.6988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Hearing no objections, here is the updated patch.
>=20
> 								Thanx, Paul
>=20
> ------------------------------------------------------------------------
>=20
> commit 970cab5d3d206029ed27274a98ea1c3d7e780e53
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Mon Oct 29 07:36:50 2018 -0700
>=20
>     rcu: Avoid signed integer overflow in rcu_preempt_deferred_qs()
>=20
>     Subtracting INT_MIN can be interpreted as unconditional signed intege=
r
>     overflow, which according to the C standard is undefined behavior.
>     Therefore, kernel build arguments notwithstanding, it would be good t=
o
>     future-proof the code.  This commit therefore substitutes INT_MAX for
>     INT_MIN in order to avoid undefined behavior.
>=20
>     While in the neighborhood, this commit also creates some meaningful
> names
>     for INT_MAX and friends in order to improve readability, as suggested
>     by Joel Fernandes.
>=20
>     Reported-by: Ran Rozenstein <ranro@mellanox.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>=20
>     squash! rcu: Avoid signed integer overflow in rcu_preempt_deferred_qs=
()
>=20
>     While in the neighborhood, use macros to give meaningful names.
>=20
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>=20


Hi,

What is the acceptance status of this patch?

Thanks,
Ran

