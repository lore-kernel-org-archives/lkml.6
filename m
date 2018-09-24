Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF1FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E65E204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PnIcDNEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E65E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbeIXVNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:13:50 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:64608
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730744AbeIXUut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH6mW216NJ0dOB27gw9AT+McibVTVN75TGOkskf4KRw=;
 b=PnIcDNEZVleCPowGaJvlU6fZIRMYChBtvjG25N5z/2knmSQpECn6RB0BlM9zYpDq6wp2pZ4QffJMcR76GOoA7tZiuM4G+dCt+sxhtojrjy7Rt4xIBr3KIxuJv6AOstF2T6vcltEHMRTWCasx8K6fl/qNWoDaJg2Hp4FBW56IqWk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Mon, 24 Sep 2018 14:48:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 11/76] bpf, sockmap: fix potential use after free
 in bpf_tcp_close
Thread-Topic: [PATCH AUTOSEL 4.18 11/76] bpf, sockmap: fix potential use after
 free in bpf_tcp_close
Thread-Index: AQHUVBWaAve+Z6LVhkKOYQZV7mKcvA==
Date:   Mon, 24 Sep 2018 14:48:06 +0000
Message-ID: <20180924144751.164410-11-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:iPoupT+VXT890EzTMTg3tZD49zdb5M/k5T6tG+os0ZtHqoySaFF0sr9GiMiQHp7fx7ug77xBw04tKr891OvUl4DtuEK7gNJa0AyXxZ16oM5kArmEgXyvPWifrg3Nvf+iPCObaePfG1cMmlPgsVIu1uoYAeGREmU9wKtoI9RH5TcAmE59NKkqdswz8Qe2aU6IM1XoIn01Ji+w5O/rrtTMJkwiktFDk/eG1qxqkqDZ7LqyYnewjbTgYtfKo17h5XDbWKLpddjU5VJ6dxe1vqICn8J7rCw/KMAhdMbamlxtbdwzM40u8a7DDMMZ5WS4Ad9hCsG3nI+0dEJJZgQftyd8NA/7L+ZsH2kvqTems7sC7IBEAO6vuSI7EO73ZhFBtEiQfeEEFE5X25hwfsd+DBQrK+2AkN4v4Zl0eBcJ+Jwg/wklEoCIVrT3IeBz/F4oTgnmG5l/3EpHDg9RywBBJuXyGQ==;5:CqhFiJ4Mv/opseDxldBLc8pgK6qqv4YSCJ0BLiNawXNWDqcTXQeJ5+L5Egg2yc3WzKfbGs+9hr3bOBIWwOhsk2aDG0aq/Qg3ik0m/J63O6uTP0QlQJYPsDOu14Du7YJ5d3iEG8llXtW/J7o5jIkLaitUqzLiJZlZF2TlpgBzQA0=;7:Ycvc5wtr1f0qIL9U9TiSUgI0t72zJf6O8MRiphHcsfIzpdGr6cv7gaysd+M8tIA1EY+AAHbDY0c9OcG/dRZRJJVRvPXqEhbwV4ETkY9yhRJyn2iYKf0+15RfpBqAe9Z5fmzk+Cr+zm1nATQOyETiKeEuZdCe6hk69nlTCDJDj7wFl1bSj/YJSW+mRvzBK3fjDC9vcfeG/Xo250mjFbN0WheC3tNI/QFFo7oIYskEnvd3c+giiz3PjGkM34mkCB84
x-ms-office365-filtering-correlation-id: a522cedc-6a4b-4d1f-2ff8-08d6222cbd87
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB0134381E2C973637214A725AFB170@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2900100001)(86612001)(3846002)(106356001)(97736004)(105586002)(478600001)(10290500003)(36756003)(71200400001)(71190400001)(6116002)(8936002)(76176011)(186003)(5250100002)(217873002)(2501003)(8676002)(2616005)(102836004)(26005)(81166006)(81156014)(476003)(14444005)(11346002)(446003)(256004)(305945005)(54906003)(486006)(68736007)(86362001)(6486002)(5660300001)(99286004)(4326008)(2906002)(7736002)(110136005)(6346003)(6506007)(6512007)(53936002)(6436002)(25786009)(107886003)(1076002)(14454004)(10090500001)(316002)(72206003)(22452003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ak869QH8b6UrCtTVyScHhb5fkrlx0WVqQysFmGWQQwaXfCMWfHE+NHKBINB9bLXZQLPUAhS1Ku9Pqas5+Sb2q3SN+tN9b8dqPYUuDBLSo+payJQQxuB4nbcx/fFzh4W5QecT8yzL9MmVEagxH587/SFclKJOkeiIi+olnSmbj57yXj3uCVxEpsLOMOGqKUTTelSjiSjRFTWt307GnkHzpl+GUpei9zzCP+R62cFdAUlNRZXvux4AAsd01xdZPei3M82JPsoPG4SJ4ekyj5zLYtatyqyAQbuGenHxv/VIBYydPZlnKzdnWxlQCExYGaDEkywJ/rG9eM3ECFe9Pu8kAXoZK4CJSf/SeavJJUc55tI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a522cedc-6a4b-4d1f-2ff8-08d6222cbd87
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:06.4455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit e06fa9c16ce4b740996189fa5610eabcee734e6c ]

bpf_tcp_close() we pop the psock linkage to a map via psock_map_pop().
A parallel update on the sock hash map can happen between psock_map_pop()
and lookup_elem_raw() where we override the element under link->hash /
link->key. In bpf_tcp_close()'s lookup_elem_raw() we subsequently only
test whether an element is present, but we do not test whether the
element is infact the element we were looking for.

We lock the sock in bpf_tcp_close() during that time, so do we hold
the lock in sock_hash_update_elem(). However, the latter locks the
sock which is newly updated, not the one we're purging from the hash
table. This means that while one CPU is doing the lookup from bpf_tcp_close=
(),
another CPU is doing the map update in parallel, dropped our sock from
the hlist and released the psock.

Subsequently the first CPU will find the new sock and attempts to drop
and release the old sock yet another time. Fix is that we need to check
the elements for a match after lookup, similar as we do in the sock map.
Note that the hash tab elems are freed via RCU, so access to their
link->hash / link->key is fine since we're under RCU read side there.

Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/sockmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index 58899601fccf..7afa2a54ee34 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -369,7 +369,7 @@ static void bpf_tcp_close(struct sock *sk, long timeout=
)
 			/* If another thread deleted this object skip deletion.
 			 * The refcnt on psock may or may not be zero.
 			 */
-			if (l) {
+			if (l && l =3D=3D link) {
 				hlist_del_rcu(&link->hash_node);
 				smap_release_sock(psock, link->sk);
 				free_htab_elem(htab, link);
--=20
2.17.1
