Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758C520685
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lUEqtNeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758C520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeHUT2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:28:30 -0400
Received: from mail-dm3nam03on0078.outbound.protection.outlook.com ([104.47.41.78]:40368
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727463AbeHUT2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVVUZETjaFQtN1DPAcYrBcPI3sHQaesBrHrBwtk/3sY=;
 b=lUEqtNeA0obdqQwCgWv+eE8Aq3OOlkitpJpYe4OAa61oWYT8A/DqD8t9Lzou9eUGSvbQbbQTqk20/NT7XH820g0Uv7V6fNSOI4dYiFTnX1FrQB2fKfxotzinShHVUTE0yB8jOG+JtKhAXPKCpxl1HJ1Ch1GBSZpMiSKyyK+/6nM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:6f::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Tue, 21 Aug 2018 16:07:41 +0000
Cc:     brijesh.singh@amd.com, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: SEV guest regression in 4.18
To:     Borislav Petkov <bp@suse.de>
References: <20ad6cd5-394c-d3ae-d99c-b656d7ef8293@amd.com>
 <20180821083911.GF24940@nazgul.tnic>
 <3d46f44c-dd78-8fa9-02ac-8206676ffde9@amd.com>
 <20180821151938.GA31212@nazgul.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <92e2b80c-0dcc-94be-8d3a-5e11e5cf2370@amd.com>
Date:   Tue, 21 Aug 2018 11:07:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821151938.GA31212@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0401CA0017.namprd04.prod.outlook.com
 (2603:10b6:803:21::27) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:6f::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95d4585a-45cc-4163-27ff-08d60780397b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2685;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2685;3:Rw1IwSm9b7cSZzq5rDF/7jDxjHnHX+SHrYW7Tbt1m6Nf8AaBRnEmEZIpc3MyGXnX6z44+hI4UHSvEO1cqLR0hrOItRAM0eZWdtKQTmsr2ZwGe8jDwhGvPkI9XEC9EB+Wl436BuKKPGzDYgZ4IieoO88y3jfGDYiACDWujHWBPBKoPhdmASQWwB4kwdOxet+pD3vuw2L2dNswmWKRNKNRJgWlwb96Lgpsy3uKO3SnMcJFTEu6i3np3uu0jag/HNM4;25:WoWhpTCdeb6QfhWPuNXTDRAzZdlE2Huhc03y60N+rIT0aRemnl3MiX9NOKW7SjbQgyVkB73LqDNif900KC27OOIG6t6/jzOM9FxJ6kr7Pg5EjGHMFRpjNZjRYSlfuSzS+FX+klAoLarhbH4UnX/0O4avr6Cf0ULckU7yAyii22UHMQ74F+ApcGva47qDQ4BqqcyjUAGrIEPqDWVNPkzBLkzpZWBwL/ms8vvI+8D04iLlUIcK+wqbeeUJQ+FWqRsk0sa8OEsSBIqeJjhu7RoNoPXkxIYPD2ih6IgEcyZPQDtkgSXIzE0f8yDz2dOIBurTxzm59VLw4U00zEdS/sVuOQ==;31:bpXDDENK2SPcJxLszQVFWJmFOv5QtuHA+KTqDMyqQEwVUTAWo1tBaa8kA6JaArKcjQVM1KrRytpKFr5f5mI1FQHCw+Mg6eLO53GJqZ8FXON7kLFigz5lgpOJn118l8/CLHz/+2e70EcC3BMIPYTBrViWyiM+neYGUqbp5LGaFM9iiZYkgK1VNSERRjZXDXNZ7zqj0D5D3qWEq5Gk3jspb9YjGtlK7Uxq/p2QWhTgAsc=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2685:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2685;20:RSOrj4hkd6t4fprj7nINTk4v9EjpvDQX0mY6+9wQz21C7K5O5hLBY1fqmXOJ2t8zJaieiItu3b5bK7WXOzFrYEx1317sH78y/l1zKHpBOGeLDt52xpCU0trbFu/wDGUrxcEfrZdKCDwoBwIpH5CbCOfpdeeG9pACaA9TYZLHWWA+zFuxIl2n9OOa7pg43ztgiCXratnm9ZQ526lOhcYjAk1qyUCE7vHwUcuBYn5Y+yjlwVmEiUgD1+w+9LQAX3F0vKyE8udK6G0L2qj8oVnOOEPJer2rpgEVDBiEUSsnGoCGtAb8j6+RURU6JwKotGJVDPM71MjBv2BE+hkda0tgQL0QZCq0RZAePfQg+0igMTAhFx4zTdVSE/ylmwrCQbx4PuKO3zuDXaA8mvIv0V3Nripm2quPE2j2fcjrZj1eTrgh15aabEPuK/la3GCWKHnkyIEjlyZjP3YLRcP+sQNnqfei1tDcd32ZTISplMjP6QaRAGy8lHHdXR6TUwcgjMUF;4:sKywB8DMBbee8HC0IOZyviFYcYK4txAPSTqG0azSCovk0EUo7ytWqnns1Ofcr0LgGnWQxuGse+Y73/uat1K3WxC4p88cHLXnS8OCA/CzE/UCKRDzB6hV9Y/pXs44Ehpm9mRcZVdOPtQWhH5UstyxqDINlfZ6j/TLe/OpN2WD6zQz2qh06Es64tdUZUau3CVHT4j/5XnAZkNtEw/ZV4RW8wpwDz7ULaAfcd77JVZGCp9raknK9xz5SVPg/SVdWNW/glcTsvLYdicFebnZPctn0Q==
X-Microsoft-Antispam-PRVS: <SN6PR12MB2685E7DBBED1474E79E68938E5310@SN6PR12MB2685.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:SN6PR12MB2685;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2685;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(11346002)(81166006)(97736004)(2616005)(476003)(44832011)(2906002)(93886005)(16576012)(36756003)(53546011)(956004)(54906003)(66066001)(65806001)(65956001)(58126008)(47776003)(486006)(14444005)(76176011)(316002)(7736002)(446003)(81156014)(8676002)(230700001)(53936002)(6666003)(50466002)(31696002)(305945005)(6486002)(6916009)(77096007)(86362001)(65826007)(229853002)(6246003)(31686004)(8936002)(5660300001)(3846002)(186003)(16526019)(386003)(52116002)(2486003)(26005)(106356001)(52146003)(68736007)(105586002)(25786009)(23676004)(64126003)(67846002)(6116002)(4326008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2685;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg1OzIzOmJwUTU0aWtUQ3o0Y0NOajRnZDQ5QTNQTVN3?=
 =?utf-8?B?RlVwNmtwY3hFekNaOUNZRlJZZ0ZyYzdvL2tocTBqN0VoTG93NjY0MjcyNVZv?=
 =?utf-8?B?bmFlNUNOV3hWVlh5eHY4S0d0aXhTOUFKWTJTY3pJRFdqb0laN0NQU0htOGFQ?=
 =?utf-8?B?UnBCNzFrUW1QTEUwSzJ5OFhDSkRLZytuaVNmS0tjOFdBMVFaazVOMzZhelMy?=
 =?utf-8?B?ZXdWZ1hreVhPaWRabEZkbTZlcDZQOGRMVjFNdVFGR3JQbmc3a1MwRGxpTDU1?=
 =?utf-8?B?aUplMjJ6aXN2SU9XSDZ2aXJiaUFsWlBJVmpyeTVZeExnbkRoK1lNUENzZ0FY?=
 =?utf-8?B?bkJoUUVaQ2U3amVVVFZZQWozNHFFanVmLy83YmpZV3BMUStjdVFzQUo2SDJh?=
 =?utf-8?B?dzdtVmdZbGZndm1uWGx4U21kb0R5NWV4ZlUxUFhSaXZTUENWSHBMTEw4eXZy?=
 =?utf-8?B?SVFXVXRRMlhtU0JndXBXc2xVVnFsaEpPOWVhcW9EZWFHUzBYMFQrb0tQOFM4?=
 =?utf-8?B?dlVxYm0zeVdJUHQ3cUZQWEVCMHB1clZKV2Iwb2x2d2pOTUZ5bFlQeFJROVQ5?=
 =?utf-8?B?UE0ydHQySjJmc3NJZVFqSzVTSXJST0FPMG81SVo3V29rR2VpMkxYMVNKYjRk?=
 =?utf-8?B?VWViR2RrenlsUVlCQlZHVjRrbEtiU25CSTZUdjFEQ20xSUNqa1N4UzYvUk4z?=
 =?utf-8?B?c1NrTzNSKzA0Q3pZcGs4Q2Q0czlsUzNNc1VWVUZLSEFFVVRBaEt5TVJPejZr?=
 =?utf-8?B?MU5hSjYvNGNYc2ZoMzIvMTFyTWlnNndmVEVzRnNoMmp6aFVkQ1NhRG84MVdB?=
 =?utf-8?B?a1Q3c0NSQnM2Rk40T1JUSXo3MEx4bENDVHZmdW9zVTNGZnFzOThJd3NjUThN?=
 =?utf-8?B?Y3JnbkFBTFlMK20xaG5UY01zR2VxTUJjYlVXZVN5NGNDWTU3K1VXU3RyMmhJ?=
 =?utf-8?B?SGV0UTZDZWZwellmb1BFUFNLa2ZobDc1ai9DazAvbHVXUDFqUG1hMTRFcEoz?=
 =?utf-8?B?eFBHMmlDSXRiSEt6RUYyamgyR1lIZFZkUU0wbzBKdVFuMVd6WVdMY2cybUky?=
 =?utf-8?B?Zm4yaG9kWW9UUFMxc3JQdTNjRjRxbFYyL0Zsb054UXBCQU1vOW9FeFlTTGtF?=
 =?utf-8?B?aCtndEtMV0pvZlkxckdnMEpEREtGVVpYeUJPMGRkWkd5UThTdVp0K3FBNitK?=
 =?utf-8?B?YnN2dGJLRm5zWXkzT2R6MFpKVGpQYjFHektyVTgvTUhiNzFFTjc1V1Q4NldV?=
 =?utf-8?B?ZEEzWnpkRzBjVHBVeVJ5ckM2Tkp6VFNPVUFOYjNDbHBLTFUxWWhEUUpYbVZl?=
 =?utf-8?B?bHM4R09DRmxhK2FWWHd1bWplZjZhM1BlRHZQWVlBZ3piZ2ZSNzRRMHRTb1hn?=
 =?utf-8?B?VkEveE94UWVONXFSQ2FoRDBjK2lnbXlINHlrVldHaENTaVBpL0RyUmJGdUtW?=
 =?utf-8?B?M05lR2ZmSlYySG16UXBlL1pRcXB6MkFPODJFUU9YYUFKZGl4dStZaEJvMjZj?=
 =?utf-8?B?RjJVdkhvZ1VHUnN1U2FrdnFpL3FGOVMyUWFzNE5oUnF5MG02dTRsdmdpNm1P?=
 =?utf-8?B?UTBMdmV3ajEvSlZ6QWo3ZkYrQm9CZ2d3bkdiYU5rV09TN2U0RDRsUmtYUU50?=
 =?utf-8?B?N1FURTFwM0Z4ODUxbDBOQWpacGJ5K2kydmxFRlZPQ2orT1JOY2ZGQVJxRFgr?=
 =?utf-8?B?MVZ0Sk9CQTR3Q0VtKzhzYWUvdXpkMTVHcFFsTStVNWxGVE9NWk9UNjlnZk9U?=
 =?utf-8?B?bVBDWEd5V3NHRzNJZGdTUWJrc0QrTG9RcEZYNVV2ZGhUaEpTTUZFclJmYUpm?=
 =?utf-8?B?SG5ESWFpa1RadTBIUFZTSFJsSVZHbEIvcFdMRVJxOFNzUnM4Qlc5MnFTN1ZI?=
 =?utf-8?B?dENiaTdtaTVUM2VMbXQ0QVEzUCsxSVVqa3JSL2U3MkxwRDgwOXJKTW5UNW1a?=
 =?utf-8?B?N0dKbUxPeUQ1dm5rb3B3TnpRbGVMQ0ppakJqY2VvT1ZUc0NhNFlYODlSS3U3?=
 =?utf-8?B?TUEwQUJzc1lCUVdVZEk0czg0ZWtnaktmbldEUCswb3MzNHFFdlk4N0FYT3NC?=
 =?utf-8?Q?Oi1w=3D?=
X-Microsoft-Antispam-Message-Info: gJ59sSdOLhdkE641Mh7jCX/5HMhLhcW8uv+328dhKv/MfyoZUojgPkhuGgJrzYP4WB57r6GPJTwTLnWiA+2eTGGG/F/KazL0bu550EaibotH9Pz+6ZXy71YiGhC2SBf1o3VpcsKePlL4jNn1+uUo5SuDqN3zI8QLcuhmSiMAWBoDl5k/w4wCKOsUcqiZA7rZ1p3RAtVS3rqGLM4mSA5rv2WgWmOKcLS10IzTAyOMSfx65KACXr4ow5XohUMg9McIeGhGqEHtuI+/OIITpMSmtRWUoryqhgNUEVCGqyu02HFms5MlA3lyCSr9eOB6gjgWtJbAPHR1wP9pIjc/ytyJQzhpR70MVoBjoIZRw03ie58=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2685;6:UCRddRwtU3TxAmWNlCM+sVLERaqYSwwhJ/mLYax+lM7w7SB7MKAURF8i+bhPZerSEUNxWal29RrHuqGA0naiexhw3hJWLBpyEuvkurwbWRRIPNX5DdvsVYiUOg3UdX9rrL46FZsEvrTEKNIOBlndWOoQl/116aN2YO8j1uVLUBew6L1wj5vndkksMhZ+rVEViLn9RBTU9Bq2LZGTqzwMD6xSHCjnanfZhMyEnIdl5akRjLr76O+GOpPza67oLrwoStlt7iOw8bUfGJKyXVmSVPi9m0N1jL3agePZZteMANZpMFOhsL5Op25RVEf742kio74UKC9y2qdYd7hf4ZB9B4pbHRq41b+rlGcAZltex6uU4gTsdSxfOIUyhHcyQrd4tQiMX53gMBui1bzjl2HySXyYzZqSGoUC4L0VmZnFcUR/02UD4P8c0tenH1skWzzTdGeBm5ZQ5P00lVboLk2CyA==;5:ddJEOrpnfOfsPFGJ/AVd3MRvPdAw3X0dgX1XcmxTrxQgGHgHctTJqxQzrYhymdvN24aBEDkHfCkerOpsfUA9ccFY6tkBJtNtdpMnJT3g4KtbZLk/xY0h51+zBUmlfY7y/wVGlZtLAEFXGsGsS9gY8Qg2OnKaNz/IryIuNoNqw7M=;7:lZYJJR7FvSY0Sy4W47ObDjrM6GN7gnT/QvDVeW1uUtDDd615aFLijW/bSnWNuqI25cQ/F5FNPE6llDrjLDpjPEXWhpqB8IdWo0DVFV/4zaeYk+99Gq1e6bKd7tZ05jDh+p1F8hpP/GouGgisVjyEPOcWXgEJXhuWf22gnCb5L44DxvG1Xv4a2ybcUdwcv8d7uc6Ac5r2T7+fLtgUrR8CeiCIPwqvxgC1QsWRM62uZT+WUuYqw2eN9/zyyXpqhRzK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2685;20:5FCLtaarUkaTB2p3zeI3GvcsVatYssws1cU3pXE0wUOzLD0QXmxpGdHWtA1VB1wmNV1qKtnerTSL167xdaNbP7O+97RMUTOMYweT/0JGxs7ikJqfocbgPoLXrtkMy7qraPO/iCP+Hkl2D2/DrriKEh/3Drvnp6yRxFMnq4cBAjmAZ2vzaaQsZ8WQUn7+TP3HNrifY9n7Scc1htRv7qzmI3qHRNRWzxSZZkPhTFi1o0epfbY5Sf4v250bzCQqr8tT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 16:07:41.8272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d4585a-45cc-4163-27ff-08d60780397b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/21/2018 10:19 AM, Borislav Petkov wrote:
> On Tue, Aug 21, 2018 at 09:37:56AM -0500, Brijesh Singh wrote:
>> Those variables are accessed immediately by the tsc calibration code
>> path hence we will not able to delay the allocation.
> 
> If you mean, check_tsc_sync_source/_target(), those are called pretty
> late, AFAICT.
> 
> And I see a setup_arch() -> init_mem_mapping -> ... ->
> kernel_physical_mapping_init() call which happens much earlier.
> 
> Again, AFAICT. You probably should try it though, to make sure.
> 

Here is a typical flow:

setup_arch()
   ....

   init_hypervisor_platform()
     kvmclock_init()
       kvm_register_clock("primary cpu clock")
         /* this shares the physical address of variable with HV.
          * Ideally you want C-bit to be cleared before we give
          * the address to HV because HV may start using the
          * variable as soon as we issue wrmsrl(MSR_KVM_SYSTEM_TIME).
          *
          * we may able to relax rules that variable should be mapped
          * with C=0 before making the wrmsrl(). Since HV will anyways
          * write the data with C=0. The important thing is when guest
          * tries to read it must map the address as C=0.
          */
        Later part of kvmclock_init provides a hooks for tsc calibration

   tsc_early_init()
      determine_cpu_tsc_frequencies()
        /* this will call tsc calibration hooks registered by the
         * kvmclock_init. The hooks basically reads those variables.
         * These variable must be mapped with C=0 otherwise we will
         * not be able to get the data written by the hypervisor.
         */

   ...
   ...
   ...
   ...

   trim_low_memory_range
   init_mem_mapping()

   ...

The tsc_early_init() is called before setup_arch() -> init_mem_mapping.

-Brijesh
