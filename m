Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6B0C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9441120685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XEqkXS6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9441120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbeGZAH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:07:58 -0400
Received: from mail-bn3nam01on0101.outbound.protection.outlook.com ([104.47.33.101]:5680
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731344AbeGZAH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PT77jprQcLM+gYR/k9hrMaeU9yG86IvQYmgVCDVG7A=;
 b=XEqkXS6w4hkta4evccmh4XSFr1Wgwul4AyLQD37qmkSYW4KIceaxJXECKDpzYQOYicUAal6ox/GW2B0PKceVqAuz5NMFg1NtJjA4xCMo19eovvlnooH05smsdLpceuLcMH7PuZSitY9I0VzinuCzjjl85DsDn0LAKIoNMtZZU4Q=
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com (52.132.114.24) by
 SN6PR2101MB1038.namprd21.prod.outlook.com (52.132.115.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.2; Wed, 25 Jul 2018 22:54:05 +0000
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::10ea:44ff:21c6:8c07]) by SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::10ea:44ff:21c6:8c07%4]) with mapi id 15.20.1017.000; Wed, 25 Jul 2018
 22:54:05 +0000
From:   Yidong Ren <Yidong.Ren@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Madhan Sivakumar <madhans@microsoft.com>
Subject: RE: [PATCH v3] hv_netvsc: Add per-cpu ethtool stats for netvsc
Thread-Topic: [PATCH v3] hv_netvsc: Add per-cpu ethtool stats for netvsc
Thread-Index: AQHUIu18DGIjsI0UhUqLbw4mP+Fz5KSdl72AgACdo5+AAlQBsA==
Date:   Wed, 25 Jul 2018 22:54:04 +0000
Message-ID: <SN6PR2101MB11358F7DD4472E25E76DA76084540@SN6PR2101MB1135.namprd21.prod.outlook.com>
References: <20180613193608.444-1-yidren@linuxonhyperv.com>
        <20180724012622.26873-1-yidren@linuxonhyperv.com>
        <SN6PR2101MB11359728E41C4B2AB8E7736D84550@SN6PR2101MB1135.namprd21.prod.outlook.com>
 <87k1pkrj84.fsf@vitty.brq.redhat.com>
In-Reply-To: <87k1pkrj84.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=yidren@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-25T22:54:02.7465172Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:b:7c96:1260:6c36:9dd]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1038;6:wwmvkiN0QS0WRU/1DZnj5ihHBhIYV/KMBfdghQQ8fgG88NpanTz3Zsgp2YmKcmkR7TE+Y/XVTaDTL90waFwZ2pJHTfxwbbQhsaVm5ylaw1k383iRH63aMSpqPRn3QNlKr8EH1nXQXysBEV+c6XSj8F87bM8i+CKFCOfyzIqJnqG4gqMLa29ryLX7bvV4l5NX2KNsDMuIP5lTZWUl+jDzJNlgQ5wFbWflNQUij9RrLSGyGb2EmtGoEoSldahjpuUSgHiPnHQIZ3E0rloBxAuqgGuslL4CHa2JM9GlrlG2ftJsaQPBonpNAOVw3kIi02loFNwXmbf0SZ2INw4vIs77dmJAKwZigXu0YePJDyoInLfMJbgL/8iLEdAJTpFW8EZrZobGPi8vONvH55nJASIRg1zJQhjwo6B2jn+f/og/eSogfvTMP7wURzxDQywC9HbUoy9J9nsYzWPcW32KyMqk8w==;5:XKnUJ/i/JLe4j7Cu2QHkX5m5IZmcNOGl2SL5by188otYk0syAVMUND9X9LD2FMou3/jIAbZdHCFCGPRnPBM2rZdzByNtqufrsu2sBVo9FfXWIgJnaPd92kA1Qxybsl40HvjFJSg9mpmMlxK7lxZG/2NnVM49785+Gr2Z40CSA0s=;7:wVVbFKta3wLlxoSUVS7+lYF3tgNre7Jh2uop7mdDi917uHVT47f1/xtbLyEIHtQxGSHw9ucKo3+Zp8UlxREzMhi8UQptx7PWwJF4zgx9M/VmV/wWKpCsGMxAvHMDzm/8skkQEXZsz7I3GFV4+31w3vejz32YKMdRskHeQwxA2Uxy0U3bJIQBlLtTzQPcFkCVfEH+EB+BJNU3zp8K178i9Cu+ATaQVN3VDYkd2sE/q3dfElYag6T7lijO7hYpH6KQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8b8e276d-64a9-4b56-2e1b-08d5f28185b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1038;
x-ms-traffictypediagnostic: SN6PR2101MB1038:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yidong.Ren@microsoft.com; 
x-microsoft-antispam-prvs: <SN6PR2101MB10382ACFF77FAFA519572B4E84540@SN6PR2101MB1038.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB1038;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1038;
x-forefront-prvs: 0744CFB5E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(366004)(376002)(189003)(199004)(86362001)(478600001)(10090500001)(86612001)(99286004)(2906002)(53936002)(46003)(305945005)(54906003)(33656002)(55016002)(7696005)(76176011)(14454004)(9686003)(2900100001)(72206003)(229853002)(105586002)(106356001)(486006)(102836004)(6116002)(8676002)(476003)(97736004)(186003)(10290500003)(6506007)(25786009)(81156014)(4326008)(11346002)(22452003)(68736007)(256004)(8936002)(5660300001)(74316002)(107886003)(316002)(93886005)(7736002)(8990500004)(446003)(81166006)(6436002)(5250100002)(6916009)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1038;H:SN6PR2101MB1135.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZSypezUvj8rqne5OooYA9Rpqk0IFO0nwjKCdtup98pz1xEdjK3ZUZ4zH1abmvKsbuwwYYIa4rFDgq7PEvez7h9UHpy/mQ1BPT93N2jjyrNlujaph2FfP2UN86zwALdDI02PbsG2z4FZnH6K8mxyerTChVw5IQiAS9ChvctY6Yd8+wCzNN+Mtzdv8nQFMxhKldhGZ7bZk0EDHpDjW/UM4BTn368n3WGOjlxRoSJiTJqTNx5o+t1AlEqy1GkP63Yk4ig9Kg9ebjZQ29L2fmtbhccKWpBMqxb5+sc3aV7SiXAxaxvEytoVX9uPDIzrU3oBBWAo57rKwXjLivA56+mtEwRWUFV5iewGxjW+tQsBNhMo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8e276d-64a9-4b56-2e1b-08d5f28185b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2018 22:54:04.9548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> While you do for_each_present_cpu() in netvsc_get_ethtool_stats(),
> netvsc_get_pcpu_stats() does for_each_possible_cpu(). This looks
> inconsistent.

I made a mistake there.  Thanks for catch me.
=20
> The allocation you're doing here is short-lived so I would suggest you us=
e
> possible_cpus everywhere. Even knowing there's no CPU hotplug on Hyper-
> V at this moment, it can appear later and we'll get a hard-to-find issue.
> Moreover, we may consider using netvsc driver on e.g. KVM with Hyper-V
> enlightenments and KVM has CPU hotplug already.

That would cause the output to be very long and useless.
I will submit a revision that allocates for num_possible_cpus, but only cop=
y out stats for each present cpu.

-Yidong
