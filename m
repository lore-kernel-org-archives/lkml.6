Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D3C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29214217B4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Oykd3xLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29214217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbeHEJJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 05:09:03 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:44152
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbeHEJJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 05:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU4b6+dfFtbEFm1KMa+/bxa8Tjm3WvAhz+RatoDXkkI=;
 b=Oykd3xLUabHi8DB+uLht+OfPapuEz6Pp3WQNKc7YQc63N07md0BRRd1dkENqD0Bwq7zaXSmOkDSPFZqDgCerHXvG3/+X9VrPzD78q1n72rSGAkbwRc0LZRM9X17XcfB1MXYIAbvx+DGOSFL2KqghJH9FECmWJ9No85/7GZPLjsw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com; 
Received: from [10.8.23.6] (193.47.165.251) by
 AM0PR05MB4643.eurprd05.prod.outlook.com (2603:10a6:208:ae::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.18; Sun, 5 Aug 2018 07:05:18 +0000
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
 <fc04618a-3b3b-58bd-edd5-cbde11638d7b@mellanox.com>
 <1b914780-e342-6aee-ffb2-ef81ac3ddd29@gmail.com>
From:   Tal Gilboa <talgi@mellanox.com>
Message-ID: <7424c5ba-ae44-3d8d-9dd5-360e17b6e3b9@mellanox.com>
Date:   Sun, 5 Aug 2018 10:05:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1b914780-e342-6aee-ffb2-ef81ac3ddd29@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: VI1P189CA0025.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::38) To AM0PR05MB4643.eurprd05.prod.outlook.com
 (2603:10a6:208:ae::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20711789-d78e-47a3-7508-08d5faa1ce85
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4643;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4643;3:0eeB+0hf4VD64vfhaZK+0I8JXNL/oYyBcdgL5mcumanHPUZ1KqYMdY/3jqp37Rm6ceKk73H2RiQLP9pZRrl8GhATXDGiYOG9RDTjvabxcqCIN7gyIyfLL7kWPKDW5a7AJziFbFd5GDS6CJ+icDQnAqCu9DaeKVy1pSWy5hq6d7BLLSyb4URjtytZO8cwAMG4m5QZQrQjvfj+0/ii3LqQJuasGZqskiREzqlTRoGonCUIwfVYR0qAXNFWp5AMe5Oh;25:jqsT48WxOIf7D6ifEGj74YU5Y3Buube7Jaa/dvDCq3GrBUPuyUCPD03D8dNVoWEEhlpav2aj6n0Dw6VoC4GJq03xb2Q/gU70i8D4CXhZk0lBzgMdqTcqqedbJ/4p+Fx4y6FxlX61Zw5Z4uuhJS+D4NZet111G/cu2Eh2Fh0VarzhUh4cbaUFhY6BY8UGuOdFR6mr4gyFE87kNgBkEm28zRUdjdXv5OvF1vGdsPOaOD+sKP3HbRjuFz8o6b313nK3GcFxHvOJ68zu36pNsUdpOX1Vzos9YYbHYhe4RQuTrbHc/jBe0oS3Fm4jGBoaAflb7CokWMSN+qxvkM1aH9C3TA==;31:YCI/PyEiRvkRfzU56KeH+upPR9j68P6U2gwRiykO0BYrKldqp+kWzu22d7G3axB3F70AWScY85Ox6SiliJehBks3mMPhIvNuCDvZJWISHry7BsuU20jguXw76DokFnUWKJDicEUNBc9eF411/sU6Ie6tqFhmEmdGWk4O1nvN7IFHzxi3HQxyOEvzHkc4BAkJSepxcPJ1L3qfhPDQMlCyKekxLMf7nFPV8RF2ASDAR/8=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4643:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4643;20:0ElBcUB1Ch/Gdwn3MkIJmOVuHYb+j6ncV5a2KNYfefhmOS5hEl/EL9mUbchBHe1Hj6eMUnSHAAQUFiXoICOT6nLyFwySfa2hUcUFIJniwtRPfsV1mg6JeFNH+ZF0wTmRx4rtFwLHfBEQTF5/uEzqNYpYlIwKDFmyb14+bEwxk3k+xSoJLe0jOQGFIaK1aSIGyJ2RmTbbgVJ3KOfKMyV+Q4Rx7gI2Y6EXbunEIcEbCwg9M0r1QN0C9m8bsKxkEuANbEA0Zb/iqIbZW2F6n0wymGnrVd8UtwskWO10bO7Df20cZRwl2gGyfQPpFpVZwrv+2TGN75sgltrInJzPku0sFAXSjm8hlsdS8qCgp3fyZ/dDe5J+QGXx/JhN8lGm/lqS2uU4hYRsEVkp/pw41DvJmLDUvpN4NsnN73Gnet4PRZ3KpHgeLJTsoSUQJYdOMrXO/58+L+2rTmQuda7Yqp50Lve9vlRMoS4Ql4+7GZgG5kUBc+Gg4JpaWh6R0Fhkr9vD;4:cQs0qHOwNH4cA4O+xYxLr6jyU8AdM1ifHfuFZyfSDsJPhWApJZHRMSL5wXmo11v4gp78qSwnL1AfUESiIMDYjZAZd0hy/bvCSOMsxWk0FHK2yB/1aqp/3sPU/1vFISJUZzwseKpilwavwVehoeH8bZGSWp+N0DpFyjwd62hawq0sXNFOtc9xK5IHgAPXUdbuvfU7dBklcvm55ibJa5HlQNJQJ1xynYToYi+M+S4Eh92K3XivGsCjUX+pUC8YkzYOaTbCPrC0btY8+Va5sG2Fqyka1KX5dohqT7YeRaK7KQX6MfhP+gDTtkRQHXjB6sVN
X-Microsoft-Antispam-PRVS: <AM0PR05MB464326FB734799961754F3EBD2210@AM0PR05MB4643.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4643;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4643;
X-Forefront-PRVS: 0755F54DD9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39860400002)(136003)(396003)(366004)(376002)(189003)(199004)(6486002)(53546011)(386003)(86362001)(26005)(486006)(476003)(16526019)(186003)(65806001)(2906002)(54906003)(36756003)(305945005)(52146003)(7736002)(105586002)(93886005)(76176011)(52116002)(2486003)(47776003)(66066001)(65956001)(77096007)(956004)(2616005)(2870700001)(31696002)(4326008)(316002)(11346002)(67846002)(478600001)(8676002)(3260700006)(25786009)(64126003)(58126008)(229853002)(16576012)(110136005)(6246003)(97736004)(3846002)(6116002)(8936002)(53936002)(50466002)(68736007)(39060400002)(5660300001)(14444005)(65826007)(23676004)(446003)(31686004)(81166006)(106356001)(7416002)(6666003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4643;H:[10.8.23.6];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA1TUI0NjQzOzIzOjkvMm5IM0tNZGtYdHJ5ZjhsRGRHalFCeGlK?=
 =?utf-8?B?YVlJL1hBcVp4UE5zZkFWbU90RVJ1S1lRYkRwNVRhZEwrSzJ0UUo1KzZBb2Rz?=
 =?utf-8?B?U3N6WUJtUUduS1NQTDZvb3FUc1VFM1k5TUZDTDBlU1QwdkJXeE9OOXBnbW5D?=
 =?utf-8?B?aE4yZERvN0tzWFp2NkdPZ21ST2hJdnZIWjNQdzRrS1JWVi9WY3NUTVYwRUpx?=
 =?utf-8?B?S0c4UkFkdktWdmtDMHpTMEorWWtnams2Q2kzOU5rZThVSjQyeENKeEtIZUIw?=
 =?utf-8?B?WXZ4REFlVndVN2htc3NHSm5nUlREYTVLQ294MkNyMm1WSzdNTEJaWU1oSVVV?=
 =?utf-8?B?Uk5welQ3QXlvQXFZQ3ZtTTFmRWlleEtwMG5lWnp6NDNBbUYyM1l1NVBXVS9y?=
 =?utf-8?B?alpjTHdxUTUxMnFybXVydDNHZHFWR3MxKzNTN3d6VG13YlRFdENMQVBCT3VU?=
 =?utf-8?B?OHBiSUVHQTdsR0wrWnVpSjFOU2NHSDlSV3N0R0pmWnR4cXRSajNPK0tHU1Jz?=
 =?utf-8?B?TXVCa2hCTEVPTmh2cmRtZ3FFcjcvTzk5SThaV2NzaUhkTFhsb1VpZGJLejZ1?=
 =?utf-8?B?eUp1R2VwQlpHWlUxQUtmOEJmRWhqaGdib3VUcXVuV3hINWJJUjk0ZlhPakpL?=
 =?utf-8?B?Z1hjL3VZbC95ZTAxN05VVllhY3V1dHBmRDByY3NnUjFhZ2RxRUwweHphWUlh?=
 =?utf-8?B?Rk1yY1RKa1crRXZqQ2lOd2pRU2hYSnp5RWNaRGpYNU1zaFQ4UnRPOHRhYnJk?=
 =?utf-8?B?MlFQa0p2ZkhpUjhYOUlmcG5vQUliU2E3T3pRMktLSER4bUxWaGtzT3phVEx5?=
 =?utf-8?B?bnRxM2JvM2hlanlWaUgyd1ZKbkpVZ3ZoU3NTYjdnSmw4N3VYa3IwaUsyOFVn?=
 =?utf-8?B?bUpOR09adDBpd0NqTXZkUjBwWWc0UGp6NHpTSVJpZ0taVVY1T2MyWWszYmY1?=
 =?utf-8?B?Q1BUSkovYmU3cktNcEtzN3hHd3dkUGpiM0VBYU9DOVBmcDJ5U3hESTM5QmhD?=
 =?utf-8?B?TUZLblBCSUlSbU54alR1SWxtWjIzTnlCSWJiUjZjNkNMd1dTd1l1czFKaUtV?=
 =?utf-8?B?cTlpeXEzUkRKRDJ0NVlwTDdnOFZIYzFEQWpuWjZhb1Mwck50ZnRnZUJIK2Uv?=
 =?utf-8?B?bFpOd2ZFMnBncW56eFZ4YW9tY1NnWmczUVR2NmZQOEdKeXFkNG5wc01wL1Vu?=
 =?utf-8?B?clNMUkdTMkwrVUtwOUQxQ2JDMHJvMFAxdkhZU21PcXRWcUxSV3NhU2dkN3hP?=
 =?utf-8?B?cDQra3NoUGpTREIrbjNiRWk0WE82aWVMcGllS1VBcS9BeTk3YThoV1RUYjFp?=
 =?utf-8?B?OUNLdm1CdnJ0MEtkRmZTbzIzUHZYWWJHTVVJUFk4SEp4aTl4VE0xUXJlYWFz?=
 =?utf-8?B?cVlxeHpWQkdEUlB4UVV0eEFvUmcvQURjWGRYdVYydFBYa3ZxZVRKeXFQZ05Y?=
 =?utf-8?B?NGhuQU15OGxmRmFTVlJrQThmVHYweVh6Nlc5dnppNUg0MkR6SFpIK0E1MkZx?=
 =?utf-8?B?Z3lCbUhQdU9WMmRNMHFXenYxcU00eWZaU1RmTmlwUTI1dWFKZ2dDTy9qSXRt?=
 =?utf-8?B?NncxN1k1UlZMbk44UTBKYjRCdzNjVTk1MlJoSURWdlU2ZTlIc1JhTHJhTGRs?=
 =?utf-8?B?T3N4WEU4T2d0Rk0zUDVFRkJETExrUCtKSldzeDcvVW8xK1JwdG9Id0ZvdE1h?=
 =?utf-8?B?Q2hUcThjeW4rbE15SjR3eVNCU3FNb1lJaGRXZnZ3MDYrZzllREVoelBITFZR?=
 =?utf-8?B?Q3ZMd0ZKWDZXb1RYZEJ0dUtiK3FUUkFBZlI5ODhsZzRRdjRzNDZsTTB0amp4?=
 =?utf-8?B?bCtGbmVueVA3OURaUFZlNjB3d2p0R2Z6bkVGakxqNDkvdWhvTm52LzROWjJ3?=
 =?utf-8?B?NVF3U2FtYU9LREZIMERqUnFOYWFsSHphYW9Yb0NpRG1TZU9UUzlmbGNGUGxo?=
 =?utf-8?B?dWhPWXV6ZUd0ejYxc1Zxejd4N1ZVUHBVUzRaOHhiaDhxZFdYcm1YRkNXYUY5?=
 =?utf-8?B?bjVJVFNtd1dRTGljUkZkbzUyRjYvL3dQRjVRSWpzT1hCM2YrcHpxcWl4RlIx?=
 =?utf-8?B?SDZtc0VWLzNhQitieVFaQjIyZjNXOG40R0hFSEdWeS9XUmR1L1NEa2tVRWsx?=
 =?utf-8?B?S3c9PQ==?=
X-Microsoft-Antispam-Message-Info: tmD+blGpdBL4Ww/0ku6mSk91UTbtuT9EpJZqOSOcdhEUG809oLZH4RfFSXvDQZ8o+5ZEMcQ7UCsdoow+RMcf4R/Bl82L3Y8jg3kAWvos4szEHcxFmWJloOb0nvW/qG3Ehju1ppKQFwxRHteiePlQaj3RCEXCeUisY5qF+LMlxQxfU2azxkPWiE7uFMrPbnhjCy8GSv6vHMa0yehKRYo3Qlfnvw9p5J2rQ5p9TOfRQCk6mawqOzNDabqJfQto675vlVolseh8ayOz/9yMdPgJz2R086551nLLCS7pUTnYHjyY4gG7ZfDFVQk/bY7duWyjiv50CJyL/d90j6f5xW3w2fo3LLhpFwbWUB7hWeBo7t4=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4643;6:e3UccAnHvvmsaoJvYRF0juMiE4ydjLdgbMYnZ5n/Jnyonn4m0po5nqoFtgXYHHa/Ms/cpQJEsl+/tUsz6D2vKOT4gsEIqjWN59ld0L1v5oFq3Ke/3KNzizf5xQk6oNQoBDzmbsJRUwA2Gxpobux7hDbBTfLCgA8ULR60pgwfpw9wH9eC8DRukNhqEFfbAblR9+TMVf3Z4KdrrYwymbWfoMaE/ECMnLhJqEkyl6j7ZFIUmZ7tNfkyfh63KgTJCnvYloU3i5J/+M8XtUcjJy5lySb6ce6w+aI9suWg0e964OpC/uPifce4jTuqjd1y8M77DUkMCinysHCViJoO2qQphUlIzlqQxCjVQeav8Vc4knNgwV5Qaudv6wqxfyDJuZOJc2Ox3fEIEgmwB3BdmkgUpZpUyAWCMlskrwfhAvPnzzCmEokp0GOoiQbRYzTiV9FpQkeCpIkciMaaxuKf471S5g==;5:6eHlPgDCHP3yajs+0z8TDkaIFh/3JNSR7vYGIxiRivl2kvxrbaAbAJbBHERq/OxsBaNiOkbmjsas8xUuaDSZYg0PZubKkMcgFJFKWxLheGvhMZvduir0hpVxLnWzrYRdy9NeJmmaFpwyRGQU/rI/EpqBukIkmjp4qR/lIpHSf2g=;7:cQ2JUjeDqGuPpNou9/G634vFqG38KNVYtJpxYpeLbt8RRdn+x0g65O9LLox4v6LjVOXHWvbL3QROdizeH2ujAk8JJL74PVgPsGHSR5tNOJVpZEDCF1k4MJ5ZH9hlPqFI/eYI//QcqmT1JVwqJwWgpaJs7daKEW2V4AYj8wi2oidLLucc5QBG4QtSJ4QCEg4VkF/+/Zde7+alvq++1tFH6/gOeuyTHi8YsShCdmYGOL3KyHZxXNvDnGnVZs4EfuBs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2018 07:05:18.2428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20711789-d78e-47a3-7508-08d5faa1ce85
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4643
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/2018 6:10 PM, Alex G. wrote:
> On 07/31/2018 01:40 AM, Tal Gilboa wrote:
> [snip]
>>>>> @@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct 
>>>>> pci_dev *dev)
>>>>>       /* Advanced Error Reporting */
>>>>>       pci_aer_init(dev);
>>>>> +    /* Check link and detect downtrain errors */
>>>>> +    pcie_check_upstream_link(dev);
>>>
>>> This is called for every PCIe device right? Won't there be a 
>>> duplicated print in case a device loads with lower PCIe bandwidth 
>>> than needed?
>>
>> Alex, can you comment on this please?
> 
> Of course I can.
> 
> There's one print at probe() time, which happens if bandwidth < max. I 
> would think that's fine. There is a way to duplicate it, and that is if 
> the driver also calls print_link_status(). A few driver maintainers who 
> call it have indicated they'd be fine with removing it from the driver, 
> and leaving it in the core PCI.

We would be fine with that as well. Please include the removal in your 
patches.

> 
> Should the device come back at low speed, go away, then come back at 
> full speed we'd still only see one print from the first probe. Again, if 
> driver doesn't also call the function.
> There's the corner case where the device come up at < max, goes away, 
> then comes back faster, but still < max. There will be two prints, but 
> they won't be true duplicates -- each one will indicate different BW.

This is fine.

> 
> Alex
> 
>>>>> +
>>>>>       if (pci_probe_reset_function(dev) == 0)
>>>>>           dev->reset_fn = 1;
>>>>>   }
>>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>>> index abd5d5e17aee..15bfab8f7a1b 100644
>>>>> --- a/include/linux/pci.h
>>>>> +++ b/include/linux/pci.h
>>>>> @@ -1088,6 +1088,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
>>>>>   u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev 
>>>>> **limiting_dev,
>>>>>                    enum pci_bus_speed *speed,
>>>>>                    enum pcie_link_width *width);
>>>>> +void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
>>>>>   void pcie_print_link_status(struct pci_dev *dev);
>>>>>   int pcie_flr(struct pci_dev *dev);
>>>>>   int __pci_reset_function_locked(struct pci_dev *dev);
>>>>
