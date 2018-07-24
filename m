Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A45C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CAF20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="p5ar2lMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CAF20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbeGXOqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:46:15 -0400
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:48032
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388370AbeGXOqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlUWOLOU8leDdo5KUVNnmS4R68GRDHBezRgcryXORHo=;
 b=p5ar2lMMpKiOqVF+r2pNgJAo7wHu+1VWLzIr9zqBTWCqOQtwQgFRzbxbM7JzIGI56YyLxXaOIzcrf0k1FjLUFbqfSH85jNIdlCd7BX9q5bIitSD29bCku/xWJ0Whrkf0+L9rQKZ56wsGozYvDaS60ehklHFgEs9+48ygWbfQmm8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com; 
Received: from [10.207.0.55] (193.47.165.251) by
 DB6PR05MB4647.eurprd05.prod.outlook.com (2603:10a6:6:4b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 13:39:34 +0000
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
To:     "Alex G." <mr.nuke.me@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>,
        "austin_bolen@dell.com" <austin_bolen@dell.com>,
        "shyam_iyer@dell.com" <shyam_iyer@dell.com>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "ariel.elior@cavium.com" <ariel.elior@cavium.com>,
        "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "mike.marciniszyn@intel.com" <mike.marciniszyn@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
 <20180723200339.23943-1-mr.nuke.me@gmail.com>
 <20180723140143.1a46902f@cakuba.netronome.com>
 <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
 <20180723151439.50524a2a@cakuba.netronome.com>
 <2bb6e96c-a48d-62ea-90a3-ec978536372f@gmail.com>
From:   Tal Gilboa <talgi@mellanox.com>
Message-ID: <cf663b45-a6ce-b0d7-c79a-a02940001c20@mellanox.com>
Date:   Tue, 24 Jul 2018 16:39:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2bb6e96c-a48d-62ea-90a3-ec978536372f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: LO2P265CA0098.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::14) To DB6PR05MB4647.eurprd05.prod.outlook.com
 (2603:10a6:6:4b::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c0aff68-6f4f-4913-98c3-08d5f16ae538
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB4647;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4647;3:F6GshhZPRSDsSpFWiljyzHpuzMcTjAWX/24QkOcWrUrobRySOw1iu+MBsje0fxjKy/kgBDZefYJhhNcdtFX8uSRLs8XJ7hgj++8r8UmSJrXaOnq54tmAPx1autN5X0WEXTvUMWMjJBBPl1Fb2o2KZ/ObQEpnAYE09xSg5zjEwMdtPrQMWK50QKGwRwcRc6Xq7ClJT4Zyi54YW/RPuUisMQJpax8Xsryu6E4VClpk17IJVyKTTYEqhKR033MXHODJ;25:XFc5nPHdmHK/DTp4x1aT3ex/hUkEaTa0t2bfRPCU/bOb4vfmo0vyLMIgfRYCCZq1OcLYrlG/rRft7emseATewD2UbRoDajGeqRJz+5FmOuButTCTpMg+jxyQZKKiqdXtxVI3bwgPhglx8f3XkVXbB7m26WIr18kElUaVjawql1s0QNWnS2xKipzEnoUUSTyC+cc5fcy5CXgFXS5OZm/kJB3hmtn/7saZYlD3O33BppmwR5rMmYDI9YPPa2pJQrr4EiFnj0Vz04OWeSP8atqOzjkC11fM+zcaXJrVvuY+XoXa0nX/BN/zSOpsFs6FE6tGY+oa7Y07TmPP8gYAcvV2zg==;31:MBoiUeObYOV55mJAXGQEaLMAAUWAPTNJ9hgEJ19GqiPWl0psdClalWwwwtjwwCRZftaiyAYX6nfd8XuX2eHF1Rhn5+xtxObz/iXdM7rnTGvNwGh35iLvc+DZ6w5cSuHNxCpmUml1om1GPxcqOBE5CpyN4HxpMi3Hq/58HB8BSbjwlKlYQZlZy5BU1d7CAgl409Fd/Exqo8f5YbEs4jHQfiiQg9J8a3HYLEVp4h7/LSo=
X-MS-TrafficTypeDiagnostic: DB6PR05MB4647:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4647;20:4OJup3/+1was3C/yVMIWCMGT29DcRcrx1opTKDvbJm5EMXaXSgjxZGyu0S2xCwmW2cKZPCsVS+snzF2PW8QIAYBATxdS7/DdAUeMYD8shLnl7oWq4hdicIbbmw0CyPOj6/EyN82DS1JaHL0FeAWBBKZxElefl80dyBu2Oz/ePmM7iRkOjsLrXiRbwb7LKb3Bkt97H0PoNSJ6oMOtnD/p/SuW5e0ZT+bOJvPvlrn0vPCSKmv19hLcopvvIqvi7TsEsQAbN06CgcfrJ5MJRftW1hpcEA4Q+stWfhLnXKUby39xHwGMgM3QMbuiHx54tm695T02S2TVE9ON7NMDXogezWVPoBKj9+8yRpWRB5EzVnxt314tGLjdyhLzJC90RLutfc05TBkZwNRWcVlVo2cfE36s9MGUxjlr215rr7CKJmsa8/DjIBBVWol4neziZtF2nIpu7FFowCdxlcToLSh87u/KnTFokIIdytt43kxn/8LYrEAb07+/0HCH63byj9wk;4:XxxGev2DrSWFVTJoi82sx3fvjyi0dJY3lrxTLgv8IEs8+bT42Atb9P0Z/ikfbbRZNWtNldHWaMphutTGInvYBJ99F8ClcGHDtUMkQOz49e5m1PXc3FE6Efd9mBspG13VmYqqwM9zixPf0J/4/shBFdi6NDw/1z7/01HMJ5KqblFH5Ggf9HUbCq1cx5/1nqU5f3zeo9Rjr4yndKojiz14BqJM41YDz9y1sSXtZMz1wR80qUQoTs9JB1m2SkMVo1tx3Y9w+5pLwUDT0EBt/lRHsc7g6TLWKpUiNzZmmtXzeysiPrw4AS3ypbe6kNiw3BAC
X-Microsoft-Antispam-PRVS: <DB6PR05MB4647BBBCAA71B7D6E4FB4D48D2550@DB6PR05MB4647.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR05MB4647;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB4647;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(76094002)(39060400002)(386003)(561944003)(53936002)(305945005)(2870700001)(81166006)(16576012)(50466002)(93886005)(316002)(6486002)(58126008)(54906003)(106356001)(110136005)(105586002)(7736002)(86362001)(3260700006)(53546011)(25786009)(2906002)(47776003)(66066001)(65806001)(65956001)(446003)(11346002)(68736007)(8936002)(5660300001)(2616005)(16526019)(6116002)(476003)(486006)(65826007)(64126003)(3846002)(6666003)(97736004)(956004)(36756003)(14444005)(52116002)(31696002)(8676002)(52146003)(2486003)(23676004)(31686004)(76176011)(186003)(229853002)(26005)(7416002)(4326008)(6246003)(67846002)(77096007)(81156014)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4647;H:[10.207.0.55];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1TUI0NjQ3OzIzOjVvV29ubGQxRU5nTzNCcW1nbWFXYkQ4L3RC?=
 =?utf-8?B?N1hUNG9reHc0YmRrYUpCZGwvZE9JUnpBNDFCeFM0RmsyaFE0NkMyK0NlNDFq?=
 =?utf-8?B?czZSUnJ2MnlrK2R6K3N2aSs3UG94NTdYZkVsdFQyMkZ1TFBma0MrVmU2dVRp?=
 =?utf-8?B?a2R2V3NyNWlIVjlXbEcxYTBEQlMxSm9wdGFkdjBTNXRzSE0vSEJpd1FGUVl5?=
 =?utf-8?B?TWlDRVF1alZXK1dTUm1FWG9rWnZzUjZJc2ZSbktWQXlmUlBkaCtmMitkTlpG?=
 =?utf-8?B?M0dMRUp0RCtGb21jOFhZWUtWTVpVaW9VVGxURWJEMTJQUkE4OGdhTmZvSmtr?=
 =?utf-8?B?UTdUZVZhcFB4QmFONWx6YXRwNUd6VUsrQThyeFNvUHltbTArT0JRcGhKQ0VF?=
 =?utf-8?B?TytOSXZZWHJWSUk2ZUk0TmRlalAvUUpYdUtrb05aTklSK2ZpOEdPaGkvODEy?=
 =?utf-8?B?azViQVRCK241MmJjVmtWcXJJbGUxT2d1RHpZR281aHJWL2tEd21SNTVxTU1I?=
 =?utf-8?B?dXZpY2pzMS9aRFk4ZVYzTUVFemVMVE54YjF6Z2pwMXN5VllmcERyR1NBSFhu?=
 =?utf-8?B?ejZNV1lDaFVyRzVJMDExRFB1a0JVY0Q0WnovMGlqNE84SjA2Slp0eFY5ZHFL?=
 =?utf-8?B?TGtNamJ2ZWdESVkwdkU2aUhlK25ocWxEUkZYbVVqYkhlZy9GNHVoNkc0TFZS?=
 =?utf-8?B?N3Nvb2FYZVVFMDRUc2dIN0RXL3BnVyt4dldTempnQlhzSU1LbWsvdFRjaE5P?=
 =?utf-8?B?eUxicXFwclRXcGJCSTFGODBrdkxwQW9lVTJxZ05lLzRzbFN3ZHlCUmd1MndE?=
 =?utf-8?B?MHJOQ0JZeFRsN3kwWlR4Rit6UGU2Mk9tU3NLOWVKeW11MThhNzQzM3dBVFlk?=
 =?utf-8?B?dE52UG5tK1Y2VjJTSGxZZTZBZ1pBb3c0NVFPWUEwM0pRU3d1NFhwTHkyQW9F?=
 =?utf-8?B?UzdFWHliRDA5L0MyNmRKR1hwcXg4THlxanpzZTczNFpiWTFJZDM1cEZocTZa?=
 =?utf-8?B?RzRmRUQ2ZlIra0V4SVdTcWlVdlhIemZONGNYY1NjSWd6QjYvUGthVDdDWTNn?=
 =?utf-8?B?ZVI4emg1V3lRRUN2bnJqMlFhWlh5YXF5V2t1bjk4K0IwRFh0b3QxWHdZQmha?=
 =?utf-8?B?TVVCV0p0NU5BMEs2aVphNEtCMzI2ZTZyTXlIa2NzRllaQU1TZ29DZDIzV0Zv?=
 =?utf-8?B?V2Zwa0dUbmRseUwwbUtBNFFxYStOWW8zWHh0WGFlMk9rSWtpVnZnai9BL1Va?=
 =?utf-8?B?cWRtVkNZK0J4dC90cUhjUk1XR2E2TFcvcElvRzlnWlRnWElQVFFXQ1F0ajBo?=
 =?utf-8?B?UG5lWXlpVjAyN0lnbVcvazNwdGdvNVRnbzVOQWVGbzRoWHZkTW5HM1ZWQ21U?=
 =?utf-8?B?M1JOclNwRFgvR1VLeXRRTHdSbnlhbUExRkxwREYzcXdJbHR4K0NObEgxdVln?=
 =?utf-8?B?cDhmQ1JLVjgvMVRlREhxbXVlYlN3UW1LWFJHSzR5K21kT2l2eFdVS2ZnYXpG?=
 =?utf-8?B?dHNsUzdJR3drOXVFd2FVbmM0bkdzUXlLVGZzOXRydlRWdnlZbVpjNHNmUW8r?=
 =?utf-8?B?ZlQ1bVQvZmNOSHFBRUFaNFE5ZHlXbmczRFc3RHBDRjNlWHEwd0s4clV0WEV4?=
 =?utf-8?B?c0V3Q3ZxQ0RMVTJtbUpQYU1WYXhxMWpRL0tDVHBnRm13NmtpY3U5dytHRzZV?=
 =?utf-8?B?Q1hoRUFIOWQxUk04dzFhR2k1UytqZVpaNE5kUWZVcEJTY29BQWZzcTFCZS84?=
 =?utf-8?B?OTdGTTl6YUl6c29MMkV2UkJMUXM4SkV2K2RMQlhlS0RoeEptb21Uc0I0ay9F?=
 =?utf-8?B?TTA2UnVSaW9hQmZuU0RnQk41SDBrbnNPbXpia0FqcHRuaS9DRzVCZTJPVmx3?=
 =?utf-8?B?UWJDam9NZU9ROFVRaXhKSVhxbFlSWXNqOXU2Qi80enBVYnpHVnhHSnNSMEZ1?=
 =?utf-8?B?TW9ubUVXczhocUVBSlJ2TFpkdkM3UVkrVnM5WnhQN1pLVEFwMEpDdG51V1M5?=
 =?utf-8?B?MFAvU3lHYkxuSUM0Qk9GbTl5ZjE0MlBvYVpZT3JGREdjQWZGVzk5ZjQyZUtn?=
 =?utf-8?B?MDhrWkVXMWk4bHdFZHdJZFZpcEI2aVFXQ0p4alVWRlAxMGFJYk1CUkRFcXRy?=
 =?utf-8?B?NkdaWFZ6ZGFJdmdGZS8rKzB3bTV5djZHU05EVlZGY21yUDQxVEhDVDJWQzB2?=
 =?utf-8?B?NmduTmtDYjVxZjRXZnY3RVpFWndRPT0=?=
X-Microsoft-Antispam-Message-Info: tMHXP6Ztw2K2fY79iHGb87nGKpSXTLb4QTT7tNJeyRrTk1liNNVokk11anGE/FsgqWYbcHjnKbLnHR+4Asc1NtJZvtyh6ouwfuT4kgWKJ8/T8cEUftVIE1sRrcYvqXlMhINJTP7LADA6e1kRTBeLjD2OT16PPQKMJIMMmeWEfRKAmrN2lvvjc8BG4TNPD4/kXz9KUYuqsNNRtMvo6UHpMDke2/6EFOOYihWAtX92HYsOdPLWcLyjO9jBWAhY7FgBialayYl+QH0Plt/YDFVW6f9cs9fgDGN9RtPNSO1Tgi9rVZBtInW+Ei1wfu3eHAjAVPNP1rWvfIJo8XlpherYLWxaWBgWw9x1PqugJR8gdQM=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4647;6:GP0oCIiTl/JoCkDx9jQfF9YxNelOvbikFGct+0JhJ6B5hvx+eqj6tI6obLgKZHB/rdnyzAN05PwTL5Wuzd+RvsJggzUrOMpyVbAWqFLXtEgamKH8CaGuaSpb+jj1FvKwh800qFKnAxBOwx5twkuY6dm+04Gs7A5bfxLohdiLWD/+F633TAYmOJgSDsDvY/vP1maZ5ZuIcJnYW6rB58hFuOlzn5mBeurjlH9nVIOh4IGS5AzeYrnNQkJCerVWN5D6dPivNelLEpzIgP6dGsZMWqmUjD6f+j2RPe8k9RebUND1pJ31anQl2sDS8u0iafsh+UrVRQfxf0t9GanWybapZTEI/wUuVdh0mG1yfNV0o5XzrlhUYQMkdyNmMvZfjbwciIn2YoC4FpAkc3KUeAwP0AWJhTRVsZp3myjri13cBvKffoL7guaNwyCc9VnkMw14tRv1tp7NW/WUSogbfsv7qw==;5:KoyCLuVMUTX3kk7e0B+P7JQlM+wGwdMCwOHv213YwkSyQp5qSbeWmgiUFxHdurpuxSWq2HO97hqBqskTnihRmpM3GwbdQYv1tEYg1aRk5R2XqFeqQuZimc7REpQDviXRMnIaubJyei/2XcUDL5Pvad5DLDvRkvAF2oy/VHJ/d/k=;7:TnJzavSrZcjWqzt2bQTtDKzdsFXe/MWVZYzI+eIdU7y9dCSMe/r3g0jukSftsYes3Fx3bQ33YpoSxzZIWf6K3PZ4wx/KB5BBuSWIDz44Djmn4toXsgtxQJSXrW5nrygF19yOnVQ/Nc5IGcI2GMYwdW3XPDXzRCGPJk1zQuLh6dXVfSp9StSkmZze6RxwUVEFu17tSi2I42OT7y1U8CA7t9IUbQTQt5vTyB9x1lgYWphpP+6k9iaV6wh3ZqSbBDGK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 13:39:34.1999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0aff68-6f4f-4913-98c3-08d5f16ae538
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/2018 2:59 AM, Alex G. wrote:
> 
> 
> On 07/23/2018 05:14 PM, Jakub Kicinski wrote:
>> On Tue, 24 Jul 2018 00:52:22 +0300, Tal Gilboa wrote:
>>> On 7/24/2018 12:01 AM, Jakub Kicinski wrote:
>>>> On Mon, 23 Jul 2018 15:03:38 -0500, Alexandru Gagniuc wrote:
>>>>> PCIe downtraining happens when both the device and PCIe port are
>>>>> capable of a larger bus width or higher speed than negotiated.
>>>>> Downtraining might be indicative of other problems in the system, and
>>>>> identifying this from userspace is neither intuitive, nor
>>>>> straightforward.
>>>>>
>>>>> The easiest way to detect this is with pcie_print_link_status(),
>>>>> since the bottleneck is usually the link that is downtrained. It's not
>>>>> a perfect solution, but it works extremely well in most cases.
>>>>>
>>>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>>>> ---
>>>>>
>>>>> For the sake of review, I've created a __pcie_print_link_status() 
>>>>> which
>>>>> takes a 'verbose' argument. If we agree want to go this route, and 
>>>>> update
>>>>> the users of pcie_print_link_status(), I can split this up in two 
>>>>> patches.
>>>>> I prefer just printing this information in the core functions, and 
>>>>> letting
>>>>> drivers not have to worry about this. Though there seems to be 
>>>>> strong for
>>>>> not going that route, so here it goes:
>>>>
>>>> FWIW the networking drivers print PCIe BW because sometimes the network
>>>> bandwidth is simply over-provisioned on multi port cards, e.g. 80Gbps
>>>> card on a x8 link.
>>>>
>>>> Sorry to bike shed, but currently the networking cards print the info
>>>> during probe.  Would it make sense to move your message closer to probe
>>>> time?  Rather than when device is added.  If driver structure is
>>>> available, we could also consider adding a boolean to struct pci_driver
>>>> to indicate if driver wants the verbose message?  This way we avoid
>>>> duplicated prints.
>>>>
>>>> I have no objection to current patch, it LGTM.  Just a thought.
>>>
>>> I don't see the reason for having two functions. What's the problem with
>>> adding the verbose argument to the original function?
>>
>> IMHO it's reasonable to keep the default parameter to what 90% of users
>> want by a means on a wrapper.  The non-verbose output is provided by
>> the core already for all devices.
>>
>> What do you think of my proposal above Tal?  That would make the extra
>> wrapper unnecessary since the verbose parameter would be part of the
>> driver structure, and it would avoid the duplicated output.
> 
> I see how it might make sense to add another member to the driver 
> struct, but is it worth the extra learning curve? It seems to be 
> something with the potential to confuse new driver developers, and 
> having a very marginal benefit.
> Although, if that's what people want...

I prefer the wrapper function. Looking at struct pci_driver it would 
seem strange for it to hold a field for controlling verbosity (IMO). 
This is a very (very) specific field in a very general struct.

> 
> Alex
