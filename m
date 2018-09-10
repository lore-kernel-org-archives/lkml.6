Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9943AC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1B520880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0TATSarh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1B520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeIJUZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:25:24 -0400
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:31664
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728020AbeIJUZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCjc93mbhxv1OhcGexDYL/okeAqTouR94M58yV6Uxk0=;
 b=0TATSarhJzVoiSBspnAU7C0S75S/aVG3EPn9kgUomvn9PibpE7sX90qhCT7GUAJBRXEtW6nFKpMNWrizx8w1zs+TwwiLvLm6DqqdAp1t9Z6Q7vWS34LLrocBvc5aTM8BpKnYLxxxO19vldqFQOeXSOqn/iIKrH6WgwScJyR49B0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Mon, 10 Sep 2018 15:30:42 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-6-git-send-email-brijesh.singh@amd.com>
 <20180910122727.GE21815@zn.tnic>
 <026d5ca5-7b77-de6c-477e-ff39f0291ac0@amd.com>
 <1536586152.11460.40.camel@intel.com>
 <097eb5f5-2cd9-8b08-32c5-d90c8e0cbb6d@amd.com>
 <1536593297.11460.72.camel@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <11618b8b-4d1f-9307-35f0-3c0f0fc856ca@amd.com>
Date:   Mon, 10 Sep 2018 10:30:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536593297.11460.72.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0201CA0025.namprd02.prod.outlook.com
 (2603:10b6:803:2e::11) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f370b684-25b6-4725-54ff-08d617325f21
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;3:gfo6tLCDa/d0dMNPVCgbK0LxyQJxtyLgQSRm7qjzKnAuWA8DYSem5En60ltsosHmPCEGjAPNu3ItzPTRwecCocCg313hIV8kZ7SHDvCRg50Lj1LRhog0To6Rm5FUqvx8tk/RoCrXsNfcFOVe2coHk+cY8u/Q79/1MfrPaxz3HLQVK6Be37j7xQ2SnYoG4lvzpfM+PGB40S0bIE6hLNW4vCynBprv+eWR1b2gLwz8z8EUhx3fu2+pW3ekTd9lbUoh;25:erjtE4KjCUJNwTqvKqXQRv0yhKdr66ttn5SnrnE70afSQ127uO6q8wdupYh+o8VCPANFDdo8Phc0DeYdWHMYV0xjNdo+OOq6XBfk/v1OaZ+KM7hisoq1U4tZACv/CsvZNK4xokpbwWmRIdBdcartK7VAu2mF2z/rAw0UVqljVXNWD6xdi1/t/SlOEAfRvrEMaz5TnaUBdd7LOLldRsy8bJ4Dd8DABJHQ3YPRmqcRsAe1FEtWMLNYzNqVcXMXzJWjLvMAV3DNFHBvwZzxvZcvpBt4rjtQXfpefG9PynHeRiOp07gOqQDID4GNszCpD0StoynWYjo/FPabtmw7HlHNnA==;31:YPY1eQqlhbaheFkEDTX2dD2tH4Z8RBsSdsQdc4WL2Z5L8A4gRjCsIzVYbhfFKJorQWWg4yj8TPh9H0g0jasCl58doxTj3LmkUubX1UVHM/qhf5esBZE4p3fPhWKvwIVlrJBA7pcDjL0mtHlOAkjUlqLoNSnP5U39v0ArPU7TXNPj2egxUet1rgK+o0H2ulwtQ1Jr/tj6oqt4LAjmn5F72kdvYyktPDc2+O7piD88R9o=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:ZksKhcyQn6Hsoh8wuYOrkF9E4NigZqeD0fpkai+4bH2nXn69jHjVidlxpk8IJQvw1x+IjjObnvyPl0Qg7wSic2EuZhNLhiELUzSIeyKaVQeL9RjVej8GzKpqqsbJAGyf0n3hzsrTiM1GPXW5dg3OabKq5KBnnfWTWVyQ3u/yR7UUvV36SpJ1d5y9hOri2MI2v2yyYoiuSH+ZWwhG8YKUNkPs2HX5HgEk06BKTm2DcSds6trRxRJcbvr+FrgPN0Y+gF7wADAlwypLbxvxI4iibWh02UyJMqaC3cR7AViLfmfUo8/cq1t/6QAgiNo3OGr/WMyWcAOZyp4UZEhuP7RH7+UeYQTpQ+B7/e05g4mMaCxpDx1Gu0bJwHLu3PGGz9MDWXa6l/exmLvNhpFAV4utZxQGFiuFVVXUMCrNh7Q78G4hY1IgMrZsNSFoAHhwOw4lNE9C/Q4ZXM4ndMEvKU+JVhtOx/OKu2Xga+CQXMNzyrgcch4r2+vu3Ma172KOzIKP;4:ZTThU6BnLELXflrM0U1rjrMn/TGA6foSH2YQcL0D6fsPZaOfoA3gjsZ9bDHCu9eeAwYcsEYETHXxPDR06LvXo9LWzIi/lSd65wAdiqZNcUY+ECypt8tZVny51H1+afNcMkNeu0KnHyOyLprirTe+KcV2ozFxQx+4k4HWX3Bwum4VLO5v3B50/FHj/QpM2tdQklI0wGuHAiFnnjx+YVTHhmVJah8Pn+wmd7K2qyQcDnfg5ahOZUrIveffLXM/ALmH3j6PgqIELV6rF96FP7sXvA==
X-Microsoft-Antispam-PRVS: <DM6PR12MB2682FC9CC4764C36824D0C1BE5050@DM6PR12MB2682.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DM6PR12MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2682;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(5660300001)(53936002)(53546011)(229853002)(50466002)(31686004)(67846002)(106356001)(65826007)(3846002)(6666003)(6486002)(6116002)(105586002)(52116002)(23676004)(186003)(52146003)(54906003)(16526019)(47776003)(110136005)(58126008)(68736007)(77096007)(26005)(76176011)(386003)(2486003)(316002)(66066001)(65806001)(65956001)(16576012)(7736002)(305945005)(6246003)(36756003)(2906002)(14444005)(2870700001)(93886005)(25786009)(446003)(81156014)(956004)(8936002)(81166006)(476003)(2616005)(11346002)(4326008)(64126003)(486006)(8676002)(86362001)(97736004)(478600001)(31696002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2682;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjgyOzIzOlYxbWVtTGdBMk5nY2gwK3cxMi8yU0VrMXFM?=
 =?utf-8?B?MGwralNLaHlhTTRTc2FOVXVEN200czQ2amhNOXRpUHBKSnFiTkxHcFhONlJO?=
 =?utf-8?B?NTdIcTFxNXIyQkYwNTF2SHpHWHdYK3FsenRRVm5jck14WERjUW1tMFBUamg1?=
 =?utf-8?B?M1dVMU9LV2NSUXdmK2dDRXp1YU1wYWJ6K3ZlNGFFS2ZicmNNZzNEL1dXRDJC?=
 =?utf-8?B?c1pXZUIwaHFmVVJTamwvSStEcGRvblFRMXpORFJINEZaVHphKy8xMkZWN3hr?=
 =?utf-8?B?UmQ0d3NhWDF5R285VWRHN0hjd2pKejhRTnhMY013eFA3QzZlamtBYWdjVW9v?=
 =?utf-8?B?aEJhZGVibFoxTTJEa080THJMVkwxUWU5QmxBZjRIeWRqbmwvUmJoeTF3TFBH?=
 =?utf-8?B?ZzRzNVN4ckRTZFpxeEZqTm9FTWVNZDJuNWFmNTczUVN1aHpkM2NySnBNUWc4?=
 =?utf-8?B?WXc1ZEFMZEFzUDYyK21xUzlZenVQRkVNNWRLMGkvS0NNU3NuZW5kcitxdW0w?=
 =?utf-8?B?dHc5ZXZtN1RlUFM0MTA2YlljaUNsc3JnWFRGd3JzLzJMRDRyY2JucUR5TjFn?=
 =?utf-8?B?NmtyQ242eDhkMy85RVRIczZJaE5nRk84cnU5U29JSDFzb1U4bjBFRFJoNHZp?=
 =?utf-8?B?aWl4c0sxUytURVRzeFkyWTR2d1RFNldPRS9Gc3VnY3pYR0hMOWpNTld5VUtW?=
 =?utf-8?B?RjBFeUNycVg3c0I2WU5CVTlLSGNzeURIUHk5YWRsZXo3VGJ3VGsxTW8yd2dk?=
 =?utf-8?B?b3BIVkIzbFdsMUQ0d3JXUVZqd0s1QjZGM3E4Z0ZSWkVZM0RyMWhmRC9OK3V4?=
 =?utf-8?B?akE2OG5MUktnZjJhVmxoV0E0TSt3Nm4wNUZxOXZJYWxzNlJWZkpPYkNETXIw?=
 =?utf-8?B?Tm01aGsxL1F1bDFsKzBiTFN4bEZKQUdRc1dwOUE1OFJiWE1yWitJS2VCTzJE?=
 =?utf-8?B?aTdKaEJyR3BHSTRxYXdjQ2xSODQxSEtUL3h6cG5zZ2FqWmxkVlcwekxVeFZN?=
 =?utf-8?B?a3o5a0ZWeTRFYUJhdFd2S0xTK250VWY0R2NXbFRtMHFsSHQybGprdGNQTFho?=
 =?utf-8?B?M0VxdjF6WWh4WmZpNDlSaXF2OFoxVmYrNFJtSjdPRHVmRU1rZWdBNFZ4OERD?=
 =?utf-8?B?cXFlajZzYzJGVUpjN21neDZCN1dEUUhDb2JmcC9LZU9ML3BNZ3RVMVlFaUNy?=
 =?utf-8?B?NnVMa1MzNFgwcmsySTV6em1BbkgrMmcweU1mZHRlSkFnUlhUTWw0MUlmcnNM?=
 =?utf-8?B?eFdyRXRBR2ZPZW0rTjk2emJ4RmIrT293YW84QzZvajVhUkM0cGpLbWwrd29i?=
 =?utf-8?B?KzVTQ2ticlZnMnZmeUUwYVFXbnJBVm90RnVORVR2a0MrYkMzK29UQ3FhbnNZ?=
 =?utf-8?B?bWsrUzJneHQzNkluS1hTM2xTeFdUT0p0aHZ6NG05QXNJTzBXQk9wTGtxb0hY?=
 =?utf-8?B?clM2N0lDM3JiOVI0blZlYjhBOFhrY0R5U09CWG1VMmVzU2hpY1BwK1ZISTE1?=
 =?utf-8?B?NEVxVlZEb3VXS2dvcVNXU01ZU2kvSTdKRi95Zm5IZGpEc2VjYVVzNGYzWmho?=
 =?utf-8?B?V0pNTWZEbk5jNWRvWkFyL1ZpSXJ6VExwTjYrYmhzWFJEUDZMUUd6OHdoZzV1?=
 =?utf-8?B?VFRVRWZndy96TS9ram9pYUpGMnVlaUcxbzhCYnRMdU9Pb0FEbkRhYjMxOWU5?=
 =?utf-8?B?dHBxaDVYZTlSQnZUV3FXTUFwWTJTeVVqZXdsL0Z0Q1RnTWlyclFjZ2Y5UXU4?=
 =?utf-8?B?MXN1MU9URld0aWMrTTU2V2tsYVFlOWEyWjVzejRWbWl6Rm1JNmRhQzFJUUR1?=
 =?utf-8?B?VjluUzBxVmE4RUlhdXlmRlZMa2lxVTlybHpianUwYzdvRTdsN3VQUWtKSWh3?=
 =?utf-8?B?Y0M1ZjJKVzUraVh5NXBNUmsrbWFWWG4veE1POHFsamtTbDBlMEhCQ3B5bFV4?=
 =?utf-8?B?SUh5WXVqSEVGemV6SEZ4eDNSeGxwdlo3NFJXbEc0TGlIc0pXRTV3RzdkcmxM?=
 =?utf-8?B?YzFRaWNSM1Y3NUIyY2R6eTE2ZWRxWDJJMkpVR1MvU0pHcmN4bE8weUFBNDJl?=
 =?utf-8?Q?PfU0=3D?=
X-Microsoft-Antispam-Message-Info: Z5v4euoi2IOLIxAbDJmdJ42RDhuOwFClgrohe4HhNh49Yiynbc1DzGn4/edUtslwAVaxXm2uLY0DDvQdC2PBZAtTPlDplOXuIPHs0cTE2G+eVoy9gXmpm8nTz6EylN5yIqszoZ4kqkhmZ1jwty6NnFZTH8TUJgv5yFMXBA1BlBmZE6z4B7Y47qHqhRnS+6ZesCuIFWb/wDStFDnpp5nvU7opWgv9j+XzFvDnfjCj1SNrdfPxOMSN/il0NzcsSneTJOJrsFGFEioQwcsQgDg4KER8N0dEjVpRy/yN6XNvwrZYqNRM+PAZm1d5cojPRnv7QJFyp7qPolTUyBDvGld9wOTcLJ8EIN76/LVZhei7Fy0=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;6:xLn2rVj5i+yBxcMv7YHO+OW/9K7+J+h2fWfZuN0VLyQi8QH9MfvK+itdyfoVIMuPa3kjvSiAzuqWCt7PqnJEsg4Qpu6lS7pbgKuvrMvM41//mkxLSymDElU3DYmDhB48yGElvDm43TXy3la8g4Qss/Wq3JuVwrvS0u1e1T9ukosxMcLdSAoUXtoN2dHTgK+N4aVkpmYhdmzuS6OmoVo5VLU7o5QR9vKF+M/65XfOvpC5x6p8RdEGSLjpUdIA71FBANfFJLE32cy+QNtbzyDbdZfEZnVToaO12JC79StZu/aH027qrRSrhTBfIRn8y07+uPArM3WlzWe7O6LEqeBHbAOCgqBnHTRz6GGHFG45QXfgg+UPH59IExfrIIRoaE6XtvOqWZ1qcA/TIHXhkVeLCCHzDv+vevPj3Syrm7Nw/x5VsUXdCBXk9XRw+A6tDKxbIYHHtnsUZ/EAgi+xVA8ryA==;5:fC5uont8h/euQpRXCpunmsb0McQXV5OtdHs+yMT3WFYe3O02oP+aiArZb/YTiGCTfBFLOsw90dKdjZR1Yda+xGOoRDYOFtPq9WQqS5WzUUCjtg3Ea5Gflmbm0KQMeqgsgKy8E3fheob7fLqOipJxftxelaNp+nUpAEylcBTYJRk=;7:mxs2nvosfMxNOkB8SewZxshaNO2w/l7xcimZNG4Lj30mB+9FAurYya/9n7DsosEijEDadeo4NFugP2drtZSgcFTf1npoSiA+BWb6agugkoWom65vEv4aJ7d0h0kbdaucNNpuky5riivhgDmq48oyIlRAljv238ZX3fKPqG1RXeek1+S8u7oCXVLlhCnkDcQQfU/wmxV7Zp367os0wdbjhYIsvpWQzRXk1sjckN834+v36Y4HSCcD6juFO2BTxVVl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:TPMeOi4t1iYypT15+proQ4V+3w/AIHnOsFGhmw2+AdRyCETBMxh6Pj0pPUu2My21h9C3OyzXkJFYNXfDeE81m9/kAA4HrQYxIOo4OR6DC171ZYe8dE3HkweY8d/iCODO8U+O5yRxCyt0wzAqCxcRFvXzUmV2KHkJIz1EvXrN0Myxym9Lq2O7y7Egju20AL5LqCMm9OauM6DOCD8qF3eeQZ2z/RAwEwym0rBeBvM4CYL+ZZZ9XyiIyv/Mq72OEigk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 15:30:42.5023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f370b684-25b6-4725-54ff-08d617325f21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2018 10:28 AM, Sean Christopherson wrote:
...

>>
>> IIRC, during guest creation time qemu will check the host supported
>> VCPUS count. If count is greater than KVM_MAX_VCPUS then it will
>> fail to launch guest (or fail to hot plug vcpus). In other words, the
>> number of vcpus in a KVM guest will never to > KVM_MAX_VCPUS.
>>
>> Am I missing something ?
> 
> KVM_MAX_VCPUS is a definition for use in the *host*, it's even defined
> in kvm_host.h.  The guest's pvclock code won't get magically recompiled
> if KVM_MAX_VCPUS is changed in the host.  KVM_MAX_VCPUS is an arbitrary
> value in the sense that there isn't a fundamental hard limit, i.e. the
> value can be changed, either for a custom KVM build or in mainline,
> e.g. it was bumped in 2016:
> 

Ah I see your point. thanks for clarifying it.


