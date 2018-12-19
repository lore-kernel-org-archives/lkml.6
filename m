Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36180C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDFC218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XsJdRSEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeLSKpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:45:30 -0500
Received: from mail-eopbgr730059.outbound.protection.outlook.com ([40.107.73.59]:40106
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728714AbeLSKpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/hLR3c5KcmmvmV/xfRa54dcvSFoGt845uy5uobcvhY=;
 b=XsJdRSEIO//OlCv4kpcrw3rZndJyMt7BhjZ6w8uuXF5fOPspcpMt1kokH9WgsCEJTdj0/L8bzuztbUkRxE5++gR3hCxIEY0yIy/MyGnrjAKN+65SdbYx1jY/kvVPMDBRPS86nQxLDgcPf1EjTPjf9kU48yGLJKTZtPgoq7UPcHA=
Received: from BL0PR12MB2355.namprd12.prod.outlook.com (52.132.10.161) by
 BL0PR12MB2339.namprd12.prod.outlook.com (52.132.10.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Wed, 19 Dec 2018 10:45:27 +0000
Received: from BL0PR12MB2355.namprd12.prod.outlook.com
 ([fe80::882b:8614:71c5:96e2]) by BL0PR12MB2355.namprd12.prod.outlook.com
 ([fe80::882b:8614:71c5:96e2%4]) with mapi id 15.20.1425.021; Wed, 19 Dec 2018
 10:45:27 +0000
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ASoC: AMD: Fix race condition between register access
Thread-Topic: [PATCH v3] ASoC: AMD: Fix race condition between register access
Thread-Index: AQHUcWAQzfisXNxXQ02U4HpErY99ZqVBDxiAgEUeBQA=
Date:   Wed, 19 Dec 2018 10:45:27 +0000
Message-ID: <9b80c3da-c137-f1a3-fd50-85ecb9e3f6a4@amd.com>
References: <1541020930-17337-1-git-send-email-akshu.agrawal@amd.com>
 <20181105111557.GB5365@sirena.org.uk>
In-Reply-To: <20181105111557.GB5365@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::21) To BL0PR12MB2355.namprd12.prod.outlook.com
 (2603:10b6:207:4c::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.56.249.162]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR12MB2339;20:2qY7AsL+TjAO7VmuyxvQG4sNQTh/IXbB71Xi48L0NI2suMNdegCB3jGZCVEUzn+SaPZhLhp1nJECAelO45vKwVo7DaVmLN1kfvKhoK9oj3IJ42iqYJPpfpc75j3GPC2ZYsCqnp7dSwMWCObYmYKLhgTTxEFEKQ/nXi/BoaSj45Ratp63sL+Po8JF6RyFd3o2+H448WmIkmEsoX8Gp75IbNNWES5QUbaEEHmgNJb6mWbBrACotJnZSRNvsOFHfKVc
x-ms-office365-filtering-correlation-id: 0e39fc44-3ce9-47fd-8b20-08d6659f1686
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2339;
x-ms-traffictypediagnostic: BL0PR12MB2339:
x-microsoft-antispam-prvs: <BL0PR12MB2339CA74F278A0AF9E178060F8BE0@BL0PR12MB2339.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BL0PR12MB2339;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2339;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(8936002)(3846002)(36756003)(6116002)(81156014)(81166006)(54906003)(97736004)(6512007)(66066001)(6916009)(7736002)(316002)(5660300001)(11346002)(2616005)(446003)(256004)(31696002)(476003)(486006)(14444005)(71200400001)(71190400001)(8676002)(86362001)(72206003)(478600001)(14454004)(31686004)(106356001)(105586002)(4326008)(2906002)(39060400002)(6246003)(53936002)(76176011)(26005)(186003)(229853002)(52116002)(386003)(102836004)(6506007)(53546011)(6436002)(68736007)(99286004)(6486002)(305945005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2339;H:BL0PR12MB2355.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8u1OlWRrdG4WNuxlBOwXjBXdqehBFi/RhmQKhYX7IbD8yC+1bGA+pCQqPK6PQSD9Dqimc98uG3ETZpDWf2w9VZ/wdYncn5Ge5hLQuN5bzCBwKuW/iOhkfszlzit55BNb49Imngec30GcRKLuvkZhL4zabNTCMrwS1f9zP4C75xODNA6vW8dRbNz01udF/AxtSjU9i9Qz4UrODqM+Se8DRSCB7qu9VnIj9bCPUbsH6wK4GTNSIiJcX5n2je6gZa3nDYs431U5datXfGWbRQt9u8TnZYr1iFg/XK2MtHf4ls3UV6UbGflzeoo51gDK6A53
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <6E44EA00FFF9A24DAE4FA96F78AF4398@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e39fc44-3ce9-47fd-8b20-08d6659f1686
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:45:27.5375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/2018 4:45 PM, Mark Brown wrote:
> On Wed, Oct 31, 2018 at 09:24:10PM +0000, Agrawal, Akshu wrote:
>=20
>> +/* Lock to protect access to registers */
>> +static DEFINE_SPINLOCK(lock);
>> +
>=20
> Why is this a global variable and not a part of the driver structure?
> Is there some interaction between multiple instances?
>
Yes, this lock is used to protect registers which are common to multiple
instances and can cause issue in cases such as simultaneous playback and
capture.

Thanks,
Akshu
