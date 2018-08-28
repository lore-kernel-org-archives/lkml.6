Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC66C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736882087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Vp58h9yS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736882087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeH1SY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:24:59 -0400
Received: from mail-eopbgr680065.outbound.protection.outlook.com ([40.107.68.65]:1863
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727284AbeH1SY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+fpTV+C2fmSLVdyJKwu+YMVVYeboV/pvsNIstAiqNY=;
 b=Vp58h9ySp8XUSFM9qFsX24/ETWOodGYGuexKE5Hn9eUAXOJnN7bczmFE4bZch8eYF8cnQMzyahGlzy4bySjjooPxP6p/LA2rMZoeUDUSUgoINzpatwlkh00MDjszAG0WNEr/OGzn/QMrKshh5PYiE3rr1Liqky8ln/t0Z0GbMF8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from [10.167.103.249] (111.93.218.67) by
 DM6PR07MB4923.namprd07.prod.outlook.com (2603:10b6:5:2b::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Tue, 28 Aug 2018 14:32:54 +0000
Subject: Re: [PATCH 1/2] ipmi_ssif: Unregister i2c device only if created by
 ssif
To:     minyard@acm.org, George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org
References: <1535109010-5074-1-git-send-email-george.cherian@cavium.com>
 <c25ed354-5971-389a-0439-369171b5aabc@acm.org>
 <0661f015-754e-a419-bbe0-8d1c4de57ad6@caviumnetworks.com>
 <f6bd95db-0ca7-ccfa-3ef6-7e3a7a51031d@acm.org>
From:   George Cherian <gcherian@caviumnetworks.com>
Message-ID: <bfd99f3e-68db-d5bc-678b-b998ac447e72@caviumnetworks.com>
Date:   Tue, 28 Aug 2018 20:02:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f6bd95db-0ca7-ccfa-3ef6-7e3a7a51031d@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: MWHPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:301:39::42) To DM6PR07MB4923.namprd07.prod.outlook.com
 (2603:10b6:5:2b::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7da1d5f8-d54f-4f3d-4369-08d60cf325b6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4923;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4923;3:LblhrBS+C8eD2pXkVB7W9KeNv7tGVoUpB21ELsK3DSmZF1wv8hkZ/lYf+OPLQhtkrwVcf/yBOxksuXoYzamQH9HXFPzUIsd1jOP/TwuxD9Rns7SUxdb0Uy5gT/wMjFmGASp352oVyXBLbqdigwrrhWEqvqJX+AsXIgmNpF+6U61IEvpHSG+Y6zSWMoTezPTHjQD5kRkUFzm49iG9li0SRRvGrHmrgXrzTze8t3VCImt1u52BJZYw5vweWofrVldO;25:rSMILcf0zhGLr66yI7MiSjt/VSnRBDYXXZFrAeIdsUs9bSkKgpZLDJAQl/znRXHPZD/NWHi18YhQEejm6QQZ8vBV2O82gX4r9L+elyZiZSIM8Id8zP1vPx9K8UGwRj/7Oow5VDmzg0vO4n7PjrlD4aiwbNieCDO8v8ZG9hlHDe1T8U9Y1B8igAQEH2vue/Ro1SFT3RTaxT/EdoueiVVYGWTfhumHLIBaL0adqwl19Z4+XCwD8+K5F6JGZWOvGhFYjujKNuqOwgF24HglTOvD72nbrsGykXdsx7DxJRuv6euLAR7+MktjAbe/m6dK4U9oSMs/Lz7oMkny3p2nGN8XQQ==;31:wA0AtOS1HXA9g4PQpITW+u9eTTYKrD6puD4uYX2yq5iLLr7kmlcKVvS7qjyzhI59e7rVuQ2d3pJgTXbszSJfCprlksHcv5T+GCIPFbK3GRLsaekYhobOOorZkgvR2B9LxvxEp3l1LPbBIKnjAni894T/VM6ijMnJEXZawHryBWkDR//B1hQ0AiU7jOTqHgeM0bS9RBKmwIhNGf2r82CLDQbPcenr/VjSyZMnsCO5QyE=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4923:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4923;20:td7GO5U1TQNyks0d/Bu74CBNFIgjUQRHtyZO7GtViPTE35SKkfyrMfhAO4PlDzZlxXtBsCEYFSkrUSceoJ4S2E9mkrf9qZCCUntvD/v+cTIzFhecmleYv9WQ0IlSh+FagvzMhpkew8FcM/SCS7Tk0+yNCmnCucqlKlXqXSyUNm9+rBYK8CoEwohHceE02Z/scoXnUDkf4ackT3BYBJRZP8KQx88B3kNO6ot/6Fg+AsnMQcH8gF3a4lC2nHSj9P64cTOSJebY7GQR+3/Mwk4J/ruw1I++njgaUlbSqARBvWNNuJ2RM8imo2k7mD1nfVM3kwOSsnsDD11ZxPGpAiT4M10iDGr9lsS4ts20SKvDwQfbB+FFV9A5kdeAT70gbAXGET6R4L13zM6ASUGNrkQbt8pajuNwSHZoyx037FNS5ITbdPbCsaWywB3nkT+Ci9F9LCbCjLWoephZTFUXZaVmlGbhMO0ivm1VX14cH4gVwn44F/2x+gTf5TFl3ZInbOH8eznyAclTCwzNcXLsN1r+T2GmCyLfCSKkxc55eVxrVtNiAnROfjk3IUoLBIhTbUy+g+74Wc/+HF+4zwSb+z7DSvmLdlhbxOJTZrmhJTt1B9M=;4:2r82fD8OljbVHzu6Ey3dDLT2063I2l5Dgnu1wcVDZaVaUxKDg6CenvmAD0QVTuu82qRBrerizl8Tw0yE2TPwMaxIxcf8nU5DFIHRZmf8X4WXyjINa6HIK9Bwfz79HEXKXvr77raaU9IpaKvX1SPMG9HP6ylhNUTSC7vDH89GwMQx27CC1no/uvhNAnnwOJz1HVU0mFyqeSsKd5tgw/PSBggiOW9X871OvCFszGoqmcbPJx3rwkVX9611cdKTeViuSQLQaH+sbdOuf4Iv9rKa7Q==
X-Microsoft-Antispam-PRVS: <DM6PR07MB4923EFC2EB9D6DC3C4F2906AF90A0@DM6PR07MB4923.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:DM6PR07MB4923;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4923;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(51444003)(16576012)(77096007)(386003)(8936002)(68736007)(72206003)(478600001)(58126008)(42882007)(31696002)(81156014)(2906002)(81166006)(50466002)(64126003)(53936002)(186003)(2486003)(7736002)(575784001)(2870700001)(6116002)(23676004)(36756003)(4326008)(446003)(11346002)(956004)(67846002)(52146003)(53546011)(316002)(8676002)(3846002)(52116002)(26005)(6246003)(14444005)(25786009)(2616005)(476003)(486006)(105586002)(5660300001)(5009440100003)(31686004)(47776003)(97736004)(6486002)(76176011)(6666003)(65956001)(65806001)(93886005)(16526019)(305945005)(65826007)(229853002)(106356001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4923;H:[10.167.103.249];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjA3TUI0OTIzOzIzOnB0NnNFYjg2VzFqYURwOXRxcXVmcXMyL01Z?=
 =?utf-8?B?VlBhU3pNcG5IM2JiYTZPbmxTQXlSMGpOTXAwMU5xRGh0KzNOcS9RNVNJRStX?=
 =?utf-8?B?ZlRvOHVKMjdiN3c5NzF6a09GN1hxZzR5YURwYno0MVIvZWROK0h5OG5jRG5E?=
 =?utf-8?B?TnFXR2hza05CSEhGcGhXWGRHWW1RTlVGb295cjFwL3NxYmJIYXRCL21qdmNL?=
 =?utf-8?B?azJoV2EvSUlmMEpEVWVlWWJRa3FobEp2ZUwxOEFMb05aT3FKQUlrU1RWdjFB?=
 =?utf-8?B?aUR0SUZOczBiUm9CZnp1RHdGcjhBR0F1eks4cFZoa21yZXdFeXFlaG16eDF3?=
 =?utf-8?B?UVdHYkNkREgySHpjcEk0K2RpTmhiZ0tsdUZ5VXVTTlg4aktMdUJObkFaZFZz?=
 =?utf-8?B?UDgzZ2xlUG1vNGZXU3E4eXcya1Z0MTNrcHk5NFRpVnkxNVNUOEVuWDZYUU9Q?=
 =?utf-8?B?UmhjUFFCZlZiV1N3eVBHalZJci9VUDNVRnFDWGQzdG5tSGU1eVoxQ3M0cHlO?=
 =?utf-8?B?NlMrZlY3RXF3ZTNhdlJFcC9BcG1JcUpPaUVSN25zcEtUbE1OOXJmaitHcEt5?=
 =?utf-8?B?ekI2Ym1yNDR5ZTM4ZWE0ZWZXVFFKcjlVVDZUb05OUHBYYzRDbzRtSmlxaFMv?=
 =?utf-8?B?bUhueVZva2JBRFlLbWZ0QlkvdzZWOWV6MHRoMUVNQmxHUWtEZVVpOFhJbVB6?=
 =?utf-8?B?QTkvaWdWWkJsNUlFMGVscStGVkNRZVhOMGFDV1d1UWRuMjRtOGo3b2xrL1BK?=
 =?utf-8?B?T2tWWUVWTmh4dWQweFpkWTc0UzJIM2N3eDArK0l1MitKSzBhb0NaeThuR2dT?=
 =?utf-8?B?UTMzcGI2bDZsMXE0MTJ3RmlTOFlEVSsyWExPVjhnZG1mamQzWEFGb2xnNk8y?=
 =?utf-8?B?dldrNUhQV1ZDVmhodlpJcHQyZHlCWkNjdGRzeldWMVJlMGlwaG16cnppV2Ev?=
 =?utf-8?B?bjYzZFNoenhSMDZabmxpbmw4UDhWenZaeHJlUzdTV2YvZGlsM3BzVWdFOEZQ?=
 =?utf-8?B?Q05xMWJSNmVtdjZ4OEtNdnU5MG9VcWdkZHNLRXg2RjNCK2FZQWo2ZEx6T0w3?=
 =?utf-8?B?cjFhbW9aU3YzRlZsa0FWalVNd2o3dXkxamo5cUZOSEJiYk9SbHluN0p2MUJq?=
 =?utf-8?B?eDYwRUdjbS93bWkweXhJbHdBblIrRzNqQlZYMUxFN2NPVWFqV09oWm56NEN6?=
 =?utf-8?B?QVEzVUJpcThZdXNpVDdwRDNsbU9zTjg5akZ0ZWVIQnhJNWR2azdUeWlydG9T?=
 =?utf-8?B?WHZwUUQ0MXJOQjN0RnZnVDhCVjFwa2F0b2xIM3lUNnFKcGx2SEVsRS9SSDNs?=
 =?utf-8?B?R2JtQVQ3Ym9YcjNoeHRVSDFtV2xJR0krRlJIc0VOczJpbzVJalhyeDV4Qk83?=
 =?utf-8?B?REM1T3FMNjR6c2tTRkQ5SGZmcDJqVkhBTjBKUXNLME5BU3JOcUxDdmtKaFJ0?=
 =?utf-8?B?K0M3Q0JxVzNsN1FKNVBLM2czd1c5UWlxTEF6SWV1aE5Xb1kvZ2N1aWV3RDhj?=
 =?utf-8?B?TEhZaHRyOFl5WUpoZ0cvVjVsZHpCclVHV3IvRmp1ODhVQzc2UytFdi8waFRx?=
 =?utf-8?B?RUZPMGlXUk9WUDgxSXp4Z3FNT1F2eVhlWWFlY2cwNVdGR29ldkxpZVVJaThF?=
 =?utf-8?B?M0ZrTkxuTlR5STN6VHh1ZWc5b0pEU0NBVmk2OWhyQmRuL285N3J0NVROL3Fi?=
 =?utf-8?B?QUhrRDRGNlRXcnNnbkFXOHlneWJVS0tFSkdoaENyam5tNit4RHBPTkZHZnVn?=
 =?utf-8?B?cGxIZ0dvMEJBYnNhNS9CMGZRVjMraUdPWUgyWXhEdmJZWWF2QkNvSWdtelYr?=
 =?utf-8?B?cEtTK1dmUFZPdnV0T1MzMWQvUlFuM2VOZ292N1BmODh2c3h2ekd2ZnNsekRH?=
 =?utf-8?B?S0duQWRyVVZkNGs5UVVQTUJVTEhnT1hJL0F5YmFKRE9kUysxMExJUkw0VStG?=
 =?utf-8?B?eVE2TktUQTJGaXJFTTgxRHd3dDBHL1RNN1JvbGJLb2c5WHprMk4rSTcvR1Bv?=
 =?utf-8?B?UHd5elVJL3lsdlFwaXMzZ3V2V0xNdHROSi9waE5adHozNkpCYWx0eHIrTXp6?=
 =?utf-8?B?eENCc1RpQ2dWdUJNazJYOXc3c1NMYWhGN0lBRGxIclIzajFienI2dG5XdGVF?=
 =?utf-8?B?aHc9PQ==?=
X-Microsoft-Antispam-Message-Info: P7YO6UfyH9oTEcIIysECLYFvNUTIGZA0NUOq+LCTMRhc2tIXSjL8jx/YTsKLGf0xWm88wu1bUWXHVQLiySs6WwTlMGm+GkCd2oMr3IT8DraRcPbBeYd+ipKYNkTlfWCzCla0fvvfcHyWCGZNPe25eEmERVgAUTfIEPMGslK1JR3iCSZjj9uSpg9jFvMRD3LCHijK2eNLh/ewcoxeLZz7DjpVLE8ADbnaMhggTRS500gvCVr/5w1tv2J4k6gRGnccDXv8I3d5Xdfc+lYsGdQIqm0BZMt99Ua5UfFKd7KEFcMlOTuYItE8U/4Bps0dqivnftPYNMCgOo555kJrDumbMQ6aQHRJEGQLo6E9UhUAIx4=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4923;6:YqSc9j23K2Ldmme3TfiFP2Vhp0mAJj0hHUmkc3k4P0TlKnyIz1jPgKNFyS86iI1ZZC7oq88HNZqQjT0OZE/NpleZhQ9BT2HN7NNIzaFXi4MDsR2H3XkM9h+qpJLijAwYdL58cjBymczbqe4udcv5nnQbvkewO4UgNa0z1IFnpp2gJQGwDYgSES+u4Wz8JgRj2ZCercQ/B+03EF2N5qy6yzOCD0KBQftA8/hmnEkJ6vp7xU7G3px9tPixL33FJgeIRH0LqVAzRZucx17WcaEaOyGXl6jyohLKMwp/p8+ByM4bAVmQur1QeOicj/sizgHsprjrns034kZhtVeDVkFMotFWaBtnol0RjAzjA+F36nMSEXcAQuGHcbNTTtkE4SAOHqMpd0QDVOrzICFPAogsrXI+UDG7Tsph0qmaTVXJN1JWVQMukokBktpEYEro9fLyS6mGuKMQvP9JPwoItPX+0Q==;5:sdvQNRL8WOk29uLRLiVbLgzAUv3qqlgB9I1dVTngToiHSGjpd1eX5vUidwhqcjZSBpWaus70GJYJybvN0Wxp4swVqdEJjQW+qTrSOBH9WRePj+b1zo7KSD2wDDnELeaIYP2E5WLczODY+LD0AvdWHmKhKY/PV0d7f1p1pYg1h/Y=;7:R6sCTCxu/rEvBvK06W66DGcx/ysCiQ3/j9tQzN3xzGUGODElSxIjxklERFNPO4b4xfDiqVTB92ikw4tl6TkI1ViNojT5LY4X+5EtbqBABAtcHp/8GdE6eYqol1dzn/Jv03aX/WHIuMfbnTeZzV2FqhxRsNk3eMjrWrFTM6lqqrwgaxtk/Qe6g6M99W2532C6a4KZi/90YqbJrZCBTfzoWuvkl7a42MTgSzuAS53dFPdbwokQa+/I4Avlhs76ovvV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 14:32:54.8010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da1d5f8-d54f-4f3d-4369-08d60cf325b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4923
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Corey,

On 08/28/2018 04:59 AM, Corey Minyard wrote:
> 
> On 08/27/2018 01:07 AM, George Cherian wrote:
>>
>> Hi Corey,
>>
>> On 08/24/2018 06:37 PM, Corey Minyard wrote:
>>>
>>> On 08/24/2018 06:10 AM, George Cherian wrote:
>>>> In ssif_probe error path the i2c client is left hanging, so that
>>>> ssif_platform_remove will remove the client. But it is quite
>>>> possible that ssif would never call an i2c_new_device.
>>>> This condition would lead to kernel crash as below.
>>>> To fix this leave only the client ssif registered hanging in error
>>>> path. All other non-registered clients are set to NULL.
>>>
>>> I'm having a hard time seeing how this could happen.
>>>
>>> The i2c_new_device() call is only done in the case of dmi_ipmi_probe
>>> (called from
>>> ssif_platform_probe) or a hard-coded entry.  How does
>>> ssif_platform_remove get
>>> called on a device that was not registered with ssif_platform_probe?
>>>
>>
>> Initially I also had the same doubt but then,
>> ssif_adapter_hanlder is called for each i2c_dev only after initialized
>> is true. So we end up not calling i2c_new_device for devices probed
>> during the module_init time.
>>
> 
> I spent some time looking at this, and I don't think that's what is
> happening.
> 
> I think that i2c_del_driver() in cleanup_ipmi_ssif() is causing
> i2c_unregister_device() to be called on all the devices, and
> platform_driver_unregister() causes it to be called on the
> devices that came in through the platform method.  It's
> a double-free.
> 
> Try reversing the order of i2c_del_driver() and 
> platform_driver_unregister()
> in cleanup_ipmi_ssif() to test this.
> 
Reversing the call order didn't help, I am still getting the trace.

You are partly correct on the double free scenario. I dont see double 
free in normal operation. I see a double free only in probe failure case.


I have added prints in i2c_unregister_device() to print the client.
pr_err("client = %px\n", client);

In normal case, I get 2 calls to i2c_unregister_device()
Call 1: i2c-core:  client = ffff800ada315400 => called from 
i2c_del_driver()
This in turn calls ssif_remove, where we set addr_info->client to NULL.

Call 2: i2c-core:  client = 0000000000000000 => called from 
ssif_platform_remove()
This is fine since i2c_unregister_device is NULL aware.
This works fine without crashing .

Now in the probe failing case, I get 2 calls to i2c_unregister_device()
Call 1: i2c-core:  client = ffff800ad9897400 => called from 
i2c_del_driver()
This never calls ssif_remove, since the probe failed.

Call 2: i2c-core:  client = ffff800ad9897400 => called from 
ssif_platform_remove()
This is a case of double free.

Do you think the proposed patch itself is the solution or
Is it that we should really leave addr_info->client hanging in probe
error path at all?

NB: For easy simulation of the ssif_probe failing case I just replaced
the

ssif_info->thread = kthread_run(....) with

ssif_info->thread = ERR_PTR(-4); so that the probe takes the goto out path.

-George
> -corey
> 
>> ssif_platform_remove() get called during removal of ipmi_ssif.
>> In case during ssif_probe() if there is a failure before
>> ipmi_smi_register then we leave the addr_info->client hanging.
>>
>> In case of normal functioning without error, we set addr_info->client
>> to NULL after ipmi_unregiter_smi in ssif_remove.
>>
>>> Small style comment inline...
>> I will make the changess and sent out a v2!!
>>
>> Thanks,
>> -George
>>>
>>>>   CPU: 107 PID: 30266 Comm: rmmod Not tainted 4.18.0+ #80
>>>>   Hardware name: Cavium Inc. Saber/Saber, BIOS Cavium reference
>>>> firmware version 7.0 08/04/2018
>>>>   pstate: 60400009 (nZCv daif +PAN -UAO)
>>>>   pc : kernfs_find_ns+0x28/0x120
>>>>   lr : kernfs_find_and_get_ns+0x40/0x60
>>>>   sp : ffff00002310fb50
>>>>   x29: ffff00002310fb50 x28: ffff800a8240f800
>>>>   x27: 0000000000000000 x26: 0000000000000000
>>>>   x25: 0000000056000000 x24: ffff000009073000
>>>>   x23: ffff000008998b38 x22: 0000000000000000
>>>>   x21: ffff800ed86de820 x20: 0000000000000000
>>>>   x19: ffff00000913a1d8 x18: 0000000000000000
>>>>   x17: 0000000000000000 x16: 0000000000000000
>>>>   x15: 0000000000000000 x14: 5300737265766972
>>>>   x13: 643d4d4554535953 x12: 0000000000000030
>>>>   x11: 0000000000000030 x10: 0101010101010101
>>>>   x9 : ffff800ea06cc3f9 x8 : 0000000000000000
>>>>   x7 : 0000000000000141 x6 : ffff000009073000
>>>>   x5 : ffff800adb706b00 x4 : 0000000000000000
>>>>   x3 : 00000000ffffffff x2 : 0000000000000000
>>>>   x1 : ffff000008998b38 x0 : ffff000008356760
>>>>   Process rmmod (pid: 30266, stack limit = 0x00000000e218418d)
>>>>   Call trace:
>>>>    kernfs_find_ns+0x28/0x120
>>>>    kernfs_find_and_get_ns+0x40/0x60
>>>>    sysfs_unmerge_group+0x2c/0x6c
>>>>    dpm_sysfs_remove+0x34/0x70
>>>>    device_del+0x58/0x30c
>>>>    device_unregister+0x30/0x7c
>>>>    i2c_unregister_device+0x84/0x90 [i2c_core]
>>>>    ssif_platform_remove+0x38/0x98 [ipmi_ssif]
>>>>    platform_drv_remove+0x2c/0x6c
>>>>    device_release_driver_internal+0x168/0x1f8
>>>>    driver_detach+0x50/0xbc
>>>>    bus_remove_driver+0x74/0xe8
>>>>    driver_unregister+0x34/0x5c
>>>>    platform_driver_unregister+0x20/0x2c
>>>>    cleanup_ipmi_ssif+0x50/0xd82c [ipmi_ssif]
>>>>    __arm64_sys_delete_module+0x1b4/0x220
>>>>    el0_svc_handler+0x104/0x160
>>>>    el0_svc+0x8/0xc
>>>>   Code: aa1e03e0 aa0203f6 aa0103f7 d503201f (7940e280)
>>>>   ---[ end trace 09f0e34cce8e2d8c ]---
>>>>   Kernel panic - not syncing: Fatal exception
>>>>   SMP: stopping secondary CPUs
>>>>   Kernel Offset: disabled
>>>>   CPU features: 0x23800c38
>>>>
>>>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>>>> ---
>>>>   drivers/char/ipmi/ipmi_ssif.c | 8 +++++++-
>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/char/ipmi/ipmi_ssif.c
>>>> b/drivers/char/ipmi/ipmi_ssif.c
>>>> index 18e4650..ccdf6b1 100644
>>>> --- a/drivers/char/ipmi/ipmi_ssif.c
>>>> +++ b/drivers/char/ipmi/ipmi_ssif.c
>>>> @@ -181,6 +181,7 @@ struct ssif_addr_info {
>>>>       struct device *dev;
>>>>       struct i2c_client *client;
>>>>
>>>> +     bool client_registered;
>>>>       struct mutex clients_mutex;
>>>>       struct list_head clients;
>>>>
>>>> @@ -1658,6 +1659,8 @@ static int ssif_probe(struct i2c_client
>>>> *client, const struct i2c_device_id *id)
>>>>                * the client like it should.
>>>>                */
>>>>               dev_err(&client->dev, "Unable to start IPMI SSIF:
>>>> %d\n", rv);
>>>> +             if (!addr_info->client_registered)
>>>> +                     addr_info->client = NULL;
>>>>               kfree(ssif_info);
>>>>       }
>>>>       kfree(resp);
>>>> @@ -1672,11 +1675,14 @@ static int ssif_probe(struct i2c_client
>>>> *client, const struct i2c_device_id *id)
>>>>   static int ssif_adapter_handler(struct device *adev, void *opaque)
>>>>   {
>>>>       struct ssif_addr_info *addr_info = opaque;
>>>> +     struct i2c_client *client;
>>>>
>>>>       if (adev->type != &i2c_adapter_type)
>>>>               return 0;
>>>>
>>>> -     i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
>>>> +     client = i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
>>>> +     if (client)
>>>> +             addr_info->client_registered = true;
>>>>
>>>
>>> How about..
>>>     if (i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo))
>>>         addr_info->client_registered = true;
>>>
>>> No need for the client variable.
>>>
>>> -corey
>>>
>>>>       if (!addr_info->adapter_name)
>>>>               return 1; /* Only try the first I2C adapter by
>>>> default. */
>>>
>>>
> 
