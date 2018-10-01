Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A89C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4972089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JLzlPYOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4972089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeJBDbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:31:20 -0400
Received: from mail-eopbgr60104.outbound.protection.outlook.com ([40.107.6.104]:31923
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbeJBDbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0smYRLId2SHamY3P1USvta7IEEEvQqwBXdBLlcgu9Y=;
 b=JLzlPYOKWBBWfkqyRoejGatv4LTUJYY8R7UU/8T0Gcbr5tzd8gBcTVDIqn7bcH3xg9wuZZbzufT8WmwL5+UHA0Oy7LvWPaF4QZad3UJsh4KfhqMOv9W7EHVm5RHRwEfDl4bWgaDxl8YDK+dBmGjEM0UUAZ5UdozgYAC5EGHYePo=
Received: from AM6PR08MB3253.eurprd08.prod.outlook.com (52.135.164.146) by
 AM6PR08MB3352.eurprd08.prod.outlook.com (52.135.165.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Mon, 1 Oct 2018 20:51:37 +0000
Received: from AM6PR08MB3253.eurprd08.prod.outlook.com
 ([fe80::a458:ca6c:fe4e:fc39]) by AM6PR08MB3253.eurprd08.prod.outlook.com
 ([fe80::a458:ca6c:fe4e:fc39%4]) with mapi id 15.20.1185.024; Mon, 1 Oct 2018
 20:51:37 +0000
From:   Andrey Vagin <avagin@virtuozzo.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "criu@openvz.org" <criu@openvz.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: Setting monotonic time?
Thread-Topic: Setting monotonic time?
Thread-Index: AQHUWWdaiE2peLl8zUKo0W79mOHGKaUK3jqA
Date:   Mon, 1 Oct 2018 20:51:36 +0000
Message-ID: <20181001205124.GA23620@outlook.office365.com>
References: <20180919205037.9574-1-dima@arista.com>
 <874lej6nny.fsf@xmission.com> <20180924205119.GA14833@outlook.office365.com>
 <874leezh8n.fsf@xmission.com> <20180925014150.GA6302@outlook.office365.com>
 <87zhw4rwiq.fsf@xmission.com>
 <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>
 <87mus1ftb9.fsf@xmission.com>
 <alpine.DEB.2.21.1809282023350.1432@nanos.tec.linutronix.de>
 <877ej2xc23.fsf_-_@xmission.com>
In-Reply-To: <877ej2xc23.fsf_-_@xmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.0 (2018-05-17)
x-originating-ip: [2620:0:1000:fd1f:f3f3:aec8:82f8:da4d]
x-clientproxiedby: DM5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:3:c0::21) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB3352;20:uvgSXk+mm0tuUcMaYz095hZ5GIOxUHeZxCO4ATvnwt7UvluElRiLhIVdrQ1K675Yi6j2RC0K2oL0tWZZhV2TKABOvudp9vUL8oPtOIU117g57Wo6N3kpdHy/kQzt9mGm1KHcrRXbu/LGzdV5DmTpQ7+pAV3FRnxygZRLvCACsv4=
x-ms-office365-filtering-correlation-id: 5f9be4c6-d64f-4ec2-71f9-08d627dfad98
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3352;
x-ms-traffictypediagnostic: AM6PR08MB3352:
x-microsoft-antispam-prvs: <AM6PR08MB3352B169CF0046D4C2C3D2E5CFEF0@AM6PR08MB3352.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR08MB3352;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3352;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(376002)(346002)(136003)(366004)(199004)(189003)(316002)(6506007)(5250100002)(3480700004)(8936002)(386003)(81166006)(81156014)(8676002)(14454004)(105586002)(102836004)(7736002)(54906003)(7416002)(305945005)(33656002)(106356001)(58126008)(52116002)(2906002)(76176011)(99286004)(6116002)(68736007)(2900100001)(6436002)(46003)(6916009)(6246003)(6512007)(4326008)(1076002)(446003)(11346002)(486006)(478600001)(7116003)(256004)(97736004)(476003)(39060400002)(229853002)(5660300001)(6486002)(53936002)(93886005)(25786009)(186003)(9686003)(33896004)(5024004)(86362001)(71190400001)(71200400001)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3352;H:AM6PR08MB3253.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TWrMxhZ5Lgm7Pyalf2NElgDzjWD3CCNlTMpII//c3SAIFFgj/gJlsGzlroV8tvoN2tY05y8MTu5h2+CFlDL67kfJDbksimaMxNA3Xg8+n+Hhg9w/AZUYifYZQx7DyVCnLR/txCTa/N6nzDKrGpZvn6zj2t1JeYgWd07f7Y+jKGWK4gOZ6QJ1tCCHPyQ4xO1lJCq8uxYSFjR17X9oPGD/hfT4ZteuwvoyPDwdrwRfD5vJSIbwsjDMEbF7bZ14W3RDd904sw4+YF5P09E7B/AOjUbRhRfmSjccDhogerKRcRzBOML9QAxcKfiiAa5ViL/WVdQ9AFrMxYEnva/c5F40c0Hya5byGeJNxToE8xP3qYo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="koi8-r"
Content-ID: <72741018C87A6A4F880EEF1058CBD8DC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9be4c6-d64f-4ec2-71f9-08d627dfad98
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 20:51:36.8957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 11:15:32AM +0200, Eric W. Biederman wrote:
>=20
> In the context of process migration there is a simpler subproblem that I
> think it is worth exploring if we can do something about.
>=20
> For a cluster of machines all running with synchronized
> clocks. CLOCK_REALTIME matches. CLOCK_MONOTNIC does not match between
> machines.   Not having a matching CLOCK_MONOTONIC prevents successful
> process migration between nodes in that cluster.
>=20
> Would it be possible to allow setting CLOCK_MONOTONIC at the very
> beginning of time?  So that all of the nodes in a cluster can be in
> sync?

Here is a question about how to synchronize clocks between nodes. It
looks like we will need to have a working network for this, but a
network configuration may be non-trivial and it can require to run a few
processes which can use CLOCK_MONOTNIC...

>=20
> No change in skew just in offset for CLOCK_MONOTONIC.
>=20
> There are also dragons involved in coordinating things so that
> CLOCK_MONOTONIC gets set before CLOCK_MONOTONIC gets used.  So I don't
> know if allowing CLOCK_MONOTONIC to be set would be practical but it
> seems work exploring all on it's own.
>=20
> Dmitry would setting CLOCK_MONOTONIC exactly once at boot time solve
> your problem that is you are looking at a time namespace to solve?

Process migration is only one of use-cases. Another use-case is
restoring from snapshots. It may be even more popular than process
migration. We can't guarantee that all snapshots will be done in one
cluster. For example, a user meets a bug, does a container snapshot and
attaches it to a bug report.

>=20
> Eric
