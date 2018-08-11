Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EDDC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 19:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46EF21A2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 19:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="jY3PlUh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46EF21A2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeHKWWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 18:22:10 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:12640
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbeHKWWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 18:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyQjNw0CAzYwXHDfB0zXfsv/4X70WSZBMlhdGc5GRCU=;
 b=jY3PlUh0huuGAAuavGXnb39hvT+k53TwpYG1Ct9TjkJakcMTJxrPSRlcCiXaFDxALtYY18r6ReT3s652gdBZHs+R0B0c9Nl90dzCcqKptK/Lf4i2Vz9xAPNfQIaz1fZ7uy+LcMSxjdhiGAb/Q/9KT8WhXJdBfxWjh1vKhfTU0Wg=
Received: from DB6PR0601CA0040.eurprd06.prod.outlook.com (2603:10a6:4:17::26)
 by AM5PR0602MB3235.eurprd06.prod.outlook.com (2603:10a6:206:7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Sat, 11 Aug
 2018 17:13:56 +0000
Received: from VE1EUR02FT019.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::205) by DB6PR0601CA0040.outlook.office365.com
 (2603:10a6:4:17::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.22 via Frontend
 Transport; Sat, 11 Aug 2018 17:13:56 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 VE1EUR02FT019.mail.protection.outlook.com (10.152.12.107) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P256) id
 15.20.1059.14 via Frontend Transport; Sat, 11 Aug 2018 17:13:55 +0000
Received: from cernfe05.cern.ch (188.184.36.45) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.399.0; Sat, 11 Aug
 2018 19:13:55 +0200
Received: from harkonnen.localnet (178.196.40.127) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.399.0; Sat, 11 Aug
 2018 19:13:55 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     <linux-i2c@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: i2c:ocores: fixes and polling mechanism
Date:   Sat, 11 Aug 2018 19:13:54 +0200
Message-ID: <5011687.103nMUzm2u@harkonnen>
Organization: CERN
In-Reply-To: <20180625161303.7991-1-federico.vaga@cern.ch>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [178.196.40.127]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(2351001)(305945005)(53546011)(186003)(5660300001)(8676002)(16526019)(23726003)(6116002)(246002)(3846002)(356003)(7736002)(26005)(14444005)(478600001)(230700001)(229853002)(33896004)(47776003)(9686003)(4326008)(74482002)(6916009)(106466001)(7636002)(66066001)(97756001)(336012)(8936002)(486006)(476003)(126002)(33716001)(6246003)(44832011)(76176011)(9576002)(36916002)(50466002)(11346002)(2906002)(956004)(786003)(426003)(46406003)(54906003)(106002)(446003)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0602MB3235;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd35e76f-6ffd-40f9-4ff0-08d5ffadd205
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:AM5PR0602MB3235;
X-MS-TrafficTypeDiagnostic: AM5PR0602MB3235:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0602MB3235;20:oM0VY+tzbMc1IpcuVJ0wg6IQGYuIDIQxJYoTnirwxJrx99JGRdIbgQOib2hNjULDjeuYuRGQbDFvEbXcdulkjSh1g6mkDlSPpGV1VDJZ2TVl7Lp3uEfSMuk7NMW0vxXNQiS9mPLwuUVcrGkBVtpNzOL92UbZzCZmAL8+SPX5ZfG6XMwnRfvIRElZjsgrh/RMQ+NWkQcIoHXdIvI1Ibg7TiVq+LXS29s5gufIvJvaymcsywXLDTMXEWk4A9yxR5qh1utpcoUHq7asfgE1b18l6XvovVQG4WdGHlVVCPjuWvM/956PVLbhsvMN/V9PPRi+vSNXUzz5hVAlmr/ExER0jrYAS0/+j0mDTpZc8vbvhNm7yPI/B1xT+bC90MahZFhf/JXvAbg6l8HlKgeJEvlKaBUyHpC9LwdfydbJouzKogDdIXpl81i8trZJx1KSzZLianFtyVNyMlzePJSqDT1+aHuV3UbUBGw6PWft57txjTYR95IB9E5A/JzfT+p5F/S2;4:EynJ0Zj2eBSSnmoDkXROlY7lCMeA+q8y1Y+HVg+Ui7BoK9GOs57xPxl+mLzVOZBLRmxFHqHVszFpzu5Vhl5Np05OsMYz/gopInpdglTNDZRB6lE+x/4q9Z4VSiTYdMHclXUIuSBCkS+v8jYEi+dPlippAmWRhrynTFtc49g/r+j4iYnrAx4i5f8nPz1ELyMT4etLxjOYrYvXm5g5WY1tBesmKLTTPInePasMKrRQN7P+rF3EB2S2BXJt+TTyWM54B3BJSCCtGvAXtrpLcjOjgg==
X-Microsoft-Antispam-PRVS: <AM5PR0602MB3235CA3C348D0A4079B16E52EF3B0@AM5PR0602MB3235.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0602MB3235;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0602MB3235;
X-Forefront-PRVS: 0761DE1EDD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0602MB3235;23:MK+HbKdSpYjMcohB6TTDbqm9FImxyM4dG9XSqeR?=
 =?us-ascii?Q?d4ewSfXsWklbH404uxEPWKokKVZCmN+EKYtIdcZemwffNh0GJknWX/VDEOEn?=
 =?us-ascii?Q?mAhYPzF4i0aR316kVAQlsSjnPpxFfwDqQnTG8qNeJ3mF9TqUEBQBj4Sdr9jY?=
 =?us-ascii?Q?jBG7F+ONR7irPov59PxdM91J4v4w40454X9NjBaYvk6YMHvm8xdtm0naSmti?=
 =?us-ascii?Q?3V3MkcKYk6tW4M7HXudGnrW9hm4szHtrrohoZ057mWDHwLc0qM3Gucrxq0Ee?=
 =?us-ascii?Q?yqfjT94d488dza9VgdPf2dfnYOc9YyTCINZn3S/0j3ew2Su+9xm9JNlztrRH?=
 =?us-ascii?Q?g11Nm6Hr/imTZsPcm1ach9CLgrpoMlx/ZnrLBzWLWK+S2Q2yC6FI3YsdjHeN?=
 =?us-ascii?Q?avmRmhKnCaxiUe5uQWntya9SSLDXcback49Eqp8et493v4oeiW9eLzjDWNAS?=
 =?us-ascii?Q?2pjgOtvOMwEE8J7C60DxH8YPTDqbqzgUI6i0CRLUrtj9Gv2mkIqRozLDWa0f?=
 =?us-ascii?Q?ajvMpSgzNsGdNfjoXItfnilitPEMfGo4bNvg//kywW2kvK4PUn4l8jKUSaFy?=
 =?us-ascii?Q?w/Z3xLvmg5aAW4umYiPIgage05tpsDvbZXfJ+Xx8tc6uKCUIgDD8bvlO4s6/?=
 =?us-ascii?Q?8CgUE3CQ3Ks3awbc2GtIZIlJgi1g1A4iI3/3jh8Y7HN6tRj3p1VhiwU5lcvL?=
 =?us-ascii?Q?4QL/RhgGv9+kzbRbbOwsZsPXCE/usd70sKDN3WHITV9WsaNNSSKwirGSasMN?=
 =?us-ascii?Q?Yl6Osc0tESP8ImOZZ753IsjmQqatVVptfnM6u9Cbmx4JOoFqwhdHR0FFK6l3?=
 =?us-ascii?Q?hgcAAErYFUQlbqrMmXvAoAnm8bmJNPZ4JG5TvdBKdw7SYhahxGquceHwg9u/?=
 =?us-ascii?Q?Z6iAYpzypkFgpOTgYwBGAru+MpUGE6qPQTWuJvheBO4T3W7xf1y6YGzR5gMa?=
 =?us-ascii?Q?Xr06T4mowhhyht93P1EtPZcE0LZpJC3oc2nd4AMVrbJrL+rfqCrqPBqH4474?=
 =?us-ascii?Q?0IGM/N2Id20PcjZlbri6uiJkByrJONZ3+2es5nF7Mg7XyDEcapqvLcVsWbzT?=
 =?us-ascii?Q?41/qWpI+zmqNM1NBV9Jv2i6tu6TfAECYejNJ4NFrgppypmXbPUDkaI4H+V5M?=
 =?us-ascii?Q?P9Fsc4uUH6l6A/pKb+S6YtBJnjfFL3Vhxc41S/fhpEgszGblKEqbkhQlmB38?=
 =?us-ascii?Q?LGtTTOjpZJfETNcp1Y185mtF86AQ8mihK0NyX/aySpJ+YzfOITFlZjBz/2N+?=
 =?us-ascii?Q?ESywA6H8/SbN/hhVFPpBuPLTn3YzeHY49VxUNd4a7aOioWCYErv1eKmHWpRI?=
 =?us-ascii?Q?V5A=3D=3D?=
X-Microsoft-Antispam-Message-Info: Xv9T+eSnbEnMBprx2AM7Y5ya+vDD94zu7h0ztIsv0g9HNxcWlYaaOMd0tg7krl6CjiazV3x0ash5ICygt8ZGVxUVpWNt09uqTNa2WA1segffrMMkpKOcfIJIgMMa8NvrhtvD9gywOpedEGbFqrZHhhpeHp3svJV2RBzQYrdpNeMJhS55e1FB2Fh4+bTC6EE5sJ2M3j/Gvh/n2sVt3VD26XjfLGwLnmFaDtpREMdtSK02K+mPybcT4nyqNYoPe/DYWVoYnnzmLwOM6vVM4HLCVVfsUSQg83GlsUXPgqw+IPxrdSrJRweSyHfeaEJM5e9y0q1COyAgyuNpQKkOljZLhKulneZZaS7FP7hLgMzS8OQ=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0602MB3235;6:SdabZkG4B55JYsO/jlcm6kXDEemVMRTycvVkXdDs0v2sNFUd+tv2X/XwZIN9bxcWuL/aLVQ7iW+iHvH5jXMt5CE756NvxSg49d6Sc4OwPXslmXtc4tXX9KTjmp5RsLTSJp3ynk0d+ZopyPEMfa90oDFfsyoCvEimZzt/D952ZGQwZX7qupVJq11MLazNfenIoOVvaUx5kDkdPhtXz/+tzPgzXc4rvjfK1QIjVWUvPu73Ijh11N7NOSrcQ7mYl0r6uWDkEcfwL8iukmCNYyT3AfwyrrCEJXlUs5sraZKANNQlp9MM8VdG37OzUnffgSSVVTzySzfaCIJjvuXp8aP7AoAMMwJWDvDpLMjMcQpXJslomQzY1i3R+7ie7earEubGIO2Fe5pcFz5nFC/Pw91P/9Wi6KCxsFX+KGb/YUzlvBlP6AVijrKVYraJQQe1EsgZGjisUi6gcfkx5QxJsCeLRA==;5:TpJu1X+M23FsLq5lV2s+yiohl2fO0YqB5fK3uV6cd0fvELCjexxO8HCV8GKXZN21IDTSlA0wG1zvgyPnfAeosaoFegdwc7bPGzaWCbQvyAbVjNyIgHqKHeZ+Y5VVZ6WhMWFMElfR1MWO5WeO3CpNlk0MESmHqtce8yI4mXqNjEk=;7:DLUDWcanVVsTWicWw2aquWqL7cl48z2GKCwdsAxhkj713iIT6COKXQn2QdlODyNIYpNq6SSuvGsAazM2lo9cssYRTIy7YN59nalXZWuZ0Sa7Z352BWjee9FEAo5GZDejMyv8h8FnS4Kr+zIOXALgX82jPO9gTmfIJwBm0agkFH23sxyRv0tkqtXqR5vRNMmvFl/JHX4wMZb6FRI3NXqubzCwbYfe8h3KZ0nQGY9wRwvpfOxletE4hx0Zh0xbiwei
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2018 17:13:55.8125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd35e76f-6ffd-40f9-4ff0-08d5ffadd205
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0602MB3235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry to disturb you all but after one month and a half I never received 
any comment about this patch set and I fear it ended up in a forgotten 
corner. I would like to know if someone is considering it or not.

Thanks :)

On Monday, June 25, 2018 6:13:00 PM CEST Federico Vaga wrote:
> The first two patches fix what I believe are bugs.
> 
> The third patch add a polling mechanism for those systems where
> interrupts are not available.
> 
> All these patches have been tested on a system without interrupt, this
> means that I used my third patch to validate also the other two.
> I would be nice if someone can run verify this also on other system,
> perhaps with interrupts. If you consider it a useful information, I'm not
> using devicetree for this installation.


-- 
Federico Vaga
[BE-CO-HT]


