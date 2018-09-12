Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A65DC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B131220880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Nbi7EbL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B131220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeILWpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:45:07 -0400
Received: from mail-eopbgr680106.outbound.protection.outlook.com ([40.107.68.106]:17888
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbeILWpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAx61j2BxwP5YSS3JX7uGRiZxNL6aKMjJ0Wr4P3m9Kw=;
 b=Nbi7EbL5O95ZfNCcLVMC1rhiY7/SSesS9SJHcWNS82tR30zac2DZ97yRtixuCONyb7emijGXBNvxUHE2zMJegG1yIk8a+FjGXyucZkesvMb93BJpb4Iqy9QYA3kzU0yQ5ZuGqNAtdFi8CoO8k1eja31BkkhlTnV/i4XIjXwkXW8=
Received: from DM5PR21MB0778.namprd21.prod.outlook.com (10.173.172.148) by
 DM5PR21MB0283.namprd21.prod.outlook.com (10.173.174.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Wed, 12 Sep 2018 17:39:29 +0000
Received: from DM5PR21MB0778.namprd21.prod.outlook.com
 ([fe80::d05f:7c53:cb46:9ecd]) by DM5PR21MB0778.namprd21.prod.outlook.com
 ([fe80::d05f:7c53:cb46:9ecd%9]) with mapi id 15.20.1143.010; Wed, 12 Sep 2018
 17:39:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH AUTOSEL 4.18 69/88] xen-netfront: fix queue name setting
Thread-Topic: [PATCH AUTOSEL 4.18 69/88] xen-netfront: fix queue name setting
Thread-Index: AQHURkLY+K2w4GlTsE6LaL1MANj2OKTlFWCAgAfdNgA=
Date:   Wed, 12 Sep 2018 17:39:29 +0000
Message-ID: <20180912173928.GE3821@sasha-vm>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
 <20180907003547.57567-69-alexander.levin@microsoft.com>
 <5f24d66d-57d4-4424-d524-58a6d0687f02@oracle.com>
In-Reply-To: <5f24d66d-57d4-4424-d524-58a6d0687f02@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0283;6:dL2XOpepPhQ3yc+aX6US8UaXuhyS1eO18QHNMOR/rBcFULr8YsJtlM5hi6m1DA/qjKD7p0uWNptwSg6g5fLiLq16bJTiVvlvPJmbYh7nHvtzuz/mdBpkYBtAoH19MRMUALe7bPdnfW0TjzT+HPEV6rm5vBaEJo040AtK2pxT6UDJScXJL4uwyX4Kv9u0ACwL1IAitGTqG2Eyj4Mca4TqHRnpfF/ETzC9XriWzHR4NFUVoZjzMs/BFqqgiLpSnM/hVWSoAqSFIU5AmGQzgxPibEh8hlWrvOTn6Sa2ID5m5p4M+t5XGvMxl9Cpl3JOQdjRluFtG1a9ausXD+Q7TSTing60lRQ+BD4sslWY8T5YMl9y/9B2Ki7ZbLbvSepMjDLi6Nym3TzsicEoJWMV6WP6Ooj0lexApnuWonzrZOPrWDOdk8wvmOeYeuubTLeQFw4D/VcEMyaJgn/od4c/A6TWkQ==;5:7QoyMvFReV0p5/oL51JxUAl95mxyoqDHg/cqgeCbJxISsDF0Ed2yk8N/XGBwqWagq7rixBx5vpxcm/ptafjbvPmYU9aPJO6QXv1aAix6MsfuxpT8UmxppyZZfk8ejDvsSyicyx1tXbXUkouTXXivqGLH6qAv8S7+06Z/4JMciXk=;7:TFo2M5F18Yx9J1TUZ8OoCpaZA7D3mUacCRhiNzEXJxTJVE38QDGtjfdOe0zUb0Koth075XWn0ZArNJ8i3XUIScePIW8QI4aBz/+RhNM5ogpkixKrLpDEPViLCc1je1RbHzpPBBMLwH8KUOkVDDXY7jG6jRfDHpCva9bTm4QniSzrbbgBnhAevXtrtPZDmHpGVv4hsHgNb8pxKarTxJvYh3Tk4OiJJOE5tQSBAUaMj/uKfWXd3bzjQzqxXQ8D5Pbx
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 75a9425d-2585-4979-17f6-08d618d6b15b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0283;
x-ms-traffictypediagnostic: DM5PR21MB0283:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB0283B5BA0E822BDB7E6729EEFB1B0@DM5PR21MB0283.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:DM5PR21MB0283;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0283;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(376002)(136003)(346002)(366004)(396003)(199004)(189003)(102836004)(186003)(10290500003)(22452003)(10090500001)(316002)(478600001)(14454004)(72206003)(105586002)(106356001)(66066001)(86612001)(6916009)(5250100002)(3846002)(2900100001)(33716001)(6116002)(97736004)(1076002)(575784001)(86362001)(486006)(446003)(81156014)(5660300001)(81166006)(229853002)(68736007)(4326008)(25786009)(8936002)(14444005)(33656002)(476003)(217873002)(11346002)(256004)(6486002)(9686003)(6512007)(6436002)(26005)(6346003)(6506007)(53936002)(305945005)(7736002)(99286004)(8676002)(76176011)(6246003)(33896004)(54906003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0283;H:DM5PR21MB0778.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: yzpPZHJROKk8rawRgTii+CjhpN1318aQD6f4w/19IcLCRyHQMrlhwouIGAuab46ig5dmN6BxDhoZo8zlvdLHvKpD478C/m4Eo/wfqhHrR0YVfooqmEw37SIunvUJtzAKlkNxlXDJ1PG9gZ5YsUmyFYX5RaSNotmbs6Bkje/pbIExb4UJb6kXk+c2rpFoI04Y6aMxT4LA3IcZjDsaE2kuHMY0rQTphIOrWnGYks54TWoLHxuTNsYTKY3Af86iq+cMs/LpWU20oRSJaR2Mmv1xzuYg0zmFcRGwcj1HMFIlmBfNPLsVr4fHcAEtCcijo11CRQMRgAaCWsdVfDIelrfQaCge/8Lud1ZZAUyax0HG8ps=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <769A518D57A616489307372E555134A9@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a9425d-2585-4979-17f6-08d618d6b15b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 17:39:29.5937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0283
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 01:33:55PM -0400, Boris Ostrovsky wrote:
>On 09/06/2018 08:36 PM, Sasha Levin wrote:
>> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>>
>> [ Upstream commit 2d408c0d4574b01b9ed45e02516888bf925e11a9 ]
>>
>> Commit f599c64fdf7d ("xen-netfront: Fix race between device setup and
>> open") changed the initialization order: xennet_create_queues() now
>> happens before we do register_netdev() so using netdev->name in
>> xennet_init_queue() is incorrect, we end up with the following in
>> /proc/interrupts:
>>
>>  60:        139          0   xen-dyn    -event     eth%d-q0-tx
>>  61:        265          0   xen-dyn    -event     eth%d-q0-rx
>>  62:        234          0   xen-dyn    -event     eth%d-q1-tx
>>  63:          1          0   xen-dyn    -event     eth%d-q1-rx
>>
>> and this looks ugly. Actually, using early netdev name (even when it's
>> already set) is also not ideal: nowadays we tend to rename eth devices
>> and queue name may end up not corresponding to the netdev name.
>>
>> Use nodename from xenbus device for queue naming: this can't change in V=
M's
>> lifetime. Now /proc/interrupts looks like
>>
>>  62:        202          0   xen-dyn    -event     device/vif/0-q0-tx
>>  63:        317          0   xen-dyn    -event     device/vif/0-q0-rx
>>  64:        262          0   xen-dyn    -event     device/vif/0-q1-tx
>>  65:         17          0   xen-dyn    -event     device/vif/0-q1-rx
>>
>> Fixes: f599c64fdf7d ("xen-netfront: Fix race between device setup and op=
en")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Reviewed-by: Ross Lagerwall <ross.lagerwall@citrix.com>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>
>
>You also want to pull commit 21f2706b20100bb3db378461ab9b8e2035309b5b.

Added, thanks!=
