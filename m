Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C517C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052432075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ooxj2nsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052432075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeIGFCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:02:00 -0400
Received: from mail-dm3nam03on0095.outbound.protection.outlook.com ([104.47.41.95]:35264
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbeIGFB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gHAZZZYnIKP2krAw2X7A4QMjs1tnZA0bgG0a8veTrw=;
 b=ooxj2nsEw6lI7sc20S/0Eyt4XH5kAuRjN40G3y6ts2NwkHjOMyZ5tYN7wJHYcOgUa+2Tt+hk1l+eMZA/GXA0TTexxxXLcjdjwAp9IJfQXXA9r5IQ9TarEpmtdd6pcpdgZiO/2+fzCoEEwqOGA44UaiHjQzh6KKU5UDLEqZgf1Xs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:23:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:23:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Erica Bugden <erica.bugden@linutronix.de>
Subject: Re: [PATCH AUTOSEL 4.18 037/131] ftrace: Add missing check for
 existing hwlat thread
Thread-Topic: [PATCH AUTOSEL 4.18 037/131] ftrace: Add missing check for
 existing hwlat thread
Thread-Index: AQHUQr1gBE/wJ8UrN0ygaxjXaATxC6TgV3YAgAOlLQA=
Date:   Fri, 7 Sep 2018 00:23:55 +0000
Message-ID: <20180907002353.GC16300@sasha-vm>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
 <20180902064601.183036-37-alexander.levin@microsoft.com>
 <20180904124356.4a2f3dbc@gandalf.local.home>
In-Reply-To: <20180904124356.4a2f3dbc@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:N1C7Q0KlVIwI9BNPz7mJ1HxjaGgHQRhkNsny3NWwK0HRt+Ndmx9KH5F3CFbpUl5ZiCrYPWj/nQd9OALq8ABnuV3sXPTZxgR+HT112mfbKy6FP/A78DBPubd6Uy6ssTxUCesnLWZRxY+75ReywZWwTgPCwtLcM6LRveAlzHa/PvNufsXKzs6USvTqpymhLGagCL9TE91gEt2KaqmaAtUdXLtzi4LTxadrM+kyT7g70FqDYLjF08Ve4VS5B92KvgKT/c2nntuT/noPE7yaxCTEs0XDH8zOBiaDqVgOG7TbFBH9OnoCsgRAkjahkGQfg1M6SLjtjSI7Q6ih2RG9fEngtonXbGHYovfPlPaFYxMgbO7RFL6eXp5EBCmjxnSMz2lgs0mBUjhlyDpxIHtha/eq+AXCOwtgxZJWaOMWm9d+mZtqB7LMbM2uEsfGE22wK/0CgZEHW0wUAzXf4fivAYUJMA==;5:Ftm5jRBgsRcxFDSNN/3JUmwOYw8Scs71c1hMGair7p2GadyfqPZtziHPWqw6WLJQPVQTI99EBVolFHazuq9CIwRNwJMym98CLqxt2YJSRx0s7NNTwyOcEzJwLL0jKzohze9zW+UT4lc62QQCC+gsRqVi7SRr3BoXBv1HVnay3KI=;7:8lfRLOUKAz1ugrdZSvsvZzipHunWtujcOwDBf0pDPJ5NewkvYmNoPvpnQZwpKBX/av5Wo4FPOtLUKs8I5T1le7PU0N7pDDuh/Y+KaPAuOib5mxtoirB54S0m/LfDwVsPwgZ6/hE/Yeen/JwEq15AOOThqXf1ZPq919EKsyPGI4BJlF99DHKqtOdgtiBQ5keHwJ7tgDDmnnFMtEU9ZRLiWLf6GHZjq9yAQnQbpk1iurDVEA9Xa3hngCDZchpf5SgY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3a735278-f5f8-4ebd-5e99-08d614583268
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB016899799C7A4F3DC21D6A74FB000@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(1076002)(33656002)(5250100002)(81166006)(81156014)(33716001)(2900100001)(97736004)(22452003)(10090500001)(6486002)(26005)(186003)(102836004)(6436002)(229853002)(9686003)(6512007)(11346002)(6916009)(476003)(217873002)(5660300001)(256004)(486006)(6506007)(446003)(53936002)(8936002)(7736002)(33896004)(76176011)(2906002)(8676002)(54906003)(316002)(305945005)(25786009)(86612001)(68736007)(99286004)(6246003)(4326008)(86362001)(10290500003)(66066001)(478600001)(72206003)(14454004)(105586002)(6116002)(3846002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Lb782TdNkJwsBuiKa6Sj3RPZLW3MFRnjRqKawm2PTu2U/IlvGLLyQeo4tFey/Sku9Zzgxm4D2bGHWwE1mOZO5dTgKT92lkjaTtGIZvSzJ9Cvo2PFRDJJj7OLgrHs4K1ToXAsdjoHxmEf6QnR6c8BOnnaE/woZahWLJ2eZ0x8CYtlS0IDIeCWtYkPjs8k6OeI4UoVmKDNXqYdTHph+n/RctvXaO+XiyW7Qhh1g7pD7i8bKNdgYaei0A8oCPeceTVdIY6wliku8DWbbHobwZxJsSfar7a49h0EOqE1zz/RF8MVr8+RjxI+ARmEsyhwNFKKFeruahYQndMzUkF3VGUQLS9/p1quK0nBoZyl2dHlw04=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36E93CD4188AE34CA197836BEF73CA71@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a735278-f5f8-4ebd-5e99-08d614583268
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:23:55.3000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 12:43:56PM -0400, Steven Rostedt wrote:
>On Sun, 2 Sep 2018 13:03:43 +0000
>Sasha Levin <Alexander.Levin@microsoft.com> wrote:
>
>> [
>>  Note, this only fixes the symptom. The real fix was not to call
>>  this function when tracing_on was already one. But this still makes
>>  the code more robust, so we'll add it.
>> ]
>
>This patch really didn't need to be backported (which is why I didn't
>mark it for stable), because the real fix was backported.

Out it goes, thanks!=
