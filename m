Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8303ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576BC20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HAri5gdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576BC20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeINRNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:13:05 -0400
Received: from mail-dm3nam03on0058.outbound.protection.outlook.com ([104.47.41.58]:64322
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727838AbeINRNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j7W69A3SuzNx/XwGEfyvaxo7pgooIVt5g8tf9XPCcM=;
 b=HAri5gdW7v6lUHw3cq038B2Ul+x+B0DZIvIemJdqy4a7neaA+0NwkZfKS7+b0vQbbYBlPS4s/zpoH6ONbHnK+fdBPUIFzNCKQCvEtVX1P1i5Cs6Iaa11Z0mKqfnkCotlovvnncZsc4gHiEmbzA3/x7r5jacI4ZGwoUVE6h8L/HQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from Brijeshs-MacBook-Pro.local (165.204.77.1) by
 SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 14 Sep 2018 11:58:45 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v8 1/2] x86/mm: add .bss..decrypted section to hold shared
 variables
To:     Borislav Petkov <bp@suse.de>
References: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com>
 <1536875471-17391-2-git-send-email-brijesh.singh@amd.com>
 <20180914071056.GA4747@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <3517a0db-2f64-6d09-7100-dced40561d08@amd.com>
Date:   Fri, 14 Sep 2018 06:58:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914071056.GA4747@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0601CA0008.namprd06.prod.outlook.com
 (2603:10b6:803:2f::18) To SN6PR12MB2688.namprd12.prod.outlook.com
 (2603:10b6:805:6f::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eba98c26-93e7-46f3-9807-08d61a396dc8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2688;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;3:XE4AQh83RkVa+uUf447HHHNyzBJ3xnerIyZk17Q+SdRjhgBIx2g1MQ3MAuCzXQjAM2ji7hP5WvQ8ly7Jr/dXtyCaTyNM9PyDd0gSzryaX9QpEGK757jf6ZGAok/dR+KeHu1tjyuOpWDXSj+ZE+2xW84G+nG4aEtpKyLoPcQNPEWCCVxF7ToRShhGlwtMzg1sdhlOvLIL9wJKRHcnTMJQaAkdMCNp7IvV2IfW9ysOavmyVZeeCGYx/B/eUe3NstWv;25:V+ZE53/rD0/PwKcpvlm1Y2+82x4aNOhIFEn7s0YHJG5ATEfL4VFTSAE0wUBmwE2D0pWsIKdecrSNUmKAKYW4RCxG1aYbczPLOKi3m1GDQRFV+s86fZLsVx/PRLrWOwZEjvcM3Bc8VzkUJROIt+HQqlkC9EBcbbhQWTaC//sTlRN1l9z9LIpNx6r4zH3sSORlgBVFqoMw0PKAYZel9hX/LA1aGU980318Tvzob7UAHYTSLk2YQUapeTmxH+CeD2K2N0VdWVvFfDRZqFUrRnjlziJ86OIOinzwvlOutSLPVsqPKf1SxVYojNZ/sJXNLFdL+6Z5GiWR3xiGEIx7FHWzzA==;31:rYs+uZTkBre2kRv3Tq/Bo++KhmwSZxTFgpS3/Z/zlziLclASRw39PSXJURJU1OGBq7ZlIKDQ/oGBx+Vyeog9dLJN0+z6pNnGvOpmPuq5L6jqO1HAq2ln1rxmGJbUmxKneZUJtpZqF2N+TIn08Hqlxx2yN2QKFXIS0VUQqUn+6+5i4h8JZ8d3PX+QnsXhZEZIXp4jjE6jNzVG1K/zHqZwYDujzgAk1UtOUBeVUgwPLts=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;20:+6caQBUQi/hl2QYTRgmmySKyey4br37LFVG1AbhoMOMcmZqRdH2VC3pLgoVVoZzjMvzN7CcV+3fPdhnFEIP2GiG/bWuZ/Cye3pkLa7qYx2o+obxDnEMOpPCUc3jA5jKKCns43LL8kOyNjKeLfMNl4WF+b2SIoWSCBZRPDvUrDv0HLu4RRz+REtsCowe3B/ywx7OUKctvV0XMONzv8OsY47NqnDCUnrquWlJVz7Bqro7tYklNr3ommZW7qtoR3NKAD+mjlDYxq5SHXYRGbLQM6GeeoxajKGTwUV5mzO6Sj/kdtiLeaSFJAfLrSsus/8LK9U+bsWLJmG+Pg3ocHT8ijOujiomEYMqiZYhQMd6zvRLA3t6zft6DIyTbps5hjFyWAQOCOKs9cI6Ci7SITod5HNikDupmwPFGKhkjBf1zhffjgBO9LXFbhQsWlD3pYDBiYk0OMYKrlDCS+Nm1Z7bVATnti9b+tm8EzJqJ0Yve7Uj9035aYFQXPR/dbFXUzg4I;4:4qZ/qCzu3q9h89/Gqv7U4EaCQIw6lP9KXZmfcTgwA3PE4FG2chBMtR+m+7YQYbwvZhBMROc9CVq06IIDNPTXpDrpLMjTKX5sBd8y74SI8m9U42ULpEsrz9I5EwUVSzqvDMOPIPIrtZ1gEhCnkn9rTdh1wgGQOGsK/K2cp9fc7RRSNt4zo4DTkxi8TYAovJS2JHCd+No+wF686sXySJP/kgX2NbSFE1rBURS1bBAVxrBZdAOgsp+Bw+IdtE68u1PGwb21aWZjTpi31mdgOXo5Cg==
X-Microsoft-Antispam-PRVS: <SN6PR12MB268847521CEC037BC64DF7CCE5190@SN6PR12MB2688.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:SN6PR12MB2688;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2688;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(6246003)(229853002)(26005)(8936002)(316002)(81156014)(478600001)(53936002)(305945005)(52146003)(6486002)(76176011)(65806001)(23676004)(16526019)(14444005)(52116002)(36756003)(6116002)(2486003)(3846002)(65956001)(47776003)(6512007)(7736002)(66066001)(186003)(68736007)(5660300001)(2870700001)(476003)(58126008)(486006)(2906002)(53546011)(44832011)(31696002)(8676002)(6506007)(386003)(65826007)(25786009)(50466002)(2616005)(956004)(81166006)(6916009)(31686004)(4326008)(97736004)(446003)(105586002)(11346002)(64126003)(106356001)(6666003)(54906003)(86362001)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:Brijeshs-MacBook-Pro.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg4OzIzOlhOTDdneUZmc1NNVzJhbnBua2VRei9TMVht?=
 =?utf-8?B?ZEs5cllJV0lhaXM0K3dEcTJsN2k4ZHFxR0JaZDlnQUovd2ZyNDJFNnlGTDBC?=
 =?utf-8?B?ZTJzMUp5cENXZHQwL2ZCcnp4eURyL1lwT1drbGFMNW95TFRwbDRvemZhSUpK?=
 =?utf-8?B?RjE3WG1YN0wvZlF2VzQxZXZucTMvMUJFUjl2ano0TXFZbDQ4eFlmcUpuRW9v?=
 =?utf-8?B?MlZqRU9YN2hnblM4NlZ1Y3pzRmxLUGtBcUdpT21hdG4zd2ovelFMSjFOcWV3?=
 =?utf-8?B?TGVTY3FUNS8wblo5NXQ1T1ZibkpQZkVwRmVkN2l0OXNqNk9sKzdXem8vSlQ4?=
 =?utf-8?B?SlJrRGNKQlZSR0Z5dmlOVUVtTFFQQm5RQ01XSHFrNzBWYmFjRUR2Ylk4KzhG?=
 =?utf-8?B?Ym9xakpjZkhMWndtL25kUW16VDVlbjNlUlpvbzA5a0xTUnpHNHpnRXoyVVJD?=
 =?utf-8?B?R21sQkt6SmlLV1dZS0M2MUNQQmlGcFNoaVd4R2l1KzErZWlyK01HdkJUU0FJ?=
 =?utf-8?B?SjJXRkpPazFHN2h4dTVFaTRCSVRpb0xtSnNRREJMSmp5Mk13NCtEaitYK1pj?=
 =?utf-8?B?dnVUODdhOVlvZlNRbDBsdk9xV3gyamNrbVM3Ujdidy9GN2djL09CRTVweEVS?=
 =?utf-8?B?OEdTZjRNanlpV2Myb1l1WFpUWENuWFlvdkk0SGRZOURkbkUvZzFsRXhwVnNp?=
 =?utf-8?B?ZGdMSk9ZL0NSQTllN3RsWHY2a2E5QkpxRG9zWGhUeldoZjJtMEpnbHFwRGE1?=
 =?utf-8?B?S1NrZXRXVFcrUU9EbUxuSHdSMEZ1a3cyUDN5WEhLVk0wZ2dNeTMvajliM3Bx?=
 =?utf-8?B?b0dGdVlBTTJBc0J2QVB6R0l1K3dUK3ViZDdUVHhBVDFDVm5HdDNEWkl5cXJo?=
 =?utf-8?B?dldHQ09LOWJ1eFZEaGRYblhKTll0ZVF2ZHZyaE5BOUVXZG1kN2U1dnNkTnR5?=
 =?utf-8?B?cE1ITWd0anAraTVib2thOEdPTUZuY1QySnBmL2dRU25IUlVnM1RkTnE5dDVY?=
 =?utf-8?B?bCtVS1AzRS84TW5lbEVMbjZwMzZYYlE3OVN4VFU4VFprRVRIRG5NRHVyaElN?=
 =?utf-8?B?NmdPbnRuWlZubFJoY2dFVTB0enBMTFB3YUF3eEsyTkNvRWlPZWdySnc5T2Nr?=
 =?utf-8?B?QjQzbjF6MGlFUjRhTW1YTWhZbCt0amZ2UnhMWjdVU0p3L0tQWUluMWNzSWoy?=
 =?utf-8?B?TDRwdW55UkU1NFplN0VTZHprZldxampZSjkvZlZ2cEkxMDMyWXlUTmhqVmkx?=
 =?utf-8?B?OUpQcFFaZGJEcmhHN1lrZWtGUk9OWUt6bnVwNm0wcjN3R29Ba2Rac1NPb09p?=
 =?utf-8?B?UWFYUGgrUW9MYzhJOGZYTlZiVWQyc2c0Vi9FdFBETXJ6M3VtcHl1Tlo1cTZH?=
 =?utf-8?B?ejRLK2crUG53aFp4bVJsUFRUNlRYQlpuQWRTVFlJbDZSaDM1S2pKOHJRa3Rq?=
 =?utf-8?B?SG5OUGwzMnVDQ2xBajlLYXJQWk5sS2c5THZORVpYVVVLOUJIWG15bWpHTTZw?=
 =?utf-8?B?Mkx2SEFpdXJLYW9ZRStuZ1FteDJMUUdLUFFhbjZSb09pai9wSHRNOTVzdzRo?=
 =?utf-8?B?UkxmRjkxR283UkN5VlBhUUpGWGtKcndwc0x1bEo5MVVKYTArL2VNMHhrQ0Jh?=
 =?utf-8?B?b0ZseGo3WWl6S2I5a0p2MFJwWm0xUXkzOS8vSEVsYi9CUitIbThvckxoUlBv?=
 =?utf-8?B?aDdFZGhId1hXWkw5YUJwUjZHN25GUjQ2c09uWGRuSCszYkFZcjljSmNjZnpW?=
 =?utf-8?B?aVJqZmxiU0haOExlRmtxTTFZcStRbEloelpQWWNEaWNrdmZLM0ZLWW9MamlY?=
 =?utf-8?B?MEY0dGpDTXNWNHg2TWt5K0p1MjNoK0lCT1lTY3FKWStQdVI5TlJHSUJlcFdS?=
 =?utf-8?B?R0lYNnE0Zk1PT3ZrdnNHYldpMDBtNkdNRkVxS3Z1clVZYU9MRFhrK2xZREt5?=
 =?utf-8?B?VWlQVE91QkZrTk9VUUFFN09wbkJYZHFmSVN1eHRFQjNzVkljREVTeXF0T2tk?=
 =?utf-8?B?N1czYnIvMWplU1BVTUp0cnh2cTVoTmtYbldDdz09?=
X-Microsoft-Antispam-Message-Info: kc8kAfRS1wjju0yuqz/3Gis/8ZIC4Ar4LHT5ghBqpd3jwGsmUxIVFfUG11iURA+OW7RrrcopVbFm92f1Lsa0mgUJUDbnqzE7tqlKFBx9VsUtdNOEkThDiMqTsEvYgr2nP3FADLdmUmCTi7YJwdR6xWf9OAN4mXgZaJDPBH4i/ftEbYS7JVQizT6BpjFQWcielfarS7dZsPy6dQIrwBZtqzp1e3gAD7gLSCtdY4tanCZssRx0G6V6pmE9s6Qkt8j6+Yj6gfGsIrNNIxNEt+LUOuR/bXOX6UrjPRcyLOBzLpLumx66NLakU8DvYvfN3uNg6uwxWRidZx1rYOYtmxt9wdDRum1RKZ3ItBUj6Uqe++c=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;6:rn0ELMbfyOgxjEXaRrU8zxOff7nsh9wKVy5B2jr8WOslzukhm+O1jNykhgnkQAXlWrWXNzfXW1YmOCS/VHbYlFn18bmKx7AnEr4jWGdWImGQYgj2nzVBsf5jGJ58hjeule0RFLPQJGhWhYPxQEKe3U0vHm2EEP5atuJ0c6E7T48Hi+Uxk6cJHW+p9+4eG5ASLqmrbhgGYfJc00xPkMxAvfcIMYqqjuJ30le7i9Qz0h0CLHDLX9LPoEXeuC2H7KNDIcjtHhDiCAr6l8gbAxaDpYaJKWo52PPZhRvkguF/+joj+AK+bfRkxUtw95Uc6SJLZVXvJxHcoPFWck7ktsJTtOay8Tg5nNo3/tqpkk5MkZ95Dm9AtORJh4/OQ1XuF4WHZz9gXsrFvZ2WbBcYYQDG5m2glg9WpvIHAQ9MxifASrNOGo+C+5dcMEEmiCachzOuJ9c3/uxSWa11YPAROaniww==;5:GpLToi17Q/cseJqYsZAF12BNDz5Y7VxZVO1qvDOZ7UVfHnipr/SSDy2kl0pTTOy+QCK3Uvg2cecEUGCt4Inbfp/6uBi0NFMeggOcG2DhtkmVLKqIZaR+/35a0SuD52WK6FvbJYk4lXYaXTERFEjrEwfMZBJqbsFy+9oaTyZaPQ0=;7:VVVrmx3OUtHE8xHayYUJ9HJZDyuPKmdcfXOpJJnkalmtfqWFQzMItOUl1FXQafCe4+KAASCBj/5fmbPJns8EqT0OfvKYMA6iE3kiOicqWBIlqdAlGrDx56HzJDDvB/3HYZ7HEXLA4UpXTMtfe0Czfm2kIm5iXS7oPDCh992ATZnHQdqEY+NCmoVcYZGS2xA64Kcenfv8BR5IUir7iWpORONWUXKyyO6bTyT72pyv4lpiww5DD9DKM/YwuA5zl64B
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;20:JmdS98DJcrhuq6OkOY/5UeejW32BsJETPSQ8yxv1qdP5rnCh0/mcNxLM+RXq+lmXM6Sd2YyF7N3y3zS3hcnIEMXdMZMUEAymOIOlbC9MnZYiJTnatCm9YdAdNjHyzEjbRyVvibyMCEGQIrfUGTIsNgxwzQpDF0jQ3Ww6sjfk7my9MBgy5JsIDPDsuYYIJPC45NMAejVnRo9+WsadI7tP49nXxj0xSv1IiLc96pfiIcOzEvPvfcNgr5efc8oS9WKf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 11:58:45.9963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba98c26-93e7-46f3-9807-08d61a396dc8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/18 2:10 AM, Borislav Petkov wrote:
> On Thu, Sep 13, 2018 at 04:51:10PM -0500, Brijesh Singh wrote:
>> kvmclock defines few static variables which are shared with the
>> hypervisor during the kvmclock initialization.
> ...
>
>> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
>> index 8047379..c16af27 100644
>> --- a/arch/x86/kernel/head64.c
>> +++ b/arch/x86/kernel/head64.c
>> @@ -112,6 +112,7 @@ static bool __head check_la57_support(unsigned long physaddr)
>>  unsigned long __head __startup_64(unsigned long physaddr,
>>  				  struct boot_params *bp)
>>  {
>> +	unsigned long vaddr, vaddr_end;
>>  	unsigned long load_delta, *p;
>>  	unsigned long pgtable_flags;
>>  	pgdval_t *pgd;
>> @@ -235,6 +236,21 @@ unsigned long __head __startup_64(unsigned long physaddr,
>>  	sme_encrypt_kernel(bp);
>>  
>>  	/*
>> +	 * Clear the memory encryption mask from the .bss..decrypted section.
>> +	 * The bss section will be memset to zero later in the initialization so
>> +	 * there is no need to zero it after changing the memory encryption
>> +	 * attribute.
>> +	 */
>> +	if (mem_encrypt_active()) {
>> +		vaddr = (unsigned long)__start_bss_decrypted;
>> +		vaddr_end = (unsigned long)__end_bss_decrypted;
>> +		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
>> +			i = pmd_index(vaddr);
>> +			pmd[i] -= sme_get_me_mask();
>> +		}
>> +	}
> Why isn't this chunk at the end of sme_encrypt_kernel() instead of here?

The sme_encrypt_kernel() does not have access to pmd (after pointer
fixup is applied). You can extend the sme_encrypt_kernel() to pass an
additional arguments but then we start getting in include hell. The pmd
is defined as "pmdval_t". If we extend the sme_encrypt_kernel() then 
asm/mem_encrypt.h need to include the header file which defines
"pmdval_t". Adding the 'asm/pgtable_type.h' was causing all kind of
compilation errors. I didn't spend much time on it. IMO, we really don't
need to go in this path unless we see some value from doing this.

>> +	/*
>>  	 * Return the SME encryption mask (if SME is active) to be used as a
>>  	 * modifier for the initial pgdir entry programmed into CR3.
>>  	 */
>> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
>> index 9c77d2d..0d618ee 100644
>> --- a/arch/x86/kernel/vmlinux.lds.S
>> +++ b/arch/x86/kernel/vmlinux.lds.S
>> @@ -65,6 +65,23 @@ jiffies_64 = jiffies;
>>  #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
>>  #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
>>  
>> +/*
>> + * This section contains data which will be mapped as decrypted. Memory
>> + * encryption operates on a page basis. Make this section PMD-aligned
>> + * to avoid splitting the pages while mapping the section early.
>> + *
>> + * Note: We use a separate section so that only this section gets
>> + * decrypted to avoid exposing more than we wish.
>> + */
>> +#define BSS_DECRYPTED						\
>> +	. = ALIGN(PMD_SIZE);					\
>> +	__start_bss_decrypted = .;				\
>> +	*(.bss..decrypted);					\
>> +	. = ALIGN(PAGE_SIZE);					\
>> +	__start_bss_decrypted_unused = .;			\
>> +	. = ALIGN(PMD_SIZE);					\
>> +	__end_bss_decrypted = .;				\
>> +
>>  #else
>>  
>>  #define X86_ALIGN_RODATA_BEGIN
>> @@ -74,6 +91,7 @@ jiffies_64 = jiffies;
>>  
>>  #define ALIGN_ENTRY_TEXT_BEGIN
>>  #define ALIGN_ENTRY_TEXT_END
>> +#define BSS_DECRYPTED
>>  
>>  #endif
>>  
>> @@ -345,6 +363,7 @@ SECTIONS
>>  		__bss_start = .;
>>  		*(.bss..page_aligned)
>>  		*(.bss)
>> +		BSS_DECRYPTED
>>  		. = ALIGN(PAGE_SIZE);
>>  		__bss_stop = .;
> Putting it in the BSS would need a bit of care in the future as it poses
> a certain ordering on the calls in x86_64_start_kernel() (not that there
> isn't any now :)):


Hmm, I thought since we are explicitly saying that attribute will add
the variables in the bss section so caller should not be using the
variable before bss is ready. If you are concerns that clear_bss() may
get called after the variable is used then we could memset(0) when while
clearing the C-bit. I did try to add some comments when we are clearing
the C-bit. I can include some verbatim in BSS_DECRYPTED section as well.


> You have:
>
> x86_64_start_kernel:
>
> 	...
>
> 	clear_bss();
>
> 	...
>
> 	x86_64_start_reservations() -> ... -> setup_arch() -> kvmclock_init()
>
> so it would be prudent to put at least a comment somewhere, say, over
> the definition of BSS_DECRYPTED or so, that attention should be paid to
> the clear_bss() call early.



