Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20ABC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C662145D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DK41Tl2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C662145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeHPUUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:20:15 -0400
Received: from mail-eopbgr720124.outbound.protection.outlook.com ([40.107.72.124]:45375
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726987AbeHPUUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNinEDqNk4CO9nDs4Ubo/Ev1TCEgIk5u50TKpHcV+GM=;
 b=DK41Tl2hJZeA6PXFYD+1eKJt6VnFp7AvCvKfIw5xKDAK1zyPnE01nXYbAE2hKockESOt/ytEc4h5d7gl3SXBtpYiALQVvzycIlcFf1s5BMWhR7uYnyUnliBvunLsyPt69kdX9rf2mXmsborxdVEtS0tKbBRGzHr6VP8aVB7al0o=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0796.namprd21.prod.outlook.com (10.175.112.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.6; Thu, 16 Aug 2018 17:20:27 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1080.009; Thu, 16 Aug 2018
 17:20:27 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     "osalvador@techadventures.net" <osalvador@techadventures.net>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "arbab@linux.vnet.ibm.com" <arbab@linux.vnet.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/4] mm/memory_hotplug: Make
 register_mem_sect_under_node a cb of walk_memory_range
Thread-Topic: [PATCH v2 3/4] mm/memory_hotplug: Make
 register_mem_sect_under_node a cb of walk_memory_range
Thread-Index: AQHUNYVstIujEBIhdUCepLheGkxdWw==
Date:   Thu, 16 Aug 2018 17:20:27 +0000
Message-ID: <20180816172026.s2v3ytqnkiboo72s@xakep.localdomain>
References: <20180622111839.10071-1-osalvador@techadventures.net>
 <20180622111839.10071-4-osalvador@techadventures.net>
In-Reply-To: <20180622111839.10071-4-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.69.118.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0796;6:TxzEjBOLJ2CN65VpLV0jH1XsImO7yv8U4opgWWJS+JvvVhHwWRhbE8Zrm341GqFFmY05WCIkdUyu+PggZKo4gGxlCDX2G0t3GHwkzI7l+KfixEG97zqlTFJxrhm3NkR9FObqgB3N5wOAXvjIm9qjxIYXELfpZ2KXkg+c7nXP9kvCa9RljS1noS3G94ujt/Q9VXQ+FhIjwpHRuH8tVIme84LhZ8brno3jjPjeD6WN54ML7ohngte9uXvPxdW6hLGiNnQ3HsRYW51X4UjdOQu8OvORoTZFmgwaCwyHQity5tQW/VaSctKde7qAyLGesjWAthq4vUWsqja5J6BOwN6j4G2fYLx5ilAyqFs5DevQZtBRkkO4YNM0q00QCzXXAJgOVH01qWjojkHM1DpDBWA7hcIRTnyXL9UOHJfmpHtf+VKpkXUEEsb4s+zUNSBZgQSvmD+69oi+yLjUJy1viPQyHA==;5:PuRk/mJiDo1CN56EdFVVm9ZnOwDtPRRsmecF9Wh011/w83AQqx2VTTsL0B+ykz6iCayQk/FxoAm8KxkRfT7CMDMc5Q9Ho2mTJbZXhbV3XmmOXpDEIh9tRdpnsOlAgLuxjMvAyMm1FM0tgEIK7SzhyZj2tFMXUkn3xFrZmMhRq4k=;7:y4SVKYIcBTtkdZhcu2dowTIKLc+dTXMxT18zTkvVnha3IbJ0slNk4XHMYkdRx63PNz8dtC6CDznFF3un36SCSiDKqYSI+I9Ofc4ot4a3EWZ32DoLmL59PIdq0u0GTkPRHfMU02csjjXp1EGLZjUMd6WcBV/2lSIhVO1PecXMbYro9kqQ0bmV9YKxivA8Ds12XKnWIpk3vLxjViLnJKGAhKnbMJB2aPd2CSrIYPInYAsczn3ABdgFnJtwAm61qCrI
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 913f5fea-4a38-4fb6-ff61-08d6039c8f85
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0796;
x-ms-traffictypediagnostic: DM5PR21MB0796:
x-microsoft-antispam-prvs: <DM5PR21MB07966CB525C78A8913E0B7669D3E0@DM5PR21MB0796.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231336)(8210008)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:DM5PR21MB0796;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0796;
x-forefront-prvs: 07665BE9D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(199004)(10090500001)(316002)(14454004)(6246003)(25786009)(2906002)(5250100002)(8676002)(81156014)(81166006)(1730700003)(8936002)(54906003)(53936002)(72206003)(2900100001)(3846002)(105586002)(106356001)(486006)(97736004)(6436002)(6116002)(22452003)(2501003)(9686003)(6512007)(5640700003)(478600001)(68736007)(10290500003)(2351001)(6486002)(476003)(229853002)(186003)(33896004)(14444005)(53546011)(446003)(86362001)(5660300001)(6346003)(11346002)(6506007)(76176011)(256004)(1076002)(99286004)(66066001)(6916009)(305945005)(26005)(7736002)(102836004)(86612001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0796;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: 6G+lMbC5b0EZTBPYdufwOlN4scV4eq2RLoxMN7FbA4DEXfNk8awz2mY01uJ2Fa+BiIiblKqvtV3Ije5FGY7E1coSYOksmdwcmKN6k+tXJZL9l4h5ZR9kAA20v6QKYtVI0fuGvO0VUXT/zO3bhpRbxHtywIJVkp6Yxy9ocx7lL6uyLrtlwCgfiRVfBF8P9tzfbzA+2W6DHUsquKFy0PDnjSr7FGfOXA0uV1FH7z+xpnUaJIFb42pBs9Y3mLOJhS0QN/h7aA0Ot1aBifUKaSlHmEvJFhn4OlGIsJhc0Qu9+98cCrXr9xZNk+TVOWs0w8aZjj+bsPfP7bDrk7ZPARNk7xwRQXWn7q9MnHG2AI4aMP4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C4F53580C4051E42884241A129D12C36@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913f5fea-4a38-4fb6-ff61-08d6039c8f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 17:20:27.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0796
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-22 13:18:38, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
>=20
> link_mem_sections() and walk_memory_range() share most of the code,
> so we can use convert link_mem_sections() into a dummy function that call=
s
> walk_memory_range() with a callback to register_mem_sect_under_node().
>=20
> This patch converts register_mem_sect_under_node() in order to
> match a walk_memory_range's callback, getting rid of the
> check_nid argument and checking instead if the system is still
> boothing, since we only have to check for the nid if the system
> is in such state.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>=
