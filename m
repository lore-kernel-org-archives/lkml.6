Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06FCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8732C20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KFvhHonf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfA2TUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:20:43 -0500
Received: from mail-eopbgr1310100.outbound.protection.outlook.com ([40.107.131.100]:58688
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727056AbfA2TUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2pGo3/V8UroyLYvMx2nwVRLSEXzrFdGRz/hP/EJAi8=;
 b=KFvhHonfsrklPRk1buF2v4zWPDB7sGq/NnOm+hG8txjmckTKz9VJjMVp/VHiODjDSOFj+lgxlt5nQmtUjZ0vgHPORcHwwuQlQUdGgWHtttvlDBuzMcaGrh6ZGk6qXVPfnYPc6mhkCquOlz+cSvcFOo34DGLJSjh+TtCO1ysQ8kM=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0155.APCP153.PROD.OUTLOOK.COM (10.170.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.6; Tue, 29 Jan 2019 19:20:28 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.008; Tue, 29 Jan 2019
 19:20:28 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>
CC:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Thread-Topic: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Thread-Index: AQHUsfdSwFQKguS0PEqWQ+jwS7iPOKW6o/swgAAzdACAAAXaYIAKRoiAgAAQ2xA=
Date:   Tue, 29 Jan 2019 19:20:28 +0000
Message-ID: <PU1P153MB01699B96311157EA9DF515E6BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <PU1P153MB0169EB8CFC0A69407A8AE2C2BF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190122064246.GA28613@ubu-Virtual-Machine>
 <PU1P153MB01696D28CDDC098307EBD5AFBF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190128195845.GA3723@ubu-Virtual-Machine>
In-Reply-To: <20190128195845.GA3723@ubu-Virtual-Machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-29T19:20:25.7605001Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3d1bc18d-4c18-41d6-b524-cc79661462b6;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [131.107.174.220]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0155;6:8FpSKuzaYQdncJQ4IFDKvvC0g4YrHrBISgZptGZEQn5FXkFlWSSYq5K3DypHY9wFKK4bCanAD0g1ccMXX2VW8ee+rcLz7LVH7rWFDvQTFJDjB6yXOTf0eAYuj4PmcwWXOg8sw2km9hrHZYBPKHhqyeWbDLrNlgPZYYAnE+SbEAmDSbNrSW9H77Dvrh/tBdRCP2hGRO/DpQu2W+Yz3YazYZXKsvBpe6zJihbNstAakgrYLPOAqR8lmph/5sHLwd1qG5P7yIO1MQBFYMj+4sePErya7BtPNHawqW4/tE68meEMIezpXeQ9MPMSAMzHNRfwdKIoV+MHFLJsoICfhn5c+oHwKdJGUWyDY87s5SEt9OWqcqjmO8uAxOhBjFq2ragHTouhaCAZNu27OeQAp/V9pd6Sqq1q3uJHkqjjfRBNrE0xR7jypCkWjzLvMt+nNcONwEXMmrt2jEN+2mJyFepJ7g==;5:l0vP3QKUb5UrEhj2zlnjd3dqYIcIG59n+6vX8W1Nci5lvsV85tH95Ug+Cp2Py0xPwmLjVtRrad3hQWY6K1qK6ISROg/8Sk6dHhuSyI71bTT68Ulsxh/+utJy+8GlavgFUM0H5AjkECpjIEL2nlhM/f+qyWJAUNJAuEwtmiRj2f62NvQBv6TQmehameMPzkmBcYRaVFSzuKwvuJR0rY8ZdA==;7:KaEvFZTLCLRaG2ylvdjsH1p1CNnHoPmz+fjz8LL52Ds7cMx1Q3tJp15+jnWqYL3vS75T0wnVse+woByUdYnenlThx7+wLcmO47+zWmqNDoVbhbrZ3+u8YiRmHYiLbvlTQVrbuyv51hkqgjVu+Vr6YA==
x-ms-office365-filtering-correlation-id: b0ec37e9-b965-4c38-81cd-08d6861ed42b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0155;
x-ms-traffictypediagnostic: PU1P153MB0155:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB015548D282D95DBE34EC1371BF970@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39860400002)(366004)(189003)(199004)(478600001)(99286004)(4326008)(6346003)(26005)(186003)(14444005)(256004)(76176011)(102836004)(11346002)(305945005)(33656002)(97736004)(66066001)(486006)(6506007)(446003)(25786009)(7736002)(54906003)(39060400002)(74316002)(476003)(316002)(53936002)(55016002)(9686003)(93886005)(6916009)(8990500004)(1411001)(10090500001)(68736007)(7696005)(10290500003)(6246003)(6436002)(106356001)(22452003)(105586002)(2906002)(71200400001)(71190400001)(3846002)(86362001)(6116002)(86612001)(8936002)(81156014)(8676002)(14454004)(81166006)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0155;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kr67MTK2QA4VaXjWSh0m7olfZPl8B/R+c0vZ+fPR3v4Z0x6FdtB+MAFYzZSa0O5QegqhpUinMWzfJgV0QPS51GGqWJSuhOxXtvoFy3qCAMTIq8WBPYJ0QaUzWXJOok/YnyxAQytkZN5dUchOa62Cv4FnSaCwNg4mGkOzGeJHaL9gNI8cL8UGD4rAG6DqtL1b9NH2Tr+DslF+54ukqIT0DWm2DGOhsHQ5JDZ+KfMJOIZ7x/1CTBT4aunVnsfUVsHXbmJo7LoX3lFtPbw4vKYJCZ7vOEyonacsbupeyH2mH9/9VykWm/h/PxH/kOvD+JQ9Cg75b/c8mNPJCoWgFZ1bya92ejZ8I0hEIQfvzHzcTrUE3+DcJf+NpYav8KoZObnAYjUBT0JqomLGGUyACXvVg48ECBpqj/a3WDEA1oQARco=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ec37e9-b965-4c38-81cd-08d6861ed42b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 19:20:28.1308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kimberly Brown <kimbrownkd@gmail.com>
> > ...=20
> > But as you pointed, at least for sub-channels, channel->ringbuffer_page
> > can indeed disappear in vmbus_close() -> ... -> vmbus_free_ring(), and
> > the "attribute->show()" could crash when the race happens.
> > Adding channel_mutex here seems to be able to fix the race for
> > sub-channels, as the same channel_mutex is used in
> vmbus_disconnect_ring().
> >
> > For a primary channel, vmbus_close() -> vmbus_free_ring() can still
> > free channel->ringbuffer_page without notifying the "attribute->show()"=
.
> > We may also need to acquire/release the channel_mutex in vmbus_close()?
> >
> > > Actually, there should be checks that "chan" is not null and that
> > > "chan->state" is CHANNEL_OPENED_STATE within the locked section. I'll
> > > need to fix that.
> > I suppose "chan" can not be NULL here (see the above).
> >
> > Checking "chan->state" may not help to completely fix the race, because
> > there is no locking/synchronization code in
> > vmbus_close_internal() when we test and change "channel->state".
> >
>=20
> The calls to vmbus_close_internal() for the subchannels and the primary
> channel are protected with channel_mutex in vmbus_disconnect_ring().
> This prevents "channel->state" from changing while "attribute->show()" is
> running.
Ah, I think you're right.=20
=20
> > I guess we may need to check if channel->ringbuffer_page is NULL in
> > the "attribute->show()".
> >
>=20
> For the primary channel, vmbus_free_ring() is called after the
> return from vmbus_disconnect_ring(). Therefore, the primary channel's
> state is changed before "channel->ringbuffer_page" is set to NULL.
> Checking the channel state should be sufficient to prevent the ring
> buffers from being freed while "attribute->show()" is running. The
> ring buffers can't be freed until the channel's state is changed, and
> the channel state change is protected by the mutex.
I think you're right (I noticed in a previous mail you mentioned you would
improve your patch to check "chan->state" with the mutax held).

> I think checking that "channel->ringbuffer_page" is not NULL would
> also work, but, as you stated, we would need to aquire/release
> channel_mutex in vmbus_close().
Then it looks unnecessary to check "channel->ringbuffer_page".
=20
> > PS, to prove that a race condition does exist and can really cause a pa=
nic or
> > something, I usually add some msleep() delays in different paths so tha=
t I
> > can reproduce the crash every time I take a special action, e.g. when I=
 read
> > the sysfs files of a NIC, I try to remove hv_netvsc driver. This way, I=
 can prove
> > a patch can indeed help, at least it can fix the crash which would happ=
en
> > without the patch. :-)
> >
>=20
> Thanks! I was able to free the ring buffers while "attribute->show()"
> was running, which caused a null pointer dereference bug. As expected,
> the mutex lock fixed it.
Awesome!

-- Dexuan
